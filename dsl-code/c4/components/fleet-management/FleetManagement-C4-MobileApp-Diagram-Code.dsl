workspace "CargaSafe - Fleet Management (Mobile App Components)" "C4 Component view for the Mobile Application of the Fleet Management BC" {

  model {
    // Personas
    operator        = person "Company Operator" "Company staff that manages the fleet inventory."
    fleetTechnician = person "Fleet Technician" "Installs devices and updates assignments."
    auditor         = person "Auditor" "Read-only access to review vehicles and devices."

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      mobileApplication = container "Mobile Application" "Flutter app for CargaSafe fleet management (vehicles & devices)." "Flutter" {
        uiVehiclesList  = component "UI - Vehicles List" "Displays vehicles with filters and status"
        uiDevicesList   = component "UI - Devices List"  "Displays devices; supports attach/detach flows"
        uiDeviceAssign  = component "UI - Device Assign" "Wizard to attach/detach a device to a vehicle"
        blocManager     = component "BLoC Manager" "Handles state management and reactive flows"
        databaseConn    = component "Database Connector" "Manages persistence to local mobile database"
        apiClient       = component "API Client" "REST calls with token and error handling"
        authAdapter     = component "Auth Adapter" "OIDC/JWT - attaches token to each request"

        // Relaciones entre usuarios y mobile
        operator        -> uiVehiclesList "Uses"
        operator        -> uiDevicesList  "Uses"
        operator        -> uiDeviceAssign "Uses"

        fleetTechnician -> uiDevicesList  "Uses"
        fleetTechnician -> uiDeviceAssign "Uses"

        auditor         -> uiVehiclesList "Uses"
        auditor         -> uiDevicesList  "Uses"

        // Relaciones internas UI
        uiVehiclesList -> blocManager "Read/write state"
        uiDevicesList  -> blocManager "Read/write state"
        uiDeviceAssign -> blocManager "Read/write state"

        blocManager -> databaseConn "Persist/Load offline data"
        blocManager -> apiClient    "Requests data"
        apiClient   -> authAdapter  "Attach token"
      }

      backend = container "Backend API" "Domain logic for fleet management (vehicles & devices)." "Spring Boot" {
        vehicleApi = component "Vehicle API" "Manages vehicle CRUD: create, update, activate/deactivate, list"
        deviceApi  = component "Device API"  "Manages device CRUD and attach/detach to vehicles"
      }

      // Base de datos local móvil
      mobileDb = container "Mobile Database" "Local storage for offline-first UX: vehicles, devices, assignments, pending ops." "SQLite/Isar" {
          tags "Mobile Database"
      }
    }

    // Sistemas externos (opcional: push)
    fcm = softwareSystem "Firebase Cloud Messaging" "External service for push notifications"

    // Relaciones Mobile -> Backend
    apiClient -> vehicleApi "POST/PUT/PATCH/GET"
    apiClient -> deviceApi  "POST/PUT/PATCH/GET"

    // Conexión del conector a la DB local
    databaseConn -> mobileDb "Read/write vehicles, devices, assignments, pending ops"

    // Push notifications directas (opcional)
    fcm -> mobileApplication "Delivers push notifications"
  }

  views {
    component mobileApplication {
      title "Fleet Management - Mobile Application Components"
      include *
      autoLayout lr
    }

    styles {
      element "Container" {
        shape RoundedBox
        background "#1168bd"
        color "#ffffff"
      }

      element "Component" {
        background "#3F8CFF"
        color "#ffffff"
        shape RoundedBox
      }

      element "Software System" {
        background "#666666"
        color "#ffffff"
      }

      element "Person" {
        background "#084C61"
        color "#ffffff"
        shape person
      }

      element "Mobile Database" {
        background "#0f5ea6"
        color "#ffffff"
        shape Cylinder
      }
    }
  }
}
