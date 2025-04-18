package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utility class to check database structure and user data
 */
public class DatabaseChecker {
    
    public static void main(String[] args) {
        System.out.println("=== DATABASE STRUCTURE AND USER DATA CHECK ===");
        
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.out.println("ERROR: Could not connect to database!");
                return;
            }
            
            System.out.println("Successfully connected to database.");
            
            // Check database metadata
            DatabaseMetaData metaData = conn.getMetaData();
            System.out.println("Database: " + metaData.getDatabaseProductName() + " " + metaData.getDatabaseProductVersion());
            System.out.println("JDBC Driver: " + metaData.getDriverName() + " " + metaData.getDriverVersion());
            
            // Check users table structure
            System.out.println("\n=== USERS TABLE STRUCTURE ===");
            try (ResultSet columns = metaData.getColumns(null, null, "users", null)) {
                while (columns.next()) {
                    String columnName = columns.getString("COLUMN_NAME");
                    String columnType = columns.getString("TYPE_NAME");
                    String nullable = columns.getInt("NULLABLE") == 1 ? "NULL" : "NOT NULL";
                    System.out.println(columnName + " - " + columnType + " - " + nullable);
                }
            }
            
            // Check all users in the database
            System.out.println("\n=== ALL USERS IN DATABASE ===");
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, username, email, role, is_active FROM users")) {
                
                System.out.println("ID | Username | Email | Role | Is Active");
                System.out.println("----------------------------------------");
                
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String username = rs.getString("username");
                    String email = rs.getString("email");
                    String role = rs.getString("role");
                    boolean isActive = rs.getBoolean("is_active");
                    
                    System.out.println(id + " | " + username + " | " + email + " | " + role + " | " + isActive);
                }
            }
            
            // Check user with ID 7 specifically
            System.out.println("\n=== USER WITH ID 7 DETAILS ===");
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
                stmt.setInt(1, 7);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        System.out.println("ID: " + rs.getInt("id"));
                        System.out.println("Username: " + rs.getString("username"));
                        System.out.println("Password: " + rs.getString("password"));
                        System.out.println("Email: " + rs.getString("email"));
                        System.out.println("Full Name: " + rs.getString("full_name"));
                        System.out.println("Role: " + rs.getString("role"));
                        System.out.println("Is Active: " + rs.getBoolean("is_active"));
                        System.out.println("Created At: " + rs.getTimestamp("created_at"));
                        System.out.println("Updated At: " + rs.getTimestamp("updated_at"));
                        System.out.println("Last Login: " + rs.getTimestamp("last_login"));
                    } else {
                        System.out.println("User with ID 7 not found!");
                    }
                }
            }
            
            // Check if there are any admin users
            System.out.println("\n=== ADMIN USERS ===");
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, username, email, is_active FROM users WHERE role = 'ADMIN'")) {
                
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
            
        } catch (SQLException e) {
            System.err.println("Error checking database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
