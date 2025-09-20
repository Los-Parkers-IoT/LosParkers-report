workspace "CargaSafe - Alerts & Resolution Management (Web App Components)" "C4 Component view for the Web Application of the Alerts & Resolution Management BC" {



  model {

    user = person "End User" "CargaSafe User (Web)"



    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      webApp = container "Web Application" "Web frontend for managing alerts and incidents" "Angular" {
        uiAlerts     = component "UI - Alerts" "Alert management screens"
        uiIncidents  = component "UI - Incidents" "Incident management screens (created from alerts)"
        uiNotif      = component "UI - Notifications" "Notification screens"
        appState     = component "App State & Cache" "Handles session, authentication and cached queries"
        apiClient    = component "API Client" "REST/GraphQL calls with token and error handling"
        authAdapter  = component "Auth Adapter" "OIDC/JWT - attaches token to each request"

        user -> uiAlerts "Uses"
        user -> uiIncidents "Uses"
        user -> uiNotif "Uses"

        uiAlerts -> appState "Read/write state"
        uiIncidents -> appState "Read/write state"
        uiNotif -> appState "Read/write state"

        appState -> apiClient "Requests data"
        apiClient -> authAdapter "Attach token"
      }



     backend = container "Alerts & Resolution Backend" "APIs + Workers for the bounded context" "Spring Boot" {
        alertApi    = component "Alert API" "Manages alert lifecycle: create, acknowledge, close, escalate"
        incidentApi = component "Incident API" "Creates incidents from alerts"
        notifApi    = component "Notification API" "Sends and queries notifications"
        queryApi    = component "Query API" "Queries alerts, incidents and notifications"
      }

    }



    // Relaciones Web App -> Backend

    apiClient -> alertApi "POST/PUT Commands"
    apiClient -> incidentApi "POST Commands"
    apiClient -> notifApi "POST Commands"
    apiClient -> queryApi "GET Queries"

  }



  views {

    component webApp {
      title "Alerts & Resolution - Web Application Components"
      include *
      autoLayout lr
    }



    styles {

      element "Container" {

        background "#0B5FFF"

        color "#ffffff"

      }

      element "Component" {

        background "#3F8CFF"

        color "#ffffff"

      }

      element "Software System" {

        background "#666666"

        color "#ffffff"

      }

      element "Person" {

        background "#084C61"

        color "#ffffff"

      }

    }

  }

}