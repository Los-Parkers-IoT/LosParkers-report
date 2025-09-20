
workspace "CargaSafe - Real-Time Monitoring Components" "C4 Component view for the Real-Time Monitoring Context of CargaSafe" {
  model {
    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring platform" {

      monitoringContext = container "Real-Time Monitoring Context" "APIs + Workers of the bounded context" "Spring Boot (REST + Jobs)" {
        monitoringIntLayer    = component "Real-Time Monitoring Interface Layer" "Controllers (REST): Monitoring, Consumers: Telemetry, TripEvents" "Spring Boot"
        monitoringAppLayer    = component "Real-Time Monitoring Application Layer" "Use case orchestration (Command Services, Query Services, Event Services)" "Spring Boot"
        monitoringDomainLayer = component "Real-Time Monitoring Domain Layer" "Entities, Value Objects, Aggregates, Factories, Domain Services" "Spring Boot"
        monitoringInfLayer    = component "Real-Time Monitoring Infrastructure Layer" "Repositories and database connectors" "Spring Boot"
      }
      monitoringPostgres = container "Postgres" "Relational database for monitoring sessions and telemetry data" "RDBMS" {
        tags "Database"
      }
    }

    monitoringIntLayer -> monitoringAppLayer "Invokes commands and queries"
    monitoringAppLayer -> monitoringDomainLayer "Applies domain logic"
    monitoringAppLayer -> monitoringInfLayer "Uses repositories"
    monitoringInfLayer -> monitoringPostgres "Read/write monitoring and telemetry data"
    
  }
  views {
    component monitoringContext {
      title "Real-Time Monitoring Context - Component Diagram"
      description "Internal layered components of the Real-Time Monitoring Context inside CargaSafe."
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
