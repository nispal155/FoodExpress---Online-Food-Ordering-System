package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

/**
 * Utility class to debug authentication issues
 */
public class AuthenticationDebugger {
    
    public static void main(String[] args) {
        System.out.println("=== AUTHENTICATION DEBUGGER ===");
        
        // Create the user service
        UserService userService = new UserService();
        
        // Test authentication with admin credentials
        System.out.println("\n=== TESTING ADMIN AUTHENTICATION ===");
        User adminUser = userService.authenticateUser("admin", "admin123");
        
        if (adminUser != null) {
            System.out.println("Admin authentication successful!");
            System.out.println("User ID: " + adminUser.getId());
            System.out.println("Username: " + adminUser.getUsername());
            System.out.println("Email: " + adminUser.getEmail());
            System.out.println("Role: " + adminUser.getRole());
            System.out.println("Is Active: " + adminUser.isActive());
        } else {
            System.out.println("Admin authentication failed!");
            
            // Check if admin user exists
            User existingAdmin = userService.getUserByUsername("admin");
            
            if (existingAdmin != null) {
                System.out.println("\nAdmin user exists but authentication failed!");
                System.out.println("User ID: " + existingAdmin.getId());
                System.out.println("Username: " + existingAdmin.getUsername());
                System.out.println("Email: " + existingAdmin.getEmail());
                System.out.println("Role: " + existingAdmin.getRole());
                System.out.println("Is Active: " + existingAdmin.isActive());
                
                // Reset admin password
                System.out.println("\nResetting admin password...");
                existingAdmin.setPassword("admin123");
                boolean updated = userService.updateUser(existingAdmin);
                
                if (updated) {
                    System.out.println("Admin password reset successfully!");
                    
                    // Try authentication again
                    System.out.println("\nTrying authentication again...");
                    adminUser = userService.authenticateUser("admin", "admin123");
                    
                    if (adminUser != null) {
                        System.out.println("Admin authentication successful after password reset!");
                        System.out.println("User ID: " + adminUser.getId());
                        System.out.println("Username: " + adminUser.getUsername());
                        System.out.println("Email: " + adminUser.getEmail());
                        System.out.println("Role: " + adminUser.getRole());
                        System.out.println("Is Active: " + adminUser.isActive());
                    } else {
                        System.out.println("Admin authentication still failed after password reset!");
                    }
                } else {
                    System.out.println("Failed to reset admin password!");
                }
            } else {
                System.out.println("\nAdmin user does not exist!");
                
                // Create admin user
                System.out.println("Creating admin user...");
                User newAdmin = new User();
                newAdmin.setUsername("admin");
                newAdmin.setPassword("admin123");
                newAdmin.setEmail("admin@foodexpress.com");
                newAdmin.setFullName("Admin User");
                newAdmin.setPhone("123-456-7890");
                newAdmin.setAddress("123 Admin St, Admin City");
                newAdmin.setRole("ADMIN");
                newAdmin.setActive(true);
                
                boolean created = userService.createUser(newAdmin);
                
                if (created) {
                    System.out.println("Admin user created successfully!");
                    
                    // Try authentication again
                    System.out.println("\nTrying authentication again...");
                    adminUser = userService.authenticateUser("admin", "admin123");
                    
                    if (adminUser != null) {
                        System.out.println("Admin authentication successful after user creation!");
                        System.out.println("User ID: " + adminUser.getId());
                        System.out.println("Username: " + adminUser.getUsername());
                        System.out.println("Email: " + adminUser.getEmail());
                        System.out.println("Role: " + adminUser.getRole());
                        System.out.println("Is Active: " + adminUser.isActive());
                    } else {
                        System.out.println("Admin authentication still failed after user creation!");
                    }
                } else {
                    System.out.println("Failed to create admin user!");
                }
            }
        }
        
        // Check user with ID 7
        System.out.println("\n=== CHECKING USER WITH ID 7 ===");
        User user7 = userService.getUserById(7);
        
        if (user7 != null) {
            System.out.println("User with ID 7 found!");
            System.out.println("Username: " + user7.getUsername());
            System.out.println("Email: " + user7.getEmail());
            System.out.println("Role: " + user7.getRole());
            System.out.println("Is Active: " + user7.isActive());
            
            // Fix user 7 if needed
            if (!"ADMIN".equals(user7.getRole()) || !user7.isActive()) {
                System.out.println("\nUser with ID 7 needs fixing!");
                
                user7.setRole("ADMIN");
                user7.setActive(true);
                
                boolean updated = userService.updateUser(user7);
                
                if (updated) {
                    System.out.println("User with ID 7 fixed successfully!");
                } else {
                    System.out.println("Failed to fix user with ID 7!");
                }
            } else {
                System.out.println("\nUser with ID 7 is already an active admin!");
            }
        } else {
            System.out.println("User with ID 7 not found!");
        }
    }
}
