# 📖 Guide d'Utilisation ACW02

Une fois votre module installé et fonctionnel, voici comment l'utiliser et le configurer selon vos besoins.

---

## 🚀 Premiers Pas

### ✅ Vérification Post-Installation
Après installation réussie, vérifiez que :
- [ ] **ESP32 accessible** via `http://[nom-device].local/`
- [ ] **Entités visibles** dans Home Assistant
- [ ] **MQTT configuré** dans l'interface web
- [ ] **Climatisation répond** aux commandes de test

### 🎯 Configuration Initiale Rapide
1. **[Accéder à l'interface web](interface-details.md#-interface-web)**
2. **[Configurer MQTT](interface-details.md#-configuration-mqtt-obligatoire)**
3. **[Tester les contrôles de base](interface-details.md#-contrôles-disponibles)**
4. **[Créer vos premiers presets](interface-details.md#-utilisation-des-presets)**

---

## 📚 Guides Disponibles

### 🎛️ **[Détails de l'Interface](interface-details.md)**
*Comprendre tous les contrôles et capteurs disponibles*
- **Contrôles climatisation** - Température, mode, ventilation
- **Capteurs** - État, erreurs, température ambiante
- **Configuration MQTT** - Paramètres obligatoires
- **Presets personnalisés** - Créer et utiliser des configurations rapides
- **Diagnostics système** - Surveiller l'état du module

### ⚙️ **[Configuration Avancée](configuration.md)**
*Personnaliser et optimiser votre installation*
- **Configuration YAML** - Paramètres substitutions et sécurité
- **Wi-Fi avancé** - IP statique, optimisations signal
- **Intégration Home Assistant** - MQTT, automations, personnalisation
- **Performance** - Délais, monitoring, logs
- **Sécurité** - Authentification, chiffrement, sauvegardes

### 🛠️ **[Guide de Dépannage](troubleshooting.md)**
*Résoudre les problèmes courants*
- **Connexion Wi-Fi** - Signal faible, déconnexions
- **Problèmes MQTT** - Entités manquantes, broker inaccessible
- **Communication climatisation** - Commandes ignorées, états incorrects
- **Interface web** - Accès, authentification, mise à jour
- **Diagnostic système** - Outils et procédures

---

## 🎯 Cas d'Usage Courants

### 🏠 Utilisation Domestique Standard
**Objectif** : Contrôler sa climatisation via Home Assistant
1. **[Configuration de base](configuration.md#-configuration-de-base)**
2. **[Création de presets](interface-details.md#-utilisation-des-presets)** (Nuit, Confort, Éco)
3. **[Intégration HA](configuration.md#-configuration-home-assistant)** avec automations

### 🏢 Installation Multi-Zones
**Objectif** : Gérer plusieurs climatiseurs
1. **[Configuration multi-climatiseurs](configuration.md#-configurations-avancées)**
2. **Nommage cohérent** des dispositifs
3. **Centralisation MQTT** pour monitoring global

### 🔧 Installation Technique Avancée
**Objectif** : Performance et fiabilité maximales
1. **[Optimisations performance](configuration.md#-optimisations-de-performance)**
2. **[Monitoring système](troubleshooting.md#-outils-de-diagnostic)**
3. **[Sauvegardes automatiques](configuration.md#-sauvegarde-et-restauration)**

---

## 🎮 Contrôles Principaux

### 🌡️ **Température et Modes**
```yaml
# Modes disponibles (selon votre modèle)
- Cool (Refroidissement)
- Heat (Chauffage) 
- Auto (Automatique)
- Dry (Déshumidification)
- Fan Only (Ventilation seule)
```

### 💨 **Ventilation et Oscillation**
- **Vitesse ventilateur** : Auto, 1, 2, 3, 4, 5
- **Oscillation horizontale** : On/Off
- **Oscillation verticale** : Positions multiples

### ⚡ **Fonctions Spéciales**
- **Mode Éco** : Économie d'énergie
- **Mode Nuit** : Fonctionnement silencieux
- **Nettoyage automatique** : Maintenance filtre
- **Purificateur d'air** : Si supporté

---

## 📊 Surveillance et Maintenance

### 📈 **Monitoring Continu**
- **Signal Wi-Fi** : > -70 dBm recommandé
- **Température ESP32** : < 60°C normal
- **Uptime** : Redémarrage si < 24h fréquent
- **Erreurs MQTT** : Surveiller déconnexions

### 🔄 **Maintenance Préventive**
| Fréquence | Action | Description |
|-----------|--------|-------------|
| **Hebdomadaire** | Vérifier logs | Erreurs récurrentes |
| **Mensuel** | Nettoyer filtre clim | Via fonction \"Clean\" |
| **Trimestriel** | Mettre à jour firmware | Nouvelles versions ESPHome |
| **Annuel** | Vérifier connexions | Soudures, contacts |

---

## 🏆 Bonnes Pratiques

### ✅ **Recommandations d'Usage**
1. **Utiliser des presets** plutôt que des réglages manuels répétés
2. **Configurer des automations** pour usage quotidien
3. **Surveiller les logs** régulièrement
4. **Créer des sauvegardes** de configuration
5. **Tester après chaque modification**

### ⚠️ **À Éviter**
- **Commandes trop rapprochées** (respecter les délais)
- **Modifications simultanées** interface web + télécommande
- **Exposition directe** aux intempéries (même boîtier étanche)
- **Alimentation instable** (vérifier régulateur)

---

## 🔄 Workflow Typique

### 🌅 **Installation Nouvelle Climatisation**
1. **[Choisir le matériel](../hardware/)** adapté
2. **[Installer ESPHome](../installation/)** selon votre OS
3. **[Assembler le module](../hardware/esp32-d1-mini.md#-assemblage)** avec boîtier 3D
4. **[Configurer les paramètres](configuration.md#-configuration-de-base)**
5. **[Tester tous les contrôles](interface-details.md#-contrôles-disponibles)**
6. **[Créer des presets utiles](interface-details.md#-utilisation-des-presets)**
7. **[Intégrer dans Home Assistant](configuration.md#-intégration-home-assistant)**

### 🔧 **Maintenance d'Installation Existante**
1. **[Vérifier les logs](troubleshooting.md#-analyse-des-logs)** d'erreur
2. **[Mettre à jour firmware](troubleshooting.md#-problèmes-de-mise-à-jour)** si nécessaire
3. **[Optimiser configuration](configuration.md#-optimisations-de-performance)** selon retours d'expérience
4. **[Sauvegarder paramètres](configuration.md#-sauvegarde-et-restauration)** avant modifications

---

## 🆘 Support Rapide

### 🔍 **Auto-Diagnostic**
Problème détecté ? Suivez ce parcours :

1. **🔴 Climatisation ne répond pas** → [Communication UART](troubleshooting.md#-climatisation-ne-répond-pas)
2. **🟡 Interface web inaccessible** → [Problèmes Wi-Fi](troubleshooting.md#-esp32-ne-se-connecte-pas-au-wi-fi)
3. **🟠 Entités manquantes HA** → [Problèmes MQTT](troubleshooting.md#-entités-manquantes-dans-home-assistant)
4. **🔵 Signal Wi-Fi faible** → [Optimisation réseau](troubleshooting.md#-signal-wi-fi-faible-ou-instable)

### 📞 **Obtenir de l'Aide**
- **[Problèmes techniques](https://github.com/devildant/acw02_esphome/issues)** → GitHub Issues
- **[Questions générales](https://github.com/devildant/acw02_esphome/discussions)** → GitHub Discussions  
- **[Support ESPHome](https://community.home-assistant.io/c/esphome/)** → Forum Home Assistant

---

## 🔗 Navigation Rapide

### 📖 **Documentation Technique**
- **[Installation](../installation/)** - Méthodes selon votre OS
- **[Matériel](../hardware/)** - Choix ESP32 et composants
- **[Fonctions Avancées](../advanced/)** - MQTT seul, Jeedom

### 🛠️ **Ressources Pratiques**
- **[Fichiers 3D](../../hardware_new/3d-files/)** - Boîtiers à imprimer
- **[Fichiers PCB](../../hardware_new/pcb/)** - Cartes à fabriquer  
- **[Outils](../../tools_new/)** - Scripts et utilitaires