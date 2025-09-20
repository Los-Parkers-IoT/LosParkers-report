workspace "CargaSafe - Profile and Preferences (Mobile App Components)" "C4 Component view for the Mobile Application of the Profile and Preferences BC" {

  model {
    // People
    operator    = person "Company Operator" "Manages profiles and preferences from the mobile app."
    driver      = person "Driver" "Updates preferences from the mobile app."
    endCustomer = person "End Customer" "Views profile and manages notification preferences from the mobile app."

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      mobileApplication = container "Mobile Application" "Flutter app for profile and preferences management." "Flutter" {
        profileScreen        = component "Profile Screen" "Screen to view profile and preferences"
        profileFormWidget    = component "Profile Form Widget" "Widget embedded in the Profile Screen to edit profile data (name, phone, avatar)"
        preferencesSwitches  = component "Preferences Switches" "UI switches embedded in the Profile Screen to enable/disable alerts (email, push, SMS)"
        blocManager          = component "BLoC Manager" "Handles state management and reactive flows"
        databaseConn         = component "Database Connector" "Manages persistence to local mobile database"
        apiClient            = component "API Client" "REST calls with token and error handling"
        authAdapter          = component "Auth Adapter" "OIDC/JWT - attaches token to each request"

        // Relations between users and mobile
        operator    -> profileScreen "Uses"
        driver      -> profileScreen "Uses"
        endCustomer -> profileScreen "Uses"

        // Internal UI relations
        profileScreen       -> profileFormWidget "Contains"
        profileScreen       -> preferencesSwitches "Contains"
        profileScreen       -> blocManager "Read/write state"
        profileFormWidget   -> blocManager "Read/write state"
        preferencesSwitches -> blocManager "Read/write state"

        blocManager -> databaseConn "Persist/Load offline data"
        blocManager -> apiClient "Requests data"
        apiClient   -> authAdapter "Attach token"
      }

      backend = container "Profile and Preferences Backend API" "Domain logic for profiles and preferences." "Spring Boot" {
        profileApi     = component "Profile API" "Manages profile lifecycle: create, update"
        preferencesApi = component "Preferences API" "Manages preferences: language, timezone, alerts"
        queryApi       = component "Query API" "Provides queries for profiles and preferences"
      }

      // Local mobile database
      mobileDb = container "Mobile Database" "Local storage for offline-first UX: profile and preferences data." "SQLite/Isar" {
          tags "Mobile Database"
      }
    }

    // Relations Mobile -> Backend
    apiClient -> profileApi "POST/PUT Profile operations"
    apiClient -> preferencesApi "POST/PUT Preferences operations"
    apiClient -> queryApi "GET Queries"

    // Connector -> DB
    databaseConn -> mobileDb "Read/write profile and preferences data"
  }

  views {
    component mobileApplication {
      title "Profile and Preferences - Mobile Application Components"
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
