# Parking Project

This project simulates the operation and performance of electric buses in a parking lot scenario. It leverages **Gradle** to automate development tasks such as dependency management, project versioning, compilation, and packaging.

---

### Prerequisites

Before running the project, ensure the following tools are installed on your machine:

- **Java 21**: Required to run the application. Verify your installation with:
  `java -version`

- **Gradle**: Used for building and managing the project. Check the installation with:
  `gradle -v`

---

### Installation

1. Clone the repository and navigate to the project directory:
   `git clone https://github.com/joaomarcalst/Parking-MJ.git`
   `cd Parking-MJ`

2. Navigate to the folder located at:
   `/Part_1/Lesson_05-06/Lesson_06`

3. Build the project by installing dependencies and preparing it for execution:
   `./gradlew build`

---

### Running the Project

You can run the project in two ways:

1. **Directly using Gradle**:
   `./gradlew bootRun`

2. **Using the packaged JAR file**:
   After building the project, execute the following command:
   `java -jar build/libs/parking-app.jar`

---

### Features

- **REST API**: The project provides endpoints for managing vehicles in the parking lot:
  - `GET /vehicles`: List all vehicles.
  - `POST /vehicles`: Add a new vehicle.
  - `DELETE /vehicles/{id}`: Remove a vehicle by its ID.

- **Gradle Automation**: Manages tasks such as dependency handling, compilation, and version control.

- **Custom Gradle Task**: A custom task is available for incrementing the project version:
  `./gradlew incrementVersion`

---

### Running Tests

To execute the test suite and verify the project’s functionality, run:
`./gradlew test`

Test reports are generated in the `build/reports/tests` directory.

---

### Documentation

- **Javadoc**: Detailed documentation for all classes and methods can be generated with:
  `./gradlew javadoc`
  The output will be located in the `build/docs/javadoc` directory.

- **Tutorial**: Refer to the `docs/tutorial.md` file for a complete guide to using the project.

---

### Project Structure

- `src/main`: Application source code.
- `src/test`: Unit tests for the project.
- `build.gradle.kts`: Gradle configuration file.
- `docs`: Contains tutorials and reference documentation.

---

### Build Tool

This project uses **Gradle** for:
- Dependency management
- Compilation and packaging
- Version control
- Test execution

For more details, visit the [Gradle official website](https://gradle.org/).

---

### Contribution

We welcome contributions! Follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   `git checkout -b feature/your-feature`

3. Commit your changes and push them to your fork:
   `git push origin feature/your-feature`

4. Open a pull request on GitHub.

Ensure your changes include tests and proper documentation.

---

## Generating Reference Documentation

This project includes comprehensive Javadoc documentation for all classes and methods. You can generate the reference documentation by following these steps:

1. Open a terminal and navigate to the root directory of the project.
2. Run the following Gradle command to generate the Javadoc:
   ```bash
   ./gradlew javadoc
3.	The generated documentation will be located in the `build/docs/javadoc` directory.
4.	Open the `index.html file in a web browser to view the documentation.

This documentation provides detailed information about the project structure, classes, methods, and their functionality.

---

### License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

---

### Release

Find the latest release of the project [here](https://github.com/joaomarcalst/Parking-MJ/releases).
