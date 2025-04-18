package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

/**
 * Utility class to create an admin user
 * Run this class to create an admin user in the database
 */
public class CreateAdminUser {
    
    public static void main(String[] args) {
        // Create a new admin user
        User adminUser = new User();
        adminUser.setUsername("admin");
        adminUser.setPassword("admin123"); // This will be hashed by the UserService
        adminUser.setEmail("admin@foodexpress.com");
        adminUser.setFullName("Admin User");
        adminUser.setPhone("123-456-7890");
        adminUser.setAddress("123 Admin St, Admin City");
        adminUser.setRole("ADMIN");
        
        // Create the user service
        UserService userService = new UserService();
        
        // Check if the admin user already exists
        User existingUser = userService.getUserByUsername("admin");
        
        if (existingUser != null) {
            System.out.println("Admin user already exists. Updating password...");
            existingUser.setPassword("admin123");
            boolean updated = userService.updateUser(existingUser);
            if (updated) {
                System.out.println("Admin user password updated successfully.");
            } else {
                System.out.println("Failed to update admin user password.");
            }
        } else {
            System.out.println("Creating new admin user...");
            boolean created = userService.createUser(adminUser);
            if (created) {
                System.out.println("Admin user created successfully.");
            } else {
                System.out.println("Failed to create admin user.");
            }
        }
    }
}
