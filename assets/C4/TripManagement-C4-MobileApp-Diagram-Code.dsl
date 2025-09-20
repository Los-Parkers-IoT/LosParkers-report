workspace "CargaSafe - Trip Management (Mobile App Components)" "C4 Component view for the Mobile Application of the Trip Management BC" {

  model {
    // Personas
    operator    = person "Company Operator" "Company staff that plans and supervises operations."
    driver      = person "Driver" "Completes trips and submits reports from the app."
    endCustomer = person "End Customer" "Checks status and receives reports."

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      mobileApplication = container "Mobile Application" "Flutter app for CargaSafe trip management and tracking." "Flutter" {
        uiTripsList    = component "UI - Trips List" "Displays assigned trips and their status"
        uiTripDetails  = component "UI - Trip Details" "View details of a trip, including route on map"
        uiTripForm     = component "UI - Trip Form" "Form for creating or editing trips (only operator)"
        uiMap          = component "UI - Map" "Reusable map widget to display routes and markers"
        blocManager    = component "BLoC Manager" "Handles state management and reactive flows"
        databaseConn   = component "Database Connector" "Manages persistence to local mobile database"
        apiClient      = component "API Client" "REST calls with token and error handling"
        authAdapter    = component "Auth Adapter" "OIDC/JWT - attaches token to each request"
        routesAdapter  = component "RoutesAdapterFacade" "Facade for interacting with Google Maps routes, places and polylines"

        // Relaciones entre usuarios y mobile
        operator -> uiTripsList "Uses"
        operator -> uiTripDetails "Uses"
        operator -> uiTripForm "Uses"

        driver -> uiTripsList "Uses"
        driver -> uiTripDetails "Uses"

        endCustomer -> uiTripsList "Uses"
        endCustomer -> uiTripDetails "Uses"

        // Relaciones internas UI
        uiTripsList   -> blocManager "Read/write state"
        uiTripDetails -> blocManager "Read/write state"
        uiTripForm    -> blocManager "Read/write state"

        blocManager -> databaseConn "Persist/Load offline data"

        uiTripDetails -> uiMap "Embeds map"
        uiTripForm    -> uiMap "Embeds map"
        uiMap -> routesAdapter "Requests routes and map data"

        blocManager -> apiClient "Requests data"
        apiClient   -> authAdapter "Attach token"
      }

      backend = container "Backend API" "Domain logic, trip management, monitoring sessions, alert orchestration." "Spring Boot" {
        tripApi  = component "Trip API"  "Manages trip lifecycle: create, start, complete, cancel"
        queryApi = component "Query API" "Provides trip queries and route details"
      }

      // Base de datos local móvil
      mobileDb = container "Mobile Database" "Local storage for offline-first UX: trips, checkpoints, media, pending events." "SQLite/Isar" {
          tags "Mobile Database"
      }
    }

    // Sistemas externos
    googleMaps = softwareSystem "Google Maps" "External API for routes, distances, durations, polylines"
    sendGrid   = softwareSystem "SendGrid" "External API for transactional emails"
    fcm        = softwareSystem "Firebase Cloud Messaging" "External service for push notifications"

    // Relaciones Mobile -> Backend
    apiClient    -> tripApi "POST/PUT Commands"
    apiClient    -> queryApi "GET Queries"

    // Conexión del conector a la DB local
    databaseConn -> mobileDb "Read/write trips, checkpoints, pending events"

    // Push notifications directas
    fcm -> mobileApplication "Delivers push notifications"

    // Relaciones Backend -> Externos
    tripApi -> sendGrid "Send trip confirmation/cancellation emails"

    // Relación directa Mobile -> Google Maps
    routesAdapter -> googleMaps "Calls APIs for routes, places, polylines"
  }

  views {
    component mobileApplication {
      title "Trip Management - Mobile Application Components"
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
