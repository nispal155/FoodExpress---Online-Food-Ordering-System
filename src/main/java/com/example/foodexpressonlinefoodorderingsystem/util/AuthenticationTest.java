package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

/**
 * Utility class to test authentication
 */
public class AuthenticationTest {
    
    public static void main(String[] args) {
        testAuthentication();
    }
    
    /**
     * Test authentication with BCrypt
     */
    private static void testAuthentication() {
        System.out.println("Testing authentication...");
        
        UserService userService = new UserService();
        
        // Test admin authentication
        System.out.println("\nTesting admin authentication:");
        testUser(userService, "admin", "admin123", "ADMIN");
        
        // Test customer authentication
        System.out.println("\nTesting customer authentication:");
        testUser(userService, "customer", "customer123", "CUSTOMER");
        
        // Test delivery authentication
        System.out.println("\nTesting delivery authentication:");
        testUser(userService, "delivery", "delivery123", "DELIVERY");
        
        // Test invalid authentication
        System.out.println("\nTesting invalid authentication:");
        testUser(userService, "admin", "wrongpassword", null);
        testUser(userService, "nonexistent", "password", null);
    }
    
    /**
     * Test authentication for a specific user
     * @param userService the user service
     * @param username the username
     * @param password the password
     * @param expectedRole the expected role, or null if authentication should fail
     */
    private static void testUser(UserService userService, String username, String password, String expectedRole) {
        User user = userService.authenticateUser(username, password);
        
        if (user != null) {
            System.out.println("Authentication successful for user: " + username);
            System.out.println("User ID: " + user.getId());
            System.out.println("Full Name: " + user.getFullName());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Role: " + user.getRole());
            
            if (expectedRole != null && !expectedRole.equals(user.getRole())) {
                System.out.println("ERROR: Expected role " + expectedRole + " but got " + user.getRole());
            }
        } else {
            System.out.println("Authentication failed for user: " + username);
            
            if (expectedRole != null) {
                System.out.println("ERROR: Expected successful authentication with role " + expectedRole);
            }
        }
    }
}
