const API_URL = 'http://localhost:8080/vehicles';
const form = document.getElementById('add-vehicle-form');
const vehicleList = document.getElementById('vehicles');

// Show loading message
const loadingMessage = document.createElement('p');
loadingMessage.textContent = 'Loading vehicles...';
vehicleList.appendChild(loadingMessage);

// Fetch and display all vehicles on page load
fetch(API_URL)
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to fetch vehicles');
        }
        return response.json();
    })
    .then(vehicles => {
        vehicleList.removeChild(loadingMessage);
        vehicles.forEach(vehicle => {
            const li = document.createElement('li');
            li.textContent = `${vehicle.make} ${vehicle.model}`;
            vehicleList.appendChild(li);
        });
    })
    .catch(error => {
        vehicleList.removeChild(loadingMessage);
        const errorMessage = document.createElement('p');
        errorMessage.textContent = 'Error loading vehicles';
        vehicleList.appendChild(errorMessage);
        console.error('Error fetching vehicles:', error);
    });

// Handle form submission to add a new vehicle
form.addEventListener('submit', event => {
    event.preventDefault();

    const make = document.getElementById('make').value;
    const model = document.getElementById('model').value;

    fetch(API_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ make, model }),
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to add vehicle');
            }
            return response.json();
        })
        .then(vehicle => {
            const li = document.createElement('li');
            li.textContent = `${vehicle.make} ${vehicle.model}`;
            vehicleList.appendChild(li);

            form.reset();
        })
        .catch(error => {
            console.error('Error adding vehicle:', error);
        });
});