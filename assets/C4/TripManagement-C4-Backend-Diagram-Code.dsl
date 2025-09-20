workspace "CargaSafe - Trip Management Components" "C4 Component view for the Trip Management Context of CargaSafe" {

  model {

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring platform" {

      webApplication = container "Web Application" "Angular SPA for CargaSafe UI & dashboards." "Angular" {
        tags "WebApp"
      }

      mobileApplication = container "Mobile Application" "Flutter app for CargaSafe mobile operations." "Flutter" {
        tags "MobileApp"
      }

      tripContext = container "Trip Management Context" "APIs + Workers of the bounded context" "Spring Boot (REST + Jobs)" {

        tripIntLayer    = component "Trip Management Interface Layer" "Controllers (REST): Trip, Route" "Spring Boot"
        tripAppLayer    = component "Trip Management Application Layer" "Use case orchestration (Command Services, Query Services, Event Services)" "Spring Boot"
        tripDomainLayer = component "Trip Management Domain Layer" "Entities, Value Objects, Aggregates, Factories, Domain Services" "Spring Boot"
        tripInfLayer    = component "Trip Management Infrastructure Layer" "Repositories and database connectors" "Spring Boot"
      }

      tripPostgres = container "Postgres" "Relational database for trip and route data" "RDBMS" {
        tags "Database"
      }
    }

    webApplication     -> tripIntLayer "Consumes REST endpoints"
    mobileApplication  -> tripIntLayer "Consumes REST endpoints"
    tripIntLayer -> tripAppLayer "Invokes commands and queries"
    tripAppLayer -> tripDomainLayer "Applies domain logic"
    tripAppLayer -> tripInfLayer "Uses repositories"
    tripInfLayer -> tripPostgres "Read/write trip and route data"
    
  }

  views {

    component tripContext {
      title "Trip Management Context - Component Diagram"
      description "Internal layered components of the Trip Management Context inside CargaSafe."
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
