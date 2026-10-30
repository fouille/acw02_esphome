# Configuration Files

This directory contains all ESPHome configuration files for the ACW02 project.

## 📋 Configuration Files

### Main Configurations
- `esphome-acw02-en.yaml` - English version configuration
- `esphome-acw02-fr.yaml` - French version configuration  
- `my-esphome-acw02-fr.yaml` - Custom French configuration
- `secrets.yaml` - Sensitive configuration data

### Test Configurations
- See `../../other/test-build/` for development configurations

## 🔧 Usage

### Basic Configuration
```bash
# Compile the firmware
esphome compile esphome-acw02-en.yaml

# Upload to device
esphome upload esphome-acw02-en.yaml
```

### Docker Usage
```bash
# From project root
cd tools/docker
./build-en.bat
```

## 📖 Documentation
- [Installation Guide](../../docs/en/installation/)
- [Hardware Selection](../../docs/en/hardware/)
- [Usage Guide](../../docs/en/usage/)

## ⚠️ Security Note
The `secrets.yaml` file contains sensitive information like WiFi passwords and API keys. 
Never commit this file to version control.

Example `secrets.yaml`:
```yaml
wifi_ssid: "Your WiFi Name"
wifi_password: "Your WiFi Password"
api_encrypted_key: "your-32-byte-base64-key"
ota_password: "your-ota-password"
ap_password: "your-fallback-ap-password"
web_server_username: "your-web-username"
web_server_password: "your-web-password"
```

Generate a unique API key for each device: `openssl rand -base64 32`.