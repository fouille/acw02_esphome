# Hardware Selection Guide

Choose the right ESP32 board for your ACW02 project. Each variant has specific advantages and use cases.

## 🎯 Quick Selection

| Board | Best For | Size | Level Shifter | Price Range |
|-------|----------|------|---------------|-------------|
| **ESP32 D1 Mini** | Beginners, stable setup | Large | ✅ Required | $ |
| **LOLIN C3** | Compact build | Medium | ❌ Not needed | $$ |
| **XIAO C3** | Ultra-compact | Small | ❌ Not needed | $$ |
| **XIAO C6** | Latest features | Small | ❌ Not needed | $$$ |

## 📊 Detailed Comparison

### ESP32 D1 Mini (Original Version)
**Recommended for beginners**

✅ **Advantages:**
- Most tested and stable
- Abundant documentation
- Easy to find and replace
- Standard pinout
- Compatible with many shields

❌ **Disadvantages:**
- Requires level shifter circuit
- Larger PCB footprint
- More components needed

📋 **Specifications:**
- Chip: ESP32-WROOM-32
- Flash: 4MB
- RAM: 520KB
- WiFi: 802.11 b/g/n
- Bluetooth: Classic + BLE
- GPIO: 22 pins
- Voltage: 3.3V (5V tolerant with level shifter)

[📖 Complete D1 Mini Guide](d1-mini.md)

### LOLIN C3 (Compact Version)
**Best balance of size and features**

✅ **Advantages:**
- No level shifter needed
- More compact design
- Good price/performance ratio
- USB-C connector
- Built-in RGB LED

❌ **Disadvantages:**
- Single core processor
- No Bluetooth Classic
- Limited GPIO pins
- Less community support

📋 **Specifications:**
- Chip: ESP32-C3
- Flash: 4MB
- RAM: 400KB
- WiFi: 802.11 b/g/n
- Bluetooth: BLE only
- GPIO: 13 pins
- Voltage: 3.3V native

[📖 Complete LOLIN C3 Guide](lolin-c3.md)

### XIAO ESP32-C3 (Ultra-Compact)
**Perfect for space-constrained builds**

✅ **Advantages:**
- Extremely small size
- No level shifter needed
- High-quality Seeed design
- Good documentation
- USB-C connector

❌ **Disadvantages:**
- Higher cost
- Limited GPIO access
- Smaller community
- More delicate handling

📋 **Specifications:**
- Chip: ESP32-C3
- Flash: 4MB
- RAM: 400KB
- WiFi: 802.11 b/g/n
- Bluetooth: BLE only
- GPIO: 11 pins usable
- Voltage: 3.3V native

### XIAO ESP32-C6 (Latest Generation)
**Cutting-edge features**

✅ **Advantages:**
- Latest ESP32-C6 chip
- WiFi 6 support
- Thread/Zigbee capability
- Excellent power efficiency
- USB-C with data

❌ **Disadvantages:**
- Highest cost
- Newest, less tested
- Limited availability
- Requires latest ESPHome

📋 **Specifications:**
- Chip: ESP32-C6
- Flash: 4MB
- RAM: 512KB
- WiFi: 802.11 ax (WiFi 6)
- Bluetooth: BLE 5.0
- Thread/Zigbee: Yes
- GPIO: 15 pins
- Voltage: 3.3V native

[📖 Complete XIAO C3/C6 Guide](xiao-c3-c6.md)

## 🔧 PCB Requirements

### Level Shifter Circuit
**Required for ESP32 D1 Mini only**

The air conditioner uses 5V logic, but the ESP32 uses 3.3V. A level shifter is needed to safely interface between them.

#### Components Needed:
- 74HC4050 level shifter IC
- Pull-up resistors (10kΩ)
- Decoupling capacitors
- PCB or breadboard

#### Not Needed For:
- LOLIN C3
- XIAO C3
- XIAO C6

*These boards can directly interface with 5V signals on their GPIO pins.*

## 📦 What's Included

### Complete Kit Contents
Each hardware variant includes:
- ✅ ESP32 board
- ✅ Custom PCB (if applicable)
- ✅ 3D printed case
- ✅ Connection cables
- ✅ Assembly instructions
- ✅ Pre-configured firmware

### Additional Requirements
You'll also need:
- USB cable for programming
- Computer for initial setup
- Screwdriver for assembly
- Multimeter for testing (recommended)

## 🎯 Selection Guide

### Choose ESP32 D1 Mini If:
- You're new to ESP32 development
- You want maximum stability and support
- Cost is the primary concern
- You have space for a larger PCB

### Choose LOLIN C3 If:
- You want a good balance of features and size
- You prefer USB-C connectivity
- You don't need Bluetooth Classic
- You want easier assembly (no level shifter)

### Choose XIAO C3 If:
- Size is critical
- You like high-quality hardware
- You're comfortable with compact designs
- You want modern connectivity (USB-C)

### Choose XIAO C6 If:
- You want cutting-edge features
- WiFi 6 support is important
- You plan to use Thread/Zigbee
- Budget is not a primary concern

## 🛒 Where to Buy

### Official Sources
- **D1 Mini**: AliExpress, Amazon, local electronics stores
- **LOLIN C3**: LOLIN official store, electronics distributors
- **XIAO C3/C6**: Seeed Studio, authorized distributors

### Recommended Suppliers
- Seeed Studio (XIAO boards)
- LOLIN official store (C3 boards)
- Espressif authorized distributors
- Reputable electronics retailers

## 🔧 Assembly Difficulty

| Board | Assembly | Soldering | Case Fit | Overall |
|-------|----------|-----------|----------|---------|
| **D1 Mini** | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| **LOLIN C3** | ⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐ |
| **XIAO C3** | ⭐ | ⭐ | ⭐ | ⭐ |
| **XIAO C6** | ⭐ | ⭐ | ⭐ | ⭐ |

## ⚠️ Important Considerations

### Power Supply
- All boards require stable 3.3V supply
- USB power is sufficient for development
- Consider external power for final installation

### Heat Management
- Ensure adequate ventilation
- Consider heat sinks for continuous operation
- Monitor temperature during testing

### Signal Integrity
- Use proper shielded cables
- Keep connections short when possible
- Test thoroughly before final assembly

---
*Next: [Installation Guide](../installation/README.md)*