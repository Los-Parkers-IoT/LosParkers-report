workspace "Fleet Monitoring System" "Fleet monitoring system for logistics management" {

    model {
        // External actors
        logisticManager = person "Logistics Manager" "Manages operations from mobile device"
        endCustomer = person "End Customer" "Monitors orders from mobile device"

        // External systems
        backendSystem = softwareSystem "Backend API" "Backend system that handles business logic"
        
        // Local database
        sqliteDB = softwareSystem "SQLite Local Database" "Mobile device local database" "SQLite"

        // Mobile system
        mobileSystem = softwareSystem "Mobile Flutter Application" "Mobile application for fleet monitoring" {
            
            // Flutter Container
            flutterApp = container "Flutter Application" "Cross-platform mobile application" "Flutter, Dart" {
                
                // Widgets (Screens & Widgets)
                loginScreen = component "Login Screen" "User login screen" "Widget"
                registerScreen = component "Register Screen" "User registration screen" "Widget"
                userProfileScreen = component "User Profile Screen" "User profile management screen" "Widget"
                
                // Services (Logic Orchestrators)
                authService = component "Authentication Service" "Orchestrates authentication logic" "Service"
                userService = component "User Service" "Orchestrates user management logic" "Service"
                
                // BLoC (State Management)
                authBloc = component "Authentication BLoC" "Authentication state management" "BLoC"
                userBloc = component "User BLoC" "User state management" "BLoC"
                
                // DB Connector
                dbConnector = component "Database Connector" "Local database connectivity" "DB Connector"
                
                // Models (Aggregates Only)
                userAggregate = component "User Aggregate" "User domain aggregate" "Model"
            }
        }

        // User relationships
        logisticManager -> loginScreen "Logs in from mobile"
        endCustomer -> loginScreen "Logs in from mobile"
        
        // Screen and BLoC relationships
        loginScreen -> authBloc "Sends authentication events"
        registerScreen -> authBloc "Sends registration events"
        userProfileScreen -> userBloc "Sends user events"
        
        // BLoC and service relationships
        authBloc -> authService "Uses authentication service"
        userBloc -> userService "Uses user service"
        
        // Service relationships
        authService -> dbConnector "Stores authentication data"
        userService -> dbConnector "Stores user data"
        authService -> backendSystem "Communicates with backend API"
        userService -> backendSystem "Communicates with backend API"
        
        // Database relationships
        dbConnector -> sqliteDB "Accesses local database"
        
        // Model usage
        authService -> userAggregate "Uses"
        userService -> userAggregate "Uses"
        authBloc -> userAggregate "Manages"
        userBloc -> userAggregate "Manages"
    }

    views {
        component flutterApp "FlutterIAMComponents" {
            title "Identity & Access Management - Mobile Flutter Components"
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