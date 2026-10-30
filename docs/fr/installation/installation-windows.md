# 🔧 Installation Windows Native

## 🐍 Installation de Python

Installez Python 3.12 depuis le Microsoft Store ou téléchargez-le depuis [python.org](https://www.python.org/).

### Vérification de l'Installation
```powershell
python --version
# Devrait afficher: Python 3.12.x
```

---

## 📦 Mise à Jour de pip

```powershell
pip install --upgrade pip
```

---

## 🧱 Installation d'ESPHome

### Installation d'une Version Spécifique
```powershell
pip install esphome==2026.7.0
```

### Vérification de l'Installation
```powershell
esphome version
# Devrait afficher: Version 2026.7.0
```

---

## 📋 Configuration Initiale

### 1️⃣ Cloner le Projet
```powershell
git clone https://github.com/devildant/acw02_esphome.git
cd acw02_esphome
```

### 2️⃣ Copier et Configurer les Fichiers
```powershell
copy esphome-acw02-fr.yaml mon-esphome-acw02.yaml
```

Éditez `mon-esphome-acw02.yaml` et `secrets.yaml` selon vos besoins.

---

## 🛠️ Compilation et Flash

### Utilisation des Scripts Fournis

Pour compiler le firmware en français :
```powershell
build-fr.bat
```

Pour compiler en anglais :
```powershell
build-en.bat
```

### Compilation Manuelle
```powershell
esphome run mon-esphome-acw02.yaml
```

---

## 📊 Surveillance des Logs

Pour voir les logs en temps réel :

**Français :**
```powershell
logs-fr.bat
```

**Anglais :**
```powershell
logs-en.bat
```

**Manuellement :**
```powershell
esphome logs mon-esphome-acw02.yaml
```

---

## 🔍 Résolution des Problèmes

### Problème : Python non trouvé
1. **Vérifiez que Python est dans le PATH** :
   ```powershell
   where python
   ```

2. **Ajoutez Python au PATH** si nécessaire :
   - Paramètres Windows → Système → Paramètres système avancés
   - Variables d'environnement → PATH → Modifier
   - Ajouter le chemin vers Python (ex: `C:\\Users\\[utilisateur]\\AppData\\Local\\Programs\\Python\\Python311\\`)

### Problème : pip install échoue
```powershell
# Utilisez l'option --user si les permissions sont insuffisantes
pip install --user esphome==2026.7.0
```

### Problème : Port série non détecté
1. **Installez les pilotes USB** :
   - CH340/CH341 pour les clones ESP32 bon marché
   - CP2102 pour les cartes officielles

2. **Vérifiez les ports disponibles** :
   ```powershell
   # Dans le Gestionnaire de périphériques
   # Recherchez \"Ports (COM et LPT)\"
   ```

### Problème : Permission refusée sur le port COM
1. **Fermez l'IDE Arduino** (si ouvert)
2. **Fermez le moniteur série** d'autres applications
3. **Exécutez PowerShell en tant qu'administrateur**

---

## 🔄 Mises à Jour

### Mettre à Jour ESPHome
```powershell
pip install --upgrade esphome
```

### Installer une Version Spécifique
```powershell
pip uninstall esphome
pip install esphome==2026.7.0
```

---

## ⚡ Optimisation des Performances

### Accélération de la Compilation
Ajoutez ces variables d'environnement :

```powershell
# Dans PowerShell (temporaire)
$env:PLATFORMIO_BUILD_FLAGS = \"-j4\"
$env:PLATFORMIO_UPLOAD_SPEED = \"921600\"

# Ou ajoutez-les de façon permanente via les Paramètres système
```

### Cache de Compilation
ESPHome utilise automatiquement un cache. Pour le vider si nécessaire :
```powershell
esphome clean-mqtt-discovery mon-esphome-acw02.yaml
esphome clean mon-esphome-acw02.yaml
```

---

## 📂 Structure des Fichiers de Build

```
acw02_esphome/
├── mon-esphome-acw02.yaml    # Votre configuration
├── secrets.yaml              # Vos identifiants Wi-Fi
├── build-fr.bat              # Script de compilation français
├── build-en.bat              # Script de compilation anglais  
├── logs-fr.bat               # Script de logs français
├── logs-en.bat               # Script de logs anglais
└── .esphome/                 # Cache de compilation
    └── build/
        └── [device-name]/    # Fichiers compilés
```

---

## ✅ Vérification de l'Installation

Après un flash réussi :

1. **ESP32 visible dans le réseau** : `ping [nom-device].local`
2. **Interface web accessible** : `http://[nom-device].local/`
3. **Logs en temps réel** : Utilisez `logs-fr.bat`

---

## 🔗 Prochaines Étapes

1. **[Choisir votre Hardware](../hardware/)** - ESP32, LOLIN C3, XIAO, etc.
2. **[Configuration de l'Interface](../usage/interface-details.md)** - Comprendre les contrôles
3. **[Configuration Avancée](../usage/configuration.md)** - Personnaliser votre setup