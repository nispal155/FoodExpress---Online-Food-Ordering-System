package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for listing restaurants
 */
@WebServlet(name = "RestaurantListServlet", urlPatterns = {"/restaurants"})
public class RestaurantListServlet extends HttpServlet {
    
    private final RestaurantService restaurantService = new RestaurantService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get all active restaurants
        List<Restaurant> restaurants = restaurantService.getAllActiveRestaurants();
        
        // Set attributes for the JSP
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("pageTitle", "Restaurants");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/customer/restaurant-list.jsp").forward(request, response);
    }
}
