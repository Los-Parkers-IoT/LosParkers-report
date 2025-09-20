workspace "CargaSafe - Real-Time Monitoring (Mobile app Components)" "C4 Component view for the Mobile App of the Real-Time Monitoring BC" {
  model {
    user = person "End User" "CargaSafe User (Mobile)"
    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {
      mobileApp = container "Mobile Application" "Mobile app for real-time monitoring" "Flutter" {
        uiDashboardM     = component "UI - Dashboard (Mobile)" "Mobile monitoring dashboard screens"
        uiMapM           = component "UI - Live Map (Mobile)" "Mobile real-time tracking screens"
        uiChartsM        = component "UI - Charts (Mobile)" "Mobile telemetry charts screens"
        uiAlertsM        = component "UI - Alerts (Mobile)" "Mobile monitoring alerts screens"
        localCache       = component "Local Cache & Session" "Lightweight persistence and offline state"
        apiClientM       = component "API Client" "REST calls with token and retry logic"
        authAdapterM     = component "Auth Adapter" "OIDC/JWT for mobile"
        googleFacadeM    = component "Google Facade Service" "Google Maps integration for mobile"
        
        sqlite     = component "SQLite Store" "local / offline (SQLite)" "SQLite" {
          tags "Database"
        }
        user -> uiDashboardM "use"
        user -> uiMapM "use"
        user -> uiChartsM "use"
        user -> uiAlertsM "use"
        uiDashboardM -> localCache "read/write"
        uiMapM -> localCache "read/write"
        uiChartsM -> localCache "read/write"
        uiAlertsM -> localCache "read/write"
        localCache -> apiClientM "requests data"
        apiClientM -> authAdapterM "attach token"
        
        uiMapM -> googleFacadeM "use maps services"
        
        localCache -> sqlite "save/read data offline"
        apiClientM -> sqlite "updates/reads local cache"
        
      }
     backend = container "Real-Time Monitoring Backend" "APIs + Workers for the bounded context" "Spring Boot" {
        sessionApi    = component "Session API" "Manages monitoring session lifecycle"
        telemetryApi  = component "Telemetry API" "Retrieves telemetry data and live readings"
        mapApi        = component "Map API" "Provides real-time location and route data"
        chartApi      = component "Chart API" "Serves temperature and sensor data for charts"
      }
      
    }
    
    // External system
    googleMaps = softwareSystem "Google Maps API" "External mapping and location services"
    
    // Relaciones mobile App -> Backend
    apiClientM -> sessionApi "GET Queries"
    apiClientM -> telemetryApi "GET Queries"
    apiClientM -> mapApi "GET Queries"
    apiClientM -> chartApi "GET Queries"
    
    // Google Maps integration
    googleFacadeM -> googleMaps "API calls"
  }
  views {
    component mobileApp {
      title "Real-Time Monitoring - Mobile Application Components"
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
