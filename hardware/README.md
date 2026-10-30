# Hardware Files

This directory contains all hardware-related files for the ACW02 project.

## 📁 Directory Structure

### 3D Files (`3d-files/`)
- **D1-MINI/** - 3D models for ESP32 D1 Mini version
- **LOLIN-C3-XIAO-C3-C6/** - Models for compact ESP32 versions
- **images/** - Reference images and assembly photos
- **support for airton/** - Specific mounting hardware

### PCB Files (`pcb/`)
- **esp32_D1_mini_wroom32/** - PCB designs for D1 Mini
- **lolin_c3_xiao_c3_xiao_c6/** - PCB designs for compact versions
- **logic_level_converter/** - Level shifter circuits
- **images/** - PCB photos and assembly guides

### Images (`images/`)
- Assembly photos
- Antenna configurations
- Airflow diagrams
- Installation examples

## 🔧 Manufacturing

### 3D Printing
The STL files are optimized for:
- **Layer height:** 0.2mm
- **Infill:** 20-30%
- **Support:** Required for some models
- **Material:** PLA recommended, PETG for higher temperatures

### PCB Production
- **Format:** Gerber files included
- **Thickness:** 1.6mm standard
- **Copper:** 1oz (35μm)
- **Color:** Any (Green recommended for compatibility)

## 📖 Documentation
- [Hardware Selection Guide](../docs/en/hardware/)
- [Assembly Instructions](../docs/en/hardware/assembly.md)
- [Compatibility Matrix](../docs/compatibility.md)

## 🛒 Sourcing Components

### ESP32 Boards
- ESP32 D1 Mini: AliExpress, Amazon
- LOLIN C3: LOLIN official store
- XIAO C3/C6: Seeed Studio

### Additional Components
- Level shifter IC (74HC4050) - for D1 Mini only
- Resistors and capacitors - standard electronics suppliers
- Connectors - depends on your air conditioner model

## ⚠️ Safety Notes
- Always disconnect power before working on hardware
- Use proper ESD protection
- Double-check connections before powering on
- Follow local electrical codes for permanent installations