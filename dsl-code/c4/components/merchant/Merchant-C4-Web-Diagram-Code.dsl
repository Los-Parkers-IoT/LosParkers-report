workspace "CargaSafe - Merchant (Web App Components)" "C4 Component view for the Merchant BC Web Application" {
  model {
    merchantAdmin     = person "Merchant Admin" "Admin user managing merchant account, locations and contacts"
    financeAnalyst    = person "Finance/Billing Analyst" "Manages subscriptions, invoices and payments"

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {
      merchantWebApp = container "Merchant Web Application" "Admin portal for merchant management" "Angular" {
        uiMerchantProfile = component "UI - Merchant Profile" "Screens for merchant profile and contacts"
        uiLocations       = component "UI - Locations" "Screens to manage merchant locations"
        uiContracts       = component "UI - Contracts" "Screens to manage contracts"
        uiBilling         = component "UI - Billing" "Screens for plans, subscriptions and invoices"
        localCache        = component "Local Cache & Session" "Client-side state and session"
        apiClient         = component "API Client" "REST calls with token and retry logic"
        authAdapter       = component "Auth Adapter" "OIDC/JWT for web"

        merchantAdmin  -> uiMerchantProfile "use"
        merchantAdmin  -> uiLocations "use"
        merchantAdmin  -> uiContracts "use"
        merchantAdmin  -> uiBilling "use"
        financeAnalyst -> uiBilling "use"
        financeAnalyst -> uiContracts "use"

        uiMerchantProfile -> localCache "read/write"
        uiLocations       -> localCache "read/write"
        uiContracts       -> localCache "read/write"
        uiBilling         -> localCache "read/write"

        localCache -> apiClient "requests/refresh data"
        apiClient  -> authAdapter "attach/refresh token"
      }

      merchantBackend = container "Merchant Backend" "APIs + Workers for the Merchant bounded context" "Spring Boot" {
        merchantApi   = component "Merchant API" "CRUD merchants, contacts and locations"
        contractApi   = component "Contract API" "Manage contracts lifecycle"
        billingApi    = component "Billing API" "Plans and subscriptions management"
        invoiceApi    = component "Invoice API" "Invoice listing and retrieval"
        webhookWorker = component "Billing Webhook Consumer" "Consumes payment webhooks and updates state"
      }

      merchantPostgres = container "Postgres (Merchant)" "Relational database for merchants, locations, contacts, contracts and billing state" "PostgreSQL" {
        tags "Database"
      }
    }

    // External system
    paymentsGateway = softwareSystem "Payments Gateway" "External subscriptions, invoices and webhooks" {
      tags "External"
    }

    // WebApp -> Backend (HTTPS/REST)
    apiClient -> merchantApi "GET/POST" "HTTPS/REST"
    apiClient -> contractApi "GET/POST" "HTTPS/REST"
    apiClient -> billingApi  "GET/POST" "HTTPS/REST"
    apiClient -> invoiceApi  "GET"      "HTTPS/REST"

    // Backend -> DB
    merchantApi   -> merchantPostgres "read/write"
    contractApi   -> merchantPostgres "read/write"
    billingApi    -> merchantPostgres "read/write"
    invoiceApi    -> merchantPostgres "read"
    webhookWorker -> merchantPostgres "read/write"

    // Backend -> External payments
    billingApi     -> paymentsGateway "Create/Update subscription, retrieve invoices" "HTTPS"
    paymentsGateway -> webhookWorker  "Sends webhooks (subscription.updated, invoice.paid)" "HTTPS"
  }

  views {
    component merchantWebApp {
      title "Merchant - Web Application Components"
      description "Merchant WebApp UI, client cache/auth, Merchant Backend APIs, database and external payments integration."
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
      element "External" {
        opacity 60
        stroke "#ffffff"
      }
    }
  }
}
