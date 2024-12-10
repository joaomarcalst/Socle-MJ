package com.emse.spring.parking_proj.model;

import jakarta.persistence.*;

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
    private Long id;

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

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "id=" + id +
                ", make='" + make + '\'' +
                ", model='" + model + '\'' +
                '}';
    }
}