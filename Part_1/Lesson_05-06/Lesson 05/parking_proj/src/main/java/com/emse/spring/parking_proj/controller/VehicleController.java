package com.emse.spring.parking_proj.controller;

import com.emse.spring.parking_proj.model.Vehicle;
import com.emse.spring.parking_proj.service.VehicleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST controller for managing vehicles.
 * Provides endpoints for retrieving, adding, and deleting vehicles.
 */
@RestController
@RequestMapping("/vehicles")
public class VehicleController {

    private static final Logger LOGGER = LoggerFactory.getLogger(VehicleController.class); // Corrigido para maiúsculas
    private final VehicleService vehicleService;

    /**
     * Constructor for {@link VehicleController}.
     *
     * @param vehicleService the service handling vehicle operations.
     */
    public VehicleController(final VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }

    /**
     * Retrieves all vehicles.
     *
     * @return a list of all {@link Vehicle} objects.
     */
    @GetMapping
    public List<Vehicle> getAllVehicles() {
        LOGGER.info("Request received to retrieve all vehicles."); // INFO log
        try {
            List<Vehicle> vehicles = vehicleService.getAllVehicles();
            LOGGER.debug("Retrieved {} vehicles from the database.", vehicles.size()); // DEBUG log
            return vehicles;
        } catch (Exception e) {
            LOGGER.error("Error occurred while retrieving vehicles.", e); // ERROR log
            throw e;
        }
    }

    /**
     * Adds a new vehicle.
     *
     * @param vehicle the vehicle to be added.
     * @return the created {@link Vehicle}.
     */
    @PostMapping
    public Vehicle addVehicle(@RequestBody final Vehicle vehicle) {
        LOGGER.info("Request received to add a new vehicle: {}", vehicle); // INFO log
        try {
            Vehicle createdVehicle = vehicleService.addVehicle(vehicle);
            LOGGER.debug("Vehicle added successfully: {}", createdVehicle); // DEBUG log
            return createdVehicle;
        } catch (Exception e) {
            LOGGER.error("Error occurred while adding a new vehicle: {}", vehicle, e); // ERROR log
            throw e;
        }
    }

    /**
     * Deletes a vehicle by its ID.
     *
     * @param vehicleId the ID of the vehicle to delete.
     * @return a {@link ResponseEntity} indicating the operation's success.
     */
    @DeleteMapping("/{vehicleId}")
    public ResponseEntity<Void> deleteVehicle(@PathVariable final Long vehicleId) {
        LOGGER.info("Request received to delete vehicle with ID: {}", vehicleId); // INFO log
        try {
            vehicleService.deleteVehicle(vehicleId);
            LOGGER.debug("Vehicle with ID {} deleted successfully.", vehicleId); // DEBUG log
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            LOGGER.error("Error occurred while deleting vehicle with ID: {}", vehicleId, e); // ERROR log
            throw e;
        }
    }
}