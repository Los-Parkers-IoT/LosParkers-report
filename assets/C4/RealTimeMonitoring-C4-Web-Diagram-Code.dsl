
workspace "CargaSafe - Real-Time Monitoring (Web App Components)" "C4 Component view for the Web Application of the Real-Time Monitoring BC" {
  model {
    user = person "End User" "CargaSafe User (Web)"
    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {
      webApp = container "Web Application" "Web frontend for real-time monitoring" "Angular" {
        uiDashboard     = component "UI - Dashboard" "Monitoring dashboard screens"
        uiLiveMap       = component "UI - Live Map" "Real-time tracking and map visualization"
        uiCharts        = component "UI - Charts" "Temperature and sensor data charts"
        uiSessions      = component "UI - Sessions" "Monitoring session management screens"
        appState        = component "App State & Cache" "Handles session, authentication and cached queries"
        apiClient       = component "API Client" "REST/GraphQL calls with token and error handling"
        authAdapter     = component "Auth Adapter" "OIDC/JWT - attaches token to each request"
        user -> uiDashboard "Uses"
        user -> uiLiveMap "Uses"
        user -> uiCharts "Uses"
        user -> uiSessions "Uses"
        uiDashboard -> appState "Read/write state"
        uiLiveMap -> appState "Read/write state"
        uiCharts -> appState "Read/write state"
        uiSessions -> appState "Read/write state"
        appState -> apiClient "Requests data"
        apiClient -> authAdapter "Attach token"
      }
     backend = container "Real-Time Monitoring Backend" "APIs + Workers for the bounded context" "Spring Boot" {
        sessionApi    = component "Session API" "Manages monitoring session lifecycle"
        telemetryApi  = component "Telemetry API" "Retrieves telemetry data and live readings"
        mapApi        = component "Map API" "Provides real-time location and route data"
        chartApi      = component "Chart API" "Serves temperature and sensor data for charts"
      }
    }
    // Relaciones Web App -> Backend
    apiClient -> sessionApi "GET/POST Commands"
    apiClient -> telemetryApi "GET Queries"
    apiClient -> mapApi "GET Queries"
    apiClient -> chartApi "GET Queries"
  }
  views {
    component webApp {
      title "Real-Time Monitoring - Web Application Components"
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
