# ⚙️ Configuration Avancée

Guide pour personnaliser et optimiser votre module ACW02 selon vos besoins spécifiques.

---

## 🎯 Configuration de Base

### Paramètres Substitutions YAML

Dans votre fichier `esphome-acw02-fr.yaml`, personnalisez la section `substitutions` :

```yaml
substitutions:
  # Identifiants du périphérique
  dev_name: \"acw02-salon\"           # Nom technique (sans espaces, sans accents)
  dev_friendly: \"Climatisation Salon\" # Nom affiché dans Home Assistant
  lang: \"fr\"                        # Langue de l'interface (fr/en)
  
  # Configuration matérielle (dépend de votre carte ESP32)
  board: esp32dev    # Voir section \"Configuration Matériel\"
  TX: GPIO17
  RX: GPIO16
```

### 🔐 Fichier `secrets.yaml`

La clé API et tous les mots de passe sont lus depuis `secrets.yaml` (ignoré par git), placé à côté du fichier de configuration :

```yaml
api_encrypted_key: VOTRE_CLE_BASE64
ota_password: VOTRE_MOT_DE_PASSE_OTA          # Mises à jour OTA
ap_password: VOTRE_MOT_DE_PASSE_AP            # Point d'accès de secours (8 caractères min.)
web_server_username: VOTRE_UTILISATEUR
web_server_password: VOTRE_MOT_DE_PASSE
```

### 🔑 Génération de Clés Sécurisées

#### Clé API ESPHome
```bash
# Générer une nouvelle clé (une par module)
openssl rand -base64 32

# Ou via l'assistant ESPHome
esphome wizard mon-device.yaml

# Ou utiliser le générateur en ligne
# https://esphome.io/components/api.html
```

#### Mots de Passe Forts
```yaml
# Utilisez des mots de passe complexes
ota_password: \"Clim@Salon2025!\"
ap_password: \"FallBack_WiFi123\"
web_server_password: \"WebAdmin$2025\"
```

---

## 🖥️ Configuration Matérielle

### ESP32 D1 Mini WROOM 32
```yaml
substitutions:
  board: esp32dev
  TX: GPIO17
  RX: GPIO16
```

### LOLIN ESP32 C3 Mini
```yaml
substitutions:
  board: lolin_c3_mini
  TX: GPIO21
  RX: GPIO20
```

### XIAO ESP32 C3
```yaml
substitutions:
  board: seeed_xiao_esp32c3
  TX: GPIO21
  RX: GPIO20
```

### XIAO ESP32 C6
```yaml
substitutions:
  board: seeed_xiao_esp32c6
  TX: GPIO16  # ⚠️ Différent du C3
  RX: GPIO17  # ⚠️ Différent du C3
```

---

## 📶 Configuration Wi-Fi Avancée

### Fichier secrets.yaml
```yaml
# Wi-Fi principal
wifi_ssid: \"MonWiFi_Principal\"
wifi_password: \"MotDePasseWiFi123\"

# Wi-Fi de secours
wifi_ssid2: \"MonWiFi_Invites\"
wifi_password2: \"MotDePasseInvites\"

# Wi-Fi mobile (si besoin)
wifi_ssid3: \"Partage_4G\"
wifi_password3: \"MotDePasseMobile\"
```

### Configuration Wi-Fi avec IP Statique
```yaml
# Dans votre .yaml principal, ajoutez après wifi:
wifi:
  ssid: !secret wifi_ssid
  password: !secret wifi_password
  
  # Configuration IP statique (optionnel)
  manual_ip:
    static_ip: 192.168.1.150
    gateway: 192.168.1.1
    subnet: 255.255.255.0
    dns1: 8.8.8.8
    dns2: 8.8.4.4
  
  # Options de performance
  output_power: 20dB        # Puissance Wi-Fi maximale
  fast_connect: true        # Connexion rapide
  reboot_timeout: 0s        # Pas de redémarrage auto si déconnexion
```

---

## 🏠 Configuration Home Assistant

### Intégration ESPHome Automatique
L'ESP32 apparaît automatiquement dans Home Assistant si :
1. **ESPHome add-on** est installé
2. **Même réseau** que Home Assistant
3. **API activée** dans le YAML (par défaut)

### Configuration MQTT
```yaml
# Ajout MQTT pour compatibilité étendue
mqtt:
  broker: !secret mqtt_broker_ip
  username: !secret mqtt_username
  password: !secret mqtt_password
  port: 1883
  discovery: true           # Auto-discovery des entités
  discovery_prefix: homeassistant
  topic_prefix: acw02_salon # Préfixe des topics
```

Ajoutez dans `secrets.yaml` :
```yaml
mqtt_broker_ip: \"192.168.1.100\"  # IP de votre broker MQTT
mqtt_username: \"ha_mqtt_user\"
mqtt_password: \"MotDePasseMQTT123\"
```

---

## 🎮 Configuration des Presets

### Presets Prédéfinis Courants

```yaml
# Exemple de presets utiles à configurer via l'interface web :

# Preset \"Nuit\" : 
# - Température : 24°C
# - Mode : Cool
# - Ventilation : Auto ou Faible
# - Oscillation : Désactivée

# Preset \"Confort\" :
# - Température : 22°C
# - Mode : Cool
# - Ventilation : Auto
# - Oscillation : Horizontale activée

# Preset \"Éco\" :
# - Température : 26°C
# - Mode : Éco activé
# - Ventilation : Faible

# Preset \"Turbo\" :
# - Température : 20°C
# - Mode : Cool
# - Ventilation : Max
```

### Utilisation via Home Assistant
```yaml
# Automation utilisant les presets
automation:
  - alias: \"Mode Nuit Automatique\"
    trigger:
      platform: time
      at: \"22:30:00\"
    condition:
      condition: state
      entity_id: climate.acw02_salon
      state: \"cool\"
    action:
      service: climate.set_preset_mode
      entity_id: climate.acw02_salon
      data:
        preset_mode: \"Nuit\"
```

---

## 🔧 Optimisations de Performance

### Délais de Communication
Dans l'interface web, ajustez selon votre installation :

```
Délai publication état : 300ms     # Évite les commandes trop rapides
Délai silence général : 1000ms     # Pause entre commandes
Délai silence démarrage : 2000ms   # Pause après allumage clim
```

### Optimisation Wi-Fi
```yaml
# Dans votre .yaml, ajustez ces paramètres
wifi:
  # ... autres paramètres ...
  power_save_mode: none     # Désactive l'économie d'énergie Wi-Fi
  
# Réduire les logs pour améliorer les performances
logger:
  level: WARN              # INFO par défaut, WARN pour moins de logs
  logs:
    mqtt: ERROR            # Moins de logs MQTT
    wifi: WARN            # Moins de logs Wi-Fi
```

### Surveillance Système
```yaml
# Ajout de capteurs de surveillance (optionnel)
sensor:
  - platform: uptime
    name: \"Uptime ACW02\"
    update_interval: 300s
    
  - platform: wifi_signal
    name: \"Signal Wi-Fi ACW02\"
    update_interval: 60s
    
  - platform: internal_temperature
    name: \"Température ESP32\"
    update_interval: 120s
```

---

## 🛡️ Configuration Sécurité

### Sécurisation API
```yaml
api:
  encryption:
    key: !secret api_encrypted_key
  reboot_timeout: 0s
  
  # Services personnalisés (optionnel)
  services:
    - service: force_update_status
      then:
        - lambda: |-
            // Code pour forcer une mise à jour
```

### Sécurisation OTA
```yaml
ota:
  - platform: esphome
    password: !secret ota_password
    # Sécurisation supplémentaire
    port: 8266
    reboot_timeout: 0s
```

### Interface Web Sécurisée
```yaml
web_server:
  port: 80
  version: 3
  auth:
    username: !secret web_server_username
    password: !secret web_server_password
  # Désactiver si non nécessaire pour sécuriser
  # include_internal: false
```

---

## 🎛️ Personnalisation Interface

### Désactivation de Modes Non Supportés

Si votre climatiseur ne supporte pas certains modes, désactivez-les via l'interface web :
- **Mode Auto** : Si pas de régulation automatique
- **Mode Dry** : Si pas de déshumidification 
- **Mode Fan Only** : Si pas de ventilation seule
- **Mode Heat** : Si pas de chauffage

### Personnalisation des Noms d'Entités
```yaml
# Dans Home Assistant configuration.yaml
customize:
  climate.acw02_salon:
    friendly_name: \"Climatisation Salon\"
    icon: mdi:air-conditioner
    
  sensor.acw02_salon_temperature:
    friendly_name: \"Température Salon\"
    icon: mdi:thermometer
    
  switch.acw02_salon_display:
    friendly_name: \"Affichage Clim Salon\"
    icon: mdi:monitor
```

---

## 📊 Surveillance et Logs

### Configuration des Logs
```yaml
logger:
  # Niveau général (DEBUG, INFO, WARN, ERROR)
  level: INFO
  
  # Logs spécifiques par composant
  logs:
    climate: INFO          # Logs entité climat
    uart: WARN            # Communication série
    mqtt: INFO            # MQTT
    wifi: WARN            # Wi-Fi
    api: WARN             # API ESPHome
    ota: ERROR            # OTA
    web_server: ERROR     # Serveur web
```

### Monitoring via MQTT
```yaml
# Topics MQTT utiles pour le monitoring
# État général : homeassistant/climate/acw02_salon/state
# Température : homeassistant/sensor/acw02_salon_temperature/state  
# Signal Wi-Fi : homeassistant/sensor/acw02_salon_wifi_signal/state
# Disponibilité : homeassistant/climate/acw02_salon/availability
```

---

## 🔄 Sauvegarde et Restauration

### Sauvegarde de Configuration
```bash
# Sauvegarder votre configuration
cp mon-esphome-acw02.yaml ~/Sauvegardes/acw02-backup-$(date +%Y%m%d).yaml
cp secrets.yaml ~/Sauvegardes/secrets-backup-$(date +%Y%m%d).yaml

# Sauvegarder les presets (via interface web)
# Note : Les presets sont stockés dans l'ESP, faire une capture d'écran
```

### Scripts de Déploiement
```bash
#!/bin/bash
# deploy_acw02.sh - Script de déploiement automatique

echo \"Déploiement ACW02...\"

# Vérification configuration
esphome config mon-esphome-acw02.yaml

if [ $? -eq 0 ]; then
    echo \"Configuration valide, compilation...\"
    esphome run mon-esphome-acw02.yaml --device OTA
else
    echo \"Erreur de configuration !\"
    exit 1
fi
```

---

## 🚀 Configurations Avancées

### Multi-Climatiseurs
```yaml
# Pour gérer plusieurs climatiseurs
substitutions:
  dev_name: \"acw02-salon\"
  mqtt_prefix: \"salon\"
  
# Dupliquer le fichier pour chaque climatiseur :
# acw02-salon.yaml, acw02-chambre.yaml, etc.
```

### Intégration Domotique Avancée
```yaml
# Exemple d'automation complexe Home Assistant
automation:
  - alias: \"Gestion Intelligente Climatisation\"
    trigger:
      - platform: numeric_state
        entity_id: sensor.temperature_exterieure
        above: 28
      - platform: state
        entity_id: binary_sensor.presence_salon
        to: \"on\"
    condition:
      - condition: time
        after: \"07:00:00\"
        before: \"23:00:00\"
    action:
      - service: climate.set_temperature
        entity_id: climate.acw02_salon
        data:
          temperature: \"{{ 26 - (states('sensor.temperature_exterieure')|float - 28) }}\"
      - service: climate.turn_on
        entity_id: climate.acw02_salon
```

---

## 🔗 Prochaines Étapes

1. **[Test de l'Interface](interface-details.md)** - Comprendre tous les contrôles
2. **[Dépannage](troubleshooting.md)** - Résoudre les problèmes courants  
3. **[Utilisation MQTT](../advanced/mqtt-only.md)** - Configuration avancée MQTT
4. **[Intégration Jeedom](../advanced/jeedom-integration.md)** - Pour utilisateurs Jeedom