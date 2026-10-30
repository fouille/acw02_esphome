# 🎨 Configuration des Presets Personnalisés

Guide complet pour créer, gérer et optimiser les presets de votre climatisation ACW02.

---

## 🎯 Qu'est-ce qu'un Preset ?

### Définition
Un **preset** est une **configuration sauvegardée** de votre climatisation incluant :
- 🌡️ **Température cible**
- ❄️ **Mode** (Cool, Heat, Auto, etc.)
- 💨 **Vitesse ventilateur**
- 🔄 **Oscillations** (horizontale/verticale)
- ⚡ **Options spéciales** (Éco, Nuit, Purificateur)

### Avantages
- ⚡ **Activation rapide** d'un ensemble de paramètres
- 🏠 **Intégration HA** via entité climate 
- 🤖 **Automatisation** avec scénarios/automations
- 📱 **Contrôle simplifié** (un bouton = configuration complète)

---

## 🛠️ Créer des Presets

### Via Interface Web ESP32

#### 1️⃣ Préparer la Configuration
1. **Allumer la climatisation** avec la télécommande ou l'interface
2. **Régler tous les paramètres** comme souhaité :
   - Température (ex: 22°C)
   - Mode (ex: Cool)
   - Vitesse ventilateur (ex: Auto)
   - Oscillations (ex: Horizontale On)
   - Options (ex: Mode nuit activé)

#### 2️⃣ Sauvegarder le Preset
1. **Accéder à l'interface web** : `http://acw02-salon.local/`
2. **Section Configuration** → **Preset Configuration**
3. **Choisir un numéro** de preset libre (F)
4. **Entrer un nom** significatif (G) - 22 caractères max
5. **Cliquer \"Store current AC state\"** (H)

#### 3️⃣ Activer les Presets dans l'Entité Climate  
1. **Cocher \"Add presets to climate entity\"** (E)
2. **Cliquer \"Recreate Climate Entity\"** pour appliquer
3. **Vérifier dans Home Assistant** → Les presets apparaissent

---

## 🏆 Presets Recommandés

### 🌙 Preset \"Nuit\" 
**Objectif** : Sommeil confortable et silencieux
```
Température : 24°C (été) / 20°C (hiver)
Mode : Cool / Heat selon saison
Ventilateur : 1 ou 2 (silencieux)
Oscillation H : Off (éviter courant d'air direct)
Oscillation V : Position médiane fixe
Mode Nuit : ✅ Activé
Purificateur : Off (silencieux)
```

### 🏠 Preset \"Confort\"
**Objectif** : Usage quotidien optimal
```
Température : 22°C (été) / 21°C (hiver) 
Mode : Cool / Heat selon saison
Ventilateur : Auto
Oscillation H : ✅ Activée (répartition homogène)
Oscillation V : Auto ou position médiane
Mode Éco : Off (performance prioritaire)
Purificateur : ✅ Activé si supporté
```

### 💚 Preset \"Éco\"
**Objectif** : Économie d'énergie  
```
Température : 26°C (été) / 19°C (hiver)
Mode : Cool + Éco / Heat
Ventilateur : Auto ou faible
Oscillation H : ✅ Activée
Oscillation V : Auto
Mode Éco : ✅ Activé si Cool
Purificateur : Off (économie)
```

### 🚀 Preset \"Turbo\"
**Objectif** : Refroidissement/chauffage rapide
```
Température : 18°C (été) / 25°C (hiver)
Mode : Cool / Heat  
Ventilateur : 5 (maximum)
Oscillation H : ✅ Activée
Oscillation V : Balayage complet
Mode Éco : Off
Purificateur : ✅ Activé
```

### 🏢 Preset \"Travail\"
**Objectif** : Bureau/télétravail
```
Température : 23°C (été) / 21°C (hiver)
Mode : Cool / Heat
Ventilateur : 2 ou 3 (pas trop fort)
Oscillation H : Off (éviter papiers qui volent)
Oscillation V : Position haute (au-dessus tête)
Mode Nuit : Off
Purificateur : ✅ Activé (qualité air)
```

### 🍽️ Preset \"Repas\"
**Objectif** : Confort pendant les repas
```
Température : 23°C (été) / 22°C (hiver)
Mode : Cool / Heat
Ventilateur : 1 ou 2 (discret)
Oscillation H : Off (éviter courant d'air sur table)
Oscillation V : Position basse ou médiane
Mode Nuit : ✅ Activé (silencieux)
```

---

## 🎮 Utilisation des Presets

### Dans Home Assistant

#### Via Interface Lovelace
```yaml
# Carte climate avec presets
type: thermostat
entity: climate.acw02_salon
features:
  - type: climate-preset-modes
    preset_modes:
      - \"Nuit\"
      - \"Confort\"  
      - \"Éco\"
      - \"Turbo\"
```

#### Via Services HA
```yaml
# Service call pour activer preset
service: climate.set_preset_mode
target:
  entity_id: climate.acw02_salon
data:
  preset_mode: \"Nuit\"
```

### Via MQTT Direct
```bash
# Activer preset \"Confort\"
mosquitto_pub -h 192.168.1.100 -t \"homeassistant/select/acw02_salon_preset/command\" -m \"Confort\"
```

---

## 🤖 Automations avec Presets

### Automation \"Modes Selon Heure\"

```yaml
# automation.yaml Home Assistant
- alias: \"Climatisation - Modes automatiques selon heure\"
  trigger:
    - platform: time
      at: \"07:00:00\"
      id: \"matin\"
    - platform: time  
      at: \"18:00:00\"
      id: \"soiree\"
    - platform: time
      at: \"22:30:00\" 
      id: \"nuit\"
  condition:
    - condition: state
      entity_id: climate.acw02_salon
      state: 
        - \"cool\"
        - \"heat\"
  action:
    - choose:
        - conditions:
            - condition: trigger
              id: \"matin\"
          sequence:
            - service: climate.set_preset_mode
              target:
                entity_id: climate.acw02_salon
              data:
                preset_mode: \"Confort\"
        - conditions:
            - condition: trigger
              id: \"soiree\"  
          sequence:
            - service: climate.set_preset_mode
              target:
                entity_id: climate.acw02_salon
              data:
                preset_mode: \"Travail\"
        - conditions:
            - condition: trigger
              id: \"nuit\"
          sequence:
            - service: climate.set_preset_mode
              target:
                entity_id: climate.acw02_salon  
              data:
                preset_mode: \"Nuit\"
```

### Automation \"Preset Selon Présence\"

```yaml
- alias: \"Climatisation - Preset selon présence\"
  trigger:
    - platform: state
      entity_id: binary_sensor.presence_salon
      to: \"on\"
      id: \"presence\"
    - platform: state
      entity_id: binary_sensor.presence_salon
      to: \"off\"
      for: \"01:00:00\"  # Absent 1h
      id: \"absence\"
  condition:
    - condition: state
      entity_id: climate.acw02_salon
      state:
        - \"cool\"  
        - \"heat\"
  action:
    - choose:
        - conditions:
            - condition: trigger
              id: \"presence\"
            - condition: time
              after: \"07:00:00\"
              before: \"23:00:00\"
          sequence:
            - service: climate.set_preset_mode
              target:
                entity_id: climate.acw02_salon
              data:
                preset_mode: \"Confort\"
        - conditions:
            - condition: trigger
              id: \"absence\"
          sequence:
            - service: climate.set_preset_mode  
              target:
                entity_id: climate.acw02_salon
              data:
                preset_mode: \"Éco\"
```

---

## 🔧 Gestion Avancée des Presets

### Modification d'un Preset Existant

#### Méthode 1 : Recréer
1. **Configurer climatisation** avec nouveaux paramètres
2. **Sélectionner le preset** à modifier (F)
3. **Cliquer \"Store current AC state\"** (H) - écrase l'ancien

#### Méthode 2 : Supprimer et Recréer
1. **Sélectionner le preset** (F)
2. **Cliquer \"Delete preset\"** (I)
3. **Créer un nouveau** preset avec le même nom

### Sauvegarde des Presets

#### Via Interface Web (Capture d'écran)
Les presets sont **stockés dans l'ESP32**, pas dans Home Assistant :
- **Faire des captures d'écran** de la configuration
- **Noter les paramètres** dans un fichier texte
- **Sauvegarder avant reflash** du firmware

#### Script de Documentation
```bash
#!/bin/bash
# backup_presets.sh - Documentation automatique des presets

echo \"=== SAUVEGARDE PRESETS ACW02 $(date) ===\" > presets_backup.txt
echo \"\" >> presets_backup.txt

# Liste des presets depuis MQTT (nécessite mosquitto-clients)
mosquitto_sub -h 192.168.1.100 -t \"homeassistant/select/acw02_salon_preset/state\" -C 1 >> presets_backup.txt

echo \"Sauvegarde terminée dans presets_backup.txt\"
```

---

## 📱 Interface Utilisateur Personnalisée

### Carte Lovelace Avancée

```yaml
# Configuration Lovelace pour contrôle presets
type: vertical-stack
cards:
  # Carte principale climate
  - type: thermostat
    entity: climate.acw02_salon
    
  # Boutons presets rapides
  - type: horizontal-stack
    cards:
      - type: button
        entity: climate.acw02_salon
        name: \"🌙 Nuit\"
        tap_action:
          action: call-service
          service: climate.set_preset_mode
          target:
            entity_id: climate.acw02_salon
          service_data:
            preset_mode: \"Nuit\"
      - type: button 
        entity: climate.acw02_salon
        name: \"🏠 Confort\"
        tap_action:
          action: call-service
          service: climate.set_preset_mode
          target:
            entity_id: climate.acw02_salon
          service_data:
            preset_mode: \"Confort\"
      - type: button
        entity: climate.acw02_salon
        name: \"💚 Éco\"
        tap_action:
          action: call-service
          service: climate.set_preset_mode
          target:
            entity_id: climate.acw02_salon  
          service_data:
            preset_mode: \"Éco\"
            
  # Carte état actuel détaillé
  - type: entities
    title: \"État Climatisation\"
    entities:
      - entity: sensor.acw02_salon_temperature
        name: \"Température actuelle\"
      - entity: select.acw02_salon_preset
        name: \"Preset actuel\"
      - entity: select.acw02_salon_fan_speed
        name: \"Vitesse ventilateur\"
      - entity: switch.acw02_salon_swing_horizontal
        name: \"Oscillation H\"
```

---

## 📊 Monitoring et Statistiques

### Suivi Usage des Presets

#### Capteur Utilisation
```yaml
# configuration.yaml Home Assistant
sensor:
  - platform: history_stats
    name: \"Usage Preset Nuit\"
    entity_id: select.acw02_salon_preset
    state: \"Nuit\"
    type: time
    start: \"{{ now().replace(hour=0, minute=0, second=0) }}\"
    end: \"{{ now() }}\"
    
  - platform: history_stats
    name: \"Usage Preset Confort\"
    entity_id: select.acw02_salon_preset 
    state: \"Confort\"
    type: time
    start: \"{{ now().replace(hour=0, minute=0, second=0) }}\"
    end: \"{{ now() }}\"
```

#### Graphiques d'Usage
```yaml
# Carte graphique utilisation presets
type: history-graph
entities:
  - entity: sensor.usage_preset_nuit
    name: \"Nuit\"
  - entity: sensor.usage_preset_confort
    name: \"Confort\"
  - entity: sensor.usage_preset_eco
    name: \"Éco\"
hours_to_show: 24
refresh_interval: 300
```

---

## 💡 Conseils d'Optimisation

### Nommage Efficace
- **Court et explicite** : \"Nuit\", \"Éco\", \"Turbo\"
- **Émojis possibles** : \"🌙 Nuit\", \"💚 Éco\" (selon interface)
- **Cohérence** : Même logique pour tous les presets

### Organisation par Usage
- **Temporel** : Matin, Jour, Soir, Nuit
- **Fonctionnel** : Travail, Repos, Sport, Repas  
- **Performance** : Éco, Normal, Turbo
- **Saisonnier** : Été-Cool, Hiver-Heat

### Test et Validation
1. **Tester chaque preset** individuellement
2. **Vérifier tous les paramètres** après activation
3. **Mesurer consommation** pour presets Éco
4. **Ajuster selon retours** famille/utilisateurs

---

## 🚨 Limitations et Contraintes

### Contraintes Techniques
- **Maximum presets** : Dépend de la mémoire ESP32 (~10-20 presets)
- **Noms limités** : 22 caractères maximum
- **Sauvegarde** : Dans ESP32, perdue si reflash sans sauvegarde
- **Conflit oscillation** : Si presets activés, oscillation H désactivée dans entité climate

### Incompatibilités
- **Mode Auto + Éco** : Parfois incompatibles selon modèle climatisation
- **Oscillation V + modes spéciaux** : Certaines combinaisons non supportées
- **Température hors limites** : Respecter 16-32°C selon modèle

---

## 🔗 Ressources Complémentaires  

- **[Interface Détails](../usage/interface-details.md#-utilisation-des-presets)** - Fonctionnement interface web
- **[Configuration Avancée](../usage/configuration.md#-configuration-des-presets)** - Paramétrage YAML
- **[MQTT-Only](mqtt-only.md)** - Usage presets via MQTT pur
- **[Jeedom](jeedom-integration.md#-scénarios-jeedom)** - Intégration presets dans Jeedom