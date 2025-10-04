workspace "CargaSafe - Profile and Preferences Management Components" "C4 Component view for the Profile and Preferences Context of CargaSafe" {

  model {

    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring platform" {

      webApplication = container "Web Application" "Angular SPA for CargaSafe UI & dashboards." "Angular" {
        tags "WebApp"
      }

      mobileApplication = container "Mobile Application" "Flutter app for CargaSafe mobile operations." "Flutter" {
        tags "MobileApp"
      }

      profileContext = container "Profile and Preferences Context" "APIs + Workers of the bounded context" "Spring Boot (REST + Jobs)" {

        profileIntLayer    = component "Profile and Preferences Interface Layer" "Controllers (REST): Profile, Preferences" "Spring Boot"
        profileAppLayer    = component "Profile and Preferences Application Layer" "Use case orchestration (Application Service handling commands, queries, events)" "Spring Boot"
        profileDomainLayer = component "Profile and Preferences Domain Layer" "Entities, Value Objects, Aggregates, Factories, Domain Services" "Spring Boot"
        profileInfLayer    = component "Profile and Preferences Infrastructure Layer" "Repositories and database connectors" "Spring Boot"
      }

      profilePostgres = container "Postgres" "Relational database for profile and preferences data" "RDBMS" {
        tags "Database"
      }
    }

    // Relationships
    webApplication     -> profileIntLayer "Consumes REST endpoints"
    mobileApplication  -> profileIntLayer "Consumes REST endpoints"
    profileIntLayer -> profileAppLayer "Invokes application service"
    profileAppLayer -> profileDomainLayer "Applies domain logic"
    profileAppLayer -> profileInfLayer "Uses repositories"
    profileInfLayer -> profilePostgres "Read/write profile and preferences data"
    
  }

  views {

    component profileContext {
      title "Profile and Preferences Context - Component Diagram"
      description "Internal layered components of the Profile and Preferences Context inside CargaSafe."
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
