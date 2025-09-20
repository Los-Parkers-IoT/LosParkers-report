workspace "CargaSafe - Fleet Management Components (Backend)" "C4 Component view for the Fleet Management Context of CargaSafe" {

  model {

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring platform" {


    webApplication = container "Web Application" "Angular SPA for CargaSafe UI & dashboards." "Angular" {
        tags "WebApp"
      }

      mobileApplication = container "Mobile Application" "Flutter app for CargaSafe mobile operations." "Flutter" {
        tags "MobileApp"
      }
      // ===== Fleet BC (Backend) =====
      fleetContext = container "Fleet Management Backend" "CRUD Vehicles/Devices (REST API)" "Spring Boot / Node" {

        intLayer    = component "Interface Layer (REST)" "Controllers: VehicleController, DeviceController" "Framework"
        appLayer    = component "Application Layer" "VehicleCommandServiceImpl, DeviceCommandServiceImpl, FleetQueryServiceImpl" "Framework"
        domainLayer = component "Domain Layer" "Aggregates & Domain Services: Vehicle, Device, DeviceAttachmentService" "Language/Runtime"
        infLayer    = component "Infrastructure Layer" "VehicleRepository, DeviceRepository, IAMClient adapter" "Framework"
      }

      postgres = container "Postgress" "Vehicles & Devices" "PostgreSQL" {
        tags "Database"
      }
    }

    // ===== Relaciones por capas =====
    webApplication     -> intLayer "Consumes REST endpoints"
    mobileApplication  -> intLayer "Consumes REST endpoints"
    intLayer  -> appLayer    "Invokes commands/queries"
    appLayer  -> domainLayer "Delegates invariants"
    appLayer  -> infLayer    "Uses repositories/ports"
    infLayer  -> postgres                 "Read/Write"
  }

  views {

    component fleetContext {
      title "Fleet Management - Backend Component Diagram"
      description "Internal layered components (Interface, Application, Domain, Infrastructure) for the Fleet Management BC inside CargaSafe."
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
