name: "Indoor Unit Compatibility Report"
description: "Report an indoor unit tested with the ACX02 ESPHome module"
title: "[Compatibility] Brand Model"
labels: ["compatibility"]
body:
  - type: input
    id: brand
    attributes:
      label: Brand
      description: "Example: Airton, Teknopoint, Daikin, Mitsubishi..."
      placeholder: "Airton"
    validations:
      required: true

  - type: input
    id: model
    attributes:
      label: Exact Model
      description: "Provide the full reference as written on the indoor unit."
      placeholder: "Teknopoint ARX35"
    validations:
      required: true

  - type: dropdown
    id: works
    attributes:
      label: Works with ACX02 ESPHome?
      options:
        - ✅ Yes
        - ⚠️ Partially (some functions missing)
        - ❌ No
    validations:
      required: true

  - type: textarea
    id: notes
    attributes:
      label: Additional Notes
      description: "Mention if specific functions do not work (swing, display, eco, etc.) or any other observations."
      placeholder: "Example: works with Teknopoint ARX35, but vertical swing not supported"
