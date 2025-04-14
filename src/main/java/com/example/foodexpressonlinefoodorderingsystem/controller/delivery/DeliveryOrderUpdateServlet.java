package com.example.foodexpressonlinefoodorderingsystem.controller.delivery;

import com.example.foodexpressonlinefoodorderingsystem.model.Order;
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
 * Servlet for updating order status by a delivery person
 */
@WebServlet(name = "DeliveryOrderUpdateServlet", urlPatterns = {"/delivery/orders/update"})
public class DeliveryOrderUpdateServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is a delivery person
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"DELIVERY".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Get form parameters
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        // Validate input
        if (orderId == null || orderId.isEmpty() || status == null || status.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/delivery/orders?error=missing-params");
            return;
        }
        
        try {
            int orderIdInt = Integer.parseInt(orderId);
            Order.Status newStatus = Order.Status.valueOf(status);
            
            // Get the order to check if it's assigned to this delivery person
            Order order = orderService.getOrderById(orderIdInt);
            
            if (order == null) {
                // Order not found
                response.sendRedirect(request.getContextPath() + "/delivery/orders?error=not-found");
                return;
            }
            
            // Check if the order is assigned to this delivery person
            if (order.getDeliveryUserId() == null || order.getDeliveryUserId() != user.getId()) {
                // Order not assigned to this delivery person
                response.sendRedirect(request.getContextPath() + "/delivery/orders?error=not-assigned");
                return;
            }
            
            // Check if the new status is valid for a delivery person to set
            if (newStatus != Order.Status.OUT_FOR_DELIVERY && newStatus != Order.Status.DELIVERED) {
                // Invalid status for delivery person
                response.sendRedirect(request.getContextPath() + "/delivery/orders/detail?id=" + orderIdInt + "&error=invalid-status");
                return;
            }
            
            // Update the order status
            boolean success = orderService.updateOrderStatus(orderIdInt, newStatus);
            
            if (success) {
                // Redirect to order detail with success message
                response.sendRedirect(request.getContextPath() + "/delivery/orders/detail?id=" + orderIdInt + "&success=status-updated");
            } else {
                // Redirect to order detail with error message
                response.sendRedirect(request.getContextPath() + "/delivery/orders/detail?id=" + orderIdInt + "&error=status-update-failed");
            }
            
        } catch (NumberFormatException e) {
            // Invalid order ID
            response.sendRedirect(request.getContextPath() + "/delivery/orders?error=invalid-id");
        } catch (IllegalArgumentException e) {
            // Invalid status
            response.sendRedirect(request.getContextPath() + "/delivery/orders?error=invalid-status");
        }
    }
}
