workspace "CargaSafe - Alerts & Resolution Management (Mobile app Components)" "C4 Component view for the Mobile App of the Alerts & Resolution Management BC" {



  model {

    user = person "End User" "CargaSafe User (Web)"



    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      mobileApp = container "Mobile Application" "Mobile app for managing alerts and incidents" "Flutter" {
        uiAlertsM     = component "UI - Alerts (Mobile)" "Mobile alert screens"
        uiIncidentsM  = component "UI - Incidents (Mobile)" "Mobile incident screens"
        uiNotifM      = component "UI - Notifications (Mobile)" "Mobile notification screens"
        localCache    = component "Local Cache & Session" "Lightweight persistence and offline state"
        apiClientM    = component "API Client" "REST calls with token and retry logic"
        authAdapterM  = component "Auth Adapter" "OIDC/JWT for mobile"
        
        sqlite     = component "SQLite Store" "local / offline (SQLite)" "SQLite" {

          tags "Database"

        }

        user -> uiAlertsM "use"
        user -> uiIncidentsM "use"
        user -> uiNotifM "use"

        uiAlertsM -> localCache "read/write"
        uiIncidentsM -> localCache "read/write"
        uiNotifM -> localCache "read/write"

        localCache -> apiClientM "requests data"
        apiClientM -> authAdapterM "attach token"
        
        localCache -> sqlite "save/read data offline"
        apiClientM -> sqlite "updates/reads local cache"
        
      }



     backend = container "Alerts & Resolution Backend" "APIs + Workers for the bounded context" "Spring Boot" {
        alertApi    = component "Alert API" "Manages alert lifecycle: create, acknowledge, close, escalate"
        incidentApi = component "Incident API" "Creates incidents from alerts"
        notifApi    = component "Notification API" "Sends and queries notifications"
        queryApi    = component "Query API" "Queries alerts, incidents and notifications"
      }

    }



    // Relaciones mobile App -> Backend

    apiClientM -> alertApi "POST/PUT Commands"
    apiClientM -> incidentApi "POST Commands"
    apiClientM -> notifApi "POST Commands"
    apiClientM -> queryApi "GET Queries"

  }



  views {

    component mobileApp {
      title "Alerts & Resolution - Mobile Application Components"
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
      
      element "Database" {

        shape Cylinder

        background "#0B5FFF"

        color "#ffffff"

      }

    }

  }

}