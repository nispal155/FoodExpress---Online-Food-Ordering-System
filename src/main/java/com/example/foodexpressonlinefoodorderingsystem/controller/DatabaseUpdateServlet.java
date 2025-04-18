package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet for updating the database schema
 */
@WebServlet(name = "DatabaseUpdateServlet", urlPatterns = {"/update-database"})
public class DatabaseUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Database Update</title></head><body>");
        out.println("<h1>Database Update</h1>");

        // Add profile_picture column to users table
        boolean profilePictureSuccess = addProfilePictureColumn();

        if (profilePictureSuccess) {
            out.println("<p style='color: green;'>The profile_picture column was added successfully!</p>");
        } else {
            out.println("<p style='color: red;'>Failed to add profile_picture column. Check server logs for details.</p>");
        }

        // Add verification code columns to users table
        boolean verificationSuccess = addVerificationCodeColumns();

        if (verificationSuccess) {
            out.println("<p style='color: green;'>The verification code columns were added successfully!</p>");
        } else {
            out.println("<p style='color: red;'>Failed to add verification code columns. Check server logs for details.</p>");
        }

        out.println("<p><a href='" + request.getContextPath() + "/profile'>Go to Profile Page</a></p>");
        out.println("<p><a href='" + request.getContextPath() + "/forgot-password'>Go to Forgot Password</a></p>");
        out.println("</body></html>");
    }

    /**
     * Add profile_picture column to users table if it doesn't exist
     * @return true if successful, false otherwise
     */
    private boolean addProfilePictureColumn() {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.err.println("ERROR: Could not connect to database!");
                return false;
            }

            // Check if profile_picture column exists
            boolean columnExists = false;
            DatabaseMetaData metaData = conn.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, "users", "profile_picture")) {
                columnExists = columns.next();
            }

            if (columnExists) {
                System.out.println("profile_picture column already exists in users table.");
                return true;
            }

            // Add profile_picture column
            System.out.println("Adding profile_picture column to users table...");
            try (Statement stmt = conn.createStatement()) {
                String sql = "ALTER TABLE users ADD COLUMN profile_picture VARCHAR(255) DEFAULT NULL";
                stmt.executeUpdate(sql);
                System.out.println("profile_picture column added successfully!");
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error adding profile_picture column: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Add verification_code and verification_code_expiry columns to users table if they don't exist
     * @return true if successful, false otherwise
     */
    private boolean addVerificationCodeColumns() {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.err.println("ERROR: Could not connect to database!");
                return false;
            }

            // Check if verification_code column exists
            boolean verificationCodeExists = false;
            DatabaseMetaData metaData = conn.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, "users", "verification_code")) {
                verificationCodeExists = columns.next();
            }

            if (!verificationCodeExists) {
                // Add verification_code column
                System.out.println("Adding verification_code column to users table...");
                try (Statement stmt = conn.createStatement()) {
                    String sql = "ALTER TABLE users ADD COLUMN verification_code VARCHAR(10) DEFAULT NULL";
                    stmt.executeUpdate(sql);
                    System.out.println("verification_code column added successfully!");
                }
            } else {
                System.out.println("verification_code column already exists in users table.");
            }

            // Check if verification_code_expiry column exists
            boolean expiryExists = false;
            try (ResultSet columns = metaData.getColumns(null, null, "users", "verification_code_expiry")) {
                expiryExists = columns.next();
            }

            if (!expiryExists) {
                // Add verification_code_expiry column
                System.out.println("Adding verification_code_expiry column to users table...");
                try (Statement stmt = conn.createStatement()) {
                    String sql = "ALTER TABLE users ADD COLUMN verification_code_expiry TIMESTAMP DEFAULT NULL";
                    stmt.executeUpdate(sql);
                    System.out.println("verification_code_expiry column added successfully!");
                }
            } else {
                System.out.println("verification_code_expiry column already exists in users table.");
            }

            return true;

        } catch (SQLException e) {
            System.err.println("Error adding verification code columns: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
