# 🏠 Installation ESPHome Add-on Home Assistant

## 📋 Prérequis
- Home Assistant OS, Supervised, ou Container
- Add-on ESPHome installé dans Home Assistant
- Version ESPHome 2026.7.0 minimum

---

## 🛠️ Installation de l'Add-on ESPHome

### 1️⃣ Installer l'Add-on
1. **Supervisor** → **Add-on Store**
2. Rechercher **\"ESPHome\"**
3. **Installer** et **Démarrer**
4. Activer **\"Démarrage automatique\"**
5. Activer **\"Watchdog\"**

### 2️⃣ Configuration de l'Add-on
Dans l'onglet **Configuration** de l'add-on ESPHome :

```yaml
# Exemple de configuration
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
require_ssl: false
```

---

## 📁 Préparation des Fichiers

### Utiliser les Fichiers HA-Builder

Le projet inclut des fichiers spécialement conçus pour l'ESPHome Builder :

```
HA-esphome-builder/
├── ha-esphome-builder-acw02-fr.yaml    # Version française
└── ha-esphome-builder-acw02-en.yaml    # Version anglaise
```

### Copier les Fichiers dans Home Assistant

1. **Via l'interface ESPHome** :
   - Ouvrir l'add-on ESPHome
   - Cliquer sur **\"+ Nouveau dispositif\"**
   - Sélectionner **\"Continuer\"**
   - Donner un nom à votre dispositif
   - **Ignorer** l'assistant et **\"Éditer\"** directement

2. **Coller le contenu** de `ha-esphome-builder-acw02-fr.yaml`

---

## ⚙️ Configuration du Fichier YAML

### Modifier les Substitutions

```yaml
substitutions:
  dev_name: \"acw02-salon\"
  dev_friendly: \"ACW02 Salon\"
  lang: \"fr\"
  
  # Générez une clé unique sur: https://esphome.io/components/api.html
  api_encrypted_key: \"VOTRE_CLE_UNIQUE_ICI\"
  
  ota_password: \"VOTRE_MOT_DE_PASSE_OTA\"
  ap_password: \"motdepassefallback\"
  
  web_server_username: admin
  web_server_password: admin
  
  # Configuration selon votre carte ESP32
  board: esp32dev        # ESP32 D1 Mini WROOM 32
  TX: GPIO17
  RX: GPIO16
```

### Configuration Wi-Fi avec secrets.yaml

Créer un fichier `secrets.yaml` dans le répertoire ESPHome :

```yaml
# Via File Editor ou SSH
wifi_ssid: \"votre_wifi\"
wifi_password: \"votre_mot_de_passe\"
wifi_ssid2: \"wifi_backup\"
wifi_password2: \"mot_de_passe_backup\"
```

---

## 🔌 Compilation et Installation

### 1️⃣ Premier Flash (USB)

1. **Connecter l'ESP32** via USB à votre machine Home Assistant
2. Dans ESPHome, cliquer sur **\"Installer\"**
3. Sélectionner **\"Plug into this computer\"**
4. Choisir le port série approprié
5. Attendre la compilation et le flash

### 2️⃣ Mises à Jour Futures (OTA)

Une fois l'ESP32 connecté au Wi-Fi :
1. Cliquer sur **\"Installer\"**
2. Sélectionner **\"Wirelessly\"**
3. La mise à jour se fait automatiquement

---

## 🏠 Intégration dans Home Assistant

### Auto-Discovery

Avec la configuration par défaut, l'ESP32 apparaîtra automatiquement dans :
- **Paramètres** → **Appareils et Services** → **ESPHome**

### Configuration Manuelle

Si l'auto-discovery ne fonctionne pas :
1. **Paramètres** → **Appareils et Services** → **Ajouter une intégration**
2. Rechercher **\"ESPHome\"**
3. Entrer l'adresse IP de l'ESP32
4. Entrer la clé de chiffrement (`api_encrypted_key`)

---

## 📊 Surveillance et Logs

### Interface ESPHome
- **Dashboard ESPHome** : Voir tous vos dispositifs
- **Logs en temps réel** : Cliquer sur \"Logs\" sur votre dispositif
- **Mise à jour OTA** : Bouton \"Install\" pour les mises à jour

### Home Assistant
Les entités apparaîtront dans :
- **Aperçu** → Vos cartes de climat
- **Outils pour développeurs** → **États**
- **Paramètres** → **Appareils et Services** → **ESPHome** → Votre dispositif

---

## 🔧 Configuration Spécifique HA-Builder

### Différences avec la Version Standard

Le fichier `ha-esphome-builder-acw02-fr.yaml` contient :
- **Simplification des chemins** pour l'environnement HA
- **Auto-discovery optimisée** pour Home Assistant
- **Configuration MQTT intégrée** si configurée dans HA

### Activation de MQTT (Optionnel)

Si vous utilisez MQTT dans Home Assistant :
```yaml
mqtt:
  broker: !secret mqtt_broker
  username: !secret mqtt_username  
  password: !secret mqtt_password
  discovery: true
```

Ajoutez dans `secrets.yaml` :
```yaml
mqtt_broker: \"IP_DE_VOTRE_BROKER\"
mqtt_username: \"votre_utilisateur_mqtt\"
mqtt_password: \"votre_mot_de_passe_mqtt\"
```

---

## 🔍 Résolution des Problèmes

### Problème : Add-on ne démarre pas
1. Vérifier les **logs de l'add-on** ESPHome
2. S'assurer que le **port 6052** n'est pas utilisé
3. Redémarrer l'add-on

### Problème : Dispositif non détecté
1. Vérifier que l'ESP32 est sur le **même réseau**
2. Contrôler les **logs ESPHome** pour les erreurs de connexion
3. Vérifier la configuration **Wi-Fi** dans `secrets.yaml`

### Problème : Compilation échoue
1. **Vérifier la syntaxe YAML** dans l'éditeur ESPHome
2. S'assurer que tous les **secrets** sont définis
3. Contrôler la version **ESPHome** (minimum 2026.7.0)

### Problème : OTA ne fonctionne pas
1. Vérifier que l'**ESP32 est en ligne**
2. Contrôler le **mot de passe OTA**
3. S'assurer qu'il n'y a **pas de firewall** bloquant

---

## ✅ Vérification de l'Installation

Après installation réussie :

1. **✅ ESP32 visible** dans le dashboard ESPHome
2. **✅ Entités disponibles** dans Home Assistant  
3. **✅ Interface web accessible** : `http://[nom-device].local/`
4. **✅ Contrôle climatisation** via l'entité climate de HA

---

## 🔗 Prochaines Étapes

1. **[Configuration de l'Interface](../usage/interface-details.md)** - Comprendre les contrôles disponibles
2. **[Personnalisation](../usage/configuration.md)** - Configurer les presets et options
3. **[Intégration Avancée](../advanced/)** - MQTT, Jeedom, etc.