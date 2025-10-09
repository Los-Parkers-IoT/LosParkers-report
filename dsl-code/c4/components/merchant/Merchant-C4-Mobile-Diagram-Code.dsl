workspace "CargaSafe - Merchant (Mobile app Components)" "C4 Component view for the Mobile App of the Merchant BC" {
  model {
    merchantAdmin   = person "Merchant Admin" "Manages merchant profile, locations, contacts and contracts (Mobile)"
    financeAnalyst  = person "Finance Analyst" "Reviews subscriptions, invoices and payments (Mobile)"

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {
      merchantMobileApp = container "Mobile Application" "Mobile app for merchant administration" "Flutter" {
        uiMerchantProfileM = component "UI - Merchant Profile (Mobile)" "Mobile screens for merchant profile and contacts"
        uiLocationsM       = component "UI - Locations (Mobile)" "Mobile screens to manage merchant locations"
        uiContractsM       = component "UI - Contracts (Mobile)" "Mobile screens to manage contracts"
        uiBillingM         = component "UI - Billing (Mobile)" "Mobile screens for plans, subscriptions and invoices"
        localCacheM        = component "Local Cache & Session" "Lightweight persistence and offline state"
        apiClientMM        = component "API Client" "REST calls with token and retry logic"
        authAdapterMM      = component "Auth Adapter" "OIDC/JWT for mobile"
        paymentsFacadeM    = component "Payments Facade Service" "Integration helper for payments SDK/APIs (mobile)"

        sqliteM = component "SQLite Store" "local / offline (SQLite)" "SQLite" {
          tags "Database"
        }

        merchantAdmin  -> uiMerchantProfileM "use"
        merchantAdmin  -> uiLocationsM "use"
        merchantAdmin  -> uiContractsM "use"
        merchantAdmin  -> uiBillingM "use"
        financeAnalyst -> uiBillingM "use"

        uiMerchantProfileM -> localCacheM "read/write"
        uiLocationsM       -> localCacheM "read/write"
        uiContractsM       -> localCacheM "read/write"
        uiBillingM         -> localCacheM "read/write"

        localCacheM -> apiClientMM "requests/refresh data"
        apiClientMM -> authAdapterMM "attach/refresh token"

        uiBillingM -> paymentsFacadeM "use payments services"

        localCacheM -> sqliteM "save/read data offline"
        apiClientMM -> sqliteM "hydrate cache / read-through"
      }

      merchantBackend = container "Merchant Backend" "APIs + Workers for the Merchant bounded context" "Spring Boot" {
        merchantApi   = component "Merchant API" "CRUD merchants, contacts and locations"
        contractApi   = component "Contract API" "Manage contracts lifecycle"
        billingApi    = component "Billing API" "Plans and subscriptions management"
        invoiceApi    = component "Invoice API" "Invoice listing and retrieval"
        webhookWorker = component "Billing Webhook Consumer" "Consumes payment/billing webhooks and updates state"
      }
    }

    // External system
    paymentsGateway = softwareSystem "Payments Gateway" "External subscriptions, invoices and webhooks" {
      tags "External"
    }

    // Mobile App -> Backend (HTTPS/REST)
    apiClientMM -> merchantApi "GET/POST" "HTTPS/REST"
    apiClientMM -> contractApi "GET/POST" "HTTPS/REST"
    apiClientMM -> billingApi  "GET/POST" "HTTPS/REST"
    apiClientMM -> invoiceApi  "GET"      "HTTPS/REST"

    // Backend -> External payments
    billingApi      -> paymentsGateway "Create/Update subscription, retrieve invoices" "HTTPS"
    paymentsGateway -> webhookWorker   "Sends webhooks (subscription.updated, invoice.paid)" "HTTPS"

  }
  views {
    component merchantMobileApp {
      title "Merchant - Mobile Application Components"
      description "Mobile UI for Merchant, offline cache/session, API client/auth, Merchant Backend APIs and external payments integration."
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
