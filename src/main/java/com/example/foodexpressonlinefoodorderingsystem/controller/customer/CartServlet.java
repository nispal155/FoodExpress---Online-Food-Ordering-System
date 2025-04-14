package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.Cart;
import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for managing the shopping cart
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    
    private final MenuItemService menuItemService = new MenuItemService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=cart");
            return;
        }
        
        // Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        // Set attributes for the JSP
        request.setAttribute("cart", cart);
        request.setAttribute("pageTitle", "Shopping Cart");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/customer/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=cart");
            return;
        }
        
        // Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        // Get action parameter
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // Add item to cart
            addToCart(request, response, cart);
        } else if ("update".equals(action)) {
            // Update item quantity
            updateCart(request, response, cart);
        } else if ("remove".equals(action)) {
            // Remove item from cart
            removeFromCart(request, response, cart);
        } else if ("clear".equals(action)) {
            // Clear cart
            clearCart(request, response, cart);
        } else {
            // Invalid action
            response.sendRedirect(request.getContextPath() + "/cart?error=invalid-action");
        }
    }
    
    /**
     * Add an item to the cart
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response, Cart cart) 
            throws IOException {
        
        try {
            // Get parameters
            int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String specialInstructions = request.getParameter("specialInstructions");
            
            // Validate quantity
            if (quantity <= 0) {
                response.sendRedirect(request.getContextPath() + "/cart?error=invalid-quantity");
                return;
            }
            
            // Get menu item
            MenuItem menuItem = menuItemService.getMenuItemById(menuItemId);
            if (menuItem == null || !menuItem.isAvailable()) {
                response.sendRedirect(request.getContextPath() + "/cart?error=item-not-available");
                return;
            }
            
            // Add to cart
            boolean success = cart.addItem(menuItem, quantity, specialInstructions);
            
            if (success) {
                // Redirect back to the referring page or to the cart
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.contains("/cart")) {
                    response.sendRedirect(referer + "#menu-item-" + menuItemId);
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart?success=added");
                }
            } else {
                // Item from different restaurant
                response.sendRedirect(request.getContextPath() + "/cart?error=different-restaurant");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart?error=invalid-parameters");
        }
    }
    
    /**
     * Update item quantity in the cart
     */
    private void updateCart(HttpServletRequest request, HttpServletResponse response, Cart cart) 
            throws IOException {
        
        try {
            // Get parameters
            int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Update cart
            boolean success = cart.updateItemQuantity(menuItemId, quantity);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/cart?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/cart?error=update-failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart?error=invalid-parameters");
        }
    }
    
    /**
     * Remove an item from the cart
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, Cart cart) 
            throws IOException {
        
        try {
            // Get parameters
            int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
            
            // Remove from cart
            boolean success = cart.removeItem(menuItemId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/cart?success=removed");
            } else {
                response.sendRedirect(request.getContextPath() + "/cart?error=remove-failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart?error=invalid-parameters");
        }
    }
    
    /**
     * Clear the cart
     */
    private void clearCart(HttpServletRequest request, HttpServletResponse response, Cart cart) 
            throws IOException {
        
        // Clear cart
        cart.clear();
        
        // Redirect to cart page
        response.sendRedirect(request.getContextPath() + "/cart?success=cleared");
    }
}
