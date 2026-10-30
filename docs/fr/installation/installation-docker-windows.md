# 🐳 Installation Docker sur Windows

## 🖥️ Prérequis
- Windows 10/11
- Docker Desktop installé et fonctionnel
- Accès USB pour flasher l'ESP32

## 📋 Configuration Initiale

### 1️⃣ Cloner le Projet
```cmd
git clone https://github.com/devildant/acw02_esphome.git
cd acw02_esphome
```

### 2️⃣ Copier et Configurer les Fichiers
```cmd
copy esphome-acw02-fr.yaml mon-esphome-acw02.yaml
```

Éditez `mon-esphome-acw02.yaml` et `secrets.yaml` selon vos besoins.

---

## 🐳 Utilisation des Scripts Docker

### Scripts Disponibles dans `/docker/`

| Script | Description |
|--------|-------------|
| `build-docker.bat` | Construire l'image Docker ESPHome |
| `start-docker-with-attach-USB.bat` | Démarrer avec accès USB |
| `build-fr.bat` | Compiler le firmware français |
| `logs-fr.bat` | Voir les logs du firmware français |
| `stop-docker-with-detach-USB.bat` | Arrêter et détacher USB |

### 🔌 Premier Flash (avec USB)

1. **Construire l'image Docker** :
   ```cmd
   cd docker
   build-docker.bat
   ```

2. **Démarrer Docker avec accès USB** :
   ```cmd
   start-docker-with-attach-USB.bat
   ```

3. **Compiler et flasher** :
   ```cmd
   build-fr.bat
   ```

4. **Vérifier les logs** :
   ```cmd
   logs-fr.bat
   ```

### 📡 Mises à Jour Suivantes (OTA)

Pour les mises à jour sans câble USB :

1. **Démarrer Docker (sans USB)** :
   ```cmd
   start-docker.bat
   ```

2. **Compiler avec mise à jour OTA** :
   ```cmd
   build-fr.bat
   ```

---

## 🔧 Configuration Docker Avancée

### Variables d'Environnement

Le fichier `docker-compose.yml` expose ces variables :

```yaml
environment:
  - ESPHOME_DASHBOARD_USE_PING=true
  - ESPHOME_DASHBOARD_RELATIVE_URL=/
volumes:
  - .:/config
  - /etc/localtime:/etc/localtime:ro
ports:
  - "6052:6052"
```

### Accès au Dashboard ESPHome

Une fois Docker démarré, accédez au dashboard via :
- **URL** : `http://localhost:6052`
- **Interface** : Dashboard ESPHome complet

---

## 🔍 Résolution des Problèmes

### Problème : USB non détecté dans Docker
1. **Vérifiez que Docker Desktop a accès USB** :
   - Settings → Resources → WSL Integration
   - Activez l'intégration pour votre distribution WSL

2. **Utilisez le script dédié** :
   ```cmd
   start-docker-with-attach-USB.bat
   ```

### Problème : Port 6052 déjà utilisé
Modifiez le port dans `docker-compose.yml` :
```yaml
ports:
  - "6053:6052"  # Utilisez 6053 au lieu de 6052
```

### Problème : Permissions de fichiers
```cmd
# Dans le conteneur Docker
chmod +x /config/docker/*.sh
```

---

## 📂 Structure des Fichiers Docker

```
docker/
├── docker-compose.yml      # Configuration Docker
├── Dockerfile             # Image ESPHome personnalisée
├── entrypoint.sh          # Script de démarrage
├── build-*.bat            # Scripts de compilation
├── logs-*.bat             # Scripts de monitoring
├── start-docker*.bat      # Scripts de démarrage
└── stop-docker*.bat       # Scripts d'arrêt
```

---

## 🚀 Commandes Docker Manuelles

Si vous préférez utiliser Docker directement :

### Construire l'image
```cmd
docker build -t acw02-esphome ./docker
```

### Lancer le conteneur
```cmd
docker run -d --name acw02 ^
  -p 6052:6052 ^
  -v %cd%:/config ^
  --device=/dev/ttyUSB0 ^
  acw02-esphome
```

### Compiler le firmware
```cmd
docker exec -it acw02 esphome run /config/mon-esphome-acw02.yaml
```

---

## ✅ Vérification de l'Installation

Après compilation réussie :

1. **Dashboard ESPHome** : `http://localhost:6052`
2. **Interface Web ESP** : `http://[nom-device].local/`
3. **Logs en temps réel** : Utilisez `logs-fr.bat`

---

## 🔗 Prochaines Étapes

1. **[Configuration du Hardware](../hardware/)** - Choisir votre carte ESP32
2. **[Interface Utilisateur](../usage/interface-details.md)** - Comprendre les contrôles
3. **[Dépannage](../usage/troubleshooting.md)** - Résoudre les problèmes courants