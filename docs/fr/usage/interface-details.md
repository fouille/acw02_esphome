# 🔍 Détails de l'Interface Utilisateur

## 🎛️ Contrôles Disponibles

![controls](../../../docs/images/controles.PNG)
![controls](../../../docs/images/presetUsage.PNG)

| #  | Description |
|---:|-------------|
| 1  | Entité Climat (configurée dans la section ci-dessous) |
| 2  | Option Nettoyage — disponible quand la climatisation est éteinte |
| 3  | Option Affichage |
| 4  | Option Éco — disponible quand le mode est \"cool\" et la climatisation allumée |
| 5  | Vitesse du ventilateur — disponible quand la climatisation est allumée et éco désactivé |
| 6  | Oscillation horizontale (sélection) |
| 7  | Mode climatisation (sélection) |
| 8  | Mode nuit — disponible quand le mode est cool/dry/heat et la climatisation allumée |
| 9  | Purificateur — disponible quand la climatisation est allumée |
| 10 | Température cible — indisponible quand éco est activé ou mode auto |
| 11 | Unité de température (°C ou °F) (sélection) |
| 12 | Oscillation verticale (sélection) |
|  A | Presets configurés (voir section ⚙️ Configuration) |

---

## 📡 Capteurs Disponibles

![sensor](../../../docs/images/sensor2.PNG)

| #  | Description |
|---:|-------------|
| 1  | Source de la dernière commande — Indique si la dernière commande vient de l'ESP ou de la télécommande |
| 2  | Erreur climatisation détectée |
| 3  | Information erreur climatisation |
| 4  | État du filtre — Indique si un nettoyage est nécessaire (`OK` si tout va bien) |
| 5  | Température ambiante — La température actuelle rapportée par la climatisation |
| 6  | Avertissement climatisation détecté |
| 7  | Information avertissement climatisation |

---

## ⚙️ Configuration et Paramètres

![config](../../../docs/images/config.PNG)
![config](../../../docs/images/resetECOPurifierACOFF2.PNG)
![config](../../../docs/images/z-cmd2.PNG)
![config](../../../docs/images/presetConfig.PNG)

| #  | Description |
|---:|-------------|
| 1  | Détruire et recréer l'entité Climat pour refléter les options comme éco |
| 2  | Activer la version MQTT de la commande G1, exclusion Z-config et diagnostic (utile si vous n'utilisez pas l'intégration ESPHome dans Home Assistant, ou si vous voulez utiliser le module sur Jeedom) |
| 3  | Couper le son de toutes les commandes envoyées de l'ESP vers la climatisation (sauf pour l'action de nettoyage) |
| 4  | Détruire et recréer toutes les entités MQTT |
| 5  | Demander une mise à jour du statut de la climatisation |
| 6  | Redémarrer l'ESP |
| 7  | ![Mandatory](https://img.shields.io/badge/-OBLIGATOIRE-darkred?style=flat-square) IP MQTT (auto-sauvegardé ; le bouton valider redémarre seulement l'ESP) |
| 8  | ![Mandatory](https://img.shields.io/badge/-OBLIGATOIRE-darkred?style=flat-square) Nom d'utilisateur MQTT (auto-sauvegardé ; le bouton valider redémarre seulement l'ESP) |
| 9  | ![Mandatory](https://img.shields.io/badge/-OBLIGATOIRE-darkred?style=flat-square) Mot de passe MQTT (auto-sauvegardé ; le bouton valider redémarre seulement l'ESP) |
| 10 | ![Mandatory](https://img.shields.io/badge/-OBLIGATOIRE-darkred?style=flat-square) Port MQTT (auto-sauvegardé ; le bouton valider redémarre seulement l'ESP) |
| 11 | Redémarrer l'ESP pour appliquer les changements d'accès MQTT |
| 12 | Désactiver le mode \"Auto\" (auto-sauvegardé ; le bouton valider recréera les entités MQTT) |
| 13 | Désactiver le mode \"Dry\" (auto-sauvegardé ; le bouton valider recréera les entités MQTT) |
| 14 | Désactiver le mode \"Fan only\" (auto-sauvegardé ; le bouton valider recréera les entités MQTT) |
| 15 | Désactiver le mode \"Heat\" (auto-sauvegardé ; le bouton valider recréera les entités MQTT) |
| 16 | Désactiver l'oscillation horizontale (auto-sauvegardé ; le bouton valider recréera les entités MQTT) |
| 17 | Désactiver l'oscillation verticale (auto-sauvegardé ; le bouton valider recréera les entités MQTT) |
| 18 | Recréer manuellement les entités MQTT (pour appliquer les paramètres de désactivation) |
| A  | Option pour réinitialiser ou non éco/purificateur quand la climatisation est éteinte |
| B  | Délai de publication d'état (en ms) entre 2 commandes après mise sous tension, valeur possible [0-1000] (max 1s), 0 pour désactiver cette fonctionnalité |
| C  | Délai de silence (en ms) entre 2 commandes, valeur possible [0-60000] (max 60s), 0 pour désactiver cette fonctionnalité |
| D  | Délai de silence (en ms) entre 2 commandes après mise sous tension, valeur possible [0-60000] (max 60s), 0 pour désactiver cette fonctionnalité |
| E  | Option pour ajouter des presets à l'entité climat. Cependant, si l'oscillation H est également activée dans l'entité climat, elle sera désactivée |
| F  | Choisir un preset dans la liste à configurer |
| G  | Entrer un nom pour le preset sélectionné (limite 22 caractères) |
| H  | Sauvegarder l'état actuel de la climatisation dans le preset sélectionné (attention : si l'option silence est activée, le preset sera sauvé comme muet sans activer le silence) |
| I  | Supprimer le preset sélectionné |

---

## 🧪 Diagnostics Système

![diag](../../../docs/images/diag.PNG)

| #  | Description |
|---:|-------------|
| 1  | Température interne de l'ESP |
| 2  | Mémoire libre |
| 3  | Version de build ESPHome |
| 4  | État de connexion MQTT |
| 5  | BSSID Wi-Fi |
| 6  | Nom du point d'accès Wi-Fi |
| 7  | Adresse IP Wi-Fi |
| 8  | Adresse MAC Wi-Fi |
| 9  | Nom de domaine local pour l'accès web à l'ESP |
| 10 | Qualité du signal Wi-Fi |

---

## 🌐 Interface Web (exemple d'accès : http://acw02-salon.local/)

### Version Française
![webfr](../../../docs/images/FR-WEB.PNG)

### Version Anglaise
![weben](../../../docs/images/EN-WEB.PNG)

---

## 📋 Configuration MQTT Obligatoire

### Paramètres Essentiels
Pour que le module fonctionne, vous **devez** configurer :

1. **Adresse IP du broker MQTT** (ex: 192.168.1.100)
2. **Nom d'utilisateur MQTT** 
3. **Mot de passe MQTT**
4. **Port MQTT** (généralement 1883)

### Configuration dans Home Assistant
Si vous utilisez le broker MQTT intégré de Home Assistant :
1. **Supervisor** → **Add-on Store** → **Mosquitto broker**
2. **Paramètres** → **Intégrations** → **MQTT** → **Configurer**
3. Utiliser les identifiants créés

---

## 🎮 Utilisation des Presets

### Créer un Preset Personnalisé
1. **Réglez votre climatisation** comme souhaité (température, mode, ventilation, etc.)
2. **Choisissez un numéro** de preset (F)
3. **Donnez-lui un nom** (G) - 22 caractères maximum
4. **Cliquez \"Sauvegarder\"** (H)
5. **Le preset apparaît** dans l'entité climat de Home Assistant

### Utiliser un Preset
- **Dans Home Assistant** : Sélectionnez le preset dans l'entité climat
- **Via MQTT** : Publiez le nom du preset sur le topic correspondant

### Supprimer un Preset
1. **Sélectionnez le preset** à supprimer (F)
2. **Cliquez \"Supprimer\"** (I)
3. **Recréez les entités MQTT** si nécessaire (1 ou 18)

---

## 🔧 Options Avancées

### Mode Silencieux (Mute)
- **Activer** : Empêche l'ESP d'envoyer des commandes à la climatisation
- **Utile pour** : Tests, débogage, ou utilisation manuelle uniquement
- **Attention** : Le nettoyage (clean) fonctionne même en mode silencieux

### Délais de Communication
- **Délai publication** (B) : Temps entre commandes après allumage
- **Délai silence** (C/D) : Évite la surcharge de commandes
- **Valeurs recommandées** : 200-500ms pour la plupart des installations

### Désactivation de Modes
Vous pouvez désactiver certains modes si votre climatisation ne les supporte pas :
- **Auto** - Mode automatique
- **Dry** - Mode déshumidification  
- **Fan Only** - Ventilation seule
- **Heat** - Mode chauffage

---

## 🧩 Intégration Home Assistant

### Entités Automatiques
Le module crée automatiquement dans Home Assistant :
- **climate.acw02_xxx** - Contrôle principal
- **sensor.acw02_xxx_temperature** - Température ambiante
- **sensor.acw02_xxx_filter_status** - État du filtre
- **switch.acw02_xxx_display** - Affichage
- **Et bien d'autres...**

### Personnalisation Interface
```yaml
# Dans configuration.yaml de Home Assistant
customize:
  climate.acw02_salon:
    friendly_name: \"Climatisation Salon\"
    icon: mdi:air-conditioner
```

### Automations Utiles
```yaml
# Extinction automatique après 8h
automation:
  - alias: \"Clim éteinte après 8h\"
    trigger:
      platform: state
      entity_id: climate.acw02_salon
      to: \"cool\"
      for:
        hours: 8
    action:
      service: climate.turn_off
      entity_id: climate.acw02_salon
```

---

## 🔍 Résolution de Problèmes Interface

### Problème : Interface Web Inaccessible
1. **Vérifier l'adresse IP** : `ping [nom-device].local`
2. **Contrôler le Wi-Fi** : Voir les diagnostics (10)
3. **Redémarrer l'ESP** : Bouton (6) ou alimentation

### Problème : Entités Manquantes dans HA
1. **Vérifier MQTT** : Configuration (7-11)
2. **Recréer les entités** : Bouton (4)
3. **Redémarrer HA** si nécessaire

### Problème : Commandes Non Répondues
1. **Vérifier le mode silencieux** : Désactiver (3)
2. **Contrôler les délais** : Ajuster (B/C/D)
3. **Tester manuellement** : Télécommande originale

### Problème : Presets Non Visibles
1. **Activer les presets** : Option (E)
2. **Recréer l'entité climat** : Bouton (1)
3. **Vérifier les noms** : 22 caractères max

---

## 🔗 Prochaines Étapes

1. **[Configuration Avancée](configuration.md)** - Personnaliser votre installation
2. **[Guide de Dépannage](troubleshooting.md)** - Résoudre les problèmes courants
3. **[Utilisation MQTT Seule](../advanced/mqtt-only.md)** - Sans intégration ESPHome