package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for configuring email settings
 */
@WebServlet(name = "EmailConfigServlet", urlPatterns = {"/admin/email-config"})
public class EmailConfigServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Forward to the email configuration page
        request.getRequestDispatcher("/WEB-INF/views/admin/email-config.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String host = request.getParameter("host");
        String portStr = request.getParameter("port");
        String from = request.getParameter("from");
        String enabled = request.getParameter("enabled");
        String action = request.getParameter("action");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            host == null || host.trim().isEmpty() ||
            portStr == null || portStr.trim().isEmpty() ||
            from == null || from.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/views/admin/email-config.jsp").forward(request, response);
            return;
        }
        
        int port;
        try {
            port = Integer.parseInt(portStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Port must be a number");
            request.getRequestDispatcher("/WEB-INF/views/admin/email-config.jsp").forward(request, response);
            return;
        }
        
        boolean isEnabled = "on".equals(enabled);
        
        // If test connection action
        if ("test".equals(action)) {
            // Save the configuration temporarily
            EmailUtil.saveConfiguration(username, password, host, port, from, isEnabled);
            
            // Test the connection
            boolean success = EmailUtil.testConnection();
            
            if (success) {
                request.setAttribute("message", "Connection test successful! Email configuration has been saved.");
            } else {
                request.setAttribute("error", "Connection test failed. Please check your settings.");
            }
            
            request.getRequestDispatcher("/WEB-INF/views/admin/email-config.jsp").forward(request, response);
            return;
        }
        
        // Save the configuration
        boolean success = EmailUtil.saveConfiguration(username, password, host, port, from, isEnabled);
        
        if (success) {
            request.setAttribute("message", "Email configuration saved successfully!");
        } else {
            request.setAttribute("error", "Failed to save email configuration");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/email-config.jsp").forward(request, response);
    }
}
