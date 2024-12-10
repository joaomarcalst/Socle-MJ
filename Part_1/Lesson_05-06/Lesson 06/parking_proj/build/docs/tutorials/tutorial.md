# Parking Project - Tutorial

This tutorial provides step-by-step instructions for setting up and using the Parking Project, a simulation of electric buses in a parking lot.

---

## Prerequisites

Ensure you have the following installed:
- **Java 21**
- **Gradle**

### To verify the installations:
```bash
java -version
gradle -v 
```

### Setting Up the Project

#### Clone the Repository

Run the following commands:

`git clone https://github.com/yourusername/Parking-MJ.git`

`cd Parking-MJ`

#### Build the Project

Install the dependencies and build the project:

`./gradlew build`

#### Running the Application

You can run the project in two ways:

**Option 1: Directly with Gradle**

Use the following command:

`./gradlew bootRun`

**Option 2: Using the Packaged JAR**

Package the project into a JAR file:

`./gradlew bootJar`

Run the JAR file:

`java -jar build/libs/parking-app.jar`

### Using the REST API

The Parking Project provides a REST API to manage vehicles. Below are examples for interacting with the API using curl:

List All Vehicles
	•	Endpoint: GET /vehicles
	•	Example Command:

`curl -X GET http://localhost:8080/vehicles`

#### Add a New Vehicle
- Endpoint: POST /vehicles
- mple Command:
```bash
curl -X POST http://localhost:8080/vehicles \
-H "Content-Type: application/json" \
-d '{"id": 1, "licensePlate": "XYZ-7890", "type": "Bus"}'
```

#### Delete a Vehicle
- Endpoint: DELETE /vehicles/{id}
- Example Command:

`curl -X DELETE http://localhost:8080/vehicles/1`

#### Running Tests

To ensure everything is functioning as expected, run the following command:

`./gradlew test`

### Generating API Documentation

The project supports Javadoc for API reference. To generate the documentation:

`./gradlew javadoc`

The documentation will be generated in the build/docs/javadoc directory.

### Troubleshooting

#### Common Issues and Fixes
- Gradle Version Issues:

Run:

`gradle --version`

Ensure you are using a compatible version.

#### Dependency Issues:
Update dependencies with:

`./gradlew dependencies`

Feel free to contribute or suggest improvements to the tutorial or the project.

---