package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

/**
 * Utility class to reset users in the database
 * Run this class to remove all existing users and create new ones
 */
public class ResetUsers {
    
    public static void main(String[] args) {
        // Create the user service
        UserService userService = new UserService();
        
        // First, delete all existing users
        boolean deleted = deleteAllUsers();
        
        if (!deleted) {
            System.out.println("Failed to delete existing users. Aborting.");
            return;
        }
        
        System.out.println("All existing users deleted successfully.");
        
        // Create admin user
        User adminUser = new User();
        adminUser.setUsername("admin");
        adminUser.setPassword("admin123"); // This will be hashed by the UserService
        adminUser.setEmail("admin@foodexpress.com");
        adminUser.setFullName("Admin User");
        adminUser.setPhone("123-456-7890");
        adminUser.setAddress("123 Admin St, Admin City");
        adminUser.setRole("ADMIN");
        
        boolean adminCreated = userService.createUser(adminUser);
        if (adminCreated) {
            System.out.println("Admin user created successfully.");
        } else {
            System.out.println("Failed to create admin user.");
        }
        
        // Create customer user
        User customerUser = new User();
        customerUser.setUsername("customer");
        customerUser.setPassword("customer123"); // This will be hashed by the UserService
        customerUser.setEmail("customer@example.com");
        customerUser.setFullName("Sample Customer");
        customerUser.setPhone("987-654-3210");
        customerUser.setAddress("456 Customer Ave, Customer City");
        customerUser.setRole("CUSTOMER");
        
        boolean customerCreated = userService.createUser(customerUser);
        if (customerCreated) {
            System.out.println("Customer user created successfully.");
        } else {
            System.out.println("Failed to create customer user.");
        }
        
        // Create delivery user
        User deliveryUser = new User();
        deliveryUser.setUsername("delivery");
        deliveryUser.setPassword("delivery123"); // This will be hashed by the UserService
        deliveryUser.setEmail("delivery@example.com");
        deliveryUser.setFullName("Delivery Person");
        deliveryUser.setPhone("555-123-4567");
        deliveryUser.setAddress("789 Delivery Blvd, Delivery City");
        deliveryUser.setRole("DELIVERY");
        
        boolean deliveryCreated = userService.createUser(deliveryUser);
        if (deliveryCreated) {
            System.out.println("Delivery user created successfully.");
        } else {
            System.out.println("Failed to create delivery user.");
        }
        
        // Verify users were created
        List<User> users = userService.getAllUsers();
        System.out.println("\nUsers in the database:");
        for (User user : users) {
            System.out.println("- " + user.getUsername() + " (" + user.getRole() + ")");
        }
    }
    
    /**
     * Delete all users from the database
     * @return true if successful, false otherwise
     */
    private static boolean deleteAllUsers() {
        try (Connection conn = DBUtil.getConnection()) {
            // Disable foreign key checks
            try (PreparedStatement stmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 0")) {
                stmt.executeUpdate();
            }
            
            // Delete all users
            try (PreparedStatement stmt = conn.prepareStatement("TRUNCATE TABLE users")) {
                stmt.executeUpdate();
            }
            
            // Re-enable foreign key checks
            try (PreparedStatement stmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 1")) {
                stmt.executeUpdate();
            }
            
            return true;
        } catch (SQLException e) {
            System.err.println("Error deleting users: " + e.getMessage());
            return false;
        }
    }
}
