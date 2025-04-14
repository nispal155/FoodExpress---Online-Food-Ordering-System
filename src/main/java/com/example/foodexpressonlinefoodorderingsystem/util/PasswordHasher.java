package com.example.foodexpressonlinefoodorderingsystem.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Utility class to hash existing passwords in the database
 */
public class PasswordHasher {

    public static void main(String[] args) {
        hashExistingPasswords();
    }

    /**
     * Hash all existing passwords in the database
     */
    private static void hashExistingPasswords() {
        System.out.println("Hashing existing passwords...");

        try (Connection conn = DBUtil.getConnection()) {
            // Get all users with plain text passwords
            String selectSql = "SELECT id, username, password FROM users";
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql);
                 ResultSet rs = selectStmt.executeQuery()) {

                // Prepare update statement
                String updateSql = "UPDATE users SET password = ? WHERE id = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

                    int count = 0;
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String username = rs.getString("username");
                        String password = rs.getString("password");

                        // Check if the password is already hashed (BCrypt hashes start with '$2a$', '$2b$', or '$2y$')
                        if (password.startsWith("$2")) {
                            System.out.println("Password for user " + username + " is already hashed. Skipping.");
                            continue;
                        }

                        // Hash the password
                        String hashedPassword = PasswordUtil.hashPassword(password);

                        // Update the user's password
                        updateStmt.setString(1, hashedPassword);
                        updateStmt.setInt(2, id);
                        updateStmt.executeUpdate();

                        System.out.println("Hashed password for user: " + username);
                        count++;
                    }

                    System.out.println("Hashed " + count + " passwords successfully!");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error hashing passwords: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
