workspace "CargaSafe - Merchant Components" "C4 Component view for the Merchant Context of CargaSafe" {
  model {
    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring platform" {

      merchantContext = container "Merchant Context" "APIs + Workers of the bounded context" "Spring Boot (REST + Jobs)" {
        merchantIntLayer    = component "Merchant Interface Layer" "Controllers (REST): Merchants, Locations, Contacts, Contracts" "Spring Boot"
        merchantAppLayer    = component "Merchant Application Layer" "Use case orchestration (Command Services, Query Services, Event Services)" "Spring Boot"
        merchantDomainLayer = component "Merchant Domain Layer" "Entities, Value Objects, Aggregates, Factories, Domain Services" "Spring Boot"
        merchantInfLayer    = component "Merchant Infrastructure Layer" "Repositories and database connectors" "Spring Boot"
      }
      merchantPostgres = container "Postgres" "Relational database for merchants, locations, contacts and contracts" "RDBMS" {
        tags "Database"
      }
    }

    merchantIntLayer -> merchantAppLayer "Invokes commands and queries"
    merchantAppLayer -> merchantDomainLayer "Applies domain logic"
    merchantAppLayer -> merchantInfLayer "Uses repositories"
    merchantInfLayer -> merchantPostgres "Read/write merchant-related data"

  }
  views {
    component merchantContext {
      title "Merchant Context - Component Diagram"
      description "Internal layered components of the Merchant Context inside CargaSafe."
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
    }
  }
}
