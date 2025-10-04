workspace "Fleet Monitoring System" "Fleet monitoring system for logistics management" {

    model {
        // External actors
        logisticManager = person "Logistics Manager" "Manages and supervises fleet operations"
        endCustomer = person "End Customer" "Monitors their orders and deliveries"

        // Backend system
        backendSystem = softwareSystem "Backend API" "Backend system that handles business logic"

        // Frontend system
        frontendSystem = softwareSystem "Frontend Web Application" "Angular web application for fleet monitoring" {
            
            // Angular Container
            angularApp = container "Angular Application" "Single Page Web Application" "Angular 17, TypeScript" {
                
                // UI Components (Pages & Components)
                loginPage = component "Login Page" "User login page" "UI Component"
                registerPage = component "Register Page" "User registration page" "UI Component"
                userProfilePage = component "User Profile Page" "User profile management page" "UI Component"
                userManagementPage = component "User Management Page" "User administration page" "UI Component"
                
                // Services (Logic Orchestrators)
                authService = component "Authentication Service" "Orchestrates authentication logic" "Service"
                userService = component "User Service" "Orchestrates user management logic" "Service"
                
                // States (State Management)
                authState = component "Auth State" "Authentication state management" "State"
                userState = component "User State" "User data state management" "State"
                
                // Models (Aggregates Only)
                userAggregate = component "User Aggregate" "User domain aggregate" "Model"
            }
        }

        // Relationships between actors and system
        logisticManager -> loginPage "Logs in to manage users"
        endCustomer -> loginPage "Logs in to view their orders"
        
        // Component relationships
        loginPage -> authService "Uses for authentication"
        registerPage -> authService "Uses for user registration"
        
        userProfilePage -> userService "Gets and updates profile"
        userManagementPage -> userService "Manages users"
        
        authService -> authState "Updates authentication state"
        userService -> userState "Updates user state"
        
        authService -> backendSystem "Sends authentication requests"
        userService -> backendSystem "Sends user management requests"
        
        // Model usage
        authService -> userAggregate "Uses"
        userService -> userAggregate "Uses"
        authState -> userAggregate "Manages"
        userState -> userAggregate "Manages"
    }

    views {
        component angularApp "AngularIAMComponents" {
            title "Identity & Access Management - Frontend Angular Components"
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