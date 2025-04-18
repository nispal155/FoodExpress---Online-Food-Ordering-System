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
import java.util.List;

/**
 * Servlet for handling the admin users list page
 */
@WebServlet(name = "AdminUserListServlet", urlPatterns = {"/admin/users"})
public class AdminUserListServlet extends HttpServlet {
    
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
        
        // Get filter parameters
        String roleFilter = request.getParameter("role");
        String searchQuery = request.getParameter("search");
        
        // Get users based on filters
        List<User> users;
        if (roleFilter != null && !roleFilter.isEmpty()) {
            users = userService.getUsersByRole(roleFilter);
            request.setAttribute("roleFilter", roleFilter);
        } else if (searchQuery != null && !searchQuery.isEmpty()) {
            users = userService.searchUsers(searchQuery);
            request.setAttribute("searchQuery", searchQuery);
        } else {
            users = userService.getAllUsers();
        }
        
        // Set attributes for the JSP
        request.setAttribute("users", users);
        request.setAttribute("pageTitle", "User Management");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
}
