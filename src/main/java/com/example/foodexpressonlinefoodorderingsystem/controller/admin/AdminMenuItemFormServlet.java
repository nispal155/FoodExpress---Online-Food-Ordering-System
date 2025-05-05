package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

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
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;

/**
 * Servlet for displaying the menu item form (add/edit) in the admin panel
 */
@WebServlet(name = "AdminMenuItemFormServlet", urlPatterns = {"/admin/menu-items/form"})
public class AdminMenuItemFormServlet extends HttpServlet {

    private final MenuItemService menuItemService = new MenuItemService();
    private final RestaurantService restaurantService = new RestaurantService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all restaurants and categories for the form
        List<Restaurant> restaurants = restaurantService.getAllRestaurants();
        List<Category> categories = categoryService.getAllCategories();

        // Set attributes for the JSP
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("categories", categories);

        // Check if we're editing an existing menu item
        String menuItemId = request.getParameter("id");
        if (menuItemId != null && !menuItemId.isEmpty()) {
            try {
                int id = Integer.parseInt(menuItemId);
                MenuItem menuItem = menuItemService.getMenuItemById(id);

                if (menuItem != null) {
                    request.setAttribute("menuItem", menuItem);
                    request.setAttribute("pageTitle", "Edit Menu Item");
                } else {
                    // Menu item not found, redirect to list
                    response.sendRedirect(request.getContextPath() + "/admin/menu-items");
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID, redirect to list
                response.sendRedirect(request.getContextPath() + "/admin/menu-items");
                return;
            }
        } else {
            // New menu item
            request.setAttribute("pageTitle", "Add Menu Item");

            // Check if a restaurant ID is provided
            String restaurantIdStr = request.getParameter("restaurantId");
            if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
                try {
                    int restaurantId = Integer.parseInt(restaurantIdStr);
                    Restaurant restaurant = restaurantService.getRestaurantById(restaurantId);

                    if (restaurant != null) {
                        // Pre-select the restaurant
                        request.setAttribute("selectedRestaurantId", restaurantId);
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid restaurant ID
                }
            }
        }

        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/menu-item-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward POST requests to the doGet method
        doGet(request, response);
    }
}
