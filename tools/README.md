# Tools and Scripts

This directory contains development tools, build scripts, and utilities for the ACW02 project.

## 📁 Directory Structure

### Docker Tools (`docker/`)
- Complete Docker environment for ESPHome development
- Cross-platform compilation and upload scripts
- USB device attachment utilities

### Build Scripts (`scripts/`)
- Platform-specific build scripts
- Automated compilation and upload tools
- Logging and monitoring utilities

## 🐳 Docker Environment

### Quick Start
```bash
cd tools/docker

# Start Docker environment
./start-docker.bat

# Build firmware
./build-en.bat

# View logs
./logs-en.bat
```

### Available Scripts
- `build-docker.bat` - Build Docker image
- `start-docker.bat` - Start container
- `stop-docker.bat` - Stop container
- `build-en.bat` - Build English firmware
- `build-fr.bat` - Build French firmware
- `logs-en.bat` - View English logs
- `logs-fr.bat` - View French logs

### USB Device Management
- `attach-usb.bat` - Attach USB devices to container
- `detach-usb.bat` - Detach USB devices
- `start-docker-with-attach-USB.bat` - Combined start and USB attach

## 🛠️ Build Scripts

### Windows Scripts
Located in `scripts/`:
- `build-en.bat` - Build English configuration
- `build-fr.bat` - Build French configuration
- `logs-en.bat` - Monitor English device logs
- `logs-fr.bat` - Monitor French device logs

### Build Images for Several Devices (macOS / Linux)
`scripts/build-devices.sh` compiles one firmware per device listed under `acw02_devices`
in `firmware/configs/secrets.yaml` (not versioned):

```yaml
acw02_devices:
  - name: acw02-salon        # dev_name
    friendly: ACW02 salon    # dev_friendly (optional)
  - name: acw02-bureau
    friendly: ACW02 bureau
    lang: en                 # optional: fr (default) or en
    board: lolin_c3_mini     # optional: board, tx, rx
    tx: GPIO21
    rx: GPIO20
```

```bash
tools/scripts/build-devices.sh               # every device
tools/scripts/build-devices.sh acw02-salon   # only some devices
```

Images are written to `firmware/build/<name>/`: `<name>.ota.bin` for OTA updates
(web interface or `esphome upload`) and `<name>.factory.bin` for the first USB flash.
ESPHome 2026.7.0 or later is required (Python 3.12): the script uses `.venv/bin/esphome`
at the repository root when present, otherwise `esphome` from the `PATH`, or `ESPHOME=/path/to/esphome`.
See [the macOS installation guide](../docs/install_from_macos_directly.md) to create `.venv` (Intel Macs need Rust).

### Cross-Platform Usage
```bash
# Direct ESPHome commands
esphome compile ../firmware/configs/esphome-acw02-en.yaml
esphome upload ../firmware/configs/esphome-acw02-en.yaml
esphome logs ../firmware/configs/esphome-acw02-en.yaml
```

## 🔧 Development Tools

### Docker Compose
The `docker/docker-compose.yml` provides:
- ESPHome environment with all dependencies
- USB device passthrough
- Volume mounting for project files
- Network configuration for device access

### Utility Scripts
- `open-container.bat` - Interactive container access  
- `clear-memory.bat` - Clear build cache
- `build-compile-only-*.bat` - Compile without upload

## 📖 Usage Examples

### Development Workflow
```bash
# 1. Start development environment
cd tools/docker
./start-docker.bat

# 2. Make changes to configuration
# Edit files in firmware/configs/

# 3. Build and test
./build-en.bat

# 4. Monitor device
./logs-en.bat
```

### Production Deployment
```bash
# 1. Build release firmware
./build-compile-only-en.bat

# 2. Upload to device
./upload-en.bat

# 3. Verify operation
./logs-en.bat
```

## 🐋 Docker Configuration

### Environment Variables
```yaml
# docker-compose.yml
environment:
  - ESPHOME_DASHBOARD_USE_PING=true
  - ESPHOME_DASHBOARD_RELATIVE_URL=/
  - TZ=Europe/Paris
```

### Volume Mounts
- Project files: `/config`
- Build cache: `/cache`
- USB devices: `/dev`

### Network Configuration
- Dashboard: http://localhost:6052
- Device discovery: mDNS enabled
- USB passthrough: Automatic detection

## ⚠️ Platform Notes

### Windows
- Requires Docker Desktop
- USB passthrough needs privileged mode
- WSL2 backend recommended

### macOS  
- Docker Desktop required
- USB devices may need manual configuration
- Native performance good

### Linux
- Docker CE sufficient
- USB passthrough works natively
- Best performance and compatibility

## 🆘 Troubleshooting

### Common Issues
- **USB device not detected**: Check device permissions and drivers
- **Build fails**: Verify ESPHome version and dependencies
- **Network issues**: Check firewall and Docker network settings
- **Permission errors**: Ensure Docker has proper privileges

### Debug Commands
```bash
# Check Docker status
docker ps

# View container logs
docker logs esphome-acw02

# Access container shell
./open-container.bat

# Check USB devices
lsusb  # In container
```

## 📖 Documentation
- [Installation Guide](../docs/en/installation/docker.md)
- [Development Workflow](../docs/en/development/)
- [Troubleshooting](../docs/en/usage/troubleshooting.md)