package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;
import com.example.foodexpressonlinefoodorderingsystem.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet for hashing all passwords in the database
 * This should only be accessible to administrators and should be removed in production
 */
@WebServlet(name = "HashPasswordsServlet", urlPatterns = {"/admin/hash-passwords"})
public class HashPasswordsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Hash Passwords</title></head><body>");
        out.println("<h1>Hash Passwords</h1>");
        
        // Hash all passwords
        int count = hashAllPasswords();
        
        out.println("<p>Hashed " + count + " passwords.</p>");
        out.println("<p><a href=\"" + request.getContextPath() + "/admin/dashboard\">Back to Dashboard</a></p>");
        out.println("</body></html>");
    }
    
    /**
     * Hash all passwords in the database
     * @return the number of passwords hashed
     */
    private int hashAllPasswords() {
        int count = 0;
        
        try (Connection conn = DBUtil.getConnection()) {
            // Get all users with plain text passwords
            String selectSql = "SELECT id, username, password FROM users";
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql);
                 ResultSet rs = selectStmt.executeQuery()) {
                
                // Prepare update statement
                String updateSql = "UPDATE users SET password = ? WHERE id = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    
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
                }
            }
        } catch (SQLException e) {
            System.err.println("Error hashing passwords: " + e.getMessage());
            e.printStackTrace();
        }
        
        return count;
    }
}
