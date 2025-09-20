workspace "CargaSafe - Container Diagram" "C4 Level 2: Containers of the CargaSafe SaaS" {

  model {

    operator    = person "Company Operator" "Plans and supervises operations."
    driver      = person "Driver" "Completes trips and submits reports from the mobile app."
    endCustomer = person "End customer" "Checks status and receives reports."

    cargasafe = softwareSystem "CargaSafe (SaaS)" "Cold chain monitoring, alerts and traceability for logistics trips." {

      landing = container "Landing Page" "HTML/CSS" "Public marketing site and redirects to the apps."
      webapp  = container "Web Frontend" "Angular" "Operations UI for operators."
      singleWeb = container "Single Web" "SPA/SSR" "Public tracking and report views (read-only)."

      mobile  = container "Mobile App" "Flutter" "Mobile application for drivers; offline-first."
      backend = container "Backend API" "Spring Boot" "Domain logic, trip management, monitoring sessions, alert orchestration."

      db = container "Relational Database" "PostgreSQL" "Persistent storage: users, vehicles, devices, trips, telemetry, alerts, subscriptions." {
        tags "Database"
      }

      embeddedApp = container "Embedded Application" "C++" "Lightweight embedded app/component that runs on constrained environments to capture data and buffer events for later sync."
      edgeApp     = container "Edge Application" "Python" "On-prem/edge agent for depots/vehicles: local processing, caching and reliable sync with Backend API during intermittent connectivity."
      edgeDb      = container "Edge Database" "SQLite/Embedded DB" "Local storage for edge caching, spool and retry." {
        tags "Database"
      }

      mobileDb = container "Database (Mobile)" "SQLite/Isar" "Local storage for offline-first UX: trips, checkpoints, media, pending events." {
        tags "Database"
      }

      operator    -> webapp   "Uses (manage trips, fleet, reports)"
      driver      -> mobile   "Uses (trip instructions, status updates)"
      endCustomer -> singleWeb "Views public tracking and reports"
      endCustomer -> mobile   "Receives status links/notifications"

      landing -> webapp    "Redirects/sign-in links"
      landing -> singleWeb "Redirects to public tracking"
      landing -> mobile    "App download / deep links"

      webapp  -> backend   "API calls (REST/JSON)"
      singleWeb -> backend "API calls (REST/JSON) – read-only"
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

    backend      -> gmaps   "Requests routes and ETA"
    backend      -> stripe  "Processes subscription payments"
    backend      -> fcm     "Sends push notifications"
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