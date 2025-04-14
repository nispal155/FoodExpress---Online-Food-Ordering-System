package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for listing restaurants in the admin panel
 */
@WebServlet(name = "AdminRestaurantListServlet", urlPatterns = {"/admin/restaurants"})
public class AdminRestaurantListServlet extends HttpServlet {
    
    private final RestaurantService restaurantService = new RestaurantService();
    
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
        
        // Get all restaurants
        List<Restaurant> restaurants = restaurantService.getAllRestaurants();
        
        // Set attributes for the JSP
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("pageTitle", "Manage Restaurants");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/restaurants.jsp").forward(request, response);
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
        
        // Get action parameter
        String action = request.getParameter("action");
        
        if ("toggle_active".equals(action)) {
            // Toggle restaurant active status
            int restaurantId = Integer.parseInt(request.getParameter("id"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            
            boolean success = restaurantService.toggleRestaurantActive(restaurantId, isActive);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?success=toggle_active");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=toggle_active");
            }
        } else if ("delete".equals(action)) {
            // Delete restaurant
            int restaurantId = Integer.parseInt(request.getParameter("id"));
            
            boolean success = restaurantService.deleteRestaurant(restaurantId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=delete");
            }
        } else {
            // Invalid action
            response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=invalid_action");
        }
    }
}
