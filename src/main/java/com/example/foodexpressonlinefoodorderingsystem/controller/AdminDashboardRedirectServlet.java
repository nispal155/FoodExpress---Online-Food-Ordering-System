package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for directly accessing the admin dashboard (for debugging)
 */
@WebServlet(name = "AdminDashboardRedirectServlet", urlPatterns = {"/debug-admin"})
public class AdminDashboardRedirectServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        User user = null;
        
        if (session != null && session.getAttribute("user") != null) {
            user = (User) session.getAttribute("user");
            System.out.println("DEBUG: User is already logged in as: " + user.getUsername() + " with role: " + user.getRole());
        } else {
            // Auto-login as admin for debugging
            System.out.println("DEBUG: Auto-logging in as admin for debugging");
            user = userService.getUserByUsername("admin");
            
            if (user == null) {
                System.out.println("DEBUG: Admin user not found, creating one");
                // Create admin user if it doesn't exist
                User adminUser = new User();
                adminUser.setUsername("admin");
                adminUser.setPassword("admin123");
                adminUser.setEmail("admin@foodexpress.com");
                adminUser.setFullName("Admin User");
                adminUser.setPhone("123-456-7890");
                adminUser.setAddress("123 Admin St, Admin City");
                adminUser.setRole("ADMIN");
                
                boolean created = userService.createUser(adminUser);
                if (created) {
                    System.out.println("DEBUG: Admin user created successfully");
                    user = userService.getUserByUsername("admin");
                } else {
                    System.out.println("DEBUG: Failed to create admin user");
                    response.getWriter().println("Failed to create admin user. Check server logs.");
                    return;
                }
            }
            
            // Create session for admin
            session = request.getSession(true);
            session.setAttribute("user", user);
            System.out.println("DEBUG: Created session for admin user");
        }
        
        // Force role to ADMIN for debugging
        if (!"ADMIN".equals(user.getRole())) {
            System.out.println("DEBUG: Forcing user role to ADMIN for debugging");
            user.setRole("ADMIN");
            session.setAttribute("user", user);
        }
        
        // Redirect to admin dashboard
        System.out.println("DEBUG: Redirecting to admin dashboard");
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
