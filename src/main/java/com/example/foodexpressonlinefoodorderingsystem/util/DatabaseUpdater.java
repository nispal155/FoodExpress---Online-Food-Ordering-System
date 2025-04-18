package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utility class to update the database schema
 */
public class DatabaseUpdater {
    
    public static void main(String[] args) {
        System.out.println("=== DATABASE UPDATER ===");
        
        // Add profile_picture column to users table if it doesn't exist
        addProfilePictureColumn();
    }
    
    /**
     * Add profile_picture column to users table if it doesn't exist
     */
    public static void addProfilePictureColumn() {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.out.println("ERROR: Could not connect to database!");
                return;
            }
            
            // Check if profile_picture column exists
            boolean columnExists = false;
            DatabaseMetaData metaData = conn.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, "users", "profile_picture")) {
                columnExists = columns.next();
            }
            
            if (columnExists) {
                System.out.println("profile_picture column already exists in users table.");
                return;
            }
            
            // Add profile_picture column
            System.out.println("Adding profile_picture column to users table...");
            try (Statement stmt = conn.createStatement()) {
                String sql = "ALTER TABLE users ADD COLUMN profile_picture VARCHAR(255) DEFAULT NULL";
                stmt.executeUpdate(sql);
                System.out.println("profile_picture column added successfully!");
            }
            
        } catch (SQLException e) {
            System.err.println("Error updating database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
