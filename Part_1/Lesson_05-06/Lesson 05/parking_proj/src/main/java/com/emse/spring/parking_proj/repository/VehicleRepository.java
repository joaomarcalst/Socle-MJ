package com.emse.spring.parking_proj.repository;

import com.emse.spring.parking_proj.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for accessing vehicle data.
 * Extends {@link JpaRepository} to provide CRUD operations for {@link Vehicle}.
 */
@Repository
public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
}