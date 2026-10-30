# 🚀 Guide d'Installation ACW02

Choisissez la méthode d'installation qui convient le mieux à votre environnement :

---

## 🖥️ Méthodes d'Installation Disponibles

### 1. **[Installation macOS Native](installation-macos.md)** 
*Recommandé pour les utilisateurs macOS*
- ✅ Installation directe via Homebrew
- ✅ Contrôle total de l'environnement
- ✅ Compilation rapide
- ❌ Nécessite des connaissances en ligne de commande

### 2. **[Installation Windows Native](installation-windows.md)**
*Pour les utilisateurs Windows expérimentés*
- ✅ Installation directe avec Python
- ✅ Scripts batch fournis
- ✅ Pas de virtualisation
- ❌ Configuration Python parfois complexe

### 3. **[Installation Docker sur Windows](installation-docker-windows.md)**
*Recommandé pour Windows*
- ✅ Environnement isolé et reproductible
- ✅ Scripts automatisés
- ✅ Évite les conflits Python
- ❌ Nécessite Docker Desktop

### 4. **[Installation ESPHome Add-on](installation-ha-addon.md)**
*Le plus simple pour les utilisateurs Home Assistant*
- ✅ Interface graphique intégrée
- ✅ Aucune installation externe
- ✅ Intégration automatique dans HA
- ❌ Limité à l'environnement Home Assistant

---

## 🤔 Quelle Méthode Choisir ?

### 🏠 **Vous utilisez Home Assistant ?**
→ **[ESPHome Add-on](installation-ha-addon.md)** *(le plus simple)*

### 💻 **Vous êtes sur macOS ?**
→ **[Installation macOS Native](installation-macos.md)** *(recommandé)*

### 🪟 **Vous êtes sur Windows ?**
- **Débutant** → **[Docker Windows](installation-docker-windows.md)** *(plus stable)*
- **Expérimenté** → **[Windows Native](installation-windows.md)** *(plus direct)*

### 🐧 **Vous êtes sur Linux ?**
→ Suivez le guide **[macOS Native](installation-macos.md)** (compatible, remplacez `brew` par votre gestionnaire de paquets)

---

## 📋 Prérequis Généraux

Quelle que soit la méthode choisie, vous aurez besoin de :

### 🔧 Matériel
- **ESP32** compatible (voir [section Hardware](../hardware/))
- **Câble USB** de données (pas seulement charge)
- **Accès Wi-Fi** pour l'ESP32

### 💻 Logiciel
- **Home Assistant** avec intégration **MQTT** configurée
- **Git** pour cloner le projet (optionnel, téléchargement zip possible)

### 📚 Fichiers de Configuration
Tous préparés dans le projet :
- `esphome-acw02-fr.yaml` - Configuration française
- `esphome-acw02-en.yaml` - Configuration anglaise  
- `secrets.yaml` - Identifiants Wi-Fi (à personnaliser)

---

## ⚡ Démarrage Rapide

### 1️⃣ Récupérer les Fichiers
```bash
# Méthode Git (recommandé)
git clone https://github.com/devildant/acw02_esphome.git
cd acw02_esphome

# Ou téléchargez le ZIP depuis GitHub
```

### 2️⃣ Choisir Votre Méthode
Cliquez sur une des méthodes ci-dessus selon votre système.

### 3️⃣ Configurer
1. **Copier** le fichier YAML de votre langue
2. **Éditer** `secrets.yaml` avec vos identifiants Wi-Fi
3. **Modifier** la configuration selon votre matériel ESP32

### 4️⃣ Compiler et Flash
Suivez les instructions spécifiques à votre méthode d'installation.

---

## 🔍 Après l'Installation

Une fois l'ESP32 flashé et connecté :

1. **✅ Vérifiez la connectivité** : `ping [nom-device].local`
2. **✅ Accédez à l'interface web** : `http://[nom-device].local/`
3. **✅ Configurez MQTT** dans l'interface web
4. **✅ Testez les contrôles** de climatisation

---

## 🆘 Besoin d'Aide ?

### 📖 Documentation Utile
- **[Détails de l'Interface](../usage/interface-details.md)** - Comprendre les contrôles
- **[Guide de Dépannage](../usage/troubleshooting.md)** - Résoudre les problèmes
- **[Configuration Avancée](../usage/configuration.md)** - Personnalisation

### 🐛 Problèmes Courants
- **Port USB non détecté** → Vérifiez le câble et les pilotes
- **Compilation échoue** → Vérifiez la syntaxe YAML et les versions
- **Wi-Fi ne se connecte pas** → Contrôlez `secrets.yaml`
- **MQTT ne fonctionne pas** → Vérifiez la configuration dans Home Assistant

### 💬 Support Communautaire
- **[Issues GitHub](https://github.com/devildant/acw02_esphome/issues)** - Signaler des bugs
- **[Discussions](https://github.com/devildant/acw02_esphome/discussions)** - Questions générales