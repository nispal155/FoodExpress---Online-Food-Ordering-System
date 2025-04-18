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
 * Servlet for creating a new user (admin view)
 */
@WebServlet(name = "AdminUserCreateServlet", urlPatterns = {"/admin/users/create"})
public class AdminUserCreateServlet extends HttpServlet {
    
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
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Set attributes for the JSP
        request.setAttribute("pageTitle", "Create User");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Validate input
        if (username == null || username.isEmpty() || 
            password == null || password.isEmpty() || 
            email == null || email.isEmpty() || 
            fullName == null || fullName.isEmpty() || 
            role == null || role.isEmpty()) {
            
            request.setAttribute("error", "All required fields must be filled out");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("role", role);
            request.setAttribute("pageTitle", "Create User");
            
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            return;
        }
        
        // Check if username or email already exists
        User existingUser = userService.getUserByUsername(username);
        if (existingUser != null) {
            request.setAttribute("error", "Username already exists");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("role", role);
            request.setAttribute("pageTitle", "Create User");
            
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            return;
        }
        
        existingUser = userService.getUserByEmail(email);
        if (existingUser != null) {
            request.setAttribute("error", "Email already exists");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("role", role);
            request.setAttribute("pageTitle", "Create User");
            
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            return;
        }
        
        // Create the user
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setFullName(fullName);
        newUser.setPhone(phone);
        newUser.setAddress(address);
        newUser.setRole(role);
        
        boolean success = userService.createUser(newUser);
        
        if (success) {
            // Redirect to user list with success message
            response.sendRedirect(request.getContextPath() + "/admin/users?success=created");
        } else {
            // Show error message
            request.setAttribute("error", "Failed to create user");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("role", role);
            request.setAttribute("pageTitle", "Create User");
            
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
        }
    }
}
