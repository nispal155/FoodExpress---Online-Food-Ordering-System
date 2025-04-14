package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.Category;
import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.service.CategoryService;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;
import com.example.foodexpressonlinefoodorderingsystem.util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;

/**
 * Servlet for saving menu items (add/edit) in the admin panel
 */
@WebServlet(name = "AdminMenuItemSaveServlet", urlPatterns = {"/admin/menu-items/save"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class AdminMenuItemSaveServlet extends HttpServlet {

    private final MenuItemService menuItemService = new MenuItemService();
    private final RestaurantService restaurantService = new RestaurantService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String menuItemIdStr = request.getParameter("id");
        String restaurantIdStr = request.getParameter("restaurantId");
        String categoryIdStr = request.getParameter("categoryId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String isAvailableStr = request.getParameter("isAvailable");
        String isSpecialStr = request.getParameter("isSpecial");
        String discountPriceStr = request.getParameter("discountPrice");

        // Validate required fields
        if (restaurantIdStr == null || restaurantIdStr.isEmpty() ||
            categoryIdStr == null || categoryIdStr.isEmpty() ||
            name == null || name.isEmpty() ||
            priceStr == null || priceStr.isEmpty()) {

            // Get all restaurants and categories for the form
            request.setAttribute("restaurants", restaurantService.getAllRestaurants());
            request.setAttribute("categories", categoryService.getAllCategories());
            request.setAttribute("error", "All required fields must be filled");
            request.setAttribute("pageTitle", menuItemIdStr == null || menuItemIdStr.isEmpty() ? "Add Menu Item" : "Edit Menu Item");

            // Create a temporary menu item to preserve form values
            MenuItem tempMenuItem = new MenuItem();
            if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
                try {
                    tempMenuItem.setRestaurantId(Integer.parseInt(restaurantIdStr));
                } catch (NumberFormatException e) {
                    // Ignore parsing error
                }
            }
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                try {
                    tempMenuItem.setCategoryId(Integer.parseInt(categoryIdStr));
                } catch (NumberFormatException e) {
                    // Ignore parsing error
                }
            }
            tempMenuItem.setName(name != null ? name : "");
            tempMenuItem.setDescription(description != null ? description : "");
            if (priceStr != null && !priceStr.isEmpty()) {
                try {
                    tempMenuItem.setPrice(new BigDecimal(priceStr));
                } catch (NumberFormatException e) {
                    // Ignore parsing error
                }
            }
            tempMenuItem.setAvailable(isAvailableStr != null && isAvailableStr.equals("on"));
            tempMenuItem.setSpecial(isSpecialStr != null && isSpecialStr.equals("on"));
            if (discountPriceStr != null && !discountPriceStr.isEmpty()) {
                try {
                    tempMenuItem.setDiscountPrice(new BigDecimal(discountPriceStr));
                } catch (NumberFormatException e) {
                    // Ignore parsing error
                }
            }
            request.setAttribute("menuItem", tempMenuItem);

            request.getRequestDispatcher("/WEB-INF/views/admin/menu-item-form.jsp").forward(request, response);
            return;
        }

        try {
            // Parse numeric values
            int restaurantId = Integer.parseInt(restaurantIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            BigDecimal price = new BigDecimal(priceStr);
            boolean isAvailable = isAvailableStr != null && isAvailableStr.equals("on");
            boolean isSpecial = isSpecialStr != null && isSpecialStr.equals("on");
            BigDecimal discountPrice = null;

            if (isSpecial && discountPriceStr != null && !discountPriceStr.isEmpty()) {
                discountPrice = new BigDecimal(discountPriceStr);

                // Validate discount price
                if (discountPrice.compareTo(price) >= 0) {
                    // Get all restaurants and categories for the form
                    request.setAttribute("restaurants", restaurantService.getAllRestaurants());
                    request.setAttribute("categories", categoryService.getAllCategories());
                    request.setAttribute("error", "Discount price must be less than regular price");
                    request.setAttribute("pageTitle", menuItemIdStr == null || menuItemIdStr.isEmpty() ? "Add Menu Item" : "Edit Menu Item");

                    // Create a temporary menu item to preserve form values
                    MenuItem tempMenuItem = new MenuItem();
                    tempMenuItem.setRestaurantId(restaurantId);
                    tempMenuItem.setCategoryId(categoryId);
                    tempMenuItem.setName(name);
                    tempMenuItem.setDescription(description);
                    tempMenuItem.setPrice(price);
                    tempMenuItem.setAvailable(isAvailable);
                    tempMenuItem.setSpecial(isSpecial);
                    tempMenuItem.setDiscountPrice(discountPrice);
                    request.setAttribute("menuItem", tempMenuItem);

                    request.getRequestDispatcher("/WEB-INF/views/admin/menu-item-form.jsp").forward(request, response);
                    return;
                }
            }

            // Create or update menu item
            MenuItem menuItem;
            boolean isNewMenuItem = menuItemIdStr == null || menuItemIdStr.isEmpty();

            if (isNewMenuItem) {
                // Create new menu item
                menuItem = new MenuItem();
            } else {
                // Update existing menu item
                int menuItemId = Integer.parseInt(menuItemIdStr);
                menuItem = menuItemService.getMenuItemById(menuItemId);

                if (menuItem == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/menu-items");
                    return;
                }
            }

            // Set menu item properties
            menuItem.setRestaurantId(restaurantId);
            menuItem.setCategoryId(categoryId);
            menuItem.setName(name);
            menuItem.setDescription(description);
            menuItem.setPrice(price);
            menuItem.setAvailable(isAvailable);
            menuItem.setSpecial(isSpecial);
            menuItem.setDiscountPrice(discountPrice);

            // Handle image upload
            String imageUrl = FileUploadUtil.uploadMenuItemImage(request, "image");
            if (imageUrl != null) {
                // If updating and there's an existing image, delete it
                if (!isNewMenuItem && menuItem.getImageUrl() != null && !menuItem.getImageUrl().isEmpty()) {
                    FileUploadUtil.deleteFile(request, menuItem.getImageUrl());
                }
                menuItem.setImageUrl(imageUrl);
            }

            // Save the menu item
            boolean success;
            if (isNewMenuItem) {
                success = menuItemService.createMenuItem(menuItem);
            } else {
                success = menuItemService.updateMenuItem(menuItem);
            }

            if (success) {
                // Redirect to menu item list with success message
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?success=" +
                                     (isNewMenuItem ? "created" : "updated"));
            } else {
                // Forward back to form with error message
                // Get all restaurants and categories for the form
                request.setAttribute("restaurants", restaurantService.getAllRestaurants());
                request.setAttribute("categories", categoryService.getAllCategories());
                request.setAttribute("error", "Failed to save menu item");
                request.setAttribute("pageTitle", menuItemIdStr == null || menuItemIdStr.isEmpty() ? "Add Menu Item" : "Edit Menu Item");
                request.setAttribute("menuItem", menuItem);
                request.getRequestDispatcher("/WEB-INF/views/admin/menu-item-form.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            // Invalid numeric input
            // Get all restaurants and categories for the form
            request.setAttribute("restaurants", restaurantService.getAllRestaurants());
            request.setAttribute("categories", categoryService.getAllCategories());
            request.setAttribute("error", "Invalid numeric input");
            request.setAttribute("pageTitle", menuItemIdStr == null || menuItemIdStr.isEmpty() ? "Add Menu Item" : "Edit Menu Item");

            // Create a temporary menu item to preserve form values
            MenuItem tempMenuItem = new MenuItem();
            if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
                try {
                    tempMenuItem.setRestaurantId(Integer.parseInt(restaurantIdStr));
                } catch (NumberFormatException ignored) {
                    // Already caught the exception
                }
            }
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                try {
                    tempMenuItem.setCategoryId(Integer.parseInt(categoryIdStr));
                } catch (NumberFormatException ignored) {
                    // Already caught the exception
                }
            }
            tempMenuItem.setName(name != null ? name : "");
            tempMenuItem.setDescription(description != null ? description : "");
            tempMenuItem.setAvailable(isAvailableStr != null && isAvailableStr.equals("on"));
            tempMenuItem.setSpecial(isSpecialStr != null && isSpecialStr.equals("on"));
            request.setAttribute("menuItem", tempMenuItem);

            request.getRequestDispatcher("/WEB-INF/views/admin/menu-item-form.jsp").forward(request, response);
        }
    }
}
