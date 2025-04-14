package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for cancelling orders in the admin panel
 */
@WebServlet(name = "AdminOrderCancelServlet", urlPatterns = {"/admin/orders/cancel"})
public class AdminOrderCancelServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
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
        
        // Get the order ID
        String orderId = request.getParameter("orderId");
        
        // Validate input
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=missing-params");
            return;
        }
        
        try {
            int orderIdInt = Integer.parseInt(orderId);
            
            // Cancel the order
            boolean success = orderService.cancelOrder(orderIdInt);
            
            if (success) {
                // Redirect to order list with success message
                response.sendRedirect(request.getContextPath() + "/admin/orders?success=cancelled");
            } else {
                // Redirect to order list with error message
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=cancel-failed");
            }
            
        } catch (NumberFormatException e) {
            // Invalid order ID
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid-id");
        }
    }
}
