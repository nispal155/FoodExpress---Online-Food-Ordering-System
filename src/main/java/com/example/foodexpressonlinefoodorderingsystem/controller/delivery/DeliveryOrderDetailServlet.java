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
 * Servlet for viewing order details for a delivery person
 */
@WebServlet(name = "DeliveryOrderDetailServlet", urlPatterns = {"/delivery/orders/detail"})
public class DeliveryOrderDetailServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
        
        // Get the order ID
        String orderId = request.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/delivery/orders");
            return;
        }
        
        try {
            int id = Integer.parseInt(orderId);
            Order order = orderService.getOrderById(id);
            
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
            
            // Set attributes for the JSP
            request.setAttribute("order", order);
            request.setAttribute("pageTitle", "Order #" + order.getId());
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/delivery/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Invalid order ID
            response.sendRedirect(request.getContextPath() + "/delivery/orders?error=invalid-id");
        }
    }
}
