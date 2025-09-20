workspace "Fleet Monitoring System" "Fleet monitoring system for logistics management" {

    model {
        // Frontend consumers
        frontendApp = softwareSystem "Frontend Application" "Angular web application"
        mobileApp = softwareSystem "Mobile Application" "Flutter mobile application"
        
        // Database
        database = softwareSystem "PostgreSQL Database" "Analytics database" "PostgreSQL"

        // Analytics Backend system
        analyticsSystem = softwareSystem "Analytics API System" "Read-only analytics and visualization API" {
            
            // Analytics Container
            analyticsApp = container "Analytics Application" "Analytics and visualization service" "Java 17, Spring Boot 3.x" {
                
                // Application Layer
                dashboardQueryService = component "Dashboard Query Service" "Dashboard data queries" "Application Layer"
                metricsQueryService = component "Metrics Query Service" "Metrics and KPIs queries" "Application Layer"
                reportsQueryService = component "Reports Query Service" "Reports data queries" "Application Layer"
                
                // Infrastructure Layer
                tripRepository = component "Trip Repository" "Trip data access" "Infrastructure Layer"
                incidentRepository = component "Incident Repository" "Incident data access" "Infrastructure Layer"
                driverRepository = component "Driver Repository" "Driver data access" "Infrastructure Layer"
            }
        }

        // External relationships - Frontend/Mobile to Query Services
        frontendApp -> dashboardQueryService "Direct dashboard queries"
        frontendApp -> metricsQueryService "Direct metrics queries"
        frontendApp -> reportsQueryService "Direct reports queries"
        mobileApp -> dashboardQueryService "Direct dashboard queries"
        mobileApp -> metricsQueryService "Direct metrics queries"
        
        // Application to Infrastructure Layer
        dashboardQueryService -> tripRepository "Gets trip data"
        dashboardQueryService -> incidentRepository "Gets incident data"
        dashboardQueryService -> driverRepository "Gets driver data"
        
        metricsQueryService -> tripRepository "Gets trip metrics"
        metricsQueryService -> incidentRepository "Gets incident metrics"
        metricsQueryService -> driverRepository "Gets driver metrics"
        
        reportsQueryService -> tripRepository "Gets trip reports data"
        reportsQueryService -> incidentRepository "Gets incident reports data"
        reportsQueryService -> driverRepository "Gets driver reports data"
        
        // Infrastructure to Database
        tripRepository -> database "Reads trip data"
        incidentRepository -> database "Reads incident data"
        driverRepository -> database "Reads driver data"
    }

    views {
        component analyticsApp "AnalyticsSystemComponents" {
            title "Visualization/Analytics - Simple Query Architecture"
            include *
            autoLayout lr
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Interface Layer" {
                background #6db33f
                color #ffffff
            }
            element "Application Layer" {
                background #0066cc
                color #ffffff
            }
            element "Infrastructure Layer" {
                background #17a2b8
                color #ffffff
            }
            element "PostgreSQL" {
                shape Cylinder
                background #ffa500
                color #ffffff
            }
        }
    }
}