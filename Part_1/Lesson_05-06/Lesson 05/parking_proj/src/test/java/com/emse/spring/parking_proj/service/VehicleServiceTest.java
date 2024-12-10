package com.emse.spring.parking_proj.service;

import com.emse.spring.parking_proj.model.Vehicle;
import com.emse.spring.parking_proj.repository.VehicleRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class VehicleServiceTest {

    private VehicleRepository vehicleRepository;
    private VehicleService vehicleService;

    @BeforeEach
    void setUp() {
        vehicleRepository = mock(VehicleRepository.class); // Mock do repositório
        vehicleService = new VehicleService(vehicleRepository); // Injeta o mock no serviço
    }

    @Test
    void testGetAllVehicles() {
        // Arrange
        List<Vehicle> vehicles = new ArrayList<>();
        vehicles.add(new Vehicle(1L, "Car", "Sedan"));
        vehicles.add(new Vehicle(2L, "Truck", "Pickup"));

        when(vehicleRepository.findAll()).thenReturn(vehicles);

        // Act
        List<Vehicle> result = vehicleService.getAllVehicles();

        // Assert
        assertNotNull(result);
        assertEquals(2, result.size());
        verify(vehicleRepository, times(1)).findAll();
    }

    @Test
    void testAddVehicle() {
        // Arrange
        Vehicle vehicle = new Vehicle(1L, "Car", "Sedan");
        when(vehicleRepository.save(vehicle)).thenReturn(vehicle);

        // Act
        Vehicle addedVehicle = vehicleService.addVehicle(vehicle);

        // Assert
        assertNotNull(addedVehicle);
        assertEquals(vehicle, addedVehicle);
        verify(vehicleRepository, times(1)).save(vehicle);
    }

    @Test
    void testDeleteVehicle_Success() {
        // Arrange
        Long vehicleId = 1L;
        when(vehicleRepository.existsById(vehicleId)).thenReturn(true);

        // Act & Assert
        assertDoesNotThrow(() -> vehicleService.deleteVehicle(vehicleId));
        verify(vehicleRepository, times(1)).deleteById(vehicleId);
    }

    @Test
    void testDeleteVehicle_NotFound() {
        // Arrange
        Long vehicleId = 999L;
        when(vehicleRepository.existsById(vehicleId)).thenReturn(false);

        // Act & Assert
        Exception exception = assertThrows(IllegalArgumentException.class, () -> vehicleService.deleteVehicle(vehicleId));
        assertEquals("Vehicle with ID 999 not found.", exception.getMessage());
        verify(vehicleRepository, never()).deleteById(vehicleId);
    }
}