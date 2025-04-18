package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

/**
 * Utility class to check if admin user exists and has correct role
 */
public class CheckAdminUser {
    
    public static void main(String[] args) {
        // Create the user service
        UserService userService = new UserService();
        
        // Check if admin user exists
        User adminUser = userService.getUserByUsername("admin");
        
        if (adminUser == null) {
            System.out.println("ERROR: Admin user does not exist!");
            System.out.println("Creating admin user...");
            
            // Create admin user
            User newAdmin = new User();
            newAdmin.setUsername("admin");
            newAdmin.setPassword("admin123");
            newAdmin.setEmail("admin@foodexpress.com");
            newAdmin.setFullName("Admin User");
            newAdmin.setPhone("123-456-7890");
            newAdmin.setAddress("123 Admin St, Admin City");
            newAdmin.setRole("ADMIN");
            
            boolean created = userService.createUser(newAdmin);
            if (created) {
                System.out.println("Admin user created successfully.");
                adminUser = userService.getUserByUsername("admin");
            } else {
                System.out.println("Failed to create admin user!");
                return;
            }
        }
        
        // Print admin user details
        System.out.println("Admin User Details:");
        System.out.println("ID: " + adminUser.getId());
        System.out.println("Username: " + adminUser.getUsername());
        System.out.println("Email: " + adminUser.getEmail());
        System.out.println("Role: " + adminUser.getRole());
        System.out.println("Is Active: " + adminUser.isActive());
        
        // Check if role is correct
        if (!"ADMIN".equals(adminUser.getRole())) {
            System.out.println("ERROR: Admin user does not have ADMIN role!");
            System.out.println("Updating role to ADMIN...");
            
            adminUser.setRole("ADMIN");
            boolean updated = userService.updateUser(adminUser);
            
            if (updated) {
                System.out.println("Admin role updated successfully.");
            } else {
                System.out.println("Failed to update admin role!");
            }
        } else {
            System.out.println("Admin role is correct.");
        }
        
        // Print login instructions
        System.out.println("\n=== ADMIN LOGIN INFORMATION ===");
        System.out.println("Username: admin");
        System.out.println("Password: admin123");
        System.out.println("==============================");
    }
}
