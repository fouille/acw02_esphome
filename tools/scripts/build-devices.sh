#!/usr/bin/env bash
# Compile un firmware ACW02 pour chaque module déclaré dans firmware/configs/secrets.yaml.
#
# La liste des modules (non versionnée) se trouve sous la clé `acw02_devices` :
#
#   acw02_devices:
#     - name: acw02-salon          # dev_name (minuscules, chiffres, tirets)
#       friendly: ACW02 salon      # dev_friendly (optionnel, "ACW02 <suffixe>" par défaut)
#       lang: fr                   # optionnel : fr (défaut) ou en
#       config: my-config.yaml     # optionnel : config de base dans firmware/configs/
#       board: esp32dev            # optionnels : carte et broches UART
#       tx: GPIO17
#       rx: GPIO16
#
# Usage : tools/scripts/build-devices.sh [nom-du-module ...]
#   Sans argument, tous les modules de la liste sont compilés.
#   ESPHOME=/chemin/vers/esphome force le binaire ESPHome utilisé
#   (par défaut : .venv/bin/esphome à la racine du dépôt, sinon esphome du PATH).
#
# Images produites dans firmware/build/<nom>/ :
#   <nom>.ota.bin      mise à jour OTA (interface web ou esphome upload)
#   <nom>.factory.bin  premier flash en USB

set -eo pipefail

MIN_ESPHOME_VERSION="2026.7.0"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG_DIR="$ROOT/firmware/configs"
SECRETS="$CONFIG_DIR/secrets.yaml"
OUT_DIR="$ROOT/firmware/build"
REF_ESPHOME_VERSION="$(sed -n 's/^ESPHOME_VERSION=//p' "$ROOT/tools/docker/.env" 2>/dev/null | tr -d '\r')"

die() { echo "ERREUR : $*" >&2; exit 1; }

case "${1:-}" in
  -h|--help) sed -n '2,22p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
esac

[ -f "$SECRETS" ] || die "$SECRETS introuvable."

# --- ESPHome ---------------------------------------------------------------
if [ -n "${ESPHOME:-}" ]; then
  ESPHOME_BIN="$ESPHOME"
elif [ -x "$ROOT/.venv/bin/esphome" ]; then
  ESPHOME_BIN="$ROOT/.venv/bin/esphome"
elif command -v esphome >/dev/null 2>&1; then
  ESPHOME_BIN="$(command -v esphome)"
else
  die "esphome introuvable. Installez ESPHome $MIN_ESPHOME_VERSION ou plus (voir docs) ou définissez ESPHOME."
fi

ESPHOME_VERSION="$("$ESPHOME_BIN" version 2>/dev/null | sed -n 's/^Version: //p')"
[ -n "$ESPHOME_VERSION" ] || die "impossible de lire la version de $ESPHOME_BIN."
LOWEST="$(printf '%s\n%s\n' "$MIN_ESPHOME_VERSION" "$ESPHOME_VERSION" | sort -t. -k1,1n -k2,2n -k3,3n | head -1)"
if [ "$LOWEST" != "$MIN_ESPHOME_VERSION" ]; then
  die "ESPHome $ESPHOME_VERSION trop ancien ($ESPHOME_BIN), $MIN_ESPHOME_VERSION minimum requis."
fi
if [ -n "$REF_ESPHOME_VERSION" ] && [ "$ESPHOME_VERSION" != "$REF_ESPHOME_VERSION" ]; then
  echo "Attention : ESPHome $ESPHOME_VERSION utilisé, version de référence du projet : $REF_ESPHOME_VERSION." >&2
fi

# --- Lecture de la liste des modules (PyYAML est fourni avec ESPHome) ------
PYTHON=""
SHEBANG="$(head -1 "$ESPHOME_BIN" 2>/dev/null | sed -n 's/^#! *//p' || true)"
for candidate in "${SHEBANG%% *}" "$(dirname "$ESPHOME_BIN")/python3" python3; do
  if [ -n "$candidate" ] && "$candidate" -c 'import yaml' >/dev/null 2>&1; then
    PYTHON="$candidate"
    break
  fi
done
[ -n "$PYTHON" ] || die "aucun interpréteur Python avec PyYAML trouvé pour lire $SECRETS."

SEP=$'\x1f'
read -r -d '' PARSE_DEVICES <<'PY' || true
import os, re, sys, yaml

secrets_path, config_dir = sys.argv[1], sys.argv[2]
with open(secrets_path, encoding="utf-8") as f:
    data = yaml.safe_load(f) or {}

devices = data.get("acw02_devices")
if not isinstance(devices, list) or not devices:
    sys.exit(f"aucune liste 'acw02_devices' dans {secrets_path}")

seen = set()
for i, dev in enumerate(devices, 1):
    if not isinstance(dev, dict) or not dev.get("name"):
        sys.exit(f"acw02_devices[{i}] : champ 'name' manquant")
    name = str(dev["name"])
    if not re.fullmatch(r"[a-z0-9-]+", name):
        sys.exit(f"{name} : nom invalide (minuscules, chiffres et tirets uniquement)")
    if name in seen:
        sys.exit(f"{name} : déclaré deux fois")
    seen.add(name)
    friendly = str(dev.get("friendly") or "ACW02 " + re.sub(r"^acw02-", "", name))
    lang = str(dev.get("lang", "fr"))
    if lang not in ("fr", "en"):
        sys.exit(f"{name} : lang doit valoir fr ou en")
    config = str(dev.get("config") or f"esphome-acw02-{lang}.yaml")
    if not os.path.isfile(os.path.join(config_dir, config)):
        sys.exit(f"{name} : config {config} introuvable dans {config_dir}")
    fields = [name, friendly, config] + [str(dev.get(k) or "") for k in ("board", "tx", "rx")]
    print("\x1f".join(fields))
PY
DEVICES="$("$PYTHON" -c "$PARSE_DEVICES" "$SECRETS" "$CONFIG_DIR")" || die "liste des modules invalide."

# --- Filtre éventuel sur les modules passés en argument --------------------
SELECTED="$DEVICES"
if [ "$#" -gt 0 ]; then
  SELECTED=""
  for wanted in "$@"; do
    line="$(printf '%s\n' "$DEVICES" | awk -F"$SEP" -v w="$wanted" '$1 == w { print; exit }')"
    [ -n "$line" ] || die "module '$wanted' absent de acw02_devices."
    SELECTED="${SELECTED}${line}"$'\n'
  done
fi

# --- Compilation -----------------------------------------------------------
BUILT=""
FAILED=""
mkdir -p "$OUT_DIR"

while IFS="$SEP" read -r name friendly config board tx rx; do
  [ -n "$name" ] || continue
  echo
  echo "==> $name (\"$friendly\") depuis $config"

  subs=(--substitution dev_name "$name" --substitution dev_friendly "$friendly")
  [ -z "$board" ] || subs+=(--substitution board "$board")
  [ -z "$tx" ] || subs+=(--substitution TX "$tx")
  [ -z "$rx" ] || subs+=(--substitution RX "$rx")

  stamp="$(mktemp "${TMPDIR:-/tmp}/acw02-build.XXXXXX")"
  if "$ESPHOME_BIN" "${subs[@]}" compile "$CONFIG_DIR/$config" </dev/null; then
    build_dir="$CONFIG_DIR/.esphome/build/$name"
    ota="$(find "$build_dir" -name firmware.ota.bin -newer "$stamp" -print -quit 2>/dev/null || true)"
    factory="$(find "$build_dir" -name firmware.factory.bin -newer "$stamp" -print -quit 2>/dev/null || true)"
    if [ -n "$ota" ]; then
      rm -rf "${OUT_DIR:?}/$name"
      mkdir -p "$OUT_DIR/$name"
      cp "$ota" "$OUT_DIR/$name/$name.ota.bin"
      [ -z "$factory" ] || cp "$factory" "$OUT_DIR/$name/$name.factory.bin"
      BUILT="$BUILT $name"
    else
      echo "ERREUR : compilation terminée mais firmware.ota.bin introuvable dans $build_dir" >&2
      FAILED="$FAILED $name"
    fi
  else
    FAILED="$FAILED $name"
  fi
  rm -f "$stamp"
done <<EOF
$SELECTED
EOF

# --- Résumé ----------------------------------------------------------------
echo
echo "==================== Résumé (ESPHome $ESPHOME_VERSION) ===================="
for name in $BUILT; do
  for f in "$OUT_DIR/$name"/*.bin; do
    echo "OK     $name  ${f#"$ROOT"/}"
  done
done
for name in $FAILED; do
  echo "ÉCHEC  $name"
done
[ -z "$FAILED" ]
