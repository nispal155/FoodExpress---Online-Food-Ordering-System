package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

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
 * Servlet for deleting a user (admin view)
 */
@WebServlet(name = "AdminUserDeleteServlet", urlPatterns = {"/admin/users/delete"})
public class AdminUserDeleteServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Get user ID from request
        String userId = request.getParameter("id");
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=missing-id");
            return;
        }
        
        try {
            int id = Integer.parseInt(userId);
            
            // Prevent deleting yourself
            if (id == currentUser.getId()) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=cannot-delete-self");
                return;
            }
            
            boolean success = userService.deleteUser(id);
            
            if (success) {
                // Redirect to user list with success message
                response.sendRedirect(request.getContextPath() + "/admin/users?success=deleted");
            } else {
                // Redirect with error message
                response.sendRedirect(request.getContextPath() + "/admin/users?error=delete-failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
        }
    }
}
