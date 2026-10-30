# ACW02 ESPHome Module

[🇫🇷 Version Française](docs_new/fr/README-fr.md) | [🇬🇧 English Version](docs_new/en/README-en.md)

---

**Composant ESPHome personnalisé pour les climatiseurs Teknopoint et Airton** utilisant le module Wi-Fi **Tuya ACW02**.

**Custom ESPHome component for Teknopoint and Airton AC units** using the **Tuya ACW02 Wi-Fi module**.

---

## 🚀 Démarrage Rapide / Quick Start

### 📖 Documentation
- [🇫🇷 **Documentation Française Complète**](docs_new/fr/) 
- [🇬🇧 **Complete English Documentation**](docs_new/en/)

### ⚙️ Installation
- [🇫🇷 Guide d'Installation](docs_new/fr/installation/)
- [🇬🇧 Installation Guide](docs_new/en/installation/)

### 🔧 Matériel / Hardware
- [🇫🇷 Cartes PCB & Composants](hardware_new/)
- [🇬🇧 PCB & Components](hardware_new/)

---

## 📊 État de Compilation / Build Status

**ESP32 D1 Mini WROOM 32**  
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/build-d1-mini.json&style=flat-square&label=Build&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/last_passing-d1-mini.json&style=flat-square&label=Last%20passing&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/problem-d1-mini.json&style=flat-square&label=Problem%20version&labelColor=1f2328" height="24">

**Lolin ESP32 C3 mini**  
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/build-lolin-c3.json&style=flat-square&label=Build&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/last_passing-lolin-c3.json&style=flat-square&label=Last%20passing&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/problem-lolin-c3.json&style=flat-square&label=Problem%20version&labelColor=1f2328" height="24">

**XIAO ESP32 C3**  
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/build-xiao-c3.json&style=flat-square&label=Build&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/last_passing-xiao-c3.json&style=flat-square&label=Last%20passing&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/problem-xiao-c3.json&style=flat-square&label=Problem%20version&labelColor=1f2328" height="24">

**XIAO ESP32 C6**  
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/build-xiao-c6.json&style=flat-square&label=Build&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/last_passing-xiao-c6.json&style=flat-square&label=Last%20passing&labelColor=1f2328" height="24"> &nbsp;
<img src="https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/devildant/acw02_esphome/main/.ci/badges/problem-xiao-c6.json&style=flat-square&label=Problem%20version&labelColor=1f2328" height="24">

---

## ⚠️ Compatibilité / Compatibility

> **Important** / **Important**  
> - ✅ **Teknopoint** : Fonctionne sur la plupart des modèles / Works on most units  
> - ✅ **Airton** : Fonctionne sur la plupart des modèles / Works on most units  
> - ❌ **Exception** : Les climatiseurs Airton avec module WiFi 409945 ne sont pas compatibles / Airton AC units with WiFi module 409945 are not compatible

👉 **Liste complète des modèles testés** / **Complete tested models list** : [COMPATIBILITY.md](COMPATIBILITY.md)

---

## 📌 Contribuer / Contribute

Aidez à améliorer ce projet en signalant la compatibilité de votre unité.  
Help improve this project by reporting your unit compatibility.

👉 [🇫🇷 Signaler votre modèle](https://github.com/devildant/acw02_esphome/issues/new?template=unit_report.yml) / [🇬🇧 Submit your unit](https://github.com/devildant/acw02_esphome/issues/new?template=unit_report.yml)

---

## 🛠️ Outils Utiles / Useful Tools

- [🔧 Générateur de QR Code / QR Code Generator](tools_new/create_QRcode_info.html)
- [🐳 Configuration Docker / Docker Setup](tools_new/docker/)
- [📜 Scripts d'aide / Helper Scripts](tools_new/scripts/)

---

## 🛡️ Licence / License

Ce projet utilise plusieurs licences selon le type de contenu :  
This project uses multiple licenses depending on content type:

- **Code** (`*.yaml`, `*.cpp`, `*.h`) — [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)
- **Fichiers PCB** / **PCB files** (`*.zip`, `*.json`) — [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
- **Modèles 3D** / **3D models** (`*.f3d`, `*.stl`) — [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

> L'usage commercial des fichiers PCB et 3D est **strictement interdit**.  
> Commercial use of PCB and 3D files is **strictly prohibited**.