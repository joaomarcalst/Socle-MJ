package com.emse.spring.parking_proj.repository;

import com.emse.spring.parking_proj.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
}