workspace "CargaSafe - Fleet Management Components" "C4 Component view for the Fleet Management Context of CargaSafe" {

  model {

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring platform" {

      webApplication = container "Web Application" "Angular SPA for CargaSafe UI & dashboards." "Angular" {
        tags "WebApp"
      }

      mobileApplication = container "Mobile Application" "Flutter app for CargaSafe mobile operations." "Flutter" {
        tags "MobileApp"
      }

      fleetContext = container "Fleet Management Context" "APIs + Workers of the bounded context" "Spring Boot (REST + Jobs)" {

        fleetIntLayer    = component "Fleet Management Interface Layer" "Controllers (REST): Vehicle, Device" "Spring Boot"
        fleetAppLayer    = component "Fleet Management Application Layer" "Use case orchestration (Command Services, Query Services)" "Spring Boot"
        fleetDomainLayer = component "Fleet Management Domain Layer" "Entities, Value Objects, Aggregates, Domain Services (Vehicle, Device, DeviceAttachmentService)" "Spring Boot"
        fleetInfLayer    = component "Fleet Management Infrastructure Layer" "Repositories and database connectors (VehicleRepository, DeviceRepository, IAMClient adapter)" "Spring Boot"
      }

      fleetPostgres = container "Postgres" "Relational database for vehicles and devices" "RDBMS" {
        tags "Database"
      }
    }

    webApplication     -> fleetIntLayer "Consumes REST endpoints"
    mobileApplication  -> fleetIntLayer "Consumes REST endpoints"
    fleetIntLayer -> fleetAppLayer "Invokes commands and queries"
    fleetAppLayer -> fleetDomainLayer "Applies domain logic"
    fleetAppLayer -> fleetInfLayer "Uses repositories"
    fleetInfLayer -> fleetPostgres "Read/write vehicles and devices data"
    
  }

  views {

    component fleetContext {
      title "Fleet Management Context - Component Diagram"
      description "Internal layered components of the Fleet Management Context inside CargaSafe."
      include *
      autoLayout tb
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

      element "Database" {
        shape Cylinder
        background "#0B5FFF"
        color "#ffffff"
      }

      element "WebApp" {
        shape WebBrowser
        background "#00897B"
        color "#ffffff"
      }

      element "MobileApp" {
        shape MobileDevicePortrait
        background "#6A1B9A"
        color "#ffffff"
      }
    }
  }
}
