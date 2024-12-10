package com.emse.spring.parking_proj.service;

import com.emse.spring.parking_proj.model.Vehicle;
import com.emse.spring.parking_proj.repository.VehicleRepository;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service class for handling vehicle operations.
 */
@Service
public class VehicleService {
    private final VehicleRepository vehicleRepository;

    /**
     * Constructor for {@link VehicleService}.
     *
     * @param vehicleRepository the repository for vehicle data.
     */
    public VehicleService(final VehicleRepository vehicleRepository) {
        this.vehicleRepository = vehicleRepository;
    }

    /**
     * Retrieves all vehicles.
     *
     * @return a list of all {@link Vehicle} objects.
     */
    public List<Vehicle> getAllVehicles() {
        return vehicleRepository.findAll();
    }

    /**
     * Adds a new vehicle.
     *
     * @param vehicle the vehicle to add.
     * @return the saved {@link Vehicle}.
     */
    public Vehicle addVehicle(final Vehicle vehicle) {
        return vehicleRepository.save(vehicle);
    }

    /**
     * Deletes a vehicle by its ID.
     *
     * @param vehicleId the ID of the vehicle to delete.
     */
    public void deleteVehicle(final Long vehicleId) {
        vehicleRepository.deleteById(vehicleId);
    }
}