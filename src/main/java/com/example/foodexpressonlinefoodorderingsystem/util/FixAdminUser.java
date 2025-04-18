package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Utility class to fix the admin user role and status
 * Run this class to update the admin user with ID 7
 */
public class FixAdminUser {
    
    public static void main(String[] args) {
        // Fix admin user with ID 7
        boolean fixed = fixAdminUser(7);
        
        if (fixed) {
            System.out.println("Admin user fixed successfully!");
            
            // Verify the fix
            verifyAdminUser(7);
        } else {
            System.out.println("Failed to fix admin user!");
        }
    }
    
    /**
     * Fix the admin user role and status
     * @param userId the user ID to fix
     * @return true if successful, false otherwise
     */
    private static boolean fixAdminUser(int userId) {
        String sql = "UPDATE users SET role = 'ADMIN', is_active = TRUE WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error fixing admin user: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Verify the admin user role and status
     * @param userId the user ID to verify
     */
    private static void verifyAdminUser(int userId) {
        String sql = "SELECT id, username, email, role, is_active FROM users WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("User ID: " + rs.getInt("id"));
                System.out.println("Username: " + rs.getString("username"));
                System.out.println("Email: " + rs.getString("email"));
                System.out.println("Role: " + rs.getString("role"));
                System.out.println("Is Active: " + rs.getBoolean("is_active"));
            } else {
                System.out.println("User not found!");
            }
            
        } catch (SQLException e) {
            System.err.println("Error verifying admin user: " + e.getMessage());
        }
    }
}
