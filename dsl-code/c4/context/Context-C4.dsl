workspace "CargaSafe - Context Diagram" "C4 Level 1: System Context" {
  model {
    // Personas (actores)
    operator    = person "Company Operator" "Company staff that plans and supervises operations."
    driver      = person "Driver" "Completes trips and submits reports from the app."
    endCustomer = person "End customer" "Checks status and receives reports."
    
    // Sistema en foco
    cargasafe = softwareSystem "CargaSafe (SaaS)" "Cold chain monitoring, alerts and traceability for logistics trips." {
      tags "InternalSystem"
    }
    
    // Sistemas externos
    stripe = softwareSystem "Stripe" "Payments and billing for subscriptions." {
      tags "ExternalSystem"
    }
    gmaps = softwareSystem "Google Maps" "Routes, geocoding and ETA." {
      tags "ExternalSystem"
    }
    notifications = softwareSystem "Firebase Cloud Messaging" "Delivery channels: FCM, SMS." {
      tags "ExternalSystem"
    }
    sendgrid = softwareSystem "SendGrid" "Email delivery service for notifications and reports." {
      tags "ExternalSystem"
    }
    
    // Relaciones (actores ↔ CargaSafe)
    operator   -> cargasafe "Manages trips, fleet and reports"
    driver     -> cargasafe "Sends status, receives trip instructions"
    endCustomer -> cargasafe "Check trip status"
    # cargasafe  -> endCustomer "Sends status links and reports"
    
    // Relaciones (sistemas externos ↔ CargaSafe)
    cargasafe -> gmaps "Requests routes and ETA"
    cargasafe -> notifications "Sends push notifications and SMS"
    cargasafe -> sendgrid "Sends email notifications and reports"
    cargasafe -> stripe "Processes subscription payments"
  }
  
  views {
    systemContext cargasafe "cargasafe-context" "CargaSafe - System Context" {
        include *
        autolayout
    }
    
    styles {
      element "Person" {
        shape Person
        background "#0b4884"
        color "#ffffff"
      }
      element "InternalSystem" {
        shape RoundedBox
        background "#1168bd"
        color "#ffffff"
      }
      element "ExternalSystem" {
        shape RoundedBox
        background "#999999"
        color "#ffffff"
      }
      relationship "Relationship" {
        color "#bdbdbd"
      }
    }
  }
}