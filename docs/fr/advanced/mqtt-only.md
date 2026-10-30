# 🧩 Utilisation MQTT Uniquement (Sans Intégration ESPHome)

Cette configuration permet d'utiliser le module ACW02 **uniquement via MQTT**, sans passer par l'intégration ESPHome native de Home Assistant. Idéal pour Jeedom, OpenHAB, ou autres systèmes domotiques.

> ⚠️ **Topics MQTT** : certains topics cités dans cette page (`homeassistant/climate/…/set`, `acw02_salon/…`) n'existent pas dans le firmware. La liste exacte des topics et des payloads est dans la [Référence MQTT](mqtt-reference.md).

---

## 🎯 Cas d'Usage

### ✅ Recommandé Pour
- **Jeedom** avec plugin MQTT
- **OpenHAB** avec binding MQTT
- **Node-RED** pour logique personnalisée
- **Home Assistant** sans add-on ESPHome
- **Systèmes domotiques tiers** supportant MQTT
- **Installation réseau complexe** (VLAN, firewall)

### ❌ Non Recommandé Pour
- **Home Assistant standard** (utilisez l'intégration ESPHome)
- **Débutants** (configuration plus complexe)
- **Installation simple** (ESPHome natif plus facile)

---

## ⚙️ Configuration YAML

### 1️⃣ Modifications Requises

#### Supprimer la Section API
```yaml
# SUPPRIMEZ ces lignes de substitutions:
substitutions:
  # api_encrypted_key: \"D2oldc0VP++fni6src89tCSC0UwBhNPgyc8vgYN8/mA=\"  # À supprimer
  
# SUPPRIMEZ la section api complète:
# api:
#   encryption:
#     key: ${api_encrypted_key}
#   reboot_timeout: 0s
```

#### Conserver Uniquement MQTT
```yaml
# GARDEZ seulement ces sections:
wifi:
  # ... configuration Wi-Fi ...

web_server:
  # ... interface web ...

mqtt:
  # ... configuration MQTT ...
  
# Tous les composants climate, sensor, etc.
```

---

### 2️⃣ Configuration MQTT Renforcée

```yaml
mqtt:
  broker: !secret mqtt_broker
  username: !secret mqtt_username
  password: !secret mqtt_password
  port: 1883
  
  # Configuration discovery renforcée
  discovery: true
  discovery_prefix: homeassistant
  discovery_retain: true
  
  # Topics personnalisés
  topic_prefix: acw02_salon
  
  # Qualité de service
  birth_message:
    topic: acw02_salon/status
    payload: online
  will_message:
    topic: acw02_salon/status
    payload: offline
    retain: true
```

---

## 🌐 Configuration Interface Web

### Activation du Mode MQTT-Only

Une fois le firmware flashé, **configurez l'interface web** :

![Interface MQTT-Only](../../../docs/images/EN-WEB-without-esphome-native.PNG)

### Étapes de Configuration

1. **Accéder à l'interface** : `http://[nom-device].local/`
2. **Section Configuration** : 
   - **Activer \"G2: Enable MQTT version\"** ✅
   - **Configurer MQTT** (IP, username, password, port)
   - **Valider et redémarrer**

3. **Résultat** :
   - ✅ **Toutes entités MQTT** créées automatiquement  
   - ✅ **Discovery Home Assistant** fonctionnel via MQTT
   - ✅ **Compatibilité totale** systèmes tiers

---

## 📡 Topics MQTT Générés

### Structure Standard Home Assistant
```
homeassistant/
├── climate/acw02_salon/
│   ├── config          # Configuration auto-discovery
│   ├── state           # État climat (JSON)
│   ├── temperature/set # Consigne température  
│   ├── mode/set        # Mode climatisation
│   └── preset/set      # Preset sélectionné
│
├── sensor/acw02_salon_temperature/
│   ├── config          # Configuration capteur
│   └── state           # Température actuelle
│
├── switch/acw02_salon_display/
│   ├── config          # Configuration switch
│   ├── state           # État affichage
│   └── command         # Commande on/off
│
└── select/acw02_salon_swing_horizontal/
    ├── config          # Configuration sélecteur
    ├── state           # Position actuelle
    └── command         # Nouvelle position
```

### Topics de Diagnostic
```
acw02_salon/
├── status              # online/offline
├── wifi_signal         # Force signal Wi-Fi  
├── uptime             # Durée fonctionnement
├── free_memory        # Mémoire libre ESP32
└── temperature_internal # Température ESP32
```

---

## 🏠 Intégration Home Assistant (MQTT)

### Auto-Discovery
Avec la configuration MQTT-only, Home Assistant détecte **automatiquement** :
- **climate.acw02_salon** - Entité principale  
- **sensor.acw02_salon_temperature** - Température ambiante
- **switch.acw02_salon_display** - Affichage
- **select.acw02_salon_swing_horizontal** - Oscillation H
- **Et toutes les autres entités...**

### Configuration Manuelle (si Auto-Discovery désactivée)
```yaml
# Dans configuration.yaml de Home Assistant
climate:
  - platform: mqtt
    name: \"Climatisation Salon\"
    modes:
      - \"off\"
      - \"cool\" 
      - \"heat\"
      - \"auto\"
      - \"dry\"
      - \"fan_only\"
    temperature_command_topic: \"homeassistant/climate/acw02_salon/temperature/set\"
    temperature_state_topic: \"homeassistant/sensor/acw02_salon_temperature/state\"
    mode_command_topic: \"homeassistant/climate/acw02_salon/mode/set\"
    mode_state_topic: \"homeassistant/climate/acw02_salon/state\"
    # ... autres paramètres ...
```

---

## 🧾 Intégration Jeedom

### Plugin MQTT Jeedom

1. **Installer le plugin MQTT** Jeedom officiel
2. **Configurer le broker** MQTT dans le plugin
3. **Auto-inclusion** des topics Home Assistant

#### Configuration Broker Jeedom
```
IP Broker: 192.168.1.100
Port: 1883
Username: jeedom_user  
Password: jeedom_password
Topic racine: homeassistant/#
```

### Créer les Équipements Manuellement

#### Climatisation Principale
```
Nom: Climatisation Salon
Topic état: homeassistant/climate/acw02_salon/state
Topic commande température: homeassistant/climate/acw02_salon/temperature/set
Topic commande mode: homeassistant/climate/acw02_salon/mode/set
```

#### Capteur Température
```
Nom: Température Salon  
Topic: homeassistant/sensor/acw02_salon_temperature/state
Type: Numérique
Unité: °C
```

### Script Jeedom pour Contrôle
```php
// Script Jeedom pour changer température
$mqtt = mqtt();
$topic = 'homeassistant/climate/acw02_salon/temperature/set';
$temperature = 22; // Température souhaitée
$mqtt->publish($topic, $temperature);
```

---

## 🔧 OpenHAB Integration

### Configuration Things
```
// Fichier things/acw02.things
Bridge mqtt:broker:mybroker \"MQTT Broker\" [ 
    host=\"192.168.1.100\", 
    port=1883,
    username=\"openhab\",
    password=\"password123\"
] {
    Thing topic acw02_salon \"Climatisation Salon\" {
        Channels:
            Type string : mode \"Mode\" [ 
                stateTopic=\"homeassistant/climate/acw02_salon/state\",
                commandTopic=\"homeassistant/climate/acw02_salon/mode/set\"
            ]
            Type number : temperature \"Température\" [
                stateTopic=\"homeassistant/sensor/acw02_salon_temperature/state\",
                commandTopic=\"homeassistant/climate/acw02_salon/temperature/set\"
            ]
    }
}
```

### Configuration Items
```
// Fichier items/acw02.items
String ACW02_Mode \"Mode Climatisation\" { channel=\"mqtt:topic:mybroker:acw02_salon:mode\" }
Number ACW02_Temperature \"Température [%.1f °C]\" { channel=\"mqtt:topic:mybroker:acw02_salon:temperature\" }
```

---

## 📊 Node-RED Integration

### Flow de Base
```json
[
    {
        \"id\": \"climate_control\",
        \"type\": \"mqtt out\",
        \"broker\": \"mqtt_broker\",
        \"topic\": \"homeassistant/climate/acw02_salon/mode/set\",
        \"name\": \"Contrôle Mode Clim\"
    },
    {
        \"id\": \"temperature_monitor\", 
        \"type\": \"mqtt in\",
        \"broker\": \"mqtt_broker\",
        \"topic\": \"homeassistant/sensor/acw02_salon_temperature/state\",
        \"name\": \"Surveillance Température\"
    }
]
```

### Logique Automation Node-RED
```javascript
// Fonction Node-RED pour automation intelligente
if (msg.payload > 26) {
    // Si température > 26°C, activer clim mode cool à 24°C
    var coolMsg = {
        topic: \"homeassistant/climate/acw02_salon/mode/set\",
        payload: \"cool\"
    };
    var tempMsg = {
        topic: \"homeassistant/climate/acw02_salon/temperature/set\", 
        payload: 24
    };
    return [coolMsg, tempMsg];
} else if (msg.payload < 18) {
    // Si température < 18°C, éteindre
    return {
        topic: \"homeassistant/climate/acw02_salon/mode/set\",
        payload: \"off\"
    };
}
```

---

## 🔍 Monitoring et Debug

### Topics de Debug Utiles
```bash
# Surveiller tous les messages
mosquitto_sub -h 192.168.1.100 -t \"homeassistant/+/acw02_salon/+\"

# État climatisation uniquement
mosquitto_sub -h 192.168.1.100 -t \"homeassistant/climate/acw02_salon/state\"

# Température en temps réel
mosquitto_sub -h 192.168.1.100 -t \"homeassistant/sensor/acw02_salon_temperature/state\"
```

### Test de Commandes
```bash
# Changer mode en cool
mosquitto_pub -h 192.168.1.100 -t \"homeassistant/climate/acw02_salon/mode/set\" -m \"cool\"

# Fixer température à 22°C  
mosquitto_pub -h 192.168.1.100 -t \"homeassistant/climate/acw02_salon/temperature/set\" -m \"22\"

# Activer oscillation horizontale
mosquitto_pub -h 192.168.1.100 -t \"homeassistant/select/acw02_salon_swing_horizontal/command\" -m \"On\"
```

---

## ⚠️ Limitations Mode MQTT-Only

### Fonctionnalités Perdues
- **Interface ESPHome** dans Home Assistant (logs, mise à jour OTA via HA)
- **Intégration native** ESPHome (plus fluide)
- **Configuration via HA** (tout se fait via interface web ESP32)

### Fonctionnalités Conservées  
- ✅ **Tous les contrôles** climatisation
- ✅ **Tous les capteurs** et états
- ✅ **Presets personnalisés**
- ✅ **Interface web** complète sur ESP32
- ✅ **Mise à jour OTA** via ESPHome CLI
- ✅ **Compatibilité totale** systèmes tiers

---

## 🔧 Migration ESPHome ↔ MQTT-Only

### Passer en Mode MQTT-Only
1. **Modifier le YAML** (supprimer API)
2. **Recompiler et flasher**
3. **Configurer interface web** (activer G2)
4. **Vérifier topics MQTT**

### Revenir au Mode ESPHome
1. **Restaurer la section API** dans le YAML
2. **Recompiler et flasher**  
3. **Désactiver G2** dans l'interface web
4. **Réintégrer dans Home Assistant**

---

## 🔗 Ressources Complémentaires

- **[Configuration Avancée](../usage/configuration.md)** - Optimiser MQTT
- **[Guide Dépannage](../usage/troubleshooting.md)** - Problèmes MQTT
- **[Intégration Jeedom](jeedom-integration.md)** - Guide dédié Jeedom
- **[Interface Détails](../usage/interface-details.md)** - Comprendre l'interface web