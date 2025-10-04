workspace "CargaSafe - Profile and Preferences (Web App Components)" "C4 Component view for the Web Application of the Profile and Preferences BC" {

  model {
    // People
    operator    = person "Company Operator" "Manages profiles and preferences from the web console."
    driver      = person "Driver" "Updates preferences from the web application."
    endCustomer = person "End Customer" "Views profile and sets notification preferences from the web application."

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      webApplication = container "Web Application" "Angular SPA for managing profiles and preferences." "Angular" {
        profilePage        = component "Profile Page" "Main page to view and edit profile and preferences"
        profileForm        = component "Profile Form" "Form embedded in the Profile Page to edit name, phone, avatar"
        preferencesSwitches = component "Preferences Switches" "UI switches on the Profile Page to enable/disable alerts (email, push, SMS)"
        appState           = component "App State & Cache" "Manages session state and cached queries"
        apiClient          = component "API Client" "REST calls with error handling"
        authAdapter        = component "Auth Adapter" "Attaches authentication tokens to requests"

        // Relations between users and web
        operator    -> profilePage "Uses"
        driver      -> profilePage "Uses"
        endCustomer -> profilePage "Uses"

        // Internal UI relations
        profilePage -> profileForm "Contains"
        profilePage -> preferencesSwitches "Contains"

        profilePage -> appState "Reads/writes state"
        profileForm -> appState "Reads/writes state"
        preferencesSwitches -> appState "Reads/writes state"

        appState  -> apiClient "Requests data"
        apiClient -> authAdapter "Attach token"
      }

      backend = container "Profile and Preferences Backend API" "Domain logic for managing profiles and preferences." "Spring Boot" {
        profileApi     = component "Profile API" "Manages profile lifecycle: create, update"
        preferencesApi = component "Preferences API" "Manages preferences: language, timezone, alerts"
        queryApi       = component "Query API" "Provides queries for profiles and preferences"
      }
    }

    // Relations WebApp -> Backend
    apiClient -> profileApi "POST/PUT Profile operations"
    apiClient -> preferencesApi "POST/PUT Preferences operations"
    apiClient -> queryApi "GET Queries"
  }

  views {
    component webApplication {
      title "Profile and Preferences - Web Application Components"
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
