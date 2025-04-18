package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet to fix the admin user and redirect to the admin dashboard
 */
@WebServlet(name = "FixAdminServlet", urlPatterns = {"/fix-admin"})
public class FixAdminServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Fix Admin User</title></head><body>");
        out.println("<h1>Fixing Admin User...</h1>");
        
        // Fix admin user with ID 7
        boolean fixed = fixAdminUser(7);
        
        if (fixed) {
            out.println("<p>Admin user fixed successfully!</p>");
            
            // Verify the fix
            User adminUser = userService.getUserById(7);
            
            if (adminUser != null) {
                out.println("<h2>Admin User Details:</h2>");
                out.println("<p>User ID: " + adminUser.getId() + "</p>");
                out.println("<p>Username: " + adminUser.getUsername() + "</p>");
                out.println("<p>Email: " + adminUser.getEmail() + "</p>");
                out.println("<p>Role: " + adminUser.getRole() + "</p>");
                out.println("<p>Is Active: " + adminUser.isActive() + "</p>");
                
                // Create a session for the admin user
                HttpSession session = request.getSession(true);
                session.setAttribute("user", adminUser);
                
                out.println("<p>Created session for admin user.</p>");
                out.println("<p>Redirecting to admin dashboard in 5 seconds...</p>");
                out.println("<script>setTimeout(function() { window.location.href = '" + 
                            request.getContextPath() + "/admin/dashboard'; }, 5000);</script>");
            } else {
                out.println("<p>Admin user not found after fix!</p>");
            }
        } else {
            out.println("<p>Failed to fix admin user!</p>");
        }
        
        out.println("<p><a href='" + request.getContextPath() + "/login'>Back to Login</a></p>");
        out.println("</body></html>");
    }
    
    /**
     * Fix the admin user role and status
     * @param userId the user ID to fix
     * @return true if successful, false otherwise
     */
    private boolean fixAdminUser(int userId) {
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
}
