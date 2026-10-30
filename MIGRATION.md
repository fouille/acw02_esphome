# Migration Notice

## ⚠️ Project Structure Updated

This project has been restructured for better organization. If you're looking for files that were previously in the root directory, they have been moved to the following locations:

### 📁 File Locations

| Old Location | New Location | Description |
|--------------|--------------|-------------|
| `3Dfiles/` | `hardware/3d-files/` | 3D printing files and models |
| `PCB/` | `hardware/pcb/` | PCB designs and fabrication files |
| `components/` | `firmware/components/` | ESPHome custom components |
| `esphome-*.yaml` | `firmware/configs/` | Configuration files |
| `docker/` | `tools/docker/` | Docker development environment |
| `build-*.bat` | `tools/scripts/` | Build and utility scripts |
| `docs/` | `docs/` | ✅ Updated with new structure |

### 🔗 Quick Links

#### Hardware
- **3D Files**: [`hardware/3d-files/`](hardware/3d-files/)
- **PCB Designs**: [`hardware/pcb/`](hardware/pcb/)
- **Hardware Guide**: [`docs/en/hardware/`](docs/en/hardware/)

#### Firmware
- **Configurations**: [`firmware/configs/`](firmware/configs/)
- **Components**: [`firmware/components/`](firmware/components/)
- **Installation Guide**: [`docs/en/installation/`](docs/en/installation/)

#### Tools
- **Docker Environment**: [`tools/docker/`](tools/docker/)
- **Build Scripts**: [`tools/scripts/`](tools/scripts/)
- **Development Guide**: [`docs/en/development/`](docs/en/development/)

#### Documentation
- **🇫🇷 French**: [`docs/fr/`](docs/fr/)
- **🇬🇧 English**: [`docs/en/`](docs/en/)

### 🚀 Quick Start

The basic workflow remains the same, just update your paths:

```bash
# Old way
esphome compile esphome-acw02-en.yaml

# New way  
esphome compile firmware/configs/esphome-acw02-en.yaml
```

### 🔄 Update Your Scripts

If you have custom scripts or bookmarks, update them:
- Change `components/acw02/` → `firmware/components/acw02/`
- Change `docker/build-en.bat` → `tools/docker/build-en.bat`
- Change `docs/install_*.md` → `docs/en/installation/`

### 📖 Full Documentation

See the updated [README.md](README.md) for the complete project overview and navigation.

---
*This migration notice will be removed in a future version once the transition is complete.*