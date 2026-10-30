# Module ACW02 ESPHome

**Composant ESPHome personnalisé pour les climatiseurs Teknopoint et Airton** utilisant le module Wi-Fi **Tuya ACW02**.

---

## 🏁 Démarrage Rapide

### 📋 Prérequis
- Home Assistant avec l'intégration **MQTT** activée et correctement configurée
- Activer le Wi-Fi avec la télécommande de la climatisation

### 🔧 Installation
Choisissez votre méthode d'installation préférée :

1. **[Installation macOS native](installation/installation-macos.md)**
2. **[Installation Docker Windows](installation/installation-docker-windows.md)**  
3. **[Installation Windows native](installation/installation-windows.md)**
4. **[Installation ESPHome Add-on Home Assistant](installation/installation-ha-addon.md)**

### 🖥️ Matériel Compatible
- **[ESP32 D1 MINI WROOM 32](hardware/esp32-d1-mini.md)** *(recommandé pour débuter)*
- **[LOLIN ESP32 C3 MINI](hardware/esp32-c3-mini.md)** *(meilleur signal Wi-Fi)*
- **[XIAO ESP32 C3](hardware/xiao-esp32-c3.md)** *(support antenne externe)*
- **[XIAO ESP32 C6](hardware/xiao-esp32-c6.md)** *(nécessite antenne externe)*

### 📖 Utilisation
- **[Détails de l'interface utilisateur](usage/interface-details.md)**
- **[Configuration avancée](usage/configuration.md)**
- **[Guide de dépannage](usage/troubleshooting.md)**

### 🔬 Fonctionnalités Avancées
- **[Référence MQTT (topics et commandes)](advanced/mqtt-reference.md)**
- **[Utilisation MQTT uniquement (sans intégration HA)](advanced/mqtt-only.md)**
- **[Configuration de presets personnalisés](advanced/custom-presets.md)**
- **[Intégration Jeedom](advanced/jeedom-integration.md)**

---

## ⚠️ Avertissement de Compatibilité

> **Important**  
> - ✅ Fonctionne sur la plupart des unités **Teknopoint** *(non confirmé mais aucun problème connu jusqu'à présent)*
> - ✅ Fonctionne sur la plupart des unités **Airton** *(non confirmé mais aucun problème connu jusqu'à présent)*
> - ❌ **Exception Airton** : Les climatiseurs utilisant le module WiFi **409945** d'Airton ne sont **PAS compatibles** avec ce module

---

## ✅ Liste de Compatibilité Communautaire

Une liste non exhaustive des modèles testés est disponible ici :  
👉 [COMPATIBILITY.md](../../COMPATIBILITY.md)

---

## 📌 Contribuer

Aidez à améliorer ce projet en signalant la compatibilité de votre unité.  
Si votre modèle n'est pas référencé, veuillez soumettre un rapport (**unités testées uniquement**) :  
👉 [Signaler votre unité](https://github.com/devildant/acw02_esphome/issues/new?template=unit_report.yml)  
PS : Si vous rencontrez un problème, veuillez poster un issue avant de mettre votre modèle en incompatible.

---

## 📋 Configuration de Base

### 📁 Configuration des Fichiers

Ouvrez `esphome-acw02-fr.yaml` pour la version française.

Si vous souhaitez compiler avec l'add-on ESPHome Builder dans Home Assistant, utilisez plutôt les fichiers du dossier `HA-esphome-builder` (`ha-esphome-builder-acw02-fr.yaml`).

Modifiez la section `substitutions` — vous pouvez modifier :

- `dev_name` - Nom du périphérique
- `dev_friendly` - Nom convivial

```yaml
substitutions:
  dev_name: acw02-salon
  dev_friendly: ACW02 salon
  lang: "fr"
  # ESP32 D1 mini WROOM 32
  board: esp32dev
  TX: GPIO17
  RX: GPIO16
```

⚠️ **La configuration dépend de la carte ESP32 choisie (Commentez/décommentez les blocs)**

Les mots de passe et la clé API se trouvent dans `secrets.yaml` (ignoré par git), à côté du fichier de configuration :

```yaml
api_encrypted_key: "VOTRE_CLE_BASE64"
ota_password: "VOTRE_MOT_DE_PASSE_OTA"
ap_password: "VOTRE_MOT_DE_PASSE_AP"
web_server_username: "VOTRE_UTILISATEUR"
web_server_password: "VOTRE_MOT_DE_PASSE"
```

Avec l'add-on ESPHome Builder de Home Assistant, ces clés vont dans le `secrets.yaml` de l'add-on.

🔑 Générez une `api_encrypted_key` unique pour chaque module, par exemple avec `openssl rand -base64 32` ou depuis [cette page](https://esphome.io/components/api.html).

---

### 📶 Configuration Wi-Fi et Serveur Web

Ouvrez `secrets.yaml` et remplissez vos identifiants Wi-Fi :

```yaml
wifi_ssid: "votre_wifi"
wifi_password: "votre_mot_de_passe"
wifi_ssid2: "wifi_backup"
wifi_password2: "mot_de_passe_backup"
wifi_ssid3: "wifi_invites"
wifi_password3: "mot_de_passe_invites"
```

---

## 📦 Mise à Jour

> **🔁 Après une mise à jour :**  
> Je recommande d'appuyer sur le bouton **"G1: Reconstruire les Entités MQTT"** pour s'assurer que tous les topics de découverte MQTT sont correctement rafraîchis.

---

## ❗ Notes Importantes

Ce composant nécessite **MQTT** pour fonctionner correctement.  
Assurez-vous de savoir comment le configurer avec Home Assistant.

> ⚠️ **AVERTISSEMENT**  
> Soyez prudent avec ce que vous faites, et assurez-vous d'avoir les connaissances nécessaires avant de tenter quoi que ce soit.  
> Je ne suis pas responsable des dommages causés à votre climatiseur, module ESP, ou autre matériel.

---

## 🔗 Liens Rapides

### 📖 Documentation
- [Guide d'Installation](installation/)
- [Configuration Matériel](hardware/)
- [Utilisation](usage/)
- [Fonctions Avancées](advanced/)

### 🛠️ Ressources
- [Fichiers PCB et Composants](../../hardware_new/)
- [Fichiers 3D](../../hardware_new/3d-files/)
- [Outils](../../tools_new/)

---

## 🛡️ Licence

Ce projet est sous licence multiple selon le type de contenu :

- **Code** (`*.yaml`, `*.cpp`, `*.h`) — [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)
- **Fichiers PCB** (`*.zip`, `*.json`) — [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
- **Modèles 3D** (`*.f3d`, `*.stl`) — [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

> L'usage commercial des fichiers PCB et 3D est **strictement interdit**.