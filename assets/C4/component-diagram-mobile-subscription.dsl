workspace "CargaSafe - Subscriptions & Billing (Mobile App Components)" "C4 Component view for the Mobile Application" {



  model {

    user = person "End User (Mobile)" "Usuario de la app móvil"



    cargaSafe = softwareSystem "CargaSafe" "SaaS de monitoreo logístico" {

      // ---- Mobile app (cliente) ----

      mobileApp = container "Mobile Application" "App móvil para gestión de suscripciones y facturación" "Kotlin/Swift/Flutter" {

        uiSubs     = component "UI - Subscriptions" "Pantallas de suscripción"

        uiBilling  = component "UI - Billing" "Pantallas de facturación y pagos"

        appState   = component "App State & Cache" "Maneja sesión y cache de datos"

        sqlite     = component "SQLite Store" "Persistencia local / offline (SQLite)" "SQLite" {

          tags "Database"

        }

        apiClient  = component "API Client" "REST/GraphQL con manejo de tokens"

        authAdp    = component "Auth Adapter" "OIDC/JWT – secure storage de tokens"



        // Relaciones internas

        user -> uiSubs "Usa"

        user -> uiBilling "Usa"

        uiSubs -> appState "lee/escribe estado"

        uiBilling -> appState "lee/escribe estado"



        // Lecturas y cache

        appState  -> apiClient "solicita datos"

        apiClient -> sqlite   "actualiza/lee cache local"

        appState  -> sqlite   "guarda/lee datos offline"



        // Auth

        apiClient -> authAdp "adjunta token"

      }



      // ---- Backend del BC con sus APIs como componentes ----

      backend = container "Subscriptions & Billing Backend" "REST/GraphQL APIs" "Monolito" {

        subsApi  = component "Subscriptions API" "Comandos"

        queryApi = component "Query API" "Consultas"

      }

    }



    // Relaciones Mobile -> Backend (a componentes de backend)

    apiClient -> subsApi  "POST/PUT comandos"

    apiClient -> queryApi "GET consultas"

  }



  views {

    component mobileApp {

      title "Subscriptions & Billing Mobile Application - Component Diagram"

      description "Componentes principales de la app móvil (incluye SQLite para offline) y su interacción con el backend."

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