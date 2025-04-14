package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.Category;
import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.service.CategoryService;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet for displaying restaurant details and menu
 */
@WebServlet(name = "RestaurantDetailServlet", urlPatterns = {"/restaurant"})
public class RestaurantDetailServlet extends HttpServlet {
    
    private final RestaurantService restaurantService = new RestaurantService();
    private final MenuItemService menuItemService = new MenuItemService();
    private final CategoryService categoryService = new CategoryService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get restaurant ID from request parameter
        String restaurantIdParam = request.getParameter("id");
        if (restaurantIdParam == null || restaurantIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/restaurants");
            return;
        }
        
        try {
            int restaurantId = Integer.parseInt(restaurantIdParam);
            
            // Get restaurant details
            Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);
            if (restaurant == null || !restaurant.isActive()) {
                response.sendRedirect(request.getContextPath() + "/restaurants?error=not-found");
                return;
            }
            
            // Get menu items for the restaurant
            List<MenuItem> menuItems = menuItemService.getMenuItemsByRestaurant(restaurantId);
            
            // Get all categories
            List<Category> categories = categoryService.getAllCategories();
            
            // Organize menu items by category
            Map<Integer, List<MenuItem>> menuItemsByCategory = new HashMap<>();
            for (Category category : categories) {
                List<MenuItem> itemsInCategory = menuItemService.getMenuItemsByRestaurantAndCategory(
                        restaurantId, category.getId());
                if (!itemsInCategory.isEmpty()) {
                    menuItemsByCategory.put(category.getId(), itemsInCategory);
                }
            }
            
            // Set attributes for the JSP
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuItems", menuItems);
            request.setAttribute("categories", categories);
            request.setAttribute("menuItemsByCategory", menuItemsByCategory);
            request.setAttribute("pageTitle", restaurant.getName());
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/customer/restaurant-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/restaurants?error=invalid-id");
        }
    }
}
