<div style="text-align: center">
  <p align="center">
    <br />
    <img
      src="https://www.upc.edu.pe/static/img/logo_upc_red.png"
      width="100px"
    />
    <br />
    <strong>Universidad Peruana de Ciencias Aplicadas</strong>
    <br /><br />
    <strong>Carrera de ingeniería de Software</strong>
    <br /><br />
    <strong>Ciclo 202520</strong>
    <br /><br />
    1ASI0572 - Desarrollo de Soluciones IOT
    <br /><br />
    <strong>NRC:</strong> 3443 <br /><br />
    <strong>Profesor:</strong> Velásquez Núñez, Angel Augusto <br /><br />
    <strong>Informe de Trabajo Final</strong>
  </p>

  <div style="width: 80%; margin: 0 auto; text-align: center">
    <p>
      <strong>Startup:</strong> Los Parkers 
      <br />
      <strong>Producto:</strong> Macetech
    </p>

  <div>
      <strong>Relación de integrantes</strong>
      <br /><br />
      <table style="width: 60%; margin: 0 auto;   text-align: left">
        <thead>
          <tr>
            <th>Código</th>
            <th>Nombre</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>u20201c410</td>
            <td>Garro Vega, Marcelo Fabian</td>
          </tr>
          <tr>
            <td>u202113324</td>
            <td>Sanchez Ignacio, Jefrey Martin</td>
          </tr>
          <tr>
            <td>u...</td>
            <td>Apellidos, Nombres</td>
          </tr>
        </tbody>
      </table>
      <p style="text-align: center">
        <br />
        <strong>Agosto 2025</strong>
      </p>
    </div>

  </div>
</div>

---

# Capítulo I: Introducción

## 1.1. Startup Profile

### 1.1.1. Descripción de la Startup

### 1.1.2. Perfiles de integrantes del equipo

## 1.2. Solution Profile

### 1.2.1. Antecedentes y problemática

### 1.2.2. Lean UX Process

#### 1.2.2.1. Lean UX Problem Statements

#### 1.2.2.2. Lean UX Assumptions

#### 1.2.2.3. Lean UX Hypothesis Statements

#### 1.2.2.4. Lean UX Canvas

## 1.3. Segmentos objetivo

# Capítulo II: Requirements Elicitation & Analysis

## 2.1. Competidores

### 2.1.1. Análisis competitivo

### 2.1.2. Estrategias y tácticas frente a competidores

## 2.2. Entrevistas

### 2.2.1. Diseño de entrevistas

### 2.2.2. Registro de entrevistas

### 2.2.3. Análisis de entrevistas

## 2.3. Needfinding

### 2.3.1. User Personas

### 2.3.2. User Task Matrix

### 2.3.3. User Journey Mapping

### 2.3.4. Empathy Mapping

## 2.4. Big Picture EventStorming

## 2.5. Ubiquitous Language

# Capítulo III: Requirements Specification

## 3.1. User Stories

## 3.2. Impact Mapping

## 3.3. Product Backlog

# Capítulo IV: Solution Software Design

## 4.1. Strategic-Level Domain-Driven Design

### 4.1.1. Design-Level EventStorming

## 4.1.1.1 Candidate Context Discovery

Para esta etapa se llevó a cabo una sesión, la sesión tuvo una duración aproximada de 90 minutos y permitió identificar los bounded contexts del sistema CargaSafe. Durante el proceso se aplicaron las técnicas start-with-value, start-with-simple y look-for-pivotal-events, que facilitaron la agrupación de eventos y entidades según su afinidad y valor para el negocio.

Como resultado, se identificaron ocho bounded contexts:

- **Identity and Access Management**: administración de usuarios, autenticación y control de accesos.
- **Profiles and Preferences Management**: gestión de perfiles de usuario y configuración de preferencias.
- **Fleet management**: gestión de vehículos y dispositivos IoT.
- **Execution of the trip**: creación y ejecución de viajes.
- **Real-time monitoring**: monitoreo de condiciones en tiempo real.
- **Alerts and resolution**: generación de alertas.
- **Visualization/Analytics**: visualización de métricas y reportes.
- **Subscriptions and payments**: gestión de suscripciones y pagos con Stripe.

![EventStorming – Candidate Context Discovery](assets/Candidate_Context_Discovery_Image.png)

### Leyenda utilizada en el EventStorming

- 🟧 **Event**: describe algo que ocurrió en el dominio (Viaje iniciado, Alerta generada).
- 🟦 **Command**: una instrucción o acción que dispara un evento (Registrar viaje).
- 🟪 **Policy**: regla de negocio que determina qué ocurre ante ciertas condiciones (Si falta dispositivo → bloquear inicio del viaje).
- 🟨 **Aggregate**: entidad principal que concentra datos y operaciones (Viaje, Suscripción).
- 🟩 **UI**: vistas o pantallas del sistema que muestran información al usuario (Dashboard de KPIs).
- ⚪ **Actor**: roles que interactúan con el sistema (Operador, Conductor).
- ⬛ **Sistema externo**: integraciones con servicios de terceros (Google Maps, Stripe).

Con esta estructura, el EventStorming permitió organizar y simplificar el dominio de CargaSafe, evidenciando de forma clara los contextos candidatos y la interacción entre actores, procesos y sistemas externos.

[Ver gráfico en Miro](https://miro.com/app/board/uXjVJMskjeA=/?share_link_id=697373503273)

#### 4.1.1.2. Domain Message Flows Modeling

En esta etapa se desarrolló el **modelado de flujos de mensajes de dominio (Domain Message Flows)** con el objetivo de visualizar cómo colaboran los bounded contexts identificados en el Candidate Context Discovery para resolver los principales casos de negocio del sistema CargaSafe.

Para la construcción de estos flujos se aplicó la técnica de **Domain Storytelling**, la cual permite describir las interacciones en un lenguaje natural, mostrando cómo un evento generado en un bounded context desencadena comandos o nuevos eventos en otros contextos. De este modo se logra una visión clara de la cooperación entre módulos y del ciclo de vida de la información dentro de la plataforma.

### Historias de dominio (Domain Stories)

1. **Gestión de identidad y perfiles**

   - Cuando un _usuario se registra_ en **Identity and Access Management**, se genera un evento que es consumido por **Profiles and Preferences**, el cual crea automáticamente el perfil asociado.
   - Si un _usuario edita sus preferencias_, se guarda la configuración en **Profiles**, y en caso de referirse a notificaciones, estas se utilizan en **Alerts** para personalizar los canales de envío.

2. **Control de acceso y suscripciones**

   - Cuando un _pago es procesado exitosamente_ en **Subscriptions & Billing**, se envía un evento a **Identity and Access Management**, que habilita el acceso al sistema.
   - Si un _pago falla_, el mismo flujo comunica a IAM que debe restringir o bloquear el acceso del usuario hasta regularizar su situación.

3. **Gestión de flota y ejecución de viajes**

   - Al _registrarse un vehículo o dispositivo IoT_ en **Fleet Management**, este queda disponible para **Trip Management**, que puede asignarlo a un viaje planificado.
   - Cuando un _operador crea e inicia un viaje_ en **Trip Management**, se emite un evento que da origen a una sesión de monitoreo en **Monitoring**.

4. **Monitoreo en tiempo real y alertas**

   - **Monitoring** recibe continuamente _lecturas de sensores_ (temperatura, ubicación, señal). Si se detecta una condición fuera de rango, se genera un evento que es consumido por **Alerts**.
   - **Alerts** crea la alerta correspondiente y la notifica a los usuarios, aplicando las preferencias definidas en **Profiles** (por ejemplo, envío por SMS, correo o notificación push).

5. **Analítica y reportes**
   - Cada _alerta generada o reconocida_ en **Alerts** actualiza los indicadores en **Dashboard & Analytics**, alimentando las métricas de cumplimiento y los reportes de incidentes.
   - Cuando **Dashboard & Analytics** genera un _reporte final_, este puede personalizarse de acuerdo con las preferencias almacenadas en **Profiles**, permitiendo al usuario recibir información ajustada a su rol o necesidades.

![EventStorming – Domain Message Flows Modeling](assets/Domain_Message_Flows_Modeling.png)

### Resultados

Los flujos de mensajes de dominio evidencian la cooperación entre los ocho bounded contexts de CargaSafe:

- **Identity and Access Management**
- **Profiles and Preferences Management**
- **Fleet Management**
- **Execution of the trip**
- **Real-time monitoring**
- **Alerts and resolution**
- **Visualization/Analytics**
- **Subscriptions and payments**

Este ejercicio permitió comprender cómo un evento local en un contexto puede impactar en otros, asegurando la trazabilidad del negocio y la correcta interacción entre los distintos módulos de la solución.

#### 4.1.1.3. Bounded Context Canvases

En esta sección se elaboraron los Bounded Context Canvases de CargaSafe para los ocho contextos identificados. El objetivo fue delimitar con precisión responsabilidades, lenguaje ubicuo y decisiones de negocio, además de explicitar las comunicaciones (Queries, Commands y Events) y colaboradores (otros BC, sistemas externos y frontend). Cada canvas documenta: Descripción, Clasificación estratégica (core/supporting/generic), Rol de dominio (draft/execution/analysis/gateway), Inbound/Outbound communication, Ubiquitous Language, Business Decisions y Collaborators. Esta definición fija ownership de datos, reduce ambigüedades y prepara los contratos de integración que se implementarán en APIs y mensajería.

![EventStorming – Bounded Context Canvases](assets/Canvases_iam.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_profiles.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_subscriptions.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_alerts.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_fleet.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_tripManagement.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_realtimeMonitoring.png)

![EventStorming – Bounded Context Canvases](assets/Canvases_analytics.png)

[Ver gráfico en Miro](https://miro.com/app/board/uXjVJJ2PHqk=/?share_link_id=762570504671)

### 4.1.2. Context Mapping

En esta etapa se construyó el **Context Map** de CargaSafe con los ocho bounded contexts identificados. El objetivo fue representar las **relaciones estructurales** entre ellos aplicando patrones de Domain-Driven Design como Customer/Supplier, Conformist y Anti-Corruption Layer (ACL).

### Resultado

El mapa final permitió:

1. **Visualizar las dependencias entre contextos**, mostrando qué módulos proveen información y cuáles la consumen.
2. **Identificar los contextos core** (Trip Management, Monitoring, Alerts), los de soporte (Fleet, Profiles, Analytics) y los genéricos (IAM, Billing).
3. **Clasificar las relaciones**:
   - Customer/Supplier en la mayoría de flujos operativos (Billing → IAM, Trip → Monitoring, Monitoring → Alerts).
   - Conformist en el consumo de datos por Analytics.
   - Anti-Corruption Layer en la interacción Analytics → Profiles.

De esta manera, el Context Mapping consolida una visión global del sistema, mostrando cómo los distintos contextos colaboran para dar soporte al negocio.

![EventStorming – Context Mapping](assets/Context_Mapping.png)

### 4.1.3. Software Architecture

#### 4.1.3.1. Software Architecture System Landscape Diagram

El **System Landscape Diagram** ofrece una visión de alto nivel del **ecosistema empresarial** en el que se integra CargaSafe. Este diagrama no se centra únicamente en un sistema, sino que representa **todas las personas y sistemas de software relevantes**, tanto internos como externos, que participan en la operación logística.

### Propósito

El objetivo de este diagrama es:

1. Mostrar el alcance de la organización y cómo conviven sus distintos sistemas.
2. Identificar a las **personas, sistemas internos, SaaS externos y proveedores** que colaboran en la cadena de valor.
3. Resaltar cómo **CargaSafe (SaaS)** se conecta dentro de este panorama, en interacción con otros actores y servicios.

![Software Architecture – System Landscape Diagram](assets/System_Landscape_Diagram.png)

### Elementos incluidos

- **Personas**: Company Operator, Driver and End Customer.
- **Sistemas internos**: Logistics Planning and Power BI Data.
- **Sistemas y proveedores externos**: CargaSafe (SaaS), Stripe, Google Maps, Notification Services e IoT Devices (sensors).
- **Grupos**: Se organizaron en cuatro dominios principales:
  - Logistics company
  - Field / Devices
  - Customers and Regulators
  - SaaS and Vendors

### Relaciones principales

- Logistics Planning → CargaSafe (SaaS): exporta planes y asignaciones de viaje.
- IoT Devices → CargaSafe (SaaS): envía telemetría (temperatura, humedad, vibración, volcado/inclinación, GPS, energía/baterías).
- CargaSafe (SaaS) → Google Maps: consulta rutas y tiempos estimados.
- CargaSafe (SaaS) → Notification Services: envía alertas a los usuarios.
- CargaSafe (SaaS) → Stripe: procesa pagos de suscripción.
- CargaSafe (SaaS) → Power BI Data: exporta datasets consolidados para analítica.
- Company Operator / Driver ↔ CargaSafe (SaaS): planifican, ejecutan y reportan el estado operativo.
- End customer ← CargaSafe (SaaS): consulta estado y recibe reportes.

### Resultado

El diagrama muestra a CargaSafe (SaaS) como el núcleo de integración entre operaciones (Company Operator, Driver, Logistics Planning), telemetría IoT (sensores en campo) y servicios externos (ruteo, notificaciones y pagos), además de su aporte a la inteligencia de negocio mediante Power BI Data. Esta representación proporciona una visión clara e integral de las dependencias y colaboraciones que sustentan la operación logística y la gestión de la cadena de frío.

#### 4.1.3.2. Software Architecture Context Level Diagrams

El **Context Diagram** de CargaSafe muestra una visión de alto nivel del sistema y de cómo se relaciona con los actores humanos y los sistemas externos que lo rodean.

![Software Architecture – Context Level Diagram](assets/Context_Level_Diagram.png)

En el centro se ubica CargaSafe (SaaS), que representa el sistema principal encargado del monitoreo de la cadena de frío, la trazabilidad y la generación de alertas en los viajes logísticos.

Alrededor del sistema se identifican los siguientes actores:

- _Company Operator_: gestiona viajes, flota y reportes desde la plataforma.
- _Driver_: completa viajes y reporta información desde la aplicación móvil.
- _End customer_: recibe enlaces de estado, alertas y reportes generados por el sistema.

Asimismo, se destacan las interacciones con sistemas externos que complementan las funcionalidades de CargaSafe:

- Google Maps: provee rutas, geocodificación y cálculo de ETA.
- Firebase Cloud Messaging: entrega notificaciones push.
  Stripe: procesa pagos y facturación de suscripciones.
  Este diagrama permite visualizar de manera clara las responsabilidades de cada actor y sistema, y cómo CargaSafe se convierte en el núcleo que articula la comunicación entre usuarios, dispositivos IoT y servicios externos, garantizando la operación eficiente y segura de la cadena logística.

#### 4.1.3.2. Software Architecture Container Level Diagrams

En esta parte expandimos el sistema **CargaSafe (SaaS)** para mostrar sus contenedores internos, las tecnologías que utilizamos y cómo se comunican entre sí y con los sistemas externos.

![Software Architecture – Container Level Diagram](assets/Container_Level_Diagram.png)

El diagrama de contenedores muestra cómo se organiza internamente CargaSafe (SaaS) y cómo se relaciona con los actores y sistemas externos.

Dentro de la plataforma tenemos varios contenedores:

- _Landing Page:_ sitio público que sirve para marketing y como punto de acceso, redirigiendo tanto a la Web App, al Single Web como a la Mobile App (descarga o deeplinks).
- _Web Frontend:_ aplicación usada por los operadores para gestionar viajes, flota y reportes.
- _Single Web:_ vista pública en línea donde los clientes finales pueden consultar estados y reportes sin necesidad de autenticarse.
- _Mobile App:_ aplicación móvil para los conductores, con soporte offline-first. Se conecta a su propia base de datos embebida SQLite para cache y operación sin conexión.
- _Backend API:_ núcleo de la lógica de negocio, responsable de gestionar viajes, monitoreo, alertas y suscripciones.
- _Relational Database (PostgreSQL):_ base de datos principal donde se almacenan usuarios, vehículos, dispositivos, viajes, telemetría, alertas y suscripciones.
- _Edge Application (Python):_ agente que corre en instalaciones o vehículos, con capacidad de procesamiento local, cache y sincronización confiable con el backend. Usa su propia Edge Database local para tolerar desconexiones.
- _Embedded Application (C++):_ componente ligero que corre en dispositivos restringidos, captura datos y los envía hacia la aplicación edge para su posterior sincronización.

Los actores principales interactúan con los contenedores:

- Company Operator usa la Web App para planificar y supervisar operaciones.
- Driver utiliza la Mobile App para recibir instrucciones y reportar estado de los viajes.
- End Customer accede tanto a la Single Web (para reportes públicos) como a la Mobile App (para recibir notificaciones y links de estado).

Además, CargaSafe se integra con varios sistemas externos:

- _Google Maps_: para rutas, geocodificación y cálculo de ETA.
- _Stripe_: para pagos y facturación de suscripciones.
- _Firebase Cloud Messaging (FCM)_: para notificaciones push hacia aplicaciones móviles y web.
  En conjunto, el diagrama muestra cómo CargaSafe se estructura en contenedores especializados que soportan las necesidades de operadores, conductores y clientes, asegurando tanto la operación online como offline en distintos puntos de la cadena logística.

#### 4.1.3.3. Software Architecture Deployment Diagrams

El Deployment Diagram de CargaSafe muestra cómo se despliega la solución en un entorno de producción real, representando los nodos de infraestructura, los contenedores de software y las interacciones entre ellos.

![Software Architecture – Deployment Diagram](assets/Deployment_Diagram.png)

**Clientes:**

- Los usuarios finales acceden desde navegadores web, donde la Landing Page y el Web Frontend se sirven por separado desde CDNs independientes (CloudFlare/AWS CloudFront) para optimizar la entrega de contenido.
- Los conductores utilizan una aplicación móvil Flutter en dispositivos Android/iOS, que incluye una base de datos SQLite local para almacenamiento offline y sincronización de datos.
- Todas las peticiones de API se realizan mediante HTTPS y son redirigidas hacia el Load Balancer, encargado de enrutar el tráfico hacia los servicios backend.

**Backend y orquestación**

- El Backend API (Spring Boot) se despliega dentro de un Kubernetes Cluster en múltiples pods de aplicaciones para alta disponibilidad y escalabilidad.
- El backend centraliza la lógica de negocio, gestiona operaciones de viajes, monitoreo de cadena de frío y orquestación de alertas en tiempo real.

**Base de datos**

- El sistema utiliza una base de datos PostgreSQL gestionada (AWS RDS/Google Cloud SQL), con una instancia primaria para operaciones de escritura y réplicas de solo lectura para consultas distribuidas y balanceo de carga.
- Los dispositivos móviles mantienen datos críticos localmente en SQLite para funcionamiento offline durante los viajes.

**Integraciones externas**
El backend consume servicios de terceros para extender sus capacidades:

- Google Maps para rutas, geocodificación y cálculo de ETA en tiempo real.
- Stripe para procesamiento de pagos y facturación de subscripciones.
- Firebase Cloud Messaging (FCM) para la entrega de notificaciones push directamente a los dispositivos móviles de los conductores.

**Resultado**
El diagrama de despliegue muestra que la solución CargaSafe está organizada bajo una arquitectura cloud-native optimizada, con:

- Separación de responsabilidades: Landing page y aplicación web servidas independientemente
- Capacidades offline: Base de datos local SQLite en dispositivos móviles
- Kubernetes para la orquestación de contenedores del backend
- CDNs separados para optimizar la entrega de contenido estático
- Base de datos gestionada con réplicas para mejorar el rendimiento y disponibilidad
- Notificaciones push nativas a través de FCM

Esta infraestructura permite un sistema escalable, resiliente y con capacidades offline críticas para la operación de conductores en campo, garantizando la continuidad operativa en la gestión de la cadena de frío incluso sin conectividad permanente.

## 4.2. Tactical-Level Domain-Driven Design

### 4.2.1. Bounded Context: `<Bounded Context Name>`

#### 4.2.1.1. Domain Layer

Responsabilidad: Ingestar y evaluar telemetría (temperatura/GPS/humedad) contra políticas de cadena de frío, generando eventos de dominio para Alertas y resolución y alimentando Visualización/Analytics.

**Agregados y Entidades**

- Sensor (AR): identidad del dispositivo y estado operativo (online/offline, última calibración).

- SensorTripBinding: historial de asociación sensor↔viaje (permite auditoría y replay).

- TelemetryReading: lectura puntual (time-series); modelada como entidad inmutable.

- DeviceStatus: snapshot operativo (batería, señal, último heartbeat).

**Value Objects**

- TemperatureCelsius
- GeoPoint
- Thresholds (min/max/hysteresis)
- TimeWindow

**Servicios de Dominio**

- EvaluationService: reglas de evaluación (ventanas, anti-ruido, histeresis) → emite eventos.

- BindingService: lógica para bind/unbind de sensores a viajes.

**Eventos de Dominio**

- TelemetryReceived
- TemperatureOutOfRange
- DeviceOffline
- GeofenceBreach
- TimeseriesUpdated (para vistas)

**Repositorios**

- TelemetryRepository
- DeviceStatusRepository
- SensorBindingRepository
- SensorRepository

**Políticas/Reglas Clave**

- Frecuencia mínima de muestreo por plan
- Tolerancias por producto
- Ventana de evaluación deslizante
- Reconciliación de lecturas offline.

**Diagrama de clases (dominio)**

#### 4.2.1.2. Interface Layer

**Entradas (adapters)**

- **HTTP Ingestion API:** POST /ingest/telemetry (API-Key/JWT por tenant).

- **MQTT**: tópico devices/{sensorId}/telemetry para ingesta directa desde edge.

- **Queries**:
  - GET /live-status?sensorId=
  - GET /telemetry?tripId=&from=&to= (paginado por tiempo).

**Salidas (pub/sub y notificaciones)**

- **Events a Alertas y resolución:**

  - TemperatureOutOfRange
  - DeviceOffline
  - GeofenceBreach

- **Events a Visualización/Analytics:**
  - TimeseriesUpdated

**DTOs principales**

- TelemetryInDTO{ sensorId, ts, tempC, humidityPct, lat, lon, raw }
- LiveStatusDTO{ sensorId, lastSeen, batteryPct, signalDbm, tripId }

#### 4.2.1.3. Application Layer

**Command Handlers**

- IngestTelemetryCommandHandler: Valida TelemetryInDTO, persiste lectura (y outbox), emite TelemetryReceived.

- BindSensorToTripCommandHandler: Gestiona historia de bind/unbind y emite SensorBoundToTrip.

- EvaluateTelemetryCommandHandler: Usa EvaluationService (ventana + histéresis) y publica TemperatureOutOfRange | DeviceOffline | GeofenceBreach.

- UpdateDeviceStatusCommandHandler: Actualiza snapshot y cache en vivo.

**Event Handlers**

- TripStartedEventHandler: Precarga políticas/umbrales activos para la sesión del viaje.

- TelemetryReceivedEventHandler: Encadena evaluación y proyección a timeseries para vistas.

- PolicyUpdatedEventHandler: Refresca umbrales en memoria / caché.

**Application Services (capabilities)**

- LiveViewService — GetLiveStatus(sensorId) y cola corta de lecturas recientes.

- TimeseriesQueryService: Consulta paginada por rango {from,to}.

- AnomalyDetectionService: Hook para modelos (opt-in según plan).

**Transaccionalidad & resiliencia**

- Outbox + publicador para garantizar at-least-once de eventos.

- Idempotencia por (sensorId, ts).

- Sagas livianas para bind/unbind.

**Secuencia**

![Bounded Context Domain Layer – Class Diagram](assets/Sequence_Diagram.png)

[Ver gráfico en Mermaid](https://www.mermaidchart.com/app/projects/f9114f89-7e7c-4378-9a7e-53fc0436e622/diagrams/b984e287-826d-49b5-9eae-3e6cee59ba42/version/v0.1/edit)

#### 4.2.1.4. Infrastructure Layer

**Adapters / Implementaciones**

- HttpIngestionController (REST)

- MqttIngestionConsumer (tópico devices/{sensorId}/telemetry)

- KafkaEventBus (tópicos: monitoring.alerts, monitoring.viz)

- PostgresTelemetryRepository (TimescaleDB)

- PostgresDeviceStatusRepository

- PostgresSensorBindingRepository

- RedisLiveCache (clave live:{sensorId} TTL corto)

- OutboxPublisher (lee event_outbox y publica a Kafka)

**Cross-cutting**

- RLS/tenancy por tenant_id, observabilidad (metrics/logs/traces). rate-limit, validación de payloads, DLQ.

#### 4.2.1.5. Bounded Context Software Architecture Component Level Diagrams

[Ver gráfico en Mermaid](https://www.mermaidchart.com/app/projects/f9114f89-7e7c-4378-9a7e-53fc0436e622/diagrams/2b56cea5-6f35-4228-b70e-2052df1785b7/version/v0.1/edit)

#### 4.2.1.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.1.6.1. Bounded Context Domain Layer Class Diagrams

![Bounded Context Domain Layer – Class Diagram](assets/Class_Diagram.png)

[Ver gráfico en Mermaid](https://www.mermaidchart.com/app/projects/f9114f89-7e7c-4378-9a7e-53fc0436e622/diagrams/da4a4688-bf70-4195-b82c-b3aee7598cde/version/v0.1/edit)

##### 4.2.1.6.2. Bounded Context Database Design Diagram

4.2.2. Bounded Context: _Subscriptions and Billing_

4.2.2.1. Domain Layer

*Entities*

**Subscription**

- **Propósito**: Gestionar el ciclo de vida de la suscripción de una empresa.
- **Atributos principales**: subscriptionId, companyId, plan, billingCycle, status (ACTIVE, CANCELED), startedAt, expiresAt.
- **Métodos principales**: activate(), changePlan(newPlan), renew(), cancel().

**Payment**

- **Propósito**: Representar pagos asociados a una suscripción.
- **Atributos principales**: paymentId, subscriptionId, amount, status (PENDING, SUCCEEDED, FAILED), date.
- **Métodos principales**: markSucceeded(), markFailed().

**Company**

- **Propósito**: Entidad que consume el servicio y depende de su suscripción activa.
- **Atributos principales**: companyId, name, vehicleCount.
- **Métodos principales**: canFitPlan(plan).

**Value Objects**

- **Plan**: Define límites y beneficios (code, vehicleLimit, price).
- **BillingCycle**: Periodo de facturación (type, startDate, endDate).
- **GracePeriod**: Tolerancia tras vencimiento (days).

**Domain Services**

- **BillingService**: Calcula montos y renovaciones.
- **PaymentPolicy**: Aplica reglas de activación y cancelación según pagos.

**Factory**

- **SubscriptionFactory**: Crea una suscripción válida con plan y ciclo inicial.

**Commands**

- **CreateSubscriptionCommand**: Crea una nueva suscripción.
- **ChangePlanCommand**: Cambia de plan.
- **CancelSubscriptionCommand**: Cancela una suscripción.
- **RenewSubscriptionCommand**: Renueva periodo.
- **RecordPaymentCommand**: Registra un pago.

**Queries**

**GetSubscriptionByIdQuery**: Consulta suscripción por ID.
**GetActiveSubscriptionByCompanyQuery**: Consulta suscripción activa de una compañía.
**ListPaymentsBySubscriptionQuery**: Lista pagos de una suscripción.

**Events**

**SubscriptionCreated**: Suscripción creada.
**PlanChanged**: Cambio de plan.
**SubscriptionRenewed**: Renovación realizada.
**SubscriptionCanceled**: Suscripción cancelada.
**PaymentSucceeded / PaymentFailed**: Resultado de pago.

4.2.2.2. Interface Layer

**Controllers**

- **SubscriptionController**: Endpoints para crear, renovar, cambiar plan y cancelar suscripciones.
- **PaymentController**: Endpoints para registrar y consultar pagos.
- **PlanController**: Endpoints para listar planes disponibles.
- **CompanyAccessController**: Endpoints para consultar estado de acceso de una empresa.

4.2.2.3. Application Layer

**Command Services**

- **SubscriptionCommandService**: Ejecuta comandos de suscripción (crear, cambiar, renovar, cancelar).
- **PaymentCommandService**: Registra pagos y actualiza estado de suscripción.

**Query Services**

**SubscriptionQueryService**: Consulta suscripciones por id, estado o compañía.
**PaymentQueryService**: Consulta pagos por suscripción o estado.

**Event Handlers**
- **SubscriptionEventHandler**: Reacciona a eventos de suscripción (creada, renovada, cancelada, cambio de plan).
- **PaymentEventHandler**: Reacciona a pagos exitosos o fallidos.

4.2.2.4. Infrastructure Layer

**Repositories (Interfaces)**

- **ISubscriptionRepository**: Acceso a datos de suscripciones.
- **IPaymentRepository**: Acceso a datos de pagos.
- **ICompanyRepository**: Acceso a datos de compañías.

#### 4.2.2.5. Bounded Context Software Architecture Component Level Diagrams

_Diagrama de componentes - Backend - Subscriptions and Billing_

![Component diagrams](assets/Component_diagram_backend.png)

El backend del bounded context de Suscripciones y Pagos está organizado en cuatro capas principales:

- **Interface Layer**: expone los controladores REST que atienden operaciones de suscripciones, pagos, planes y compañías. Es la puerta de entrada para los usuarios y sistemas que consumen la API.
- **Application Layer**: orquesta los casos de uso mediante Command Services, Query Services y Event Handlers. Aquí se coordinan las operaciones y se invocan las reglas de negocio.
- **Domain Layer**: concentra la lógica de negocio del contexto, con entidades, objetos de valor, servicios de dominio y fábricas. Define las reglas que rigen el ciclo de vida de suscripciones y pagos.
- **Infrastructure Layer**: implementa repositorios y conectores hacia la base de datos y sistemas externos. Se encarga de la persistencia y de la integración técnica.

Las conexiones externas son:
- Postgres para persistencia transaccional (suscripciones, pagos, compañías).
- Stripe para procesamiento de pagos.
- Firebase Cloud Messaging (FCM) para envío de notificaciones push.
- Google Maps para consultas de rutas y tiempos estimados (ETA).

_Diagrama de componentes - Application Web - Subscriptions and Billing_

![Component diagrams](assets/Component_diagram_applicationweb.png)

La aplicación web se conecta al bounded context **Subscriptions & Billing** únicamente a través de las APIs: la _Subscriptions API_ (para enviar comandos como crear o cancelar una suscripción) y la _Query API_ (para consultar datos como facturas o planes activos).

En el lado del cliente, la app se organiza en tres partes:
• **UI (interfaz de usuario)**: pantallas de suscripciones, facturación y pagos.
• **Estado de aplicación:** maneja la sesión del usuario, el cache de consultas y el control de autenticación.
• **Servicios de datos:** cliente HTTP que llama a las APIs, agrega el token de seguridad y gestiona reintentos o errores.

La aplicación web no implementa lógica de negocio propia, solo muestra la información y envía las intenciones del usuario al backend. Todo lo que es reglas, validaciones o persistencia está en el backend.

_Diagrama de componentes - Mobile Application - Subscriptions and Billing_

![Component diagrams](assets/Component_diagram_mobile.png)

La aplicación móvil de **Subscriptions & Billing** es muy parecido a la versión web, ya que también se conecta al backend por la _Subscriptions API_ y la _Query API_. La diferencia es que en el móvil contamos con una base de datos local (SQLite), que nos permite trabajar en modo offline: la app guarda datos y puede seguir operando aunque no haya conexión, y luego sincroniza cuando vuelve el internet.

La app se organiza en pantallas de suscripciones y facturación, un estado de aplicación que maneja la sesión y el cache, y un API Client que envía las solicitudes al backend siempre agregando el token de autenticación. Toda la lógica de negocio sigue estando en el backend; en el cliente solo mostramos información y enviamos las acciones que hace el usuario.

#### 4.2.2.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.2.6.1. Bounded Context Domain Layer Class Diagrams

![layer diagrams](assets/layer_class_diagram.png)

##### Explicación del diagrama

El diagrama de clases del Domain Layer muestra a **Subscription** como _Aggregate Root_, con su ciclo de vida gestionado a través de estados (**SubscriptionStatus**) y la relación con múltiples Payment, cada uno asociado a su propio estado (**PaymentStatus**). Los Value Objects Plan y Money encapsulan reglas de negocio como límites de vehículos y montos monetarios. Asimismo, el modelo se apoya en la _SubscriptionFactory_ para la creación controlada de agregados, en los _Repositories_ para la persistencia de entidades y en el \*_PaymentProcessingService_ para la integración con Stripe y la gestión de pagos. En conjunto, este diseño asegura encapsulamiento, consistencia e independencia tecnológica en el dominio.

##### 4.2.2.6.2. Bounded Context Database Design Diagram

![layer diagrams](assets/layer_database_diagram.png)

##### Explicación del diagrama

Define la persistencia mínima y suficiente para gestionar compañías, suscripciones y pagos integrados con Stripe. La tabla companies centraliza la información de cada cliente.
Sobre ella, la tabla _subscriptions_ modela el ciclo de vida de la suscripción, incluyendo plan, estado y próxima renovación, con la restricción de que solo puede existir una suscripción activa por compañía.
La tabla _payments_ registra cada intento de cobro asociado a una suscripción, asegurando unicidad mediante el identificador del proveedor (provider_ref).
Finalmente, la tabla **stripe_webhook_events** almacena los eventos recibidos desde Stripe y se vincula con los pagos para garantizar trazabilidad e idempotencia en el procesamiento de transacciones.

### 4.2.3. Bounded Context: _Alerts & Resolution_

#### 4.2.3.1. Domain Layer

### Entidades (Entities)

**Entity: Alert (Aggregate Root)**  
**Propósito principal**  
Centralizar la gestión del ciclo de vida de una alerta y garantizar que se cumplan las reglas de negocio.  
**Atributos principales**  
- alertId: Identificador único de la alerta.  
- type: Tipo de alerta (OutOfRange, Offline, RouteDeviation).  
- status: Estado actual de la alerta (OPEN, ACKNOWLEDGED, CLOSED).  
- sensorType: Tipo de sensor que la generó (TEMPERATURE, HUMIDITY, VIBRATION, TILT, LOCATION, BATTERY).  
- createdAt: Fecha y hora de creación de la alerta.  
- acknowledgedAt: Momento en que fue reconocida.  
- closedAt: Momento en que fue cerrada.  
**Métodos principales**  
- acknowledge(): Marca la alerta como reconocida.  
- close(): Cierra la alerta si ya fue reconocida.  
- escalate(): Incrementa la criticidad si no fue atendida a tiempo.  


**Entity: Notification**  
**Propósito principal**  
Representar un mensaje enviado a un usuario sobre una alerta.  
**Atributos principales**  
- notificationId: Identificador único de la notificación.  
- alertId: Referencia a la alerta asociada.  
- channel: Canal de comunicación (EMAIL, SMS, FCM).  
- message: Contenido del mensaje.  
- sentAt: Fecha y hora de envío.  
**Métodos principales**  
- markAsSent(): Actualiza el estado de la notificación como enviada.  

**Entity: Incident**  
**Propósito principal**  
Registrar un evento relacionado con un viaje que se crea a partir de una alerta.  
**Atributos principales**  
- incidentId: Identificador único del incidente.  
- alertId: Referencia a la alerta origen.  
- tripId: Identificador del viaje asociado.  
- description: Detalle del incidente.  
- createdAt: Fecha y hora de creación.  
**Métodos principales**  
- resolve(description): Marca el incidente como resuelto con detalles.  

### Objetos de Valor (Value Objects)

- AlertType: clasifica los tipos de alertas (OutOfRange, Offline, RouteDeviation).
- AlertStatus: define en qué etapa se encuentra la alerta (Open, Acknowledged, Closed).
- NotificationChannel: indica el medio de comunicación usado (Email, SMS, FCM).
- PersistenceWindow: define el tiempo mínimo que debe cumplirse para que un evento se considere válido como alerta.
- SensorType: clasifica la fuente de monitoreo (TEMPERATURE, HUMIDITY, VIBRATION, TILT, LOCATION, BATTERY).

#### Commands

**Command: CreateAlertCommand**  
**Parámetros**  
- type, sensorType, createdAt.  
**Cómo funciona**  
Se ejecuta al detectar un evento anómalo. Crea una nueva alerta validando reglas como la ventana de persistencia y evitando duplicación.  

**Command: AcknowledgeAlertCommand**  
**Parámetros**  
- alertId.  
**Cómo funciona**  
Permite a un operador reconocer la alerta. Cambia su estado a *ACKNOWLEDGED* y registra la hora.  

**Command: CloseAlertCommand**  
**Parámetros**  
- alertId.  
**Cómo funciona**  
Cierra una alerta reconocida, cambiando su estado a *CLOSED* y registrando la fecha de cierre.  

**Command: EscalateAlertCommand**  
**Parámetros**  
- alertId.  
**Cómo funciona**  
Incrementa la criticidad de una alerta que lleva demasiado tiempo sin ser reconocida, generando un evento de escalamiento.  

**Command: CreateIncidentFromAlertCommand**  
**Parámetros**  
- alertId, tripId, description.  
**Cómo funciona**  
Crea un incidente asociado a un viaje a partir de una alerta específica, permitiendo registrar el detalle del evento.  

**Command: SendNotificationCommand**  
**Parámetros**  
- alertId, channel, message.  
**Cómo funciona**  
Ordena enviar una notificación al canal definido (Email, SMS, FCM) para informar al usuario o empresa sobre la alerta.  

#### Queries

**Query: GetAlertByIdQuery**  
**Parámetros**  
- alertId.  
**Cómo funciona**  
Recupera los detalles de una alerta específica, incluyendo su estado, tipo y fechas clave.  

**Query: GetAlertsByStatusQuery**  
**Parámetros**  
- status.  
**Cómo funciona**  
Devuelve todas las alertas con un estado determinado (ej. abiertas, reconocidas, cerradas).  

**Query: GetAlertsByTypeQuery**  
**Parámetros**  
- type.  
**Cómo funciona**  
Recupera todas las alertas de un tipo específico (ej. RouteDeviation).  

**Query: GetNotificationsByAlertIdQuery**  
**Parámetros**  
- alertId.  
**Cómo funciona**  
Devuelve todas las notificaciones emitidas en relación con una alerta.  

**Query: GetIncidentsByAlertIdQuery**  
**Parámetros**  
- alertId.  
**Cómo funciona**  
Obtiene todos los incidentes generados a partir de una alerta determinada.  

### Events

**Event: AlertCreatedEvent**  
Se emite cuando una nueva alerta es registrada en el sistema.  

**Event: AlertAcknowledgedEvent**  
Se emite cuando una alerta es reconocida.  

**Event: AlertClosedEvent**  
Se emite cuando una alerta se cierra exitosamente.  

**Event: AlertEscalatedEvent**  
Se emite cuando una alerta aumenta de criticidad por falta de respuesta.  

**Event: NotificationSentEvent**  
Se emite al enviar una notificación a un usuario o empresa.  

**Event: IncidentCreatedEvent**  
Se emite cuando se genera un incidente a partir de una alerta. 

### Fábricas (Factories) 
- AlertFactory: encapsula la lógica de creación de una alerta a partir de eventos recibidos (ejemplo: sensor fuera de rango). 
- IncidentFactory: crea incidentes asociados a un viaje cuando una alerta lo requiere.

### Repositorios (Interfaces) 
- AlertRepository: interfaz para guardar, actualizar y recuperar alertas. 
- NotificationRepository: interfaz para manejar el historial y el estado de notificaciones. 
- IncidentRepository: interfaz para registrar incidentes asociados a viajes

### Reglas Clave (Business Rules)

- Persistence Window: no se genera alerta hasta que la condición anómala se mantenga por cierto tiempo.
- No duplicación: no se permiten alertas repetidas durante un período de enfriamiento.
- Escalamiento: si una alerta no es reconocida en el tiempo condigurado, se aumenta su criticidad.
- Flujo de estados: una alerta solo puede cerrarse si fue previamente reconocida.
- Preferencias de notificación: el canal de comunicación depende de la configuración del usuario o de la compañía.
- Consistencia: toda alerta debe estar vinculada a un evento detectado en el sistema de monitoreo.

#### 4.2.3.2. Interface Layer

En esta capa se definen **Controllers (REST)**, los **DTOs asociados**, además de las **políticas de validación, errores y seguridad**.

## A. Controllers (REST — Spring Web)

El sistema expone tres controladores principales:

**AlertController**  
Este controlador permite crear nuevas alertas a partir de eventos detectados, reconocer (ACK) alertas activas, cerrarlas una vez reconocidas, y obtener tanto el detalle de una alerta específica como la lista de alertas activas (estados OPEN o ACKNOWLEDGED).

**NotificationController**  
Su responsabilidad es consultar y actualizar las preferencias de notificación de los usuarios, por ejemplo, los canales permitidos (EMAIL, SMS o FCM) y los tiempos de escalamiento configurados.

**IncidentController**  
Permite crear incidentes vinculados a una alerta y un viaje, y consultar el detalle de incidentes registrados.

## B. DTOs (principales)

Para la comunicación con la interfaz se definen varios DTOs principales:

- **CreateAlertRequestDTO**: contiene la información necesaria para registrar una alerta, incluyendo el identificador del evento, el tipo de alerta (OUT_OF_RANGE, OFFLINE, ROUTE_DEVIATION), la fuente y el momento en que fue detectada.  
- **AlertDTO**: representa la respuesta al consultar una alerta. Incluye su identificador, tipo, estado (OPEN, ACK, CLOSED) y marcas de tiempo relevantes (creación, reconocimiento y cierre).  
- **NotificationPreferencesDTO**: describe las preferencias de notificación de un usuario, incluyendo los canales habilitados y el tiempo de escalamiento en minutos.  
- **UpdateNotificationPreferencesDTO**: utilizado para modificar las preferencias de notificación.  
- **NotificationDTO**: expone el estado de una notificación enviada, incluyendo su identificador, el canal de comunicación, el estado (PENDING, SENT, FAILED) y la referencia a la alerta.  
- **CreateIncidentRequestDTO**: permite crear un incidente a partir de una alerta, especificando el viaje asociado y los detalles adicionales.  
- **IncidentDTO**: devuelve la información de un incidente registrado, con su identificador, alerta relacionada, viaje asociado, detalles y fecha de creación.  


## C. Validación y reglas en la interfaz

La capa de interfaz aplica varias reglas importantes:

- Una alerta no puede cerrarse si no ha sido reconocida previamente. En caso de incumplir esta regla, la API devuelve un error con estado `422 Unprocessable Entity`.  
- Las preferencias de notificación deben validar que los canales enviados sean soportados (únicamente EMAIL, SMS o FCM).  
- La creación de alertas es idempotente: para evitar duplicados en caso de reintentos, se permite el uso del encabezado `Idempotency-Key`.


## D. Errores (contratos comunes)

Los contratos de error siguen una convención clara:  
- **400 Bad Request**: cuando los datos enviados no cumplen con la validación de los DTOs.  
- **401 Unauthorized / 403 Forbidden**: cuando el usuario no está autenticado o carece de permisos.  
- **404 Not Found**: cuando se consulta una alerta, notificación o incidente inexistente.  
- **409 Conflict**: en casos de transición de estado inválida o problemas de concurrencia.  
- **422 Unprocessable Entity**: al violar reglas de negocio, por ejemplo, intentar cerrar una alerta que no fue reconocida.  
- **503 Service Unavailable**: cuando falla un sistema externo como FCM o un gateway de SMS.  


## E. Seguridad y políticas

En términos de seguridad, la autenticación y autorización se manejan con **JWT (OAuth2/OIDC)**, definiendo roles de usuario, sistema de monitoreo y administrador. Se aplica **rate limiting** para evitar abuso en las operaciones sensibles como el reconocimiento o cierre de alertas.  

Se implementa versionado de la API con el prefijo `/api/v1/...`. Además, la capa de interfaz incorpora mecanismos de **observabilidad**, como la propagación del identificador de trazabilidad (`X-Request-Id`), métricas por endpoint y auditoría de cambios en los estados de las alertas.

#### 4.2.3.3. Application Layer

## Command Services

- AcknowledgeAlertCommandHandler: procesa el reconocimiento de una alerta.
- CloseAlertCommandHandler: gestiona el cierre de una alerta.
- CreateAlertCommandHandler: crea una nueva alerta a partir de un evento recibido.

## Event Services

- OutOfRangeDetectedEventHandler: maneja eventos de sensores fuera de rango.
- DeviceOfflineDetectedEventHandler: maneja eventos de desconexión de dispositivos.
- RouteDeviationDetectedEventHandler: maneja desvíos de ruta.
- AlertAcknowledgedEventHandler: actúa tras el reconocimiento de una alerta (ejemplo: detener escalamiento).
- AlertClosedEventHandler: actúa tras el cierre de una alerta (ejemplo: notificar a analíticas).
- TemperatureOutOfRangeEventHandler: crea alerta de temperatura.
- HumidityOutOfRangeEventHandler: crea alerta de humedad.
- VibrationDetectedEventHandler: maneja vibración anómala.
- TiltOrDumpDetectedEventHandler: maneja vuelcos o inclinaciones.
- LowBatteryDetectedEventHandler: maneja alerta de energía.

## Query Services

- AlertAppService: coordina el ciclo de vida de las alertas.
- NotificationAppService: orquesta el envío de notificaciones a través de canales externos.
- IncidentAppService: integra el contexto de alertas con el contexto de viajes para crear incidentes relacionados.

#### 4.2.3.4. Infrastructure Layer

- Notification Repository: Repositorio para acceder a la base de datos de las notificaciones.
- Alert Repository: Repositorio para acceder a la base de datos de las alertas.
- Incident Repository: Repositorio para acceder a la base de datos de los incidentes.

#### 4.2.3.5. Bounded Context Software Architecture Component Level Diagrams

#### 4.2.3.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.3.6.1. Bounded Context Domain Layer Class Diagrams

![Alert Management Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/Los-Parkers-IoT/LosParkers-report/refs/heads/feature/chapter-4/assets/UML/Alert-Management-Domain-Layer-Class-Diagram.puml)

##### 4.2.3.6.2. Bounded Context Database Design Diagram

### 4.2.4. Bounded Context: _Real-Time Monitoring_

#### 4.2.4.1. Domain Layer

### Entidades (Entities)

- **MonitoringSession**: representa una sesión de monitoreo para un viaje específico. Almacena el estado de la sesión, los parámetros de referencia (`TemperatureRange`) y las lecturas recibidas.
- **TelemetryData**: registra una única lectura de un sensor, incluyendo temperatura, humedad, vibración, ubicación y la hora de la lectura.

### Objetos de Valor (Value Objects)

- **SensorReading**: encapsula los datos de una lectura específica (ej. temperatura, humedad).
- **TemperatureRange**: define los límites mínimos y máximos de temperatura aceptables.
- **Location**: representa las coordenadas geográficas (latitud, longitud).
- **SignalStatus**: indica el estado de la conexión del dispositivo (ONLINE, OFFLINE).
- **SessionStatus**: describe el estado de una sesión (ACTIVE, INACTIVE, COMPLETED).

### Agregados (Aggregates)

- **MonitoringSessionAggregate**: agrupa la `MonitoringSession` con sus `TelemetryData` relacionadas, asegurando que todas las lecturas de un viaje estén coherentemente gestionadas bajo una única sesión.

### Servicios de Dominio (Domain Services)

- **DataIngestionService**: procesa y valida las lecturas de telemetría entrantes desde los dispositivos IoT.
- **RuleEvaluationService**: analiza las lecturas en tiempo real para detectar violaciones de parámetros.
- **DataEnrichmentService**: enriquece los datos de telemetría con información adicional (ej. ruta).

### Fábricas (Factories)

- **MonitoringSessionFactory**: crea una nueva sesión de monitoreo a partir de los datos de un viaje.
- **TelemetryDataFactory**: encapsula la lógica para crear una instancia de `TelemetryData` a partir de una lectura de sensor.

### Repositorios (Interfaces)

- **MonitoringSessionRepository**: interfaz para guardar y recuperar sesiones de monitoreo.
- **TelemetryDataRepository**: interfaz para persistir y consultar las lecturas de telemetría.

### Reglas Clave (Business Rules)

- **Umbral de Alerta**: la `TemperatureViolation` se genera solo si la temperatura está fuera del `TemperatureRange` por un período mínimo.
- **Detección de Desconexión**: si un dispositivo deja de enviar datos por más de X minutos, su estado se marca como `OFFLINE`.
- **Integridad de Datos**: cada lectura de `TelemetryData` debe estar asociada a una `MonitoringSession` activa.

---

#### 4.2.4.2. Interface Layer

### A. Consumers (Mensajería)

| Evento de entrada      | Origen                  | Descripción                                                   |
| ---------------------- | ----------------------- | ------------------------------------------------------------- |
| `iot.telemetry.data`   | Sensores IoT            | Consume lecturas de sensores para procesarlas en tiempo real. |
| `trips.trip.started`   | `Execution of the trip` | Inicia una nueva sesión de monitoreo para el viaje.           |
| `trips.trip.completed` | `Execution of the trip` | Finaliza la sesión de monitoreo.                              |

### B. Controllers (REST)

**Base path:** `/api/v1/monitoring`

| Método | Ruta                              | Descripción                                               | Request DTO | Response DTO                | Código HTTP |
| ------ | --------------------------------- | --------------------------------------------------------- | ----------- | --------------------------- | ----------- |
| GET    | `/sessions/{sessionId}`           | obtiene el estado actual de una sesión de monitoreo       | —           | `MonitoringSessionDTO`      | 200 OK      |
| GET    | `/sessions/{sessionId}/telemetry` | obtiene lecturas de telemetría de una sesión              | —           | Lista de `TelemetryDataDTO` | 200 OK      |
| GET    | `/live-map-data/{sessionId}`      | provee datos en tiempo real para visualización en el mapa | —           | `LiveMapDataDTO`            | 200 OK      |
| GET    | `/chart-data/{sessionId}`         | provee datos de temperatura para gráficos                 | —           | `TemperatureChartDataDTO`   | 200 OK      |

### C. DTOs (principales)

| DTO                       | Campos principales                                                          |
| ------------------------- | --------------------------------------------------------------------------- |
| `TelemetryDataDTO`        | `readingId`, `deviceId`, `timestamp`, `temperature`, `humidity`, `location` |
| `MonitoringSessionDTO`    | `sessionId`, `tripId`, `status`, `temperatureRange`, `lastReadingAt`        |
| `LiveMapDataDTO`          | `sessionId`, `deviceId`, `currentLocation`, `lastTimestamp`, `status`       |
| `TemperatureChartDataDTO` | `sessionId`, `dataPoints` (lista de `timestamp`, `temperature`)             |

### D. Validación y reglas en la interfaz

- **Validación de datos**: las lecturas deben ser validadas para asegurar que contienen los campos requeridos.
- **Control de acceso**: solo usuarios con permisos (`monitoring-system`) pueden enviar datos.
- **Idempotencia**: se implementa para evitar lecturas duplicadas.

### E. Errores (contratos comunes)

| Código HTTP | Descripción                                                                  |
| ----------- | ---------------------------------------------------------------------------- |
| 400         | **Bad Request** — datos de telemetría incompletos                            |
| 404         | **Not Found** — sesión de monitoreo inexistente                              |
| 409         | **Conflict** — intento de iniciar una sesión de monitoreo que ya está activa |
| 503         | **Service Unavailable** — fallo en la integración con un sistema externo     |

---

# F. Seguridad y políticas

- **AuthN/AuthZ**: Se utilizará JWT (OAuth2/OIDC) para asegurar las APIs. Los roles principales para este contexto serán monitoring-system (para la ingestión de datos de los dispositivos) y user (para consultas).
- **Rate limiting**: Se implementará un límite de solicitudes en el endpoint de ingestión para prevenir abusos o ataques de denegación de servicio.
- **API Versioning**: Se mantendrá la práctica de versionado (/api/v1/...).
- **Observabilidad**: Se implementará el registro de trazas con un 'X-Request-Id' para correlacionar las lecturas de telemetría a través de los diferentes servicios y sistemas. Se capturarán métricas por endpoint y se auditarán las transiciones de estado de las sesiones de monitoreo.

# G. Contratos de ejemplo (OpenAPI sketch)

```yaml
paths:
  /api/v1/monitoring/sessions/{sessionId}:
    get:
      summary: Get Monitoring Session Details
      operationId: getSessionDetails
      parameters:
        - name: sessionId
          in: path
          required: true
          schema:
            type: string
            format: uuid
      security:
        - BearerAuth: []
      responses:
        '200':
          description: Session details retrieved successfully.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MonitoringSessionDTO'
        '404':
          description: Monitoring session not found.

  /api/v1/monitoring/live-map-data/{sessionId}:
    get:
      summary: Get Live Map Data
      operationId: getLiveMapData
      parameters:
        - name: sessionId
          in: path
          required: true
          schema:
            type: string
            format: uuid
      security:
        - BearerAuth: []
      responses:
        '200':
          description: Live map data retrieved successfully.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/LiveMapDataDTO'
        '404':
          description: Monitoring session not found.

components:
  schemas:
    MonitoringSessionDTO:
      type: object
      properties:
        sessionId:
          type: string
          format: uuid
        tripId:
          type: string
          format: uuid
        status:
          type: string
          enum: [ACTIVE, INACTIVE, COMPLETED]
        temperatureRange:
          type: object
          properties:
            min:
              type: number
            max:
              type: number
    LiveMapDataDTO:
      type: object
      properties:
        sessionId:
          type: string
          format: uuid
        deviceId:
          type: string
        currentLocation:
          $ref: '#/components/schemas/Location'
        lastTimestamp:
          type: string
          format: date-time
        status:
          type: string
          enum: [ONLINE, OFFLINE]
    Location:
      type: object
      properties:
        latitude:
          type: number
          format: float
        longitude:
          type: number
          format: float
```

#### 4.2.4.3. Application Layer

### Command Handlers

- **StartMonitoringSessionCommandHandler**: inicia una nueva sesión de monitoreo.
- **EndMonitoringSessionCommandHandler**: cierra una sesión de monitoreo.

### Event Handlers

- **TelemetryDataReceivedHandler**: procesa una lectura de telemetría, validando y evaluando reglas.
- **TripStartedHandler**: maneja el evento de inicio de viaje para crear una nueva sesión.
- **TripCompletedHandler**: maneja el evento de finalización de viaje para cerrar la sesión.

### Application Services (Capabilities)

- **MonitoringAppService**: orquesta el ciclo de vida de las sesiones y la gestión de datos.
- **DataProcessorAppService**: integra la ingestión de datos, la evaluación de reglas y el enriquecimiento.

### Transaccionalidad & Resiliencia

- **Patrón de Transacciones**: se usa en operaciones clave para asegurar consistencia.
- **Reintentos y Backoff**: se aplican al intentar enriquecer datos con APIs externas que pueden fallar.
- **Outbox Pattern**: para publicar eventos de dominio de forma confiable, como `OutOfRangeDetected`.

---

#### 4.2.4.4. Infrastructure Layer

### Componentes principales

- **TelemetryDataRepositoryPostgres**: implementación de `TelemetryDataRepository`, optimizada para escrituras masivas.
- **MonitoringSessionRepositoryPostgres**: implementación de `MonitoringSessionRepository` con transacciones.
- **IoTMQTTAdapter**: adapter para el protocolo MQTT que consume los mensajes de telemetría.
- **GoogleMapsAdapter**: se integra con la API de Google Maps para enriquecimiento de datos de ubicación.
- **EventBusKafkaAdapter**: adapter para el bus de eventos que consume eventos de otros contextos y publica los propios.
- **OutboxKafkaPublisher**: lee la tabla de Outbox para publicar eventos de forma confiable en Kafka.

#### 4.2.4.5. Bounded Context Software Architecture Component Level Diagrams

#### 4.2.4.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.4.6.1. Bounded Context Domain Layer Class Diagrams

##### 4.2.4.6.2. Bounded Context Database Design Diagram

### 4.2.5. Bounded Context: Trip management

#### 4.2.5.1. Domain Layer.

**Entities**

- **Trip (Aggregate Root)**: Representa un viaje de transporte. Es el núcleo del agregado y coordina las reglas de negocio. Contiene la referencia al conductor mediante un driverId, al cliente mediante un clientId, al vehículo mediante un vehicleId, además de la ruta y el estado del viaje.

**Value Objects**

- **GeoCoordinate**: Valor inmutable que representa una coordenada geográfica compuesta por una latitud y una longitud válidas.
- **Polyline**: Cadena de texto que representa la ruta en forma compacta y que siempre puede convertirse a una lista de coordenadas geográficas.
- **RouteSegment**: Tramo de la ruta entre dos puntos. Incluye la lista de coordenadas que describen el trayecto, la distancia recorrida y la duración estimada.
- **Route**: Valor que encapsula toda la información de la ruta de un viaje, incluyendo origen, destino, los segmentos que la componen, la representación en polyline, la distancia total y la duración total.
- **Distance**: Valor que expresa una magnitud de distancia junto con su unidad de medida, por ejemplo kilómetros.
- **Duration**: Valor que expresa un intervalo de tiempo junto con su unidad, por ejemplo minutos.
- **TripStatus**: Representa el estado del viaje dentro de su ciclo de vida. Los estados posibles son Pendiente, En curso, Completado o Cancelado.

**Aggregate**

- **TripAggregate**: El agregado principal que asegura la consistencia de un viaje. Garantiza que un viaje siempre tenga cliente, conductor, vehículo y ruta válidos antes de iniciarse. Controla los invariantes de negocio como no iniciar un viaje sin ruta definida.

**Factories**

- **TripFactory**: Responsable de crear instancias de Trip en estado inicial Pendiente. Se asegura de que el viaje cuente con referencias válidas a driverId, clientId, vehicleId y con una ruta completa.

**Domain Services**

- **RoutePlanningService**: Servicio de dominio que encapsula la lógica de planificación de rutas. Genera un objeto Route válido con origen, destino, segmentos, distancia y duración.
- **TripSchedulerService**: Servicio de dominio que valida la disponibilidad de conductores y vehículos. Impide asignar el mismo recurso a viajes en paralelo.

**Repositories (interfaces)**

- **ITripRepository**: Contrato de persistencia para almacenar y recuperar viajes. Proporciona métodos como buscar un viaje por su identificador, guardar cambios, encontrar viajes por estado o consultar los viajes de un cliente específico.

**Commands**

- **CreateTripCommand**: Orden para crear un nuevo viaje con cliente, conductor, vehículo y ruta asignados.
- **AssignDriverToTripCommand**: Orden para asignar un conductor a un viaje existente.
- **AssignVehicleToTripCommand**: Orden para asignar un vehículo a un viaje existente.
- **StartTripCommand**: Orden para iniciar un viaje, cambiando su estado a En curso.
- **CompleteTripCommand**: Orden para marcar un viaje como finalizado correctamente.
- **CancelTripCommand**: Orden para cancelar un viaje, cambiando su estado a Cancelado.
- **UpdateRouteForTripCommand**: Orden para actualizar la ruta asociada a un viaje antes de iniciarlo.

**Queries**

- **GetTripByIdQuery**: Consulta que devuelve la información de un viaje a partir de su identificador.
- **GetTripsByStatusQuery**: Consulta que devuelve los viajes según su estado, ya sea Pendiente, En curso, Completado o Cancelado.
- **GetTripsByClientIdQuery**: Consulta que devuelve todos los viajes asociados a un cliente específico.
- **GetAllTripsQuery**: Consulta que devuelve todos los viajes registrados en el sistema.

**Events**

- **TripCreatedEvent**: Evento que se emite cuando un viaje es creado.
- **DriverAssignedEvent**: Evento que se emite cuando un conductor es asignado a un viaje.
- **VehicleAssignedEvent**: Evento que se emite cuando un vehículo es asignado a un viaje.
- **TripStartedEvent**: Evento que se emite cuando un viaje inicia oficialmente.
- **TripCompletedEvent**: Evento que se emite cuando un viaje se completa satisfactoriamente.
- **TripCancelledEvent**: Evento que se emite cuando un viaje es cancelado.

#### 4.2.5.2. Interface Layer.

**Controllers**

- **TripController**: expone endpoints REST para gestionar los viajes. Recibe solicitudes del cliente y las convierte en comandos o queries para el Application Layer.
  - createTrip: permite registrar un nuevo viaje a partir de la información del cliente, conductor, vehículo y ruta.
  - assignDriver: asigna un conductor a un viaje existente.
  - assignVehicle: asigna un vehículo a un viaje existente.
  - startTrip: cambia el estado de un viaje a “En curso”.
  - completeTrip: marca un viaje como finalizado.
  - cancelTrip: cancela un viaje en curso o pendiente.
  - updateRoute: permite actualizar la ruta asociada a un viaje antes de iniciarse.
  - getTripById: consulta la información de un viaje específico mediante su identificador.
  - getTripsByStatus: devuelve la lista de viajes filtrados por estado.
  - getTripsByClient: consulta los viajes asociados a un cliente específico.
  - getAllTrips: devuelve todos los viajes registrados en el sistema.

#### 4.2.5.3. Application Layer.

**Command Handlers**  
Se encargan de ejecutar la lógica de cada comando y modificar el estado del dominio.

- **CreateTripCommandHandler**: procesa la creación de un viaje nuevo usando TripFactory y persiste el agregado en ITripRepository.
- **AssignDriverToTripCommandHandler**: recibe un comando de asignación de conductor, valida la referencia y actualiza el Trip.
- **AssignVehicleToTripCommandHandler**: procesa la asignación de un vehículo a un viaje.
- **StartTripCommandHandler**: cambia el estado del viaje a “En curso” y emite el evento TripStartedEvent.
- **CompleteTripCommandHandler**: marca el viaje como finalizado y emite el evento TripCompletedEvent.
- **CancelTripCommandHandler**: cambia el estado del viaje a “Cancelado” y emite el evento TripCancelledEvent.
- **UpdateRouteForTripCommandHandler**: procesa la actualización de la ruta de un viaje antes de su inicio.

**Query Handlers**  
Procesan consultas de solo lectura y devuelven DTOs o proyecciones.

- **GetTripByIdQueryHandler**: busca un viaje por su identificador y devuelve su representación.
- **GetTripsByStatusQueryHandler**: devuelve los viajes filtrados por estado (Pendiente, En curso, Completado, Cancelado).
- **GetTripsByClientIdQueryHandler**: devuelve los viajes asociados a un cliente específico.
- **GetAllTripsQueryHandler**: obtiene todos los viajes registrados en el sistema.

**Event Handlers**  
Escuchan eventos de dominio y reaccionan a ellos para ejecutar acciones adicionales dentro del mismo bounded context o preparar datos para otros.

- **TripCreatedEventHandler**: maneja el evento de creación de un viaje, inicializando procesos asociados como auditoría o métricas internas.
- **DriverAssignedEventHandler**: reacciona a la asignación de un conductor, garantizando consistencia en registros relacionados.
- **VehicleAssignedEventHandler**: maneja la asignación de un vehículo, actualizando estados necesarios.
- **TripStartedEventHandler**: responde al inicio de un viaje, registrando la hora de inicio y disparando procesos de seguimiento.
- **TripCompletedEventHandler**: procesa la finalización de un viaje, generando datos para reportes o notificaciones al cliente.
- **TripCancelledEventHandler**: maneja la cancelación de un viaje, liberando recursos y actualizando métricas de cancelación.

#### 4.2.5.4. Infrastructure Layer.

#### 4.2.5.5. Bounded Context Software Architecture Component Level Diagrams.

#### 4.2.5.6. Bounded Context Software Architecture Code Level Diagrams.

##### 4.2.5.6.1. Bounded Context Domain Layer Class Diagrams.

![Trip Management Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/Los-Parkers-IoT/LosParkers-report/refs/heads/feature/chapter-4/assets/UML/Trip-Management-Domain-Layer-Class-Diagram.puml)

##### 4.2.5.6.2. Bounded Context Database Design Diagram.
