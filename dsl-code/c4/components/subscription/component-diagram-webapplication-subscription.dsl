workspace "CargaSafe - Subscriptions & Billing (Web App Components)" "C4 Component view for the Web Application of the Subscriptions & Billing BC" {



  model {

    user = person "End User" "CargaSafe User (Web)"



    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {

      webApp = container "Web Application" "FWeb frontend for subscription management and billing" "Angular" {

        uiSubs    = component "UI - Subscriptions" "Subscription management screens"

        uiBilling = component "UI - Billing" "Billing and payment screens"

        appState  = component "App State & Cache" "Handles session, authentication, query cache"

        apiClient = component "API Client" "REST/GraphQL calls with token and error handling"

        authAdp   = component "Auth Adapter" "OIDC/JWT - adds tokens to each request"



        user -> uiSubs "Use"

        user -> uiBilling "Use"

        uiSubs -> appState "read/write status"

        uiBilling -> appState "read/write status"

        appState -> apiClient "requests data"

        apiClient -> authAdp "attach token"

      }



      backend = container "Subscriptions & Billing Backend" "backend" "REST/GraphQL APIs" {

        subsApi  = component "Subscriptions API" "Commands"

        queryApi = component "Query API" "Consultations"

      }

    }



    // Relaciones Web App -> Backend

    apiClient -> subsApi "POST/PUT Commands"

    apiClient -> queryApi "GET queries"

  }



  views {

    component webApp {

      title "Subscriptions & Billing Web Application - Component Diagram"

      description "Main components of the web application and their interaction with the backend."

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