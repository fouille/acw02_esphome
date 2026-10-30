# Usage Guide

Learn how to configure, use, and optimize your ACW02 ESPHome module for controlling your air conditioner.

## 🚀 Quick Start

1. **[First Setup](#first-setup)** - Initial configuration
2. **[Basic Operation](#basic-operation)** - Daily usage
3. **[Home Assistant Integration](#home-assistant-integration)** - HA setup
4. **[Advanced Features](#advanced-features)** - Optimize your setup

## 🔧 First Setup

### Initial Configuration
After successful installation and upload:

1. **Connect to WiFi**
   - The module creates an access point on first boot
   - Connect to `ACW02-XXXXXX` network
   - Configure your WiFi credentials
   - Device will restart and connect to your network

2. **Verify Connection**
   ```bash
   # Check device status
   ping acw02-device-name.local
   
   # Access web interface
   http://acw02-device-name.local
   ```

3. **Test Air Conditioner Communication**
   - Open the web interface
   - Check the "Status" section
   - Verify communication with AC unit
   - Test basic commands (on/off)

### Configuration Files
Your main configuration is in the YAML file:

```yaml
# Example basic configuration
substitutions:
  device_name: "acw02-living-room"
  friendly_name: "Living Room AC"
  
esphome:
  name: ${device_name}
  
# Include the ACW02 component
packages:
  acw02: !include components/acw02/acw02.yaml
  
wifi:
  ssid: "Your WiFi Name"
  password: "Your WiFi Password"
```

## 🎮 Basic Operation

### Web Interface
The module provides a web interface for direct control:

#### Main Controls
- **Power**: Turn AC on/off
- **Mode**: Cool, Heat, Dry, Fan, Auto
- **Temperature**: Set target temperature (16-32°C)
- **Fan Speed**: Auto, Low, Medium, High
- **Swing**: Vertical and horizontal swing control

#### Status Display
- Current temperature (indoor/outdoor if available)
- Operating mode and settings
- WiFi signal strength
- Uptime and diagnostics
- Error messages (if any)

### MQTT Control
If using MQTT mode, the module publishes/subscribes to these topics:

```
# State topics (published by device)
acw02/living-room/temperature/state
acw02/living-room/mode/state
acw02/living-room/fan/state

# Command topics (subscribe by device)
acw02/living-room/temperature/set
acw02/living-room/mode/set
acw02/living-room/fan/set
```

### API Control
Direct API calls for automation:

```bash
# Turn on AC
curl -X POST http://acw02-device.local/climate/living_room_ac/turn_on

# Set temperature
curl -X POST http://acw02-device.local/climate/living_room_ac/set \
  -H "Content-Type: application/json" \
  -d '{"target_temperature": 22}'

# Change mode
curl -X POST http://acw02-device.local/climate/living_room_ac/set \
  -H "Content-Type: application/json" \
  -d '{"mode": "cool"}'
```

## 🏠 Home Assistant Integration

### Automatic Discovery
If Home Assistant is on the same network, the device should be automatically discovered:

1. Go to **Settings** > **Devices & Services**
2. Look for "ESPHome" integration
3. Click **Configure** on the discovered device
4. Enter the API encryption key (if set)

### Manual Configuration
If automatic discovery doesn't work:

```yaml
# configuration.yaml
esphome:
  
climate:
  - platform: esphome
    name: "Living Room AC"
    device_class: climate
    id: living_room_ac
```

### Available Entities
The integration provides these entities:

#### Climate Entity
- `climate.living_room_ac`
  - Current temperature
  - Target temperature
  - Operating mode
  - Fan mode
  - Swing mode
  - Power state

#### Sensor Entities
- `sensor.living_room_ac_current_temperature`
- `sensor.living_room_ac_outdoor_temperature` (if available)
- `sensor.living_room_ac_power_consumption` (if available)

#### Binary Sensor Entities
- `binary_sensor.living_room_ac_online`
- `binary_sensor.living_room_ac_heating`
- `binary_sensor.living_room_ac_cooling`

### Home Assistant Automations

#### Simple Scheduling
```yaml
# Turn on AC at 7 AM on weekdays
- alias: "AC Morning Start"
  trigger:
    platform: time
    at: "07:00:00"
  condition:
    condition: time
    weekday:
      - mon
      - tue
      - wed
      - thu
      - fri
  action:
    service: climate.turn_on
    target:
      entity_id: climate.living_room_ac
    data:
      temperature: 22
      hvac_mode: cool
```

#### Temperature-Based Control
```yaml
# Auto mode based on outdoor temperature
- alias: "AC Auto Mode"
  trigger:
    platform: state
    entity_id: sensor.outdoor_temperature
  condition:
    condition: numeric_state
    entity_id: sensor.outdoor_temperature
    above: 25
  action:
    service: climate.set_hvac_mode
    target:
      entity_id: climate.living_room_ac
    data:
      hvac_mode: cool
      temperature: 24
```

#### Energy Optimization
```yaml
# Turn off when no one home
- alias: "AC Away Mode"
  trigger:
    platform: state
    entity_id: binary_sensor.anyone_home
    to: 'off'
    for: '00:30:00'
  action:
    service: climate.turn_off
    target:
      entity_id: climate.living_room_ac
```

## ⚙️ Advanced Features

### Custom Presets
Define custom operating modes:

```yaml
# In your ESPHome configuration
climate:
  - platform: acw02
    name: "Living Room AC"
    presets:
      sleep:
        temperature: 26
        fan_mode: low
        swing_mode: off
      eco:
        temperature: 25
        fan_mode: auto
      comfort:
        temperature: 22
        fan_mode: medium
```

### Scheduling
Built-in scheduling support:

```yaml
# Schedule configuration
time:
  - platform: homeassistant

interval:
  - interval: 1h
    then:
      - lambda: |-
          // Custom scheduling logic
          auto time = id(homeassistant_time).now();
          if (time.hour == 22) {
            // Night mode
            id(living_room_ac).set_preset("sleep");
          }
```

### Monitoring and Diagnostics

#### Health Monitoring
The module provides comprehensive diagnostics:

- Communication status with AC unit
- WiFi connection quality
- Temperature sensor accuracy
- Power consumption (if available)
- Error codes and troubleshooting

#### Logging
Configure logging levels:

```yaml
logger:
  level: INFO
  logs:
    climate: DEBUG
    acw02: DEBUG
```

### Performance Optimization

#### WiFi Optimization
```yaml
wifi:
  ssid: "Your WiFi"
  password: "Your Password"
  power_save_mode: none  # Better responsiveness
  fast_connect: true     # Faster reconnection
```

#### Update Intervals
```yaml
# Optimize update frequencies
climate:
  - platform: acw02
    update_interval: 30s  # Balance between responsiveness and efficiency
```

## 📊 Interface Details

For complete interface documentation, see [Interface Details](interface.md).

### Control Methods
- **Web Interface**: Direct browser control
- **Home Assistant**: Full integration
- **MQTT**: Protocol-level control
- **API**: RESTful API for custom integrations
- **Physical buttons**: Override controls (if installed)

### Status Information
- Real-time temperature readings
- Operating mode and settings
- Network connectivity status
- System health and diagnostics
- Energy usage (if supported)

## 🆘 Troubleshooting

For detailed troubleshooting information, see [Troubleshooting Guide](troubleshooting.md).

### Quick Fixes
- **No response**: Check WiFi connection and power
- **Wrong temperature**: Calibrate temperature sensors
- **Commands ignored**: Verify AC compatibility mode
- **Disconnections**: Check signal strength and power supply

---
*Next: [Interface Details](interface.md) | [Troubleshooting](troubleshooting.md)*