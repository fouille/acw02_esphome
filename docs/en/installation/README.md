# Installation Guide

This section provides comprehensive installation instructions for the ACW02 ESPHome module across different platforms and methods.

## 🎯 Choose Your Installation Method

### Quick Selection Guide

| Method | Best For | Difficulty | Requirements |
|--------|----------|------------|--------------|
| **[Home Assistant Add-on](ha-addon.md)** | Home Assistant users | ⭐ Easy | Home Assistant OS/Supervised |
| **[Docker](docker.md)** | Isolated environment | ⭐⭐ Medium | Docker installed |
| **[macOS Direct](macos.md)** | Mac users | ⭐⭐ Medium | macOS 10.15+ |
| **[Windows Direct](windows.md)** | Windows users | ⭐⭐⭐ Advanced | Windows 10+ |

## 📋 Installation Methods

### 1. Home Assistant Add-on (Recommended)
**Perfect for Home Assistant users**
- ✅ Automatic updates
- ✅ Integrated with HA
- ✅ Web interface included
- ✅ No command line required

[📖 Complete HA Add-on Guide](ha-addon.md)

### 2. Docker Installation
**Best for development and testing**
- ✅ Isolated environment
- ✅ Easy cleanup
- ✅ Consistent across platforms
- ✅ Includes all tools

[🐳 Complete Docker Guide](docker.md)

### 3. Direct Installation

#### macOS
- ✅ Native performance
- ✅ Direct hardware access
- ⚠️ Requires Python setup

[🍎 Complete macOS Guide](macos.md)

#### Windows
- ✅ Native performance
- ✅ Direct hardware access
- ⚠️ More complex setup

[🪟 Complete Windows Guide](windows.md)

## 🔧 Pre-Installation Requirements

### Hardware Requirements
- **ESP32 board** (D1 Mini, LOLIN C3, or XIAO C3/C6)
- **USB cable** for programming
- **Computer** with USB port
- **Compatible air conditioner** (see [compatibility list](../compatibility.md))

### Software Requirements
- **ESPHome 2024.6.0+** (installed via chosen method)
- **Home Assistant** (optional, for automatic discovery)
- **MQTT Broker** (if using MQTT mode)

## 🚀 Quick Start Workflow

1. **Choose installation method** based on your setup
2. **Follow the specific guide** for your chosen method
3. **Prepare your ESP32** board and connections
4. **Configure the YAML** file for your setup
5. **Compile and upload** the firmware
6. **Test the connection** with your air conditioner

## 📖 Detailed Installation Guides

| Platform | Guide | Estimated Time |
|----------|-------|----------------|
| Home Assistant Add-on | [ha-addon.md](ha-addon.md) | 15 minutes |
| Docker (All platforms) | [docker.md](docker.md) | 30 minutes |
| macOS Direct | [macos.md](macos.md) | 45 minutes |
| Windows Direct | [windows.md](windows.md) | 60 minutes |

## ⚠️ Important Notes

### Before You Start
- ⚠️ **Check compatibility** with your air conditioner model
- ⚠️ **Backup existing settings** if replacing existing module
- ⚠️ **Ensure proper power supply** for your ESP32 board
- ⚠️ **Follow safety guidelines** for electrical connections

### After Installation
- ✅ Test the module before final installation
- ✅ Configure proper network settings
- ✅ Set up monitoring and alerts
- ✅ Create backup of working configuration

## 🆘 Installation Troubleshooting

### Common Issues
- **ESP32 not detected**: Check USB drivers and cable
- **Compilation errors**: Verify ESPHome version and dependencies
- **Upload failures**: Try different upload speeds or methods
- **Network issues**: Check WiFi credentials and signal strength

### Getting Help
1. Check the specific installation guide for your platform
2. Review the [general troubleshooting guide](../usage/troubleshooting.md)
3. Verify hardware compatibility
4. Check existing GitHub issues

---
*Next: [Hardware Selection Guide](../hardware/README.md)*