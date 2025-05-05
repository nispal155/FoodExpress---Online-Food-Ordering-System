package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for deleting menu items in the admin panel
 */
@WebServlet(name = "AdminMenuItemDeleteServlet", urlPatterns = {"/admin/menu-items/delete"})
public class AdminMenuItemDeleteServlet extends HttpServlet {
    
    private final MenuItemService menuItemService = new MenuItemService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the menu item ID
        String menuItemId = request.getParameter("id");
        
        if (menuItemId != null && !menuItemId.isEmpty()) {
            try {
                int id = Integer.parseInt(menuItemId);
                
                // Get the menu item to delete its image
                MenuItem menuItem = menuItemService.getMenuItemById(id);
                
                if (menuItem != null) {
                    // Delete the menu item
                    boolean success = menuItemService.deleteMenuItem(id);
                    
                    if (success) {
                        // Delete the image file if it exists
                        if (menuItem.getImageUrl() != null && !menuItem.getImageUrl().isEmpty()) {
                            FileUploadUtil.deleteFile(request, menuItem.getImageUrl());
                        }
                        
                        // Redirect to menu item list with success message
                        response.sendRedirect(request.getContextPath() + "/admin/menu-items?success=deleted");
                    } else {
                        // Redirect to menu item list with error message
                        response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=delete-failed");
                    }
                } else {
                    // Menu item not found
                    response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=not-found");
                }
            } catch (NumberFormatException e) {
                // Invalid ID
                response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=invalid-id");
            }
        } else {
            // No ID provided
            response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=no-id");
        }
    }
}
