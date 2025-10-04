workspace "CargaSafe - Unified Context & Container Diagrams" "C4 Level 1 & 2: Context and Container" {

  model {

    // Personas (actores)
    operator    = person "Company Operator" "Plans and supervises operations."
    driver      = person "Driver" "Completes trips and submits reports from the mobile app."
    endCustomer = person "End customer" "Checks status and receives reports."

    // Sistemas externos (definidos antes para poder referenciarlos dentro de CargaSafe)
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
    
    monitoringDevice = softwareSystem "CargaSafe Monitoring Device" "Physical devices installed in vehicles to capture and transmit environmental data." {
        tags "ExternalSystem"
    }
    
    

    // Sistema en foco
    cargasafe = softwareSystem "CargaSafe (SaaS)" "Cold chain monitoring, alerts and traceability for logistics trips." {
      tags "InternalSystem"

      // --- Containers ---
      landing = container "Landing Page" "Public marketing site and redirects to the apps." "HTML/CSS"
      webapp  = container "Web Application" "Delivers the static content and provides the CargaSafe web interface for operators to manage trips, vehicles, alerts, and reports in real time." "Angular"
      mobile  = container "Mobile App" "Mobile application for drivers; offline-first." "Flutter" {
          tags "MobileApp"
      }
      backend = container "Backend API" "Domain logic, trip management, monitoring sessions, alert orchestration." "Spring Boot"
      spa = container "Single Page Application" "Provides operators and clients access to CargaSafe’s monitoring and trip management features via their web browser." {
          tags "SinglePageApplication"
      }

      db = container "Relational Database" "Persistent storage: users, vehicles, devices, trips, telemetry, alerts, subscriptions." "PostgreSQL" {
        tags "Database"
      }

      embeddedApp = container "Embedded Application" "Lightweight embedded app/component that runs on constrained environments to capture data and buffer events for later sync." "C++"
      edgeApp     = container "Edge Application" "On-prem/edge agent for depots/vehicles: local processing, caching and reliable sync with Backend API during intermittent connectivity." "Python"
      edgeDb      = container "Edge Database" "Local storage for edge caching, spool and retry." "SQLite/Embedded DB" {
        tags "Database"
      }

      mobileDb = container "Database (Mobile)" "Local storage for offline-first UX: trips, checkpoints, media, pending events." "SQLite/Isar" {
        tags "Database"
      }

      // --- Relaciones internas (Container level) ---
      operator    -> webapp   "Uses (manage trips, fleet, reports)"
      driver      -> mobile   "Uses (trip instructions, status updates)"
      endCustomer -> mobile   "Receives status links/notifications"
      operator -> landing "Explores product features and navigates to the main app"
      endCustomer -> landing "Visits the landing page to track shipments and learn about services"

      landing -> webapp    "Redirects/sign-in links"
      landing -> mobile    "App download / deep links"
      webapp -> spa "Deliver to the customer's web browser"

      spa  -> backend   "API calls (REST/JSON)"
      mobile  -> backend   "API calls (REST/JSON, background sync)"

      mobile  -> mobileDb  "Reads/Writes (offline cache)"
      edgeApp -> edgeDb    "Reads/Writes (local cache/spool)"
      spa -> gmaps "Uses Maps SDK for visualization and address search"
      mobile -> gmaps "Uses Maps SDK for visualization and address search"

      embeddedApp -> edgeApp "Buffers data/events for edge processing"
      edgeApp     -> backend "Secure sync (REST/JSON, gRPC or MQTT over WebSockets)"

      backend -> db        "Reads/Writes"

    }
    
        // --- Relaciones del backend con sistemas externos (definidas AQUÍ para evitar problemas de scope) ---
    backend -> gmaps        "Requests routes and ETA"
    backend -> stripe       "Processes subscription payments"
    backend -> notifications "Sends push notifications"
    backend -> sendgrid     "Sends email notifications and reports"
    embeddedApp -> monitoringDevice "Operates sensors and manages data capture"

    # // Relaciones de sistema (Context level)
    # operator     -> cargasafe "Manages trips, fleet and reports"
    # driver       -> cargasafe "Sends status, receives trip instructions"
    # endCustomer  -> cargasafe "Checks trip status"

    # cargasafe -> gmaps        "Requests routes and ETA"
    # cargasafe -> notifications "Sends push notifications and SMS"
    # cargasafe -> sendgrid     "Sends email notifications and reports"
    # cargasafe -> stripe       "Processes subscription payments"
  }

  views {

    // --- Nivel 1: Context ---
    systemContext cargasafe "cargasafe-context" "CargaSafe - System Context" {
      include *
      autoLayout
    }

    // --- Nivel 2: Containers ---
    container cargasafe "cargasafe-containers" "CargaSafe - Container Diagram" {
      include *
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
      element "Container" {
        shape Box
        background "#438dd5"
        color "#ffffff"
      }
      element "Database" {
        shape Cylinder
        background "#438dd5"
        color "#ffffff"
      }
      element "SinglePageApplication" {
        shape WebBrowser
      }
      element "MobileApp" {
        shape MobileDeviceLandscape
      }
      relationship "Relationship" {
        color "#bdbdbd"
      }
    }
  }
}
