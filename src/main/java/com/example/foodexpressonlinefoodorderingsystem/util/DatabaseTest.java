package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Utility class to test database connection and schema
 */
public class DatabaseTest {
    
    public static void main(String[] args) {
        testConnection();
        testSchema();
        testQueries();
    }
    
    /**
     * Test database connection
     */
    private static void testConnection() {
        System.out.println("Testing database connection...");
        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("Connection successful!");
            System.out.println("Database product: " + conn.getMetaData().getDatabaseProductName());
            System.out.println("Database version: " + conn.getMetaData().getDatabaseProductVersion());
            System.out.println();
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Test database schema
     */
    private static void testSchema() {
        System.out.println("Testing database schema...");
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Test users table
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next()) {
                System.out.println("Users table exists with " + rs.getInt(1) + " records");
            }
            
            // Test restaurants table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM restaurants");
            if (rs.next()) {
                System.out.println("Restaurants table exists with " + rs.getInt(1) + " records");
            }
            
            // Test categories table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM categories");
            if (rs.next()) {
                System.out.println("Categories table exists with " + rs.getInt(1) + " records");
            }
            
            // Test menu_items table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM menu_items");
            if (rs.next()) {
                System.out.println("Menu items table exists with " + rs.getInt(1) + " records");
            }
            
            // Test orders table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM orders");
            if (rs.next()) {
                System.out.println("Orders table exists with " + rs.getInt(1) + " records");
            }
            
            // Test order_items table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM order_items");
            if (rs.next()) {
                System.out.println("Order items table exists with " + rs.getInt(1) + " records");
            }
            
            // Test reviews table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM reviews");
            if (rs.next()) {
                System.out.println("Reviews table exists with " + rs.getInt(1) + " records");
            }
            
            // Test user_sessions table
            rs = stmt.executeQuery("SELECT COUNT(*) FROM user_sessions");
            if (rs.next()) {
                System.out.println("User sessions table exists with " + rs.getInt(1) + " records");
            }
            
            System.out.println("Schema test completed successfully!");
            System.out.println();
            
        } catch (SQLException e) {
            System.err.println("Schema test failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Test database queries
     */
    private static void testQueries() {
        System.out.println("Testing database queries...");
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Test query 1: Get all active restaurants with their average rating
            System.out.println("Query 1: Get all active restaurants with their average rating");
            ResultSet rs = stmt.executeQuery(
                    "SELECT r.id, r.name, r.address, r.phone, r.rating, COUNT(rv.id) AS review_count " +
                    "FROM restaurants r " +
                    "LEFT JOIN reviews rv ON r.id = rv.restaurant_id " +
                    "WHERE r.is_active = TRUE " +
                    "GROUP BY r.id " +
                    "ORDER BY r.rating DESC");
            
            while (rs.next()) {
                System.out.println("Restaurant: " + rs.getString("name") + 
                                   ", Rating: " + rs.getDouble("rating") + 
                                   ", Reviews: " + rs.getInt("review_count"));
            }
            System.out.println();
            
            // Test query 2: Get menu items for a specific restaurant
            System.out.println("Query 2: Get menu items for restaurant 1");
            rs = stmt.executeQuery(
                    "SELECT m.id, m.name, m.price, c.name AS category " +
                    "FROM menu_items m " +
                    "JOIN categories c ON m.category_id = c.id " +
                    "WHERE m.restaurant_id = 1 AND m.is_available = TRUE " +
                    "ORDER BY c.name, m.name");
            
            while (rs.next()) {
                System.out.println("Item: " + rs.getString("name") + 
                                   ", Category: " + rs.getString("category") + 
                                   ", Price: $" + rs.getDouble("price"));
            }
            System.out.println();
            
            // Test query 3: Get order details
            System.out.println("Query 3: Get order details for order 1");
            rs = stmt.executeQuery(
                    "SELECT o.id, o.order_date, o.total_amount, o.status, " +
                    "       u.full_name AS customer_name, r.name AS restaurant_name, " +
                    "       du.full_name AS delivery_person " +
                    "FROM orders o " +
                    "JOIN users u ON o.user_id = u.id " +
                    "JOIN restaurants r ON o.restaurant_id = r.id " +
                    "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                    "WHERE o.id = 1");
            
            if (rs.next()) {
                System.out.println("Order #" + rs.getInt("id") + 
                                   ", Date: " + rs.getTimestamp("order_date") + 
                                   ", Amount: $" + rs.getDouble("total_amount") + 
                                   ", Status: " + rs.getString("status") + 
                                   ", Customer: " + rs.getString("customer_name") + 
                                   ", Restaurant: " + rs.getString("restaurant_name") + 
                                   ", Delivery Person: " + rs.getString("delivery_person"));
            }
            System.out.println();
            
            System.out.println("Query tests completed successfully!");
            
        } catch (SQLException e) {
            System.err.println("Query test failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
