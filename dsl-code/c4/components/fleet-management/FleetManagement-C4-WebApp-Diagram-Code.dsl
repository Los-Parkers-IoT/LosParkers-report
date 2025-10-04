workspace "CargaSafe - Fleet Management (Web App Components)" "C4 Component view for the Web Application of the Fleet Management BC" {

  model {
    // Personas
    operator        = person "Company Operator" "Company staff that manages the fleet inventory."
    fleetTechnician = person "Fleet Technician" "Installs devices and updates assignments."
    auditor         = person "Auditor" "Read-only access to review vehicles and devices."

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      webApplication = container "Web Application" "Angular SPA for CargaSafe UI & dashboards." "Angular" {
        uiVehiclesList   = component "UI - Vehicles" "List/create/update/activate vehicles"
        uiDevicesList    = component "UI - Devices"  "List/create/update devices; attach/detach to vehicles"
        appState         = component "App State & Cache" "Manages session, authorization state and cached queries"
        apiClient        = component "API Client" "REST calls with token and error handling"
        authAdapter      = component "Auth Adapter" "OIDC/JWT - attaches token to each request"

        // Relaciones entre usuarios y web
        operator        -> uiVehiclesList "Uses"
        operator        -> uiDevicesList  "Uses"
        fleetTechnician -> uiDevicesList  "Uses"
        auditor         -> uiVehiclesList "Uses"
        auditor         -> uiDevicesList  "Uses"

        // Relaciones internas UI
        uiVehiclesList -> appState "Read/write state"
        uiDevicesList  -> appState "Read/write state"

        appState  -> apiClient   "Requests data"
        apiClient -> authAdapter "Attach token"
      }

      backend = container "Backend API" "Domain logic for fleet management (vehicles & devices)." "Spring Boot" {
        vehicleApi = component "Vehicle API" "CRUD for vehicles (VehicleController)"
        deviceApi  = component "Device API"  "CRUD and attach/detach for devices (DeviceController)"
      }
    }

    // Relaciones WebApp -> Backend
    apiClient -> vehicleApi "GET/POST/PUT/PATCH"
    apiClient -> deviceApi  "GET/POST/PUT/PATCH"
  }

  views {
    component webApplication {
      title "Fleet Management - Web Application Components"
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
    }
  }
}
