package com.emse.spring.parking_proj.model;

import jakarta.persistence.*;

@Entity // Marks this class as a JPA Entity, mapping it to a database table.
@Table(name = "VEHICLE") // Specifies the table name in the database.
public class Vehicle {

    @Id // Marks the field as the primary key of the table.
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-incrementing for the primary key.
    @Column(name = "ID") // Maps this field to the "ID" column in the database table.
    private Long id;

    @Column(name = "MAKE", nullable = false, length = 50) // Maps this field to the "MAKE" column in the table.
    private String make;

    @Column(name = "MODEL", nullable = false, length = 50) // Maps this field to the "MODEL" column in the table.
    private String model;

    // Getters and Setters to access and modify the fields.

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