package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

/**
 * Utility class to create only an admin user
 * Run this class to create an admin user without affecting other users
 */
public class CreateAdminOnly {
    
    public static void main(String[] args) {
        // Create the user service
        UserService userService = new UserService();
        
        // Check if admin user already exists
        User existingAdmin = userService.getUserByUsername("admin");
        
        if (existingAdmin != null) {
            System.out.println("Admin user already exists. Updating password...");
            existingAdmin.setPassword("admin123");
            boolean updated = userService.updateUser(existingAdmin);
            if (updated) {
                System.out.println("Admin user password updated successfully.");
            } else {
                System.out.println("Failed to update admin user password.");
            }
        } else {
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
        }
        
        // Print admin login information
        System.out.println("\n=== ADMIN LOGIN INFORMATION ===");
        System.out.println("Username: admin");
        System.out.println("Password: admin123");
        System.out.println("==============================");
    }
}
