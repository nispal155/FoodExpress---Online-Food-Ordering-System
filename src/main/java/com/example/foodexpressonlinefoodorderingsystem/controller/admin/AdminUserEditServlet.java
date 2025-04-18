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
 * Servlet for editing a user (admin view)
 */
@WebServlet(name = "AdminUserEditServlet", urlPatterns = {"/admin/users/edit"})
public class AdminUserEditServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
            User user = userService.getUserById(id);
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=not-found");
                return;
            }
            
            // Set attributes for the JSP
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "Edit User");
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
        }
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
        
        User currentUser = (User) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Get form parameters
        String userId = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Validate input
        if (userId == null || userId.isEmpty() || 
            username == null || username.isEmpty() || 
            email == null || email.isEmpty() || 
            fullName == null || fullName.isEmpty() || 
            role == null || role.isEmpty()) {
            
            request.setAttribute("error", "All required fields must be filled out");
            
            try {
                int id = Integer.parseInt(userId);
                User user = userService.getUserById(id);
                request.setAttribute("user", user);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
                return;
            }
            
            request.setAttribute("pageTitle", "Edit User");
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            return;
        }
        
        try {
            int id = Integer.parseInt(userId);
            User user = userService.getUserById(id);
            
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=not-found");
                return;
            }
            
            // Check if username is changed and already exists
            if (!user.getUsername().equals(username)) {
                User existingUser = userService.getUserByUsername(username);
                if (existingUser != null) {
                    request.setAttribute("error", "Username already exists");
                    request.setAttribute("user", user);
                    request.setAttribute("pageTitle", "Edit User");
                    request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                    return;
                }
            }
            
            // Check if email is changed and already exists
            if (!user.getEmail().equals(email)) {
                User existingUser = userService.getUserByEmail(email);
                if (existingUser != null) {
                    request.setAttribute("error", "Email already exists");
                    request.setAttribute("user", user);
                    request.setAttribute("pageTitle", "Edit User");
                    request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                    return;
                }
            }
            
            // Update the user
            user.setUsername(username);
            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
            }
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);
            
            boolean success = userService.updateUser(user);
            
            if (success) {
                // Redirect to user list with success message
                response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
            } else {
                // Show error message
                request.setAttribute("error", "Failed to update user");
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Edit User");
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
        }
    }
}
