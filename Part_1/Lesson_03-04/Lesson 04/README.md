# Parking Project

This is a project focused on simulating the performance and operation of electric buses in a parking lot scenario. The goal is to use a build tool (Gradle) to automate the development tasks, such as dependency management, project versioning, compilation, and packaging.

## Prerequisites

Ensure that you have the following installed on your machine:

- **Java 21**: For running the application. You can check your installed version with the command:
  ```bash
  java -version
  ```

- **Gradle**: For building and managing the project dependencies. You can check if Gradle is installed with:
  ```bash
  gradle -v
  ```

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/joaomarcalst/Parking-MJ.git
    cd Parking-MJ
    ```

2. Install the project dependencies with Gradle:

    ```bash
    gradle build
    ```

## Running the Project

To run the project, use the following command:

```bash
gradle bootRun
```

Alternatively, you can run the application with the JAR file after building it:

```bash
java -jar build/libs/parking-app.jar
```

## Tasks Automated with Gradle

This project uses Gradle to automate the following tasks:

- **Dependency Management**: External dependencies are defined in `build.gradle.kts` and are automatically downloaded and managed by Gradle.
  
- **Compilation**: The Java code is compiled automatically by Gradle as part of the build process.

- **Project Version Management**: The version of the project is managed by Gradle. You can increment the version using a custom task:

    ```bash
    gradle incrementVersion
    ```

- **Packaging**: The project is packaged into a JAR file using Gradle's `bootJar` task. The JAR file can be found in the `build/libs` directory.

## Running Tests

To run the project tests, use the command:

  ```bash
  gradle test
  ```

## Build Tool

This project uses **Gradle** as the build tool. Gradle automates the following tasks:

- Dependency management
- Compilation of source files
- Version management
- Packaging into JAR files

For more information on Gradle, visit the [official Gradle website](https://gradle.org).

## Contribution

Feel free to fork the project and submit pull requests for improvements. Make sure to follow the guidelines and best practices while contributing.
