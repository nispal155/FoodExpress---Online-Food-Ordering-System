package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for the customer home page
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    
    private final RestaurantService restaurantService = new RestaurantService();
    private final MenuItemService menuItemService = new MenuItemService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get featured restaurants (top rated)
        List<Restaurant> featuredRestaurants = restaurantService.getTopRatedRestaurants(6);
        
        // Get special menu items
        List<MenuItem> specialMenuItems = menuItemService.getSpecialMenuItems();
        
        // Set attributes for the JSP
        request.setAttribute("featuredRestaurants", featuredRestaurants);
        request.setAttribute("specialMenuItems", specialMenuItems);
        request.setAttribute("pageTitle", "Home");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/customer/home.jsp").forward(request, response);
    }
}
