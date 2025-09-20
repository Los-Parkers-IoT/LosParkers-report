workspace "CargaSafe - Trip Management (Web App Components)" "C4 Component view for the Web Application of the Trip Management BC" {

  model {
    // Personas
    operator    = person "Company Operator" "Company staff that plans and supervises operations."
    driver      = person "Driver" "Completes trips and submits reports from the app."
    endCustomer = person "End Customer" "Checks status and receives reports."

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      webApplication = container "Web Application" "Angular SPA for CargaSafe UI & dashboards." "Angular" {
        uiTripsList    = component "UI - Trips List" "Displays trips dashboard with filters and status"
        uiTripDetails  = component "UI - Trip Details" "View details of a trip including its route on map"
        uiTripForm     = component "UI - Trip Form" "Form for creating or editing trips (only operator)"
        uiMap          = component "UI - Map" "Reusable map component to display routes and markers"
        appState       = component "App State & Cache" "Manages session, authentication, cached queries"
        apiClient      = component "API Client" "REST calls with token and error handling"
        authAdapter    = component "Auth Adapter" "OIDC/JWT - attaches token to each request"
        routesAdapter  = component "RoutesAdapterFacade" "Facade for interacting with Google Maps routes, places and polylines"

        // Relaciones entre usuarios y web
        operator -> uiTripsList "Uses"
        operator -> uiTripDetails "Uses"
        operator -> uiTripForm "Uses"

        driver -> uiTripsList "Uses"
        driver -> uiTripDetails "Uses"

        endCustomer -> uiTripsList "Uses"
        endCustomer -> uiTripDetails "Uses"

        // Relaciones internas UI
        uiTripsList   -> appState "Read/write state"
        uiTripDetails -> appState "Read/write state"
        uiTripForm    -> appState "Read/write state"

        uiTripDetails -> uiMap "Embeds map"
        uiTripForm    -> uiMap "Embeds map"
        uiMap -> routesAdapter "Requests routes and map data"

        appState -> apiClient "Requests data"
        apiClient -> authAdapter "Attach token"
      }

      backend = container "Backend API" "Domain logic, trip management, monitoring sessions, alert orchestration." "Spring Boot" {
        tripApi  = component "Trip API"  "Manages trip lifecycle: create, start, complete, cancel"
        queryApi = component "Query API" "Provides trip queries and route details"
      }
    }

    // Sistemas externos
    googleMaps = softwareSystem "Google Maps" "External API for routes, distances, durations, polylines"
    sendGrid   = softwareSystem "SendGrid" "External API for transactional emails"
    fcm        = softwareSystem "Firebase Cloud Messaging" "External service for push notifications"

    // Relaciones WebApp -> Backend
    apiClient    -> tripApi "POST/PUT Commands"
    apiClient    -> queryApi "GET Queries"

    // Relaciones Backend -> Externos
    tripApi -> sendGrid "Send trip confirmation/cancellation emails"
    tripApi -> fcm "Send trip status push notifications"

    // Relación directa Web -> Google Maps
    routesAdapter -> googleMaps "Calls APIs for routes, places, polylines"
  }

  views {
    component webApplication {
      title "Trip Management - Web Application Components"
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
