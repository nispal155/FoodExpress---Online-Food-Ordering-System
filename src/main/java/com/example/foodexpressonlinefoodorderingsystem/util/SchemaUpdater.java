package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utility class to update the database schema
 */
public class SchemaUpdater {
    
    /**
     * Update the database schema
     */
    public static void main(String[] args) {
        try {
            updateSchema();
            System.out.println("Database schema updated successfully");
        } catch (Exception e) {
            System.err.println("Error updating database schema: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Update the database schema
     */
    private static void updateSchema() throws SQLException {
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Add missing columns to menu_items table
            try {
                stmt.executeUpdate("ALTER TABLE menu_items ADD COLUMN is_special BOOLEAN DEFAULT FALSE");
                System.out.println("Added is_special column to menu_items table");
            } catch (SQLException e) {
                if (e.getMessage().contains("Duplicate column name")) {
                    System.out.println("Column is_special already exists in menu_items table");
                } else {
                    throw e;
                }
            }
            
            try {
                stmt.executeUpdate("ALTER TABLE menu_items ADD COLUMN discount_price DECIMAL(10,2) DEFAULT NULL");
                System.out.println("Added discount_price column to menu_items table");
            } catch (SQLException e) {
                if (e.getMessage().contains("Duplicate column name")) {
                    System.out.println("Column discount_price already exists in menu_items table");
                } else {
                    throw e;
                }
            }
            
            // Add missing column to users table
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN last_login TIMESTAMP DEFAULT NULL");
                System.out.println("Added last_login column to users table");
            } catch (SQLException e) {
                if (e.getMessage().contains("Duplicate column name")) {
                    System.out.println("Column last_login already exists in users table");
                } else {
                    throw e;
                }
            }
            
            // Update existing menu items to set is_special to false
            stmt.executeUpdate("UPDATE menu_items SET is_special = FALSE WHERE is_special IS NULL");
            System.out.println("Updated existing menu items to set is_special to false");
        }
    }
}
