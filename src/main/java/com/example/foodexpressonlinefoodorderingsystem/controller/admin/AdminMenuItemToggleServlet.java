package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.math.BigDecimal;

/**
 * Servlet for toggling menu item properties (availability, special status) in the admin panel
 */
@WebServlet(name = "AdminMenuItemToggleServlet", urlPatterns = {"/admin/menu-items/toggle"})
public class AdminMenuItemToggleServlet extends HttpServlet {
    
    private final MenuItemService menuItemService = new MenuItemService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters
        String menuItemId = request.getParameter("id");
        String action = request.getParameter("action");
        String value = request.getParameter("value");
        
        if (menuItemId != null && !menuItemId.isEmpty() && action != null && !action.isEmpty()) {
            try {
                int id = Integer.parseInt(menuItemId);
                MenuItem menuItem = menuItemService.getMenuItemById(id);
                
                if (menuItem != null) {
                    boolean success = false;
                    
                    // Determine which action to perform
                    if (action.equals("availability")) {
                        boolean isAvailable = value != null && value.equals("true");
                        success = menuItemService.toggleMenuItemAvailability(id, isAvailable);
                    } else if (action.equals("special")) {
                        boolean isSpecial = value != null && value.equals("true");
                        
                        // If marking as special, get the discount price
                        BigDecimal discountPrice = null;
                        if (isSpecial) {
                            String discountPriceStr = request.getParameter("discountPrice");
                            if (discountPriceStr != null && !discountPriceStr.isEmpty()) {
                                try {
                                    discountPrice = new BigDecimal(discountPriceStr);
                                    
                                    // Validate discount price
                                    if (discountPrice.compareTo(menuItem.getPrice()) >= 0) {
                                        response.sendRedirect(request.getContextPath() + 
                                                             "/admin/menu-items?error=invalid-discount");
                                        return;
                                    }
                                } catch (NumberFormatException e) {
                                    response.sendRedirect(request.getContextPath() + 
                                                         "/admin/menu-items?error=invalid-discount");
                                    return;
                                }
                            }
                        }
                        
                        success = menuItemService.toggleMenuItemSpecial(id, isSpecial, discountPrice);
                    }
                    
                    if (success) {
                        // Redirect to menu item list with success message
                        response.sendRedirect(request.getContextPath() + "/admin/menu-items?success=updated");
                    } else {
                        // Redirect to menu item list with error message
                        response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=update-failed");
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
            // Missing parameters
            response.sendRedirect(request.getContextPath() + "/admin/menu-items?error=missing-params");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST requests the same way as GET
        doGet(request, response);
    }
}
