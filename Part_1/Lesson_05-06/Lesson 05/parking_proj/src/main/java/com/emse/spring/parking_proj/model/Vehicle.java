package com.emse.spring.parking_proj.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * Entity representing a vehicle.
 * Maps to the "VEHICLE" table in the database.
 */
@Entity
@Table(name = "VEHICLE")
public class Vehicle {

    /**
     * The unique identifier for the vehicle.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long vehicleId;

    /**
     * The make of the vehicle (e.g., brand).
     */
    @Column(name = "MAKE", nullable = false, length = 50)
    private String make;

    /**
     * The model of the vehicle.
     */
    @Column(name = "MODEL", nullable = false, length = 50)
    private String model;

    /**
     * Default constructor.
     */
    public Vehicle() {
    }

    /**
     * Parameterized constructor.
     *
     * @param vehicleId the unique ID of the vehicle.
     * @param make the make of the vehicle.
     * @param model the model of the vehicle.
     */
    public Vehicle(Long vehicleId, String make, String model) {
        this.vehicleId = vehicleId;
        this.make = make;
        this.model = model;
    }

    public Long getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(final Long vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getMake() {
        return make;
    }

    public void setMake(final String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(final String model) {
        this.model = model;
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "vehicleId=" + vehicleId +
                ", make='" + make + '\'' +
                ", model='" + model + '\'' +
                '}';
    }
}