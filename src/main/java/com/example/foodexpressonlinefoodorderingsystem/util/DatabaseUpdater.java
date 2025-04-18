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

        // Add verification code columns to users table if they don't exist
        addVerificationCodeColumns();
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

    /**
     * Add verification_code and verification_code_expiry columns to users table if they don't exist
     */
    public static void addVerificationCodeColumns() {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.out.println("ERROR: Could not connect to database!");
                return;
            }

            // Check if verification_code column exists
            boolean verificationCodeExists = false;
            DatabaseMetaData metaData = conn.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, "users", "verification_code")) {
                verificationCodeExists = columns.next();
            }

            if (verificationCodeExists) {
                System.out.println("verification_code column already exists in users table.");
            } else {
                // Add verification_code column
                System.out.println("Adding verification_code column to users table...");
                try (Statement stmt = conn.createStatement()) {
                    String sql = "ALTER TABLE users ADD COLUMN verification_code VARCHAR(10) DEFAULT NULL";
                    stmt.executeUpdate(sql);
                    System.out.println("verification_code column added successfully!");
                }
            }

            // Check if verification_code_expiry column exists
            boolean expiryExists = false;
            try (ResultSet columns = metaData.getColumns(null, null, "users", "verification_code_expiry")) {
                expiryExists = columns.next();
            }

            if (expiryExists) {
                System.out.println("verification_code_expiry column already exists in users table.");
            } else {
                // Add verification_code_expiry column
                System.out.println("Adding verification_code_expiry column to users table...");
                try (Statement stmt = conn.createStatement()) {
                    String sql = "ALTER TABLE users ADD COLUMN verification_code_expiry TIMESTAMP DEFAULT NULL";
                    stmt.executeUpdate(sql);
                    System.out.println("verification_code_expiry column added successfully!");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error updating database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
