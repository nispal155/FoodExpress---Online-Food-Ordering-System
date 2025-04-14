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
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet for listing orders assigned to a delivery person
 */
@WebServlet(name = "DeliveryOrderListServlet", urlPatterns = {"/delivery/orders"})
public class DeliveryOrderListServlet extends HttpServlet {
    
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
        
        // Get filter parameters
        String statusFilter = request.getParameter("status");
        
        // Get all orders assigned to the delivery person
        List<Order> allOrders = orderService.getOrdersByDeliveryPerson(user.getId());
        
        // Filter orders by status if needed
        List<Order> filteredOrders;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            try {
                Order.Status status = Order.Status.valueOf(statusFilter);
                filteredOrders = new ArrayList<>();
                
                for (Order order : allOrders) {
                    if (order.getStatus() == status) {
                        filteredOrders.add(order);
                    }
                }
                
                request.setAttribute("statusFilter", status.name());
            } catch (IllegalArgumentException e) {
                // Invalid status, use all orders
                filteredOrders = allOrders;
            }
        } else {
            // No filter, use all orders
            filteredOrders = allOrders;
        }
        
        // Set attributes for the JSP
        request.setAttribute("orders", filteredOrders);
        request.setAttribute("pageTitle", "My Orders");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/delivery/orders.jsp").forward(request, response);
    }
}
