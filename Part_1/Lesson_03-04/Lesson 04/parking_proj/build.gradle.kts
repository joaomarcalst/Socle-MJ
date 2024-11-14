plugins {
    java
    id("org.springframework.boot") version "3.3.5"
    id("io.spring.dependency-management") version "1.1.6"
}

group = "com.emse.spring"
version = "0.0.1-SNAPSHOT"

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.register("incrementVersion") {
    doLast {
        // Dividing the CurrentVersion to make increments, after
        val currentVersion = project.version.toString()
        val parts = currentVersion.split(".")

        // Converting and adding numbers (increment)
        val patch = parts[2].toInt() + 1

        // Definition of a new Version
        project.version = "${parts[0]}.${parts[1]}.$patch"
        println("Version updated to: ${project.version}")
    }
}