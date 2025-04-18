package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utility class to fix admin user issues
 */
public class AdminUserFixer {
    
    public static void main(String[] args) {
        System.out.println("=== ADMIN USER FIXER ===");
        
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.out.println("ERROR: Could not connect to database!");
                return;
            }
            
            // Check if user with ID 7 exists
            boolean userExists = checkUserExists(conn, 7);
            
            if (userExists) {
                // Fix user with ID 7
                System.out.println("Fixing user with ID 7...");
                boolean fixed = fixUser(conn, 7);
                
                if (fixed) {
                    System.out.println("User with ID 7 fixed successfully!");
                } else {
                    System.out.println("Failed to fix user with ID 7!");
                }
            } else {
                System.out.println("User with ID 7 not found. Creating admin user...");
                boolean created = createAdminUser(conn);
                
                if (created) {
                    System.out.println("Admin user created successfully!");
                } else {
                    System.out.println("Failed to create admin user!");
                }
            }
            
            // Check if there are any admin users
            checkAdminUsers(conn);
            
        } catch (SQLException e) {
            System.err.println("Error fixing admin user: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Check if a user exists
     * @param conn the database connection
     * @param userId the user ID
     * @return true if the user exists, false otherwise
     */
    private static boolean checkUserExists(Connection conn, int userId) throws SQLException {
        String sql = "SELECT id FROM users WHERE id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
    
    /**
     * Fix a user to be an admin and active
     * @param conn the database connection
     * @param userId the user ID
     * @return true if successful, false otherwise
     */
    private static boolean fixUser(Connection conn, int userId) throws SQLException {
        String sql = "UPDATE users SET role = 'ADMIN', is_active = TRUE WHERE id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    /**
     * Create an admin user
     * @param conn the database connection
     * @return true if successful, false otherwise
     */
    private static boolean createAdminUser(Connection conn) throws SQLException {
        // Check if admin user already exists
        String checkSql = "SELECT id FROM users WHERE username = 'admin'";
        
        try (Statement checkStmt = conn.createStatement();
             ResultSet rs = checkStmt.executeQuery(checkSql)) {
            
            if (rs.next()) {
                int adminId = rs.getInt("id");
                System.out.println("Admin user already exists with ID: " + adminId);
                return fixUser(conn, adminId);
            }
        }
        
        // Create new admin user
        String sql = "INSERT INTO users (username, password, email, full_name, phone, address, role, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            // Use BCrypt to hash the password
            String hashedPassword = PasswordUtil.hashPassword("admin123");
            
            stmt.setString(1, "admin");
            stmt.setString(2, hashedPassword);
            stmt.setString(3, "admin@foodexpress.com");
            stmt.setString(4, "Admin User");
            stmt.setString(5, "123-456-7890");
            stmt.setString(6, "123 Admin St, Admin City");
            stmt.setString(7, "ADMIN");
            stmt.setBoolean(8, true);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int newId = generatedKeys.getInt(1);
                        System.out.println("Created admin user with ID: " + newId);
                    }
                }
                return true;
            }
            
            return false;
        }
    }
    
    /**
     * Check if there are any admin users
     * @param conn the database connection
     */
    private static void checkAdminUsers(Connection conn) throws SQLException {
        String sql = "SELECT id, username, email, is_active FROM users WHERE role = 'ADMIN'";
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("\n=== ADMIN USERS ===");
            System.out.println("ID | Username | Email | Is Active");
            System.out.println("--------------------------------");
            
            boolean hasAdmins = false;
            
            while (rs.next()) {
                hasAdmins = true;
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                boolean isActive = rs.getBoolean("is_active");
                
                System.out.println(id + " | " + username + " | " + email + " | " + isActive);
            }
            
            if (!hasAdmins) {
                System.out.println("No admin users found in the database!");
            }
        }
    }
}
