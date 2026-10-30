# 📡 MQTT Reference

Complete list of the ACW02 module MQTT topics: what it publishes (read) and what it listens to (commands).
This page describes the firmware in this repository. When in doubt, the source of truth is
`firmware/components/acw02/acw02.cpp` (`mqtt_callback()`, `publish_state()`, `publish_availability()`).

> ℹ️ All examples use the `acw02-salon` module. Replace it with your module's `dev_name`.

---

## 🔧 Prerequisites

- **Topic prefix**: every topic starts with the module `dev_name` (`esphome: name`), e.g. `acw02-salon`. It is **not** the friendly name, and dashes are not replaced with `_`.
- **Broker connection**: the MQTT client stays disabled at boot until it is configured. Fill in "MQTT: Broker", "MQTT: Login", "MQTT: Password" and "MQTT: Port" in the module web interface, then press "MQTT: Validate".
- **Quality of service**: the module publishes and subscribes with QoS 1.

---

## 🗺️ Overview

| Topic | Direction | Retained | Content |
|---|---|---|---|
| `acw02-salon/status` | module → broker | yes | `online` / `offline` (birth and last will messages) |
| `acw02-salon/state` | module → broker | yes | Full state as JSON (see "Reading the state") |
| `acw02-salon/<option>_availability` | module → broker | yes | `available` / `unavailable` (see "Option availability") |
| `acw02-salon/last_seen` | module → broker | no | Heartbeat every 15 s (see "Ping and heartbeat") |
| `acw02-salon/ping/request` | broker → module | – | Any payload, echoed on `ping/response` |
| `acw02-salon/ping/response` | module → broker | no | Copy of the payload received on `ping/request` |
| `acw02-salon/cmd_ac/<command>` | broker → module | – | Air conditioner commands (see "AC commands") |
| `acw02-salon/cmd/<command>` | broker → module | – | Module configuration (see "Configuration commands") |
| `homeassistant/<type>/acw02-salon[-<suffix>]/config` | module → broker | yes | Home Assistant MQTT Discovery |

> ⚠️ The module subscribes to `cmd/#` and `cmd_ac/#`, and only the **last segment** of the topic selects the command: `acw02-salon/cmd/eco` and `acw02-salon/cmd_ac/eco` behave the same. The only exception is the `mode_<x>` shortcuts, which exist under `cmd_ac/` only. Use the prefix given on this page: it is the one Home Assistant uses.

---

## 📖 Reading the state: `acw02-salon/state`

The module publishes a full JSON object (retained, QoS 1):

- after every MQTT command;
- on every state frame received from the air conditioner, including after a change made with the remote.

Every field is always present. "on/off" values are lowercase strings.

### Language-independent fields

Prefer these for an integration or an AI agent.

| Field | Values | Description |
|---|---|---|
| `power_climate` | `on` / `off` | Air conditioner on |
| `power` | `on` / `off` | Same as `power_climate` |
| `mode_climate` | `off`, `auto`, `cool`, `dry`, `heat`, `fan_only` | Current mode (`off` when powered off) |
| `temp_c` | integer 16–31 | Target temperature in °C |
| `temp_f` | integer 61–88 | Target temperature in °F |
| `ambient_c` | decimal (e.g. `21.500000`) | Room temperature measured by the AC, in °C |
| `ambient_f` | decimal | Room temperature in °F |
| `unit` | `°C` / `°F` | Unit used by the module |
| `eco` | `on` / `off` | Eco mode |
| `night` | `on` / `off` | Night mode |
| `clean` | `on` / `off` | Cleaning in progress |
| `purifier` | `on` / `off` | Purifier |
| `display` | `on` / `off` | Indoor unit display |
| `last_cmd_origin` | `ESP` / `Remote` | Origin of the last command (module or remote) |
| `filter_dirty` | `true` / `false` | Filter needs cleaning |
| `warn` / `error` | `true` / `false` | Warning / error reported by the AC |
| `warn_text` / `error_text` | text | Warning / error details |
| `cmd_failure_counter` | integer (as a string, e.g. `"0"`) | Commands not acknowledged by the AC since boot |
| `swing_horizontal_climate` | `none` or label | Horizontal swing, `none` when off |
| `presets_list_element_climate` | `none` or preset name | Applied preset, `none` if none |

### Fields that depend on the firmware language

These fields hold the labels of the build language (`lang: fr` or `en`). They are also the values to send to the matching commands.

| Field | `en` values | `fr` values |
|---|---|---|
| `mode` | `Auto`, `Heat`, `Cool`, `Dry`, `Fan only`, `Off` | `Auto`, `Chauffage`, `Climatisation`, `Déshumidification`, `Ventilation uniquement`, `Éteint` |
| `fan` | `Auto`, `20%`, `40%`, `60%`, `80%`, `100%`, `Silent`, `Turbo` | `Auto`, `20%`, `40%`, `60%`, `80%`, `100%`, `Silencieux`, `Turbo` |
| `swing` (vertical) | `Off`, `On`, `Position 1` … `Position 5` | `Désactivé`, `Activé`, `Position 1` … `Position 5` |
| `swing_horizontal` | `Off`, `Auto left-right`, `Position 1` … `Position 5`, `P1-P5`, `Auto center-out` | `Désactivé`, `Auto gauche-droit`, `Position 1` … `Position 5`, `P1-P5`, `Auto centre-extérieur` |
| `presets_list_element` | `Off` or preset name | `Aucun` or preset name |

### Configuration and diagnostic fields

| Field | Description |
|---|---|
| `g1_mute`, `g1_reset_eco_purifier`, `g1_option_recalculate_climate`, `preset` | `on` / `off` options (see "Configuration commands") |
| `g1_mute_next_cmd_delay`, `g1_mute_next_cmd_after_on_delay`, `g1_publish_stats_after_power_on_delay` | Delays in ms (numbers) |
| `disable_mode_auto`, `disable_mode_heat`, `disable_mode_dry`, `disable_mode_fan`, `disable_swing_vertical`, `disable_swing_horizontal` | `on` / `off` exclusions |
| `presets_list_element_config`, `preset_name_config` | Selected preset slot and name being entered |
| `mdns`, `wifi_ip`, `wifi_ssid`, `wifi_bssid`, `wifi_mac`, `wifi_signal` (e.g. `-61 dBm`) | Network |
| `esp_version`, `internal_temperature` (e.g. `45.2 °C`), `esp_memory` (e.g. `120 kB`) | ESP module |

### Example

```json
{
  "power_climate": "on", "power": "on",
  "mode_climate": "heat", "mode": "Heat",
  "fan": "Auto", "temp_c": 22, "temp_f": 72,
  "ambient_c": 21.500000, "ambient_f": 70.699997,
  "eco": "off", "night": "off", "clean": "off", "purifier": "on", "display": "on",
  "swing": "Position 1", "swing_horizontal": "Off", "swing_horizontal_climate": "none",
  "unit": "°C", "last_cmd_origin": "ESP",
  "filter_dirty": "false", "warn": "false", "error": "false", "warn_text": "", "error_text": "",
  "presets_list_element": "Off", "presets_list_element_climate": "none",
  "cmd_failure_counter": "0"
}
```

(Excerpt: the real message also contains the configuration and diagnostic fields.)

---

## ❄️ AC commands: `cmd_ac/`

Publish the payload to `acw02-salon/cmd_ac/<command>`. The module:

1. applies the command to its internal state;
2. sends a frame to the air conditioner only if the state actually changed;
3. republishes `acw02-salon/state`.

> ⚠️ **Payload case.** `on` / `off` options expect `on` **in lowercase**: `ON` or `true` are read as `off`. Only `power_climate` expects uppercase `OFF` to power off.

| Command | Payload | Effect and conditions |
|---|---|---|
| `power_climate` | `OFF` / anything else (e.g. `ON`) | `OFF` powers off. Any other value powers on in the last used mode. |
| `mode_climate` | `off`, `auto`, `cool`, `dry`, `heat`, `fan_only` (lowercase) | Changes the mode and powers on (`off` powers off). **An unknown value, including uppercase `OFF`, powers on in `cool`.** |
| `mode` | mode label (see `mode` above) | Same as `mode_climate`, with translated labels. The `Off` / `Éteint` label powers off. Unknown label: Cool. |
| `mode_off`, `mode_auto`, `mode_cool`, `mode_dry`, `mode_heat`, `mode_fan` | anything (e.g. `PRESS`) | Shortcut to `mode_climate`, **under `cmd_ac/` only**. An `OFF` or `0` payload is **ignored**. The suffix is case-insensitive. |
| `temp_c` | number (e.g. `22`) | Target in °C, clamped to 16–31 and truncated to an integer. **Ignored** if the unit is °F, or if the AC is on in Eco or Auto (the previous value is republished). Non-numeric payload: ignored. |
| `temp_f` | number (e.g. `72`) | Target in °F, clamped to 61–88. Same conditions, when the unit is °F. |
| `fan` | fan label | **Ignored in Eco mode** (Eco forces Auto). Unknown label: Auto. |
| `swing` | vertical swing label | Unknown label: `Position 1`. |
| `swing_horizontal` | horizontal swing label, or `none` | `none` or unknown label: off. |
| `eco` | `on` / `off` | Only effective when the AC is on in `cool`. Sets the fan to Auto and turns Night mode off. |
| `night` | `on` / `off` | Only effective when the AC is on in `cool`, `dry` or `heat`. Turns Eco off. |
| `purifier` | `on` / `off` | Only effective when the AC is on (otherwise reset to `off`). |
| `display` | `on` / `off` | Turns the indoor unit display on or off. |
| `clean` | `on` / `off` | Starts or stops cleaning. If the AC is running, or not in `cool` / `dry`, the module powers it off first (and switches to `cool`), then starts cleaning 3 s later. |
| `unit` | `°C` / `°F` | Module unit. Any other value: °C. Republishes the related Home Assistant entities. |
| `presets_list_element` | exact preset name (e.g. `1 Night`), or `none` | Applies the saved preset. `none` (or `Off` / `Aucun`): does nothing. |

> ℹ️ "Z-Config" exclusions (`disable_mode_*`, `disable_swing_*`) only hide options in Home Assistant: an MQTT command for an excluded mode is still applied.

---

## ⚙️ Configuration commands: `cmd/`

Publish the payload to `acw02-salon/cmd/<command>`. These settings are stored in the module memory and survive a reboot. The `G1:` Home Assistant entities only appear when "G1: MQTT version options" is enabled in the web interface, but the commands always work.

### Behavior

| Command | Payload | Effect |
|---|---|---|
| `g1_mute` | `on` / `off` | Silent commands: the AC does not beep when it receives them. |
| `g1_mute_next_cmd_delay` | integer, ms (0–60000) | After an MQTT command, commands sent during this delay are silent. Non-numeric value: 0. |
| `g1_mute_next_cmd_after_on_delay` | integer, ms (0–60000) | Same, after a command that powers the AC on. |
| `g1_publish_stats_after_power_on_delay` | integer, ms (0–1000) | Delays the `state` publication after power on. |
| `g1_reset_eco_purifier` | `on` / `off` | Resets Eco and Purifier to `off` when the AC powers off. |
| `g1_option_recalculate_climate` | `on` / `off` | In Eco mode, the Home Assistant climate entity only offers the `Auto` fan and is republished immediately on every Eco change. |

### Actions

| Command | Payload | Effect |
|---|---|---|
| `g1_get_status` | anything | Requests a state frame from the AC (republishes `state`). |
| `g1_rebuild_mqtt_entities` | anything | Republishes the whole MQTT Discovery configuration. |
| `g1_restart_module_ac` | anything | Reboots the ESP module. |

### Exclusions (Z-Config)

| Command | Payload | Effect |
|---|---|---|
| `disable_mode_auto`, `disable_mode_heat`, `disable_mode_dry`, `disable_mode_fan` | `on` / `off` | Hides a mode in Home Assistant. |
| `disable_swing_vertical`, `disable_swing_horizontal` | `on` / `off` | Hides a swing in Home Assistant. |
| `z_config_validate` | anything | Applies the exclusions (republishes the climate and select entities). |

### Presets

The module has 8 slots. An empty slot is named `Preset N (empty)` and a saved slot `N <name>` (e.g. `3 Night`).

| Command | Payload | Effect |
|---|---|---|
| `presets_list_element_config` | exact slot name | Selects the slot to save or delete. |
| `preset_name_config` | text (22 characters max, truncated beyond) | Name of the preset to save. |
| `preset_save` | anything | Saves the current AC state in the selected slot. |
| `preset_delete` | anything | Clears the selected slot. |
| `preset` | `on` / `off` | Shows the presets as "preset modes" of the climate entity. Enabling it excludes the horizontal swing, which uses the same field. |

To apply a preset: `cmd_ac/presets_list_element` (see above).

Saving example:

```bash
mosquitto_pub -t acw02-salon/cmd/presets_list_element_config -m "Preset 3 (empty)"
mosquitto_pub -t acw02-salon/cmd/preset_name_config -m "Night"
mosquitto_pub -t acw02-salon/cmd/preset_save -m PRESS
mosquitto_pub -t acw02-salon/cmd_ac/presets_list_element -m "3 Night"   # apply
```

---

## ✅ Option availability

Published (retained) on every AC state frame, with `available` or `unavailable`:

| Topic | `available` when |
|---|---|
| `acw02-salon/eco_availability` | AC on in `cool` |
| `acw02-salon/night_availability` | AC on in `cool`, `dry` or `heat` |
| `acw02-salon/fan_speed_availability` | Eco off, or AC off |
| `acw02-salon/target_temp_availability` | mode other than `auto` and Eco off, or AC off |
| `acw02-salon/purifier_availability` | AC on |
| `acw02-salon/clean_availability` | AC off |

---

## 🏓 Ping and heartbeat

- **Ping**: publish any payload to `acw02-salon/ping/request`. The module sends the same payload back to `acw02-salon/ping/response` about 200 ms later. Use it to check the broker ↔ module chain end to end.
- **Heartbeat**: `acw02-salon/last_seen` receives the module clock in seconds every 15 s. Without time synchronization (the case with the provided configuration), it is the time since boot, not a real time: use it to detect that the module still publishes, not as a timestamp.
- **Connection**: `acw02-salon/status` switches to `offline` (last will) when the module loses its broker connection.

---

## 🏠 MQTT Discovery (Home Assistant)

The module publishes its configuration under `homeassistant/<type>/acw02-salon…/config` (retained). Entities use `acw02-salon/state` as their source and `acw02-salon/status` for availability. They include:

- **`climate`**: mode, target, fan, swing, and presets or horizontal swing;
- **`select`**: mode, fan, swings, unit, presets;
- **`switch`**: Eco, Night, Purifier, Display, Clean, G1 and Z-Config options;
- **`number`**: target temperature;
- **`button`**: one button per mode (`cmd_ac/mode_<x>`), G1 actions and presets;
- **`sensor`** / **`binary_sensor`**: temperatures, filter, alerts, diagnostics.

After a firmware update, press "G1: Rebuild MQTT entities" (or publish to `cmd/g1_rebuild_mqtt_entities`) to republish these configurations.

---

## 🧪 Examples

```bash
B="-h 192.168.1.10 -u user -P password"

# Follow the state and the connection
mosquitto_sub $B -v -t 'acw02-salon/state' -t 'acw02-salon/status'

# Heat at 22 °C, automatic fan
mosquitto_pub $B -t acw02-salon/cmd_ac/mode_climate -m heat
mosquitto_pub $B -t acw02-salon/cmd_ac/temp_c -m 22
mosquitto_pub $B -t acw02-salon/cmd_ac/fan -m Auto

# Enable Night mode (lowercase)
mosquitto_pub $B -t acw02-salon/cmd_ac/night -m on

# Power off
mosquitto_pub $B -t acw02-salon/cmd_ac/power_climate -m OFF
```

---

## 🤖 Cheat sheet (for scripts and AI agents)

```yaml
prefix: "<dev_name>"            # e.g. acw02-salon
read:
  "<dev_name>/state": retained JSON, updated after every command and every AC frame
  "<dev_name>/status": online | offline
  "<dev_name>/<eco|night|fan_speed|target_temp|purifier|clean>_availability": available | unavailable
  "<dev_name>/last_seen": seconds, every 15 s
  "<dev_name>/ping/response": echo of ping/request
write_ac:                       # "<dev_name>/cmd_ac/<key>"
  power_climate: "OFF" | "ON"
  mode_climate: off | auto | cool | dry | heat | fan_only   # lowercase; unknown => cool (powers on)
  temp_c: 16..31                # ignored if unit=°F, or if on in eco/auto
  temp_f: 61..88                # ignored if unit=°C
  fan: translated label         # Auto | 20% | 40% | 60% | 80% | 100% | Silent/Silencieux | Turbo
  swing: translated label
  swing_horizontal: translated label | none
  eco | night | purifier | display | clean: on | off   # lowercase
  unit: "°C" | "°F"
  presets_list_element: "<N> <name>" | none
  mode_<off|auto|cool|dry|heat|fan>: any payload except OFF/0 (cmd_ac/ only)
write_config:                   # "<dev_name>/cmd/<key>"
  g1_mute | g1_reset_eco_purifier | g1_option_recalculate_climate | preset: on | off
  disable_mode_<auto|heat|dry|fan> | disable_swing_<vertical|horizontal>: on | off
  g1_mute_next_cmd_delay | g1_mute_next_cmd_after_on_delay: 0..60000   # ms
  g1_publish_stats_after_power_on_delay: 0..1000                         # ms
  g1_get_status | g1_rebuild_mqtt_entities | g1_restart_module_ac | z_config_validate | preset_save | preset_delete: any payload
  presets_list_element_config: exact slot name
  preset_name_config: text <= 22 characters
```
