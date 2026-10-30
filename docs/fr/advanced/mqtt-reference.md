# 📡 Référence MQTT

Liste complète des topics MQTT du module ACW02 : ce qu'il publie (lecture) et ce qu'il écoute (commandes).
Cette page décrit le comportement du firmware de ce dépôt. En cas de doute, la source de vérité est
`firmware/components/acw02/acw02.cpp` (`mqtt_callback()`, `publish_state()`, `publish_availability()`).

> ℹ️ Tous les exemples utilisent le module `acw02-salon`. Remplacez-le par le `dev_name` de votre module.

---

## 🔧 Prérequis

- **Préfixe des topics** : tous les topics commencent par le `dev_name` du module (`esphome: name`), par exemple `acw02-salon`. Ce n'est **pas** le nom convivial et les tirets ne sont pas remplacés par des `_`.
- **Connexion au broker** : le client MQTT est désactivé au démarrage tant qu'il n'est pas configuré. Renseignez « MQTT: Broker », « MQTT: Login », « MQTT: Password » et « MQTT: Port » dans l'interface web du module, puis appuyez sur « MQTT: Validate ».
- **Qualité de service** : le module publie et s'abonne en QoS 1.

---

## 🗺️ Vue d'ensemble

| Topic | Sens | Retenu | Contenu |
|---|---|---|---|
| `acw02-salon/status` | module → broker | oui | `online` / `offline` (message de naissance et dernière volonté) |
| `acw02-salon/state` | module → broker | oui | État complet en JSON (voir « Lecture de l'état ») |
| `acw02-salon/<option>_availability` | module → broker | oui | `available` / `unavailable` (voir « Disponibilité ») |
| `acw02-salon/last_seen` | module → broker | non | Battement de cœur toutes les 15 s (voir « Ping et battement ») |
| `acw02-salon/ping/request` | broker → module | – | Payload libre, renvoyé sur `ping/response` |
| `acw02-salon/ping/response` | module → broker | non | Copie du payload reçu sur `ping/request` |
| `acw02-salon/cmd_ac/<commande>` | broker → module | – | Commandes de la climatisation (voir « Commandes clim ») |
| `acw02-salon/cmd/<commande>` | broker → module | – | Configuration du module (voir « Commandes de configuration ») |
| `homeassistant/<type>/acw02-salon[-<suffixe>]/config` | module → broker | oui | MQTT Discovery pour Home Assistant |

> ⚠️ Le module s'abonne à `cmd/#` et `cmd_ac/#`, et seul le **dernier segment** du topic détermine la commande : `acw02-salon/cmd/eco` et `acw02-salon/cmd_ac/eco` ont le même effet. Seule exception, les raccourcis `mode_<x>` n'existent que sous `cmd_ac/`. Utilisez le préfixe indiqué dans cette page : c'est celui de Home Assistant.

---

## 📖 Lecture de l'état : `acw02-salon/state`

Le module publie un objet JSON complet (retenu, QoS 1) :

- après chaque commande MQTT ;
- à chaque trame d'état reçue de la climatisation, y compris après un changement fait à la télécommande.

Tous les champs sont toujours présents. Les valeurs « on/off » sont des chaînes en minuscules.

### Champs indépendants de la langue

À privilégier pour une intégration ou un agent IA.

| Champ | Valeurs | Description |
|---|---|---|
| `power_climate` | `on` / `off` | Climatisation allumée |
| `power` | `on` / `off` | Identique à `power_climate` |
| `mode_climate` | `off`, `auto`, `cool`, `dry`, `heat`, `fan_only` | Mode courant (`off` si éteinte) |
| `temp_c` | entier 16–31 | Consigne en °C |
| `temp_f` | entier 61–88 | Consigne en °F |
| `ambient_c` | décimal (ex. `21.500000`) | Température ambiante mesurée par la clim, en °C |
| `ambient_f` | décimal | Température ambiante en °F |
| `unit` | `°C` / `°F` | Unité utilisée par le module |
| `eco` | `on` / `off` | Mode Eco |
| `night` | `on` / `off` | Mode Nuit |
| `clean` | `on` / `off` | Nettoyage en cours |
| `purifier` | `on` / `off` | Purificateur |
| `display` | `on` / `off` | Affichage de l'unité intérieure |
| `last_cmd_origin` | `ESP` / `Remote` | Origine de la dernière commande (module ou télécommande) |
| `filter_dirty` | `true` / `false` | Filtre à nettoyer |
| `warn` / `error` | `true` / `false` | Avertissement / erreur signalé par la clim |
| `warn_text` / `error_text` | texte | Détail de l'avertissement / de l'erreur |
| `cmd_failure_counter` | entier (en chaîne, ex. `"0"`) | Commandes non acquittées par la clim depuis le démarrage |
| `swing_horizontal_climate` | `none` ou libellé | Oscillation horizontale, `none` si désactivée |
| `presets_list_element_climate` | `none` ou nom du preset | Preset appliqué, `none` si aucun |

### Champs dépendant de la langue du firmware

Ces champs contiennent les libellés de la langue de compilation (`lang: fr` ou `en`). Ce sont aussi les valeurs à envoyer aux commandes correspondantes.

| Champ | Valeurs en `fr` | Valeurs en `en` |
|---|---|---|
| `mode` | `Auto`, `Chauffage`, `Climatisation`, `Déshumidification`, `Ventilation uniquement`, `Éteint` | `Auto`, `Heat`, `Cool`, `Dry`, `Fan only`, `Off` |
| `fan` | `Auto`, `20%`, `40%`, `60%`, `80%`, `100%`, `Silencieux`, `Turbo` | `Auto`, `20%`, `40%`, `60%`, `80%`, `100%`, `Silent`, `Turbo` |
| `swing` (vertical) | `Désactivé`, `Activé`, `Position 1` … `Position 5` | `Off`, `On`, `Position 1` … `Position 5` |
| `swing_horizontal` | `Désactivé`, `Auto gauche-droit`, `Position 1` … `Position 5`, `P1-P5`, `Auto centre-extérieur` | `Off`, `Auto left-right`, `Position 1` … `Position 5`, `P1-P5`, `Auto center-out` |
| `presets_list_element` | `Aucun` ou nom du preset | `Off` ou nom du preset |

### Champs de configuration et de diagnostic

| Champ | Description |
|---|---|
| `g1_mute`, `g1_reset_eco_purifier`, `g1_option_recalculate_climate`, `preset` | Options `on` / `off` (voir « Commandes de configuration ») |
| `g1_mute_next_cmd_delay`, `g1_mute_next_cmd_after_on_delay`, `g1_publish_stats_after_power_on_delay` | Délais en ms (nombres) |
| `disable_mode_auto`, `disable_mode_heat`, `disable_mode_dry`, `disable_mode_fan`, `disable_swing_vertical`, `disable_swing_horizontal` | Exclusions `on` / `off` |
| `presets_list_element_config`, `preset_name_config` | Emplacement de preset sélectionné et nom en cours de saisie |
| `mdns`, `wifi_ip`, `wifi_ssid`, `wifi_bssid`, `wifi_mac`, `wifi_signal` (ex. `-61 dBm`) | Réseau |
| `esp_version`, `internal_temperature` (ex. `45.2 °C`), `esp_memory` (ex. `120 kB`) | Module ESP |

### Exemple

```json
{
  "power_climate": "on", "power": "on",
  "mode_climate": "heat", "mode": "Chauffage",
  "fan": "Auto", "temp_c": 22, "temp_f": 72,
  "ambient_c": 21.500000, "ambient_f": 70.699997,
  "eco": "off", "night": "off", "clean": "off", "purifier": "on", "display": "on",
  "swing": "Position 1", "swing_horizontal": "Désactivé", "swing_horizontal_climate": "none",
  "unit": "°C", "last_cmd_origin": "ESP",
  "filter_dirty": "false", "warn": "false", "error": "false", "warn_text": "", "error_text": "",
  "presets_list_element": "Aucun", "presets_list_element_climate": "none",
  "cmd_failure_counter": "0"
}
```

(Extrait : le message réel contient aussi les champs de configuration et de diagnostic.)

---

## ❄️ Commandes de la climatisation : `cmd_ac/`

Publiez le payload sur `acw02-salon/cmd_ac/<commande>`. Le module :

1. applique la commande à son état interne ;
2. n'envoie une trame à la climatisation que si l'état a réellement changé ;
3. republie `acw02-salon/state`.

> ⚠️ **Casse des payloads.** Les options `on` / `off` attendent `on` **en minuscules** : `ON` ou `true` sont compris comme `off`. Seul `power_climate` attend `OFF` en majuscules pour éteindre.

| Commande | Payload | Effet et conditions |
|---|---|---|
| `power_climate` | `OFF` / autre (ex. `ON`) | `OFF` éteint. Toute autre valeur allume dans le dernier mode utilisé. |
| `mode_climate` | `off`, `auto`, `cool`, `dry`, `heat`, `fan_only` (minuscules) | Change le mode et allume la clim (`off` l'éteint). **Une valeur inconnue, y compris `OFF` en majuscules, allume la clim en `cool`.** |
| `mode` | libellé de mode (voir `mode` ci-dessus) | Comme `mode_climate`, avec les libellés traduits. Le libellé `Éteint` / `Off` éteint. Libellé inconnu : Climatisation. |
| `mode_off`, `mode_auto`, `mode_cool`, `mode_dry`, `mode_heat`, `mode_fan` | libre (ex. `PRESS`) | Raccourci vers `mode_climate`, **uniquement sous `cmd_ac/`**. Un payload `OFF` ou `0` est **ignoré**. Le suffixe est insensible à la casse. |
| `temp_c` | nombre (ex. `22`) | Consigne en °C, bornée à 16–31 et tronquée à l'entier. **Ignorée** si l'unité est °F, ou si la clim est allumée en Eco ou en Auto (la valeur précédente est republiée). Payload non numérique : ignoré. |
| `temp_f` | nombre (ex. `72`) | Consigne en °F, bornée à 61–88. Mêmes conditions, si l'unité est °F. |
| `fan` | libellé de ventilation | **Ignorée en mode Eco** (Eco impose Auto). Libellé inconnu : Auto. |
| `swing` | libellé d'oscillation verticale | Libellé inconnu : `Position 1`. |
| `swing_horizontal` | libellé d'oscillation horizontale, ou `none` | `none` ou libellé inconnu : désactivée. |
| `eco` | `on` / `off` | Effectif uniquement clim allumée en mode `cool`. Active la ventilation Auto et coupe le mode Nuit. |
| `night` | `on` / `off` | Effectif uniquement clim allumée en `cool`, `dry` ou `heat`. Coupe le mode Eco. |
| `purifier` | `on` / `off` | Effectif uniquement clim allumée (sinon remis à `off`). |
| `display` | `on` / `off` | Allume ou éteint l'affichage de l'unité intérieure. |
| `clean` | `on` / `off` | Lance ou arrête le nettoyage. Si la clim tourne, ou n'est pas en `cool` / `dry`, le module l'éteint d'abord (et passe en `cool`), puis lance le nettoyage 3 s plus tard. |
| `unit` | `°C` / `°F` | Unité du module. Toute autre valeur : °C. Republie les entités Home Assistant concernées. |
| `presets_list_element` | nom exact d'un preset (ex. `1 Nuit`), ou `none` | Applique le preset enregistré. `none` (ou `Aucun` / `Off`) : ne fait rien. |

> ℹ️ Les exclusions « Z-Config » (`disable_mode_*`, `disable_swing_*`) masquent seulement les options dans Home Assistant : une commande MQTT vers un mode exclu est quand même appliquée.

---

## ⚙️ Commandes de configuration : `cmd/`

Publiez le payload sur `acw02-salon/cmd/<commande>`. Ces réglages sont enregistrés dans la mémoire du module et survivent à un redémarrage. Les entités Home Assistant `G1:` n'apparaissent que si « G1: MQTT version options » est activé dans l'interface web, mais les commandes fonctionnent dans tous les cas.

### Comportement

| Commande | Payload | Effet |
|---|---|---|
| `g1_mute` | `on` / `off` | Commandes silencieuses : la clim ne bipe pas à la réception. |
| `g1_mute_next_cmd_delay` | entier, ms (0–60000) | Après une commande MQTT, les commandes envoyées pendant ce délai sont silencieuses. Valeur non numérique : 0. |
| `g1_mute_next_cmd_after_on_delay` | entier, ms (0–60000) | Idem, après une commande qui allume la clim. |
| `g1_publish_stats_after_power_on_delay` | entier, ms (0–1000) | Retarde la publication de `state` après un allumage. |
| `g1_reset_eco_purifier` | `on` / `off` | Remet Eco et Purificateur à `off` quand la clim s'éteint. |
| `g1_option_recalculate_climate` | `on` / `off` | En mode Eco, l'entité climate de Home Assistant ne propose plus que la ventilation `Auto` et est republiée immédiatement à chaque changement d'Eco. |

### Actions

| Commande | Payload | Effet |
|---|---|---|
| `g1_get_status` | libre | Demande une trame d'état à la clim (republie `state`). |
| `g1_rebuild_mqtt_entities` | libre | Republie toute la configuration MQTT Discovery. |
| `g1_restart_module_ac` | libre | Redémarre le module ESP. |

### Exclusions (Z-Config)

| Commande | Payload | Effet |
|---|---|---|
| `disable_mode_auto`, `disable_mode_heat`, `disable_mode_dry`, `disable_mode_fan` | `on` / `off` | Masque un mode dans Home Assistant. |
| `disable_swing_vertical`, `disable_swing_horizontal` | `on` / `off` | Masque une oscillation dans Home Assistant. |
| `z_config_validate` | libre | Applique les exclusions (republie les entités climate et select). |

### Presets

Le module propose 8 emplacements. Un emplacement vide s'appelle `Preset N (empty)` et un emplacement enregistré `N <nom>` (ex. `3 Nuit`).

| Commande | Payload | Effet |
|---|---|---|
| `presets_list_element_config` | nom exact d'un emplacement | Sélectionne l'emplacement à enregistrer ou supprimer. |
| `preset_name_config` | texte (22 caractères max., tronqué au-delà) | Nom du preset à enregistrer. |
| `preset_save` | libre | Enregistre l'état actuel de la clim dans l'emplacement sélectionné. |
| `preset_delete` | libre | Vide l'emplacement sélectionné. |
| `preset` | `on` / `off` | Affiche les presets comme « preset modes » de l'entité climate. L'activer exclut l'oscillation horizontale, qui utilise le même champ. |

Pour appliquer un preset : `cmd_ac/presets_list_element` (voir plus haut).

Exemple d'enregistrement :

```bash
mosquitto_pub -t acw02-salon/cmd/presets_list_element_config -m "Preset 3 (empty)"
mosquitto_pub -t acw02-salon/cmd/preset_name_config -m "Nuit"
mosquitto_pub -t acw02-salon/cmd/preset_save -m PRESS
mosquitto_pub -t acw02-salon/cmd_ac/presets_list_element -m "3 Nuit"   # application
```

---

## ✅ Disponibilité des options

Publiés (retenus) à chaque trame d'état de la clim, avec `available` ou `unavailable` :

| Topic | `available` quand |
|---|---|
| `acw02-salon/eco_availability` | clim allumée en `cool` |
| `acw02-salon/night_availability` | clim allumée en `cool`, `dry` ou `heat` |
| `acw02-salon/fan_speed_availability` | Eco désactivé, ou clim éteinte |
| `acw02-salon/target_temp_availability` | mode autre que `auto` et Eco désactivé, ou clim éteinte |
| `acw02-salon/purifier_availability` | clim allumée |
| `acw02-salon/clean_availability` | clim éteinte |

---

## 🏓 Ping et battement de cœur

- **Ping** : publiez n'importe quel payload sur `acw02-salon/ping/request`. Le module renvoie le même payload sur `acw02-salon/ping/response` environ 200 ms plus tard. Cela permet de vérifier la chaîne broker ↔ module de bout en bout.
- **Battement de cœur** : `acw02-salon/last_seen` reçoit toutes les 15 s l'horloge du module en secondes. Sans synchronisation horaire (cas de la configuration fournie), c'est le temps écoulé depuis le démarrage et non une heure réelle : utilisez-le pour détecter que le module publie encore, pas comme horodatage.
- **Connexion** : `acw02-salon/status` passe à `offline` (dernière volonté) si le module perd sa connexion au broker.

---

## 🏠 MQTT Discovery (Home Assistant)

Le module publie sa configuration sous `homeassistant/<type>/acw02-salon…/config` (retenu). Les entités utilisent `acw02-salon/state` comme source et `acw02-salon/status` comme disponibilité. Elles comprennent :

- **`climate`** : mode, consigne, ventilation, oscillation, et presets ou oscillation horizontale ;
- **`select`** : mode, ventilation, oscillations, unité, presets ;
- **`switch`** : Eco, Nuit, Purificateur, Affichage, Nettoyage, options G1 et Z-Config ;
- **`number`** : consigne ;
- **`button`** : un bouton par mode (`cmd_ac/mode_<x>`), actions G1 et presets ;
- **`sensor`** / **`binary_sensor`** : températures, filtre, alertes, diagnostic.

Après une mise à jour du firmware, appuyez sur « G1: Rebuild MQTT entities » (ou publiez sur `cmd/g1_rebuild_mqtt_entities`) pour republier ces configurations.

---

## 🧪 Exemples

```bash
B="-h 192.168.1.10 -u utilisateur -P motdepasse"

# Suivre l'état et la connexion
mosquitto_sub $B -v -t 'acw02-salon/state' -t 'acw02-salon/status'

# Allumer en chauffage à 22 °C, ventilation automatique
mosquitto_pub $B -t acw02-salon/cmd_ac/mode_climate -m heat
mosquitto_pub $B -t acw02-salon/cmd_ac/temp_c -m 22
mosquitto_pub $B -t acw02-salon/cmd_ac/fan -m Auto

# Activer le mode Nuit (minuscules)
mosquitto_pub $B -t acw02-salon/cmd_ac/night -m on

# Éteindre
mosquitto_pub $B -t acw02-salon/cmd_ac/power_climate -m OFF
```

---

## 🤖 Aide-mémoire (pour scripts et agents IA)

```yaml
prefix: "<dev_name>"            # ex. acw02-salon
read:
  "<dev_name>/state": JSON retenu, mis à jour après chaque commande et chaque trame de la clim
  "<dev_name>/status": online | offline
  "<dev_name>/<eco|night|fan_speed|target_temp|purifier|clean>_availability": available | unavailable
  "<dev_name>/last_seen": secondes, toutes les 15 s
  "<dev_name>/ping/response": écho de ping/request
write_ac:                       # "<dev_name>/cmd_ac/<clé>"
  power_climate: "OFF" | "ON"
  mode_climate: off | auto | cool | dry | heat | fan_only   # minuscules ; inconnu => cool (allume)
  temp_c: 16..31                # ignoré si unit=°F, ou si allumée en eco/auto
  temp_f: 61..88                # ignoré si unit=°C
  fan: libellé traduit          # Auto | 20% | 40% | 60% | 80% | 100% | Silencieux/Silent | Turbo
  swing: libellé traduit
  swing_horizontal: libellé traduit | none
  eco | night | purifier | display | clean: on | off   # minuscules
  unit: "°C" | "°F"
  presets_list_element: "<N> <nom>" | none
  mode_<off|auto|cool|dry|heat|fan>: payload libre sauf OFF/0 (cmd_ac/ uniquement)
write_config:                   # "<dev_name>/cmd/<clé>"
  g1_mute | g1_reset_eco_purifier | g1_option_recalculate_climate | preset: on | off
  disable_mode_<auto|heat|dry|fan> | disable_swing_<vertical|horizontal>: on | off
  g1_mute_next_cmd_delay | g1_mute_next_cmd_after_on_delay: 0..60000   # ms
  g1_publish_stats_after_power_on_delay: 0..1000                         # ms
  g1_get_status | g1_rebuild_mqtt_entities | g1_restart_module_ac | z_config_validate | preset_save | preset_delete: payload libre
  presets_list_element_config: nom exact d'emplacement
  preset_name_config: texte <= 22 caractères
```
