package com.emse.spring.parking_proj.controller;

import com.emse.spring.parking_proj.model.Vehicle;
import com.emse.spring.parking_proj.service.VehicleService;
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
    private final VehicleService vehicleService;

    /**
     * Constructor for {@link VehicleController}.
     *
     * @param vehicleService the service handling vehicle operations.
     */
    public VehicleController(VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }

    /**
     * Retrieves all vehicles.
     *
     * @return a list of all {@link Vehicle} objects.
     */
    @GetMapping
    public List<Vehicle> getAllVehicles() {
        return vehicleService.getAllVehicles();
    }

    /**
     * Adds a new vehicle.
     *
     * @param vehicle the vehicle to be added.
     * @return the created {@link Vehicle}.
     */
    @PostMapping
    public Vehicle addVehicle(@RequestBody Vehicle vehicle) {
        return vehicleService.addVehicle(vehicle);
    }

    /**
     * Deletes a vehicle by its ID.
     *
     * @param id the ID of the vehicle to delete.
     * @return a {@link ResponseEntity} indicating the operation's success.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVehicle(@PathVariable Long id) {
        vehicleService.deleteVehicle(id);
        return ResponseEntity.noContent().build();
    }
}