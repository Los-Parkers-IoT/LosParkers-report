workspace "CargaSafe - Container Diagram" "C4 Level 2: Containers of the CargaSafe SaaS" {

  model {

    operator    = person "Company Operator" "Plans and supervises operations."
    driver      = person "Driver" "Completes trips and submits reports from the mobile app."
    endCustomer = person "End customer" "Checks status and receives reports."

    cargasafe = softwareSystem "CargaSafe (SaaS)" "Cold chain monitoring, alerts and traceability for logistics trips." {

      landing = container "Landing Page" "Public marketing site and redirects to the apps." "HTML/CSS"
      webapp  = container "Web App" "Operations UI for operators." "Angular"

      mobile  = container "Mobile App" "Mobile application for drivers; offline-first." "Flutter"
      backend = container "Backend API" "Domain logic, trip management, monitoring sessions, alert orchestration." "Spring Boot"

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

      operator    -> webapp   "Uses (manage trips, fleet, reports)"
      driver      -> mobile   "Uses (trip instructions, status updates)"
      endCustomer -> mobile   "Receives status links/notifications"

      landing -> webapp    "Redirects/sign-in links"
      landing -> mobile    "App download / deep links"

      webapp  -> backend   "API calls (REST/JSON)"
      mobile  -> backend   "API calls (REST/JSON, background sync)"

      mobile  -> mobileDb  "Reads/Writes (offline cache)"
      edgeApp -> edgeDb    "Reads/Writes (local cache/spool)"

      embeddedApp -> edgeApp "Buffers data/events for edge processing"
      edgeApp     -> backend "Secure sync (REST/JSON, gRPC or MQTT over WebSockets)"

      backend -> db        "Reads/Writes"
    }

    gmaps        = softwareSystem "Google Maps" "Routes, geocoding and ETA."
    stripe       = softwareSystem "Stripe" "Payments and billing for subscriptions."
    fcm          = softwareSystem "Firebase Cloud Messaging" "Push notifications to mobile/web."
    sendgrid     = softwareSystem "SendGrid" "Email delivery service for notifications and reports."

    backend      -> gmaps    "Requests routes and ETA"
    backend      -> stripe   "Processes subscription payments"
    backend      -> fcm      "Sends push notifications"
    backend      -> sendgrid "Sends email notifications and reports"
  }

  views {
    container cargasafe "cargasafe-containers" "CargaSafe - Container Diagram" {
      include *
      autoLayout lr
    }

    styles {
      element "Person" {
        shape Person
        background "#0b4884"
        color "#ffffff"
      }
      element "Container" {
        shape RoundedBox
        background "#1168bd"
        color "#ffffff"
      }
      element "Database" {
        shape Cylinder
        background "#0f5ea6"
        color "#ffffff"
      }
      element "Software System" {
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
