workspace "Fleet Monitoring System" "Fleet monitoring system for logistics management" {

    model {
        // External actors
        logisticManager = person "Logistics Manager" "Analyzes fleet performance and incidents"
        endCustomer = person "End Customer" "Views temperature analytics for their shipments"

        // Backend system
        backendSystem = softwareSystem "Backend API" "Backend system that provides analytics data"

        // Frontend system
        frontendSystem = softwareSystem "Frontend Web Application" "Angular web application for fleet analytics" {
            
            // Angular Container
            angularApp = container "Angular Application" "Single Page Web Application for Analytics" "Angular 17, TypeScript, Chart.js" {
                
                // UI Components (Pages & Components)
                analyticsDashboardPage = component "Analytics Dashboard Page" "Main analytics dashboard page" "UI Component"
                tripAnalyticsPage = component "Trip Analytics Page" "Trip analytics detail page" "UI Component"
                incidentsOverviewPage = component "Incidents Overview Page" "Incidents overview page" "UI Component"
                temperatureChartComponent = component "Temperature Chart Component" "Temperature visualization component" "UI Component"
                
                // Services (Logic Orchestrators)
                analyticsService = component "Analytics Service" "Orchestrates analytics logic" "Service"
                chartService = component "Chart Service" "Orchestrates chart rendering logic" "Service"
                
                // States (State Management)
                analyticsState = component "Analytics State" "Analytics data state management" "State"
                chartState = component "Chart State" "Chart configuration state management" "State"
                
                // Models (Aggregates Only)
                tripAggregate = component "Trip Aggregate" "Trip domain aggregate" "Model"
                incidentAggregate = component "Incident Aggregate" "Incident domain aggregate" "Model"
            }
        }

        // User relationships
        logisticManager -> analyticsDashboardPage "Views comprehensive fleet analytics"
        endCustomer -> tripAnalyticsPage "Views temperature data for their shipments"
        
        // Page relationships
        analyticsDashboardPage -> tripAnalyticsPage "Navigates to trip details"
        analyticsDashboardPage -> incidentsOverviewPage "Navigates to incidents overview"
        tripAnalyticsPage -> temperatureChartComponent "Displays temperature charts"
        
        // Service relationships
        analyticsDashboardPage -> analyticsService "Gets analytics data"
        tripAnalyticsPage -> analyticsService "Gets trip analytics data"
        incidentsOverviewPage -> analyticsService "Gets incident analytics data"
        temperatureChartComponent -> chartService "Uses for chart rendering"
        
        // State relationships
        analyticsService -> analyticsState "Updates analytics state"
        chartService -> chartState "Updates chart state"
        
        // Backend relationships
        analyticsService -> backendSystem "Fetches analytics data"
        
        // Model usage
        analyticsService -> tripAggregate "Uses"
        analyticsService -> incidentAggregate "Uses"
        analyticsState -> tripAggregate "Manages"
        analyticsState -> incidentAggregate "Manages"
    }

    views {
        component angularApp "AngularAnalyticsComponents" {
            title "Visualization/Analytics - Frontend Angular Components"
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
            element "UI Component" {
                background #dd0031
                color #ffffff
            }
            element "Service" {
                background #0f7b0f
                color #ffffff
            }
            element "State" {
                background #ff6b35
                color #ffffff
            }
            element "Model" {
                background #3178c6
                color #ffffff
            }
        }
    }
}