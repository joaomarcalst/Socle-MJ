Aqui está a versão atualizada e aprimorada do seu README com todas as melhorias necessárias:

Parking Project

This project simulates the operation and performance of electric buses in a parking lot scenario. The primary goal is to utilize Gradle for automating development tasks, such as dependency management, project versioning, compilation, and packaging.

Prerequisites

Before running the project, ensure that the following tools are installed on your machine:
	•	Java 21: Required for running the application. Verify your installed version with:

java -version


	•	Gradle: Used for building and managing the project. Check if Gradle is installed with:

gradle -v



Installation
	1.	Clone the repository:

git clone https://github.com/joaomarcalst/Parking-MJ.git
cd Parking-MJ


	2.	Build the project:
Install dependencies and prepare the project by running:

./gradlew build



Running the Project

You can run the project in two ways:
	1.	Directly using Gradle:

./gradlew bootRun


	2.	Using the packaged JAR file:
After building the project, you can run the JAR file:

java -jar build/libs/parking-app.jar



Features
	•	REST API: The project provides an API for managing vehicles in the parking lot. Key endpoints include:
	•	GET /vehicles: List all vehicles.
	•	POST /vehicles: Add a new vehicle.
	•	DELETE /vehicles/{id}: Remove a vehicle by ID.
	•	Gradle Automation: Gradle handles tasks such as dependency management, compilation, and project versioning.
	•	Custom Gradle Tasks: A custom task for incrementing the project version:

./gradlew incrementVersion



Running Tests

To execute the test suite and verify the project’s functionality, run:

./gradlew test

Test reports can be found in the build/reports/tests directory.

Documentation
	•	Javadoc: The project includes detailed documentation for all classes and methods. To generate the documentation:

./gradlew javadoc

The generated files can be found in build/docs/javadoc.

	•	Tutorial: A complete tutorial is available in the tutorial file for learning how to use the project effectively.

Project Structure
	•	src/main: Contains the source code for the application.
	•	src/test: Contains the test cases.
	•	build.gradle.kts: The Gradle configuration file.
	•	docs: Includes tutorials and reference documentation.

Build Tool

This project uses Gradle for automation:
	•	Dependency management
	•	Compilation and packaging
	•	Version control
	•	Test execution

For more details about Gradle, visit the official Gradle website.

Contribution

We welcome contributions to improve the project! Here’s how you can help:
	1.	Fork the repository.
	2.	Create a new branch for your feature or bug fix:

git checkout -b feature/your-feature


	3.	Commit your changes and push to your fork:

git push origin feature/your-feature


	4.	Open a pull request on GitHub.

Make sure your changes are covered with tests and documented properly.

License

This project is licensed under the MIT License. See the LICENSE file for details.

Release

You can find the latest release of the project here.

Se precisar de mais alguma modificação ou quiser algo mais específico, é só avisar!