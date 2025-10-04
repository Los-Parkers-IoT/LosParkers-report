workspace "Fleet Monitoring System" "Fleet monitoring system for logistics management" {

    model {
        // External actors
        frontendApp = softwareSystem "Frontend Application" "Angular web application"
        mobileApp = softwareSystem "Mobile Application" "Flutter mobile application"
        
        // Database
        database = softwareSystem "PostgreSQL Database" "Main database" "PostgreSQL" 

        // Backend system
        backendSystem = softwareSystem "Backend API System" "REST API for Identity & Access Management" {
            
            // Spring Boot Container
            springBootApp = container "Spring Boot Application" "REST API for Identity & Access Management" "Java 17, Spring Boot 3.x" {
                
                // Interface Layer
                authController = component "Auth Controller" "Authentication REST endpoints" "Interface Layer"
                userController = component "User Controller" "User management REST endpoints" "Interface Layer"
                
                // Application Layer
                loginCommand = component "Login Command" "Login command handler" "Application Layer"
                registerUserCommand = component "Register User Command" "User registration command handler" "Application Layer"
                changePasswordCommand = component "Change Password Command" "Password change command handler" "Application Layer"
                
                userCommandService = component "User Command Service" "User write operations service" "Application Layer"
                userQueryService = component "User Query Service" "User read operations service" "Application Layer"
                authQueryService = component "Auth Query Service" "Authentication queries service" "Application Layer"
                
                // Infrastructure Layer
                userRepository = component "User Repository" "User data persistence" "Infrastructure Layer"
                roleRepository = component "Role Repository" "Role data persistence" "Infrastructure Layer"
                tokenRepository = component "Token Repository" "Token data persistence" "Infrastructure Layer"
                
                // Domain Layer
                userAggregate = component "User Aggregate" "User domain aggregate" "Domain Layer"
                roleEntity = component "Role Entity" "Role domain entity" "Domain Layer"
                tokenEntity = component "Token Entity" "Token domain entity" "Domain Layer"
            }
        }

        // External relationships
        frontendApp -> authController "HTTP authentication requests"
        frontendApp -> userController "HTTP user requests"
        mobileApp -> authController "HTTP authentication requests"
        mobileApp -> userController "HTTP user requests"
        
        // Interface to Application Layer
        authController -> loginCommand "Delegates login operations"
        authController -> authQueryService "Gets authentication data"
        userController -> registerUserCommand "Delegates user registration"
        userController -> changePasswordCommand "Delegates password changes"
        userController -> userCommandService "Delegates user write operations"
        userController -> userQueryService "Gets user data"
        
        // Application to Infrastructure Layer
        loginCommand -> userRepository "Validates user credentials"
        registerUserCommand -> userRepository "Persists new users"
        changePasswordCommand -> userRepository "Updates user password"
        userCommandService -> userRepository "User write operations"
        userQueryService -> userRepository "User read operations"
        authQueryService -> tokenRepository "Token operations"
        
        // Application to Domain Layer
        loginCommand -> userAggregate "User domain logic"
        registerUserCommand -> userAggregate "User creation logic"
        userCommandService -> userAggregate "User business rules"
        userQueryService -> roleEntity "Role information"
        authQueryService -> tokenEntity "Token validation"
        
        // Infrastructure to Database
        userRepository -> database "Reads/writes users"
        roleRepository -> database "Reads/writes roles"
        tokenRepository -> database "Reads/writes tokens"
    }

    views {
        component springBootApp "SpringBootIAMComponents" {
            title "Identity & Access Management - Backend Layers Architecture"
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
            element "Domain Layer" {
                background #fd7e14
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