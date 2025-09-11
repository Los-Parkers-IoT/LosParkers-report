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


| Epic / Story | ID   | Título | Descripción | Criterios de Aceptación | Relacionado con (Epic ID) |
|--------------|------|--------|-------------|--------------------------|----------------------------|
| Epic         | E3   | Monitoreo en tiempo real | Engloba funcionalidades de monitoreo de temperatura en tiempo real y alertas. |  |  |
| User Story   | US1  | Actualización de temperatura en tiempo real | Como empresa, quiero recibir la temperatura en tiempo real de mis dispositivos IoT, para supervisar la cadena de frío de los viajes. | Given un sensor IoT transmite datos de temperatura<br>When el sistema recibe los datos<br>Then la temperatura se actualiza en la plataforma sin retrasos.<br><br>Given un dispositivo pierde conexión<br>When intenta enviar datos<br>Then el sistema muestra la última lectura disponible y marca estado de conexión. | E3 |
| User Story   | US2  | Alertas por incumplimiento de temperatura | Como cliente final, quiero recibir alertas cuando la temperatura sobrepasa los límites definidos, para tomar acciones correctivas. | Given la temperatura excede el rango permitido<br>When el sistema procesa la lectura<br>Then se genera una alerta y se notifica al usuario.<br><br>Given un usuario tiene notificaciones activadas<br>When recibe una alerta<br>Then visualiza el mensaje en el sistema o correo/SMS. | E3 |
| User Story  | US19 | Alertas de conexión IoT | Como empresa, quiero recibir alertas cuando un dispositivo IoT deja de enviar datos, para actuar de inmediato. | Given un dispositivo deja de transmitir por más de X minutos<br>When el sistema detecta la ausencia<br>Then genera una alerta para la empresa. | E3 |
| User Story  | US20 | Roles y permisos de acceso | Como empresa, quiero que el sistema gestione roles y permisos de usuarios (admin, cliente, operador), para controlar accesos. | Given un usuario con rol administrador<br>When accede al panel de gestión<br>Then puede realizar todas las operaciones.<br><br>Given un usuario con rol cliente<br>When accede al sistema<br>Then solo puede ver información de sus viajes y suscripciones. | E3 |
| Epic         | E4   | Dashboard de viajes | Engloba pantallas, gráficos e informes relacionados a los viajes. |  |  |
| User Story   | US3  | Lista de viajes registrados | Como empresa, quiero ver una lista de todos los viajes registrados para gestionarlos de forma rápida. | Given un usuario autenticado accede al dashboard<br>When solicita la lista de viajes<br>Then el sistema muestra todos los viajes con sus datos principales. | E4 |
| User Story   | US4  | Detalle de viaje | Como cliente final, quiero consultar el detalle de un viaje, para verificar información específica como ruta, estado y temperatura. | Given un viaje está registrado<br>When el usuario selecciona un viaje de la lista<br>Then se muestran todos sus detalles asociados. | E4 |
| User Story   | US5  | Gráficos de tiempo y temperatura | Como cliente final, quiero ver gráficos de evolución de la temperatura durante el viaje, para verificar el cumplimiento de parámetros. | Given un viaje cuenta con datos de temperatura<br>When se consulta el detalle<br>Then el sistema despliega un gráfico de línea con los valores. | E4 |
| User Story   | US6  | Gráficos de incidencias por mes | Como empresa, quiero ver un gráfico mensual de incidencias para identificar patrones de fallos. | Given existen incidencias en el histórico<br>When el usuario consulta el dashboard<br>Then se muestra un gráfico con número de incidencias por mes. | E4 |
| User Story   | US7  | Filtrado de viajes por fecha | Como empresa, quiero filtrar la lista de viajes por rango de fechas, para analizar un periodo específico. | Given un usuario aplica un filtro de fechas<br>When el sistema procesa la consulta<br>Then se muestran solo los viajes que cumplen el criterio. | E4 |
| User Story   | US8  | Descarga de reporte de viajes | Como cliente final, quiero descargar un reporte en PDF de un viaje con su información y gráficos, para archivarlo o compartirlo. | Given un usuario selecciona un viaje<br>When solicita la exportación<br>Then el sistema genera y entrega un archivo PDF con la información del viaje. | E4 |
| Epic         | E5   | Módulo de suscripciones | Engloba funcionalidades de pago, manejo y control de suscripciones. |  |  |
| User Story   | US9 | Cancelar suscripción | Como cliente final, quiero cancelar mi suscripción, para detener los cobros futuros. | Given un cliente con suscripción activa<br>When solicita la cancelación<br>Then el sistema marca la suscripción como cancelada y detiene próximos pagos. | E5 |
| User Story   | US10 | Visualizar información de suscripción | Como cliente final, quiero ver mi estado de suscripción y fecha de expiración, para gestionar mi acceso al servicio. | Given un cliente autenticado accede a la sección de suscripción<br>When consulta su información<br>Then el sistema muestra el plan, estado y fecha de expiración. | E5 |
| User Story   | US11 | Historial de pagos | Como empresa, quiero que los clientes consulten su historial de pagos, para brindar transparencia. | Given un cliente autenticado<br>When accede al historial de pagos<br>Then el sistema muestra todas las transacciones registradas con fecha y monto. | E5 |
| User Story   | US12 | Notificación de renovación próxima | Como cliente final, quiero recibir una notificación antes de que mi suscripción se renueve, para decidir si continúo o cancelo. | Given una suscripción está próxima a renovarse (ej. 3 días antes)<br>When el sistema procesa la fecha<br>Then envía una notificación al cliente. | E5 |

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
   - Cuando un *usuario se registra* en **Identity and Access Management**, se genera un evento que es consumido por **Profiles and Preferences**, el cual crea automáticamente el perfil asociado.  
   - Si un *usuario edita sus preferencias*, se guarda la configuración en **Profiles**, y en caso de referirse a notificaciones, estas se utilizan en **Alerts** para personalizar los canales de envío.  

2. **Control de acceso y suscripciones**  
   - Cuando un *pago es procesado exitosamente* en **Subscriptions & Billing**, se envía un evento a **Identity and Access Management**, que habilita el acceso al sistema.  
   - Si un *pago falla*, el mismo flujo comunica a IAM que debe restringir o bloquear el acceso del usuario hasta regularizar su situación.  

3. **Gestión de flota y ejecución de viajes**  
   - Al *registrarse un vehículo o dispositivo IoT* en **Fleet Management**, este queda disponible para **Trip Management**, que puede asignarlo a un viaje planificado.  
   - Cuando un *operador crea e inicia un viaje* en **Trip Management**, se emite un evento que da origen a una sesión de monitoreo en **Monitoring**.  

4. **Monitoreo en tiempo real y alertas**  
   - **Monitoring** recibe continuamente *lecturas de sensores* (temperatura, ubicación, señal). Si se detecta una condición fuera de rango, se genera un evento que es consumido por **Alerts**.  
   - **Alerts** crea la alerta correspondiente y la notifica a los usuarios, aplicando las preferencias definidas en **Profiles** (por ejemplo, envío por SMS, correo o notificación push).  

5. **Analítica y reportes**  
   - Cada *alerta generada o reconocida* en **Alerts** actualiza los indicadores en **Dashboard & Analytics**, alimentando las métricas de cumplimiento y los reportes de incidentes.  
   - Cuando **Dashboard & Analytics** genera un *reporte final*, este puede personalizarse de acuerdo con las preferencias almacenadas en **Profiles**, permitiendo al usuario recibir información ajustada a su rol o necesidades.
  
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

### 4.1.2. Context Mapping

### 4.1.3. Software Architecture

#### 4.1.3.1. Software Architecture System Landscape Diagram

#### 4.1.3.2. Software Architecture Context Level Diagrams

#### 4.1.3.2. Software Architecture Container Level Diagrams

#### 4.1.3.3. Software Architecture Deployment Diagrams

## 4.2. Tactical-Level Domain-Driven Design

### 4.2.1. Bounded Context: `<Bounded Context Name>`

#### 4.2.1.1. Domain Layer

#### 4.2.1.2. Interface Layer

#### 4.2.1.3. Application Layer

#### 4.2.1.4. Infrastructure Layer

#### 4.2.1.5. Bounded Context Software Architecture Component Level Diagrams

#### 4.2.1.6. Bounded Context Software Architecture Code Level Diagrams

##### 4.2.1.6.1. Bounded Context Domain Layer Class Diagrams

##### 4.2.1.6.2. Bounded Context Database Design Diagram
