# Installation depuis Macos
Environnement testé 
* Mac Mini 2018
* 3 GHz Intel Core i5 6 cœurs
* 8 Go 2667 MHz DDR4
* MacOs 15.7 (24G222)

**Pré-requis :**
1. cloner le repos
2. copier `esphome-acw02-fr.yaml` vers `my-esphome-acw02-fr.yml`
3. configurer `my-esphome-acw02-fr.yaml` et `secret.yml` 

# Installation Esphome, Build et Flash :** 
## Installation de ESPHome
```
brew install esphome
esphome version #doit retourner la version ESPHome validée par acw02
```

## 2. Lancer le build
```
esphome run my-esphome-acw02-fr.yaml
```

## 3. Flashage
```
INFO Package configuration completed successfully
INFO Package configuration completed successfully
INFO Successfully compiled program.
Found multiple options for uploading, please choose one:
  [1] /dev/cu.usbserial-0001 (CP2102 USB to UART Bridge Controller - CP2102 USB to UART Bridge Controller)
  [2] Over The Air (acw02-entree.local)
  [3] Over The Air (MQTT IP lookup)
(number): 1
```
Choisir la méthode adaptée à votre situation

## 4. Démarrage et connection au Wifi (être patient :slight_smile: )
```
esptool v5.0.2
Connected to ESP32 on /dev/cu.usbserial-0001:
Chip type:          ESP32-D0WD-V3 (revision v3.1)
Features:           Wi-Fi, BT, Dual Core + LP Core, 240MHz, Vref calibration in eFuse, Coding Scheme None
Crystal frequency:  40MHz
MAC:                5c:01:3b:4c:52:50

Stub flasher running.
Changing baud rate to 460800...
Changed.

Configuring flash size...

[...]

[22:50:22.430][W][component:296]: wifi set Warning flag: scanning for networks
[22:50:22.435][W][acw02:2996]: TX: [7A.7A.21.D5.0C.00.00.AB.0A.0A.FC.F9 (12)]
[22:50:22.861][W][wifi_esp32:1001]: esp_wifi_sta_get_ap_info failed: ESP_ERR_WIFI_NOT_CONNECT
[22:50:22.869][W][wifi_esp32:991]: esp_wifi_sta_get_ap_info failed: ESP_ERR_WIFI_NOT_CONNECT
[22:50:22.876][W][wifi_esp32:1012]: esp_wifi_sta_get_ap_info failed: ESP_ERR_WIFI_NOT_CONNECT
[22:50:24.294][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:25.023][W][wifi:612]: No matching network found
[22:50:28.297][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:32.300][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:32.634][W][wifi:612]: No matching network found
[22:50:36.303][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:40.245][W][wifi:612]: No matching network found
[22:50:40.307][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:44.311][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:47.856][W][wifi:612]: No matching network found
[22:50:48.313][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:52.317][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:50:55.467][W][wifi:612]: No matching network found
[22:50:56.319][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:51:00.323][W][acw02:872]: Wi-Fi not connected; retrying in 5 s
[22:51:00.480][I][wifi:329]: Connecting to 'Fra...'
[22:51:04.260][I][wifi:675]: Connected
[22:51:04.264][W][wifi:678]: Network 'Fra...' should be marked as hidden
[22:51:04.282][I][app:120]: setup() finished successfully!
[22:51:04.288][W][component:326]: wifi cleared Warning flag
[22:51:04.293][I][app:185]: ESPHome version 2025.9.3 compiled on Oct  2 2025, 22:47:45
[22:51:04.330][W][acw02:863]: Wi-Fi OK; attempting MQTT connection…
[22:51:04.335][W][component:287]: mqtt set Warning flag: unspecified
[22:51:04.336][I][mqtt:268]: Connecting
[22:51:04.382][W][acw02:881]: MQTT connected → publishing discovery and state
[22:51:04.388][W][component:326]: mqtt cleared Warning flag
[22:51:04.389][I][mqtt:309]: Connected
```