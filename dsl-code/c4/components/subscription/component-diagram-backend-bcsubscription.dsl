workspace "CargaSafe - Subscriptions & Billing (Backend Components)" "C4 Component view for the backend of the Subscriptions & Billing BC" {



  model {



    user = person "End User" "CargaSafe User"



    cargaSafe = softwareSystem "CargaSafe" "SaaS logistics monitoring" {



      backend = container "Subscriptions & Billing Backend" "Bounded Context de Suscripciones y Pagos" "Monolith (REST APIs)" {



        interfaceLayer = component "Interface Layer" "Controllers (REST): suscripciones, pagos, planes, compañías" "REST"

        applicationLayer = component "Application Layer" "Orquestación de casos de uso (Command Services, Query Services, Event Handlers)" "App Layer"

        domainLayer = component "Domain Layer" "Entities, Value Objects, Domain Services, Factory" "DDD"

        infrastructureLayer = component "Infrastructure Layer" "Repositorios y conectores a BD/sistemas externos" "Infra Layer"



        # Relaciones internas

        interfaceLayer -> applicationLayer "invoca comandos y queries"

        applicationLayer -> domainLayer "aplica reglas de negocio"

        applicationLayer -> infrastructureLayer "usa repositorios"



      }



      # Base de datos interna

      Postgres = container "Postgres" "Persistencia transaccional (suscripciones, pagos, compañías)" "RDBMS" {

        tags "Database"

      }

    }



    # Sistemas externos

    stripe   = softwareSystem "Stripe" "Pasarela de pagos"

    fcm      = softwareSystem "Firebase Cloud Messaging" "Notificaciones push"

    gmaps    = softwareSystem "Google Maps" "Rutas y geocodificación"



    # Relaciones externas desde infraestructura

    infrastructureLayer -> Postgres "SQL (read/write)"

    infrastructureLayer -> stripe "HTTPS (cobros, reembolsos)"

    infrastructureLayer -> fcm "HTTPS (alertas push)"

    infrastructureLayer -> gmaps "HTTPS (consultas de rutas/ETA)"

  }



  views {

    component backend {

      title "Subscriptions & Billing Backend - Component Diagram"

      description "Componentes internos del backend organizados en capas DDD."

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

      element "Person" {

        background "#084C61"

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