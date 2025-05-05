package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.Category;
import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.CategoryService;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


import java.io.IOException;
import java.util.List;

/**
 * Servlet for listing menu items in the admin panel
 */
@WebServlet(name = "AdminMenuItemListServlet", urlPatterns = {"/admin/menu-items"})
public class AdminMenuItemListServlet extends HttpServlet {

    private final MenuItemService menuItemService = new MenuItemService();
    private final RestaurantService restaurantService = new RestaurantService();
    private final CategoryService categoryService = new CategoryService();

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
        String restaurantIdStr = request.getParameter("restaurantId");
        String categoryIdStr = request.getParameter("categoryId");
        String searchQuery = request.getParameter("search");

        Restaurant restaurant = null;
        int restaurantId = 0;
        int categoryId = 0;
        List<MenuItem> menuItems;

        // Parse restaurant ID if provided
        if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
            try {
                restaurantId = Integer.parseInt(restaurantIdStr);
                restaurant = restaurantService.getRestaurantById(restaurantId);

                if (restaurant == null) {
                    // Restaurant not found
                    response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=not_found");
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid restaurant ID
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=invalid_id");
                return;
            }
        }

        // Parse category ID if provided
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Invalid category ID - just ignore it
                categoryId = 0;
            }
        }

        // Get menu items based on filters
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Search for menu items
            menuItems = menuItemService.searchMenuItemsForAdmin(searchQuery.trim(), restaurantId, categoryId);
            request.setAttribute("searchQuery", searchQuery);
        } else if (restaurantId > 0 && categoryId > 0) {
            // Filter by both restaurant and category
            menuItems = menuItemService.getMenuItemsByRestaurantAndCategory(restaurantId, categoryId);
        } else if (restaurantId > 0) {
            // Filter by restaurant only
            menuItems = menuItemService.getMenuItemsByRestaurant(restaurantId);
        } else if (categoryId > 0) {
            // Filter by category only
            menuItems = menuItemService.getMenuItemsByCategory(categoryId);
        } else {
            // No filters - get all menu items
            menuItems = menuItemService.getAllMenuItems();
        }

        // Get all restaurants for the filter dropdown
        List<Restaurant> restaurants = restaurantService.getAllRestaurants();

        // Get all categories for the filter dropdown
        List<Category> categories = categoryService.getAllCategories();

        // Set attributes for the JSP
        request.setAttribute("menuItems", menuItems);
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedRestaurant", restaurant);
        request.setAttribute("selectedCategoryId", categoryId > 0 ? categoryId : null);

        // Set page title based on filters
        String pageTitle;
        if (restaurant != null && categoryId > 0) {
            Category category = categoryService.getCategoryById(categoryId);
            pageTitle = "Menu Items for " + restaurant.getName() + " - " +
                       (category != null ? category.getName() : "Category " + categoryId);
        } else if (restaurant != null) {
            pageTitle = "Menu Items for " + restaurant.getName();
        } else if (categoryId > 0) {
            Category category = categoryService.getCategoryById(categoryId);
            pageTitle = "Menu Items - " + (category != null ? category.getName() : "Category " + categoryId);
        } else if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            pageTitle = "Search Results for '" + searchQuery + "'";
        } else {
            pageTitle = "All Menu Items";
        }
        request.setAttribute("pageTitle", pageTitle);

        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/menu-items.jsp").forward(request, response);
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

        if ("toggle_available".equals(action)) {
            // Toggle menu item availability
            int menuItemId = Integer.parseInt(request.getParameter("id"));
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

            boolean success = menuItemService.toggleMenuItemAvailability(menuItemId, isAvailable);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?success=toggle_available");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=toggle_available");
            }
        } else if ("toggle_special".equals(action)) {
            // Toggle menu item special status
            int menuItemId = Integer.parseInt(request.getParameter("id"));
            boolean isSpecial = Boolean.parseBoolean(request.getParameter("isSpecial"));

            boolean success = menuItemService.toggleMenuItemSpecial(menuItemId, isSpecial, null);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?success=toggle_special");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=toggle_special");
            }
        } else if ("delete".equals(action)) {
            // Delete menu item
            int menuItemId = Integer.parseInt(request.getParameter("id"));

            boolean success = menuItemService.deleteMenuItem(menuItemId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=delete");
            }
        } else {
            // Invalid action
            response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=invalid_action");
        }
    }
}
