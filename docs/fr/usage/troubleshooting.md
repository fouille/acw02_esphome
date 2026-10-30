# 🛠️ Guide de Dépannage

Solutions aux problèmes les plus courants rencontrés avec le module ACW02.

---

## 🚨 Problèmes de Connexion

### 🔌 ESP32 Ne Se Connecte Pas au Wi-Fi

#### Symptômes
- LED de l'ESP32 clignote rapidement
- Impossible d'accéder à l'interface web
- Pas d'apparition dans Home Assistant

#### Solutions
1. **Vérifier les identifiants Wi-Fi**
   ```yaml
   # Dans secrets.yaml
   wifi_ssid: \"NomExactDuWiFi\"  # Respecter la casse
   wifi_password: \"MotDePasseExact\"
   ```

2. **Tester le point d'accès de secours**
   - Chercher le réseau `acw02-xxx-fallback`
   - Se connecter avec le mot de passe défini dans `ap_password`
   - Accéder à l'interface de configuration

3. **Vérifier la portée Wi-Fi**
   ```yaml
   # Augmenter la puissance Wi-Fi
   wifi:
     output_power: 20dB
     fast_connect: false
   ```

4. **Diagnostic via logs**
   ```bash
   esphome logs mon-esphome-acw02.yaml
   ```

---

### 📶 Signal Wi-Fi Faible ou Instable

#### Symptômes
- Connexion intermittente
- Interface web lente
- Déconnexions fréquentes

#### Solutions par Carte

##### ESP32 D1 Mini
- ✅ **Acceptable** : Signal > -70 dBm
- ⚠️ **Faible** : Signal -70 à -80 dBm  
- ❌ **Critique** : Signal < -80 dBm

**Actions :**
1. **Rapprocher de la box** Internet
2. **Éviter les obstacles** métalliques
3. **Changer de canal** Wi-Fi (1, 6, ou 11)
4. **Upgrader vers LOLIN C3** ou XIAO C3

##### LOLIN ESP32 C3
- Signal généralement **15-20% meilleur** que D1 Mini
- Si toujours insuffisant → **XIAO C3 avec antenne**

##### XIAO ESP32 C3/C6
- **Vérifier l'antenne externe** si installée
- **Orienter l'antenne** correctement
- **Connecteur U.FL** bien clipsé

#### Test de Signal
```yaml
# Ajouter temporairement pour diagnostiquer
sensor:
  - platform: wifi_signal
    name: \"Signal Wi-Fi Test\"
    update_interval: 10s
```

---

## 🔧 Problèmes MQTT

### 🚫 Connexion MQTT Impossible

#### Symptômes
- \"Connecting to MQTT...\" en boucle
- Entités manquantes dans Home Assistant
- Diagnostics montrent \"MQTT: Disconnected\"

#### Solutions
1. **Vérifier la configuration MQTT**
   - **IP correcte** du broker
   - **Port** (1883 par défaut, 8883 si SSL)
   - **Identifiants** valides

2. **Tester depuis l'interface web**
   - Aller dans **Configuration**
   - Entrer l'IP MQTT : `192.168.1.100`
   - Username/Password MQTT
   - Cliquer **\"Redémarrer pour appliquer\"**

3. **Vérifier le broker MQTT HA**
   ```bash
   # Dans Home Assistant
   # Supervisor → Add-ons → Mosquitto broker → Logs
   ```

4. **Test manuel MQTT**
   ```bash
   # Depuis un PC sur le réseau
   mosquitto_sub -h 192.168.1.100 -t \"homeassistant/+/acw02_salon/+\"
   ```

---

### 🏠 Entités Manquantes dans Home Assistant

#### Symptômes
- Module visible mais entités incomplètes
- Certains contrôles manquent
- Presets non visibles

#### Solutions
1. **Forcer la reconstruction**
   - Interface web → **\"G4: Rebuild MQTT Entities\"**
   - Attendre 30 secondes
   - Vérifier dans HA

2. **Vérifier la découverte MQTT**
   ```yaml
   # Dans configuration.yaml de HA
   mqtt:
     discovery: true
     discovery_prefix: homeassistant
   ```

3. **Redémarrer les services**
   - **Redémarrer Home Assistant**
   - **Redémarrer broker MQTT** si nécessaire
   - **Redémarrer ESP32** via interface web

---

## ❄️ Problèmes de Climatisation

### 🚫 Climatisation Ne Répond Pas

#### Symptômes
- Interface fonctionne mais climatisation ne change pas
- Télécommande fonctionne normalement
- Aucun retour d'état

#### Diagnostic
1. **Vérifier le câblage**
   - **Rouge** → 12V
   - **Noir** → RX (ESP vers clim)
   - **Jaune** → TX (clim vers ESP)  
   - **Vert** → GND

2. **Test du convertisseur de niveau**
   - Vérifier les soudures
   - Tester la continuité
   - Remplacer si défaillant

3. **Vérifier le mode silencieux**
   - Interface web → **Désactiver \"Mute\"**
   - Tester une commande simple

---

### 📡 Communication UART Instable

#### Symptômes
- Commandes parfois ignorées
- États incorrects remontés
- Messages d'erreur dans les logs

#### Solutions
1. **Ajuster les délais de communication**
   ```
   Interface web → Configuration :
   Délai publication : 500ms
   Délai silence : 1500ms
   Délai silence démarrage : 3000ms
   ```

2. **Vérifier l'alimentation**
   - Tension 12V stable
   - Régulateur D24V10F5 fonctionnel
   - Pas de chute de tension

3. **Optimiser le convertisseur**
   - **CYT1076** : Acceptable pour la plupart
   - **SN74LVC2T45DCUR** : Optimal (JLCPCB)

---

## ⚡ Problèmes d'Alimentation

### 💔 ESP32 Se Redémarre en Boucle

#### Symptômes
- LED s'allume puis s'éteint rapidement
- \"Brownout detector\" dans les logs
- Fonctionnement instable

#### Causes et Solutions

##### Régulateur Défaillant (ESP32 D1 Mini)
```
Symptômes : Tension VCC chute de 5V → 1.8V
Solution : 
1. Remplacer par ESP32 de meilleure qualité (AZDelivery)
2. Ou upgrader vers LOLIN C3 / XIAO C3
```

##### Alimentation 12V Insuffisante
```
Test : Mesurer tension aux bornes ACW02
- Normal : 11.5-12.5V
- Problème : < 11V

Solution : Vérifier connexions, nettoyer contacts
```

##### Surconsommation Wi-Fi
```yaml
# Réduire la puissance Wi-Fi
wifi:
  output_power: 17dB  # Au lieu de 20dB
  power_save_mode: light
```

---

## 🌡️ Problèmes de Température

### 📊 Températures Incohérentes

#### Symptômes
- Température affichée aberrante
- Écart important avec thermomètre externe
- Valeurs qui sautent

#### Solutions
1. **Vérifier l'unité de température**
   - Interface : Basculer °C ↔ °F
   - Vérifier la cohérence

2. **Recalibrage climatisation**
   - Éteindre/rallumer la climatisation
   - Attendre stabilisation (5-10 minutes)
   - Comparer avec thermomètre de référence

3. **Reset complet**
   - Interface web → **\"G5: Request Status Update\"**
   - Si persistant → **Redémarrage ESP32**

---

## 🎛️ Problèmes d'Interface

### 🌐 Interface Web Inaccessible

#### Solutions par Méthode d'Accès

##### Via Nom de Domaine
```bash
# Test de résolution DNS
ping acw02-salon.local

# Si échec, utiliser l'IP directement :
# Trouver l'IP dans les logs ESPHome ou routeur
```

##### Via Adresse IP
```bash
# Scanner le réseau pour trouver l'ESP32
nmap -sn 192.168.1.0/24
# Ou utiliser une app mobile \"Network Scanner\"
```

##### Problème de Navigateur
- **Vider le cache** du navigateur
- **Tester en navigation privée**
- **Changer de navigateur** (Chrome, Firefox, Safari)

---

### 🔐 Authentification Web Échoue

#### Symptômes
- Demande répétée de login/mot de passe
- \"Unauthorized\" même avec bons identifiants

#### Solutions
1. **Vérifier les identifiants**
   ```yaml
   substitutions:
     web_server_username: admin
     web_server_password: admin  # Vérifier dans votre fichier
   ```

2. **Reset authentification**
   - **Redémarrer ESP32**
   - **Vider cookies** du navigateur
   - **Tenter navigation privée**

---

## 🔄 Problèmes de Mise à Jour

### 📡 OTA (Over-The-Air) Échec

#### Symptômes
- \"Upload failed\" pendant la mise à jour
- Connexion perdue pendant OTA
- ESP32 inaccessible après tentative

#### Solutions
1. **Utiliser connexion USB** pour récupération
   ```bash
   esphome run mon-esphome-acw02.yaml --device /dev/ttyUSB0
   ```

2. **Optimiser pour OTA**
   ```yaml
   # Réduire la taille du firmware
   logger:
     level: ERROR  # Moins de code de debug
   
   # Augmenter timeout
   ota:
     reboot_timeout: 10min
   ```

3. **Mode de récupération**
   - **Maintenir bouton BOOT** pendant démarrage (ESP32 D1 Mini)
   - **Flash via USB** obligatoire

---

## 🧪 Outils de Diagnostic

### 📊 Monitoring Système
```yaml
# Ajout capteurs de diagnostic (temporaire)
sensor:
  - platform: uptime
    name: \"Durée fonctionnement\"
  
  - platform: wifi_signal  
    name: \"Force signal\"
    
  - platform: internal_temperature
    name: \"Température ESP32\"
    
text_sensor:
  - platform: wifi_info
    ip_address:
      name: \"Adresse IP\"
    ssid:
      name: \"SSID connecté\"
```

### 🔍 Analyse des Logs
```bash
# Logs en temps réel
esphome logs mon-esphome-acw02.yaml

# Filtrer les erreurs
esphome logs mon-esphome-acw02.yaml | grep -i \"error\\|warning\\|fail\"

# Sauvegarder pour analyse
esphome logs mon-esphome-acw02.yaml > logs_debug.txt
```

---

## 🆘 Procédures d'Urgence

### 🔄 Reset Complet

#### Méthode 1 : Via Interface Web
1. **Interface web** → **Configuration**
2. **\"G6: Restart ESP\"**
3. **Attendre redémarrage** (30-60 secondes)

#### Méthode 2 : Redémarrage Électrique  
1. **Débrancher alimentation** 12V
2. **Attendre 10 secondes**
3. **Rebrancher**

#### Méthode 3 : Factory Reset
1. **Maintenir bouton reset** pendant démarrage (si disponible)
2. **Ou reflash complet** via USB

### 📞 Obtenir de l'Aide

#### Informations à Fournir
- **Version ESPHome** utilisée
- **Type d'ESP32** (D1 Mini, LOLIN C3, XIAO...)
- **Modèle climatisation** (Airton/Teknopoint + référence)
- **Logs complets** de l'erreur
- **Configuration YAML** (sans mots de passe)

#### Canaux de Support
- **[Issues GitHub](https://github.com/devildant/acw02_esphome/issues)** - Bugs et problèmes techniques
- **[Discussions GitHub](https://github.com/devildant/acw02_esphome/discussions)** - Questions générales
- **[Forum ESPHome](https://community.home-assistant.io/c/esphome/)** - Support ESPHome général

---

## ✅ Check-list de Dépannage

### Avant de Demander de l'Aide
- [ ] **Vérifier les logs** ESPHome
- [ ] **Tester avec télécommande** originale  
- [ ] **Vérifier le câblage** (multimètre)
- [ ] **Tester l'interface web** 
- [ ] **Contrôler MQTT** dans Home Assistant
- [ ] **Essayer un redémarrage** complet
- [ ] **Vérifier la compatibilité** climatisation (COMPATIBILITY.md)

### Information Système Utile
```yaml
# Commandes pour récupérer infos système
esphome version
esphome config mon-esphome-acw02.yaml --show-config
```

---

## 🔗 Ressources Complémentaires

- **[Configuration Avancée](configuration.md)** - Personnaliser votre installation
- **[Détails Interface](interface-details.md)** - Comprendre tous les contrôles  
- **[Utilisation MQTT](../advanced/mqtt-only.md)** - Configuration MQTT seule
- **[Compatibilité](../../../COMPATIBILITY.md)** - Liste des modèles testés