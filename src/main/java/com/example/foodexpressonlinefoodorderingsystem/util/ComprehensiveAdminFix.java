package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utility class to comprehensively fix admin user issues
 */
public class ComprehensiveAdminFix {
    
    public static void main(String[] args) {
        System.out.println("=== COMPREHENSIVE ADMIN FIX ===");
        
        // Step 1: Check database connection
        System.out.println("\n=== STEP 1: CHECKING DATABASE CONNECTION ===");
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.out.println("ERROR: Could not connect to database!");
                return;
            }
            System.out.println("Database connection successful!");
        } catch (SQLException e) {
            System.err.println("Error connecting to database: " + e.getMessage());
            e.printStackTrace();
            return;
        }
        
        // Step 2: Check users table structure
        System.out.println("\n=== STEP 2: CHECKING USERS TABLE STRUCTURE ===");
        checkUsersTableStructure();
        
        // Step 3: Fix user with ID 7
        System.out.println("\n=== STEP 3: FIXING USER WITH ID 7 ===");
        fixUserWithId7();
        
        // Step 4: Create admin user if needed
        System.out.println("\n=== STEP 4: ENSURING ADMIN USER EXISTS ===");
        ensureAdminUserExists();
        
        // Step 5: Test admin authentication
        System.out.println("\n=== STEP 5: TESTING ADMIN AUTHENTICATION ===");
        testAdminAuthentication();
        
        // Step 6: Check all admin users
        System.out.println("\n=== STEP 6: CHECKING ALL ADMIN USERS ===");
        checkAllAdminUsers();
        
        System.out.println("\n=== COMPREHENSIVE ADMIN FIX COMPLETED ===");
        System.out.println("You should now be able to log in as admin with:");
        System.out.println("Username: admin");
        System.out.println("Password: admin123");
    }
    
    /**
     * Check users table structure
     */
    private static void checkUsersTableStructure() {
        try (Connection conn = DBUtil.getConnection()) {
            // Check if users table exists
            boolean tableExists = false;
            try (ResultSet tables = conn.getMetaData().getTables(null, null, "users", null)) {
                tableExists = tables.next();
            }
            
            if (!tableExists) {
                System.out.println("ERROR: Users table does not exist!");
                return;
            }
            
            System.out.println("Users table exists!");
            
            // Check if required columns exist
            boolean hasRoleColumn = false;
            boolean hasIsActiveColumn = false;
            
            try (ResultSet columns = conn.getMetaData().getColumns(null, null, "users", null)) {
                while (columns.next()) {
                    String columnName = columns.getString("COLUMN_NAME");
                    if ("role".equalsIgnoreCase(columnName)) {
                        hasRoleColumn = true;
                    } else if ("is_active".equalsIgnoreCase(columnName)) {
                        hasIsActiveColumn = true;
                    }
                }
            }
            
            if (!hasRoleColumn) {
                System.out.println("ERROR: Role column does not exist in users table!");
            } else {
                System.out.println("Role column exists in users table!");
            }
            
            if (!hasIsActiveColumn) {
                System.out.println("ERROR: is_active column does not exist in users table!");
            } else {
                System.out.println("is_active column exists in users table!");
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking users table structure: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Fix user with ID 7
     */
    private static void fixUserWithId7() {
        UserService userService = new UserService();
        
        // Check if user with ID 7 exists
        User user = userService.getUserById(7);
        
        if (user != null) {
            System.out.println("User with ID 7 found!");
            System.out.println("Username: " + user.getUsername());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Role: " + user.getRole());
            System.out.println("Is Active: " + user.isActive());
            
            // Fix user if needed
            if (!"ADMIN".equals(user.getRole()) || !user.isActive()) {
                System.out.println("User with ID 7 needs fixing!");
                
                // Fix directly in the database for maximum reliability
                try (Connection conn = DBUtil.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                             "UPDATE users SET role = 'ADMIN', is_active = TRUE WHERE id = 7")) {
                    
                    int rowsAffected = stmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        System.out.println("User with ID 7 fixed successfully!");
                    } else {
                        System.out.println("Failed to fix user with ID 7!");
                    }
                    
                } catch (SQLException e) {
                    System.err.println("Error fixing user with ID 7: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("User with ID 7 is already an active admin!");
            }
        } else {
            System.out.println("User with ID 7 not found!");
        }
    }
    
    /**
     * Ensure admin user exists
     */
    private static void ensureAdminUserExists() {
        UserService userService = new UserService();
        
        // Check if admin user exists
        User adminUser = userService.getUserByUsername("admin");
        
        if (adminUser != null) {
            System.out.println("Admin user exists!");
            System.out.println("User ID: " + adminUser.getId());
            System.out.println("Username: " + adminUser.getUsername());
            System.out.println("Email: " + adminUser.getEmail());
            System.out.println("Role: " + adminUser.getRole());
            System.out.println("Is Active: " + adminUser.isActive());
            
            // Fix admin user if needed
            if (!"ADMIN".equals(adminUser.getRole()) || !adminUser.isActive()) {
                System.out.println("Admin user needs fixing!");
                
                // Fix directly in the database for maximum reliability
                try (Connection conn = DBUtil.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                             "UPDATE users SET role = 'ADMIN', is_active = TRUE WHERE username = 'admin'")) {
                    
                    int rowsAffected = stmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        System.out.println("Admin user fixed successfully!");
                    } else {
                        System.out.println("Failed to fix admin user!");
                    }
                    
                } catch (SQLException e) {
                    System.err.println("Error fixing admin user: " + e.getMessage());
                    e.printStackTrace();
                }
                
                // Reset admin password
                System.out.println("Resetting admin password...");
                adminUser.setPassword("admin123");
                boolean updated = userService.updateUser(adminUser);
                
                if (updated) {
                    System.out.println("Admin password reset successfully!");
                } else {
                    System.out.println("Failed to reset admin password!");
                }
            } else {
                System.out.println("Admin user is already an active admin!");
            }
        } else {
            System.out.println("Admin user does not exist! Creating admin user...");
            
            // Create admin user
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
                
                // Get the created user
                adminUser = userService.getUserByUsername("admin");
                if (adminUser != null) {
                    System.out.println("User ID: " + adminUser.getId());
                }
            } else {
                System.out.println("Failed to create admin user!");
            }
        }
    }
    
    /**
     * Test admin authentication
     */
    private static void testAdminAuthentication() {
        UserService userService = new UserService();
        
        // Test authentication with admin credentials
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
            
            // Reset admin password directly in the database
            System.out.println("Resetting admin password directly in the database...");
            
            try (Connection conn = DBUtil.getConnection()) {
                // Get the admin user
                String username = "admin";
                String hashedPassword = PasswordUtil.hashPassword("admin123");
                
                try (PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE users SET password = ? WHERE username = ?")) {
                    
                    stmt.setString(1, hashedPassword);
                    stmt.setString(2, username);
                    
                    int rowsAffected = stmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        System.out.println("Admin password reset successfully!");
                        
                        // Try authentication again
                        System.out.println("Trying authentication again...");
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
                }
            } catch (SQLException e) {
                System.err.println("Error resetting admin password: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Check all admin users
     */
    private static void checkAllAdminUsers() {
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, username, email, role, is_active FROM users WHERE role = 'ADMIN'")) {
            
            System.out.println("ID | Username | Email | Role | Is Active");
            System.out.println("----------------------------------------");
            
            boolean hasAdmins = false;
            
            while (rs.next()) {
                hasAdmins = true;
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                String role = rs.getString("role");
                boolean isActive = rs.getBoolean("is_active");
                
                System.out.println(id + " | " + username + " | " + email + " | " + role + " | " + isActive);
            }
            
            if (!hasAdmins) {
                System.out.println("No admin users found in the database!");
            }
        } catch (SQLException e) {
            System.err.println("Error checking admin users: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
