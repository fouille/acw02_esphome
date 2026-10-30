# 🚀 Installation sur macOS

## 🖥️ Environnement Testé
- Mac Mini 2018
- 3 GHz Intel Core i5 (6 cœurs)
- 8 GB 2667 MHz DDR4
- macOS 15.7 (24G222)

## 📋 Prérequis
1. Cloner le dépôt :
   ```bash
   git clone https://github.com/devildant/acw02_esphome.git
   ```
2. Copier le fichier YAML pour votre langue préférée, par exemple :
   ```bash
   cp esphome-acw02-fr.yaml mon-esphome-acw02.yaml
   ```
   > ℹ️ Le fichier peut être `esphome-acw02-fr.yaml` ou `esphome-acw02-en.yaml` selon la langue souhaitée.
3. Configurer `mon-esphome-acw02.yaml` et `secrets.yaml`.

---

# ⚡ ESPHome : Installation, Compilation et Flash

## 1️⃣ Installation d'ESPHome
Installer une version spécifique d'ESPHome via Homebrew :

```bash
brew install esphome@2026.7.0
esphome version  # devrait retourner 2026.7.0
```

---

## 2️⃣ Compilation et Exécution
```bash
esphome run mon-esphome-acw02.yaml
```

---

## 3️⃣ Choisir la Méthode de Téléchargement
Après compilation, ESPHome affichera plusieurs options de téléchargement :

```text
INFO Package configuration completed successfully
INFO Package configuration completed successfully
INFO Successfully compiled program.
Found multiple options for uploading, please choose one:
  [1] /dev/cu.usbserial-0001 (CP2102 USB to UART Bridge Controller - CP2102 USB to UART Bridge Controller)
  [2] Over The Air (acw02-salon.local)
  [3] Manually deploy (generate .bin file)
```

### 🔌 Premier Flash (via USB)
Pour le premier flash, sélectionnez l'option USB (ex: `[1]`) :
```text
(1): /dev/cu.usbserial-0001
```

### 📡 Mises à Jour Suivantes (OTA - Over The Air)
Pour les mises à jour futures, vous pouvez utiliser l'option réseau (ex: `[2]`) :
```text
(2): Over The Air (acw02-salon.local)
```

---

## 🔍 Résolution des Problèmes

### Problème : Port USB non détecté
Si aucun port USB n'apparaît :
1. **Vérifiez le câble USB** - Utilisez un câble USB **de données** (pas seulement charge)
2. **Installez les pilotes CH340/CP2102** si nécessaire
3. **Vérifiez les ports disponibles** :
   ```bash
   ls /dev/cu.*
   ```

### Problème : Permission refusée
```bash
sudo chmod 666 /dev/cu.usbserial-*
```

### Problème : ESPHome non trouvé après installation
Redémarrez votre terminal ou sourcez votre profil :
```bash
source ~/.zshrc
# ou
source ~/.bash_profile
```

---

## 📦 Mise à Jour d'ESPHome

Pour mettre à jour ESPHome vers une version plus récente :
```bash
brew upgrade esphome
```

Pour installer une version spécifique :
```bash
brew uninstall esphome
brew install esphome@2026.7.0
```

---

## ✅ Vérification de l'Installation

Une fois le flash terminé avec succès, vous devriez voir :
- L'ESP32 apparaître dans Home Assistant (si l'intégration ESPHome est activée)
- Le serveur web accessible via `http://[nom-device].local/`
- Les entités MQTT apparaître dans MQTT (si configuré)

---

## 🔗 Prochaines Étapes

1. **[Configuration du Hardware](../hardware/)** - Choisir et configurer votre carte ESP32
2. **[Détails de l'Interface](../usage/interface-details.md)** - Comprendre l'interface utilisateur
3. **[Configuration Avancée](../usage/configuration.md)** - Personnaliser votre installation