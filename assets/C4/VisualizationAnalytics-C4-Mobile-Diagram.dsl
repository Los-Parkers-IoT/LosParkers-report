workspace "Fleet Monitoring System" "Fleet monitoring system for logistics management" {

    model {
        // External actors
        logisticManager = person "Logistics Manager" "Views analytics from mobile device"
        endCustomer = person "End Customer" "Views shipment analytics from mobile"

        // External systems
        backendSystem = softwareSystem "Backend API" "Backend system that provides analytics data"
        
        // Local database
        sqliteDB = softwareSystem "SQLite Local Database" "Mobile device analytics cache database" "SQLite" 

        // Mobile system
        mobileSystem = softwareSystem "Mobile Flutter Application" "Mobile application for fleet analytics" {
            
            // Flutter Container
            flutterApp = container "Flutter Application" "Cross-platform mobile analytics application" "Flutter, Dart, FL Chart" {
                
                // Widgets (Screens & Widgets)
                analyticsDashboardScreen = component "Analytics Dashboard Screen" "Main analytics dashboard screen" "Widget"
                tripAnalyticsScreen = component "Trip Analytics Screen" "Trip analytics detail screen" "Widget"
                incidentsOverviewScreen = component "Incidents Overview Screen" "Incidents overview screen" "Widget"
                temperatureChartWidget = component "Temperature Chart Widget" "Temperature chart widget" "Widget"
                
                // Services (Logic Orchestrators)
                analyticsService = component "Analytics Service" "Orchestrates analytics logic" "Service"
                chartService = component "Chart Service" "Orchestrates chart rendering logic" "Service"
                
                // BLoC (State Management)
                analyticsBloc = component "Analytics BLoC" "Analytics state management" "BLoC"
                chartBloc = component "Chart BLoC" "Chart state management" "BLoC"
                
                // DB Connector
                dbConnector = component "Database Connector" "Local analytics cache connectivity" "DB Connector"
                
                // Models (Aggregates Only)
                tripAggregate = component "Trip Aggregate" "Trip domain aggregate" "Model"
                incidentAggregate = component "Incident Aggregate" "Incident domain aggregate" "Model"
            }
        }

        // User relationships
        logisticManager -> analyticsDashboardScreen "Views comprehensive analytics"
        endCustomer -> tripAnalyticsScreen "Views temperature analytics for shipments"
        
        // Screen navigation relationships
        analyticsDashboardScreen -> tripAnalyticsScreen "Navigates to trip details"
        analyticsDashboardScreen -> incidentsOverviewScreen "Navigates to incidents overview"
        tripAnalyticsScreen -> temperatureChartWidget "Displays temperature charts"
        
        // Screen to BLoC relationships
        analyticsDashboardScreen -> analyticsBloc "Sends analytics events"
        tripAnalyticsScreen -> analyticsBloc "Sends trip analytics events"
        incidentsOverviewScreen -> analyticsBloc "Sends incident analytics events"
        temperatureChartWidget -> chartBloc "Manages chart configuration"
        
        // BLoC and service relationships
        analyticsBloc -> analyticsService "Uses analytics service"
        chartBloc -> chartService "Uses chart service"
        
        // Service relationships
        analyticsService -> dbConnector "Caches analytics data"
        chartService -> dbConnector "Stores chart configurations"
        analyticsService -> backendSystem "Fetches analytics data"
        
        // Database relationships
        dbConnector -> sqliteDB "Accesses local analytics cache"
        
        // Model usage
        analyticsService -> tripAggregate "Uses"
        analyticsService -> incidentAggregate "Uses"
        analyticsBloc -> tripAggregate "Manages"
        analyticsBloc -> incidentAggregate "Manages"
    }

    views {
        component flutterApp "FlutterAnalyticsComponents" {
            title "Visualization/Analytics - Mobile Flutter Components"
            include *
            autoLayout lr
        }

        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Widget" {
                background #02569b
                color #ffffff
            }
            element "Service" {
                background #0175c2
                color #ffffff
            }
            element "BLoC" {
                background #ff5722
                color #ffffff
            }
            element "DB Connector" {
                background #4caf50
                color #ffffff
            }
            element "Model" {
                background #607d8b
                color #ffffff
            }
            element "SQLite" {
                shape Cylinder
                background #ffa500
                color #ffffff
            }
        }
    }
}