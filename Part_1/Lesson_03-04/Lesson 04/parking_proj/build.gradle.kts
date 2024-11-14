// Apply the necessary plugins for Java, Spring Boot, and dependency management
plugins {
    java
    id("org.springframework.boot") version "3.3.5" // Spring Boot plugin for creating a standalone, production-grade application
    id("io.spring.dependency-management") version "1.1.6" // Manages dependencies and ensures compatible versions
}

// Project metadata, defining the group and version
group = "com.emse.spring" // Group ID for the project, used for dependency resolution and unique identification
version = "0.0.1-SNAPSHOT" // Initial version of the project, in SNAPSHOT for active development

// Set the Java toolchain to ensure compatibility with Java 21
java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21) // Specifies Java 21 for project compatibility
    }
}

// Define repositories for dependencies
repositories {
    mavenCentral() // Central repository to pull libraries and dependencies
}

// Define project dependencies
dependencies {
    implementation("org.springframework.boot:spring-boot-starter") // Core Spring Boot dependency
    testImplementation("org.springframework.boot:spring-boot-starter-test") // Spring Boot testing support
    testRuntimeOnly("org.junit.platform:junit-platform-launcher") // JUnit platform launcher for testing
}

// Configure test tasks to use JUnit Platform
tasks.withType<Test> {
    useJUnitPlatform() // Enables JUnit 5 support for unit testing
}

// Custom task to increment the project version automatically
tasks.register("incrementVersion") {
    doLast {
        // Retrieve the current project version and split it into parts
        val currentVersion = project.version.toString()
        val parts = currentVersion.split(".")

        // Convert and increment the patch number
        val patch = parts[2].toInt() + 1

        // Update the project version with the incremented patch number
        project.version = "${parts[0]}.${parts[1]}.$patch"
        println("Version updated to: ${project.version}")
    }
}

// Custom task to package the project into a JAR file
tasks.named<org.springframework.boot.gradle.tasks.bundling.BootJar>("bootJar") {
    enabled = true // Enable JAR creation for Spring Boot applications
    archiveFileName.set("parking-app.jar") // Set the name of the output JAR file
}