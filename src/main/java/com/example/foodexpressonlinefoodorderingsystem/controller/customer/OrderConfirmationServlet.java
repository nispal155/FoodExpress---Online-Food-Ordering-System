package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

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
 * Servlet for displaying order confirmation
 */
@WebServlet(name = "OrderConfirmationServlet", urlPatterns = {"/order-confirmation"})
public class OrderConfirmationServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get order ID from request parameter
        String orderId = request.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
            return;
        }
        
        try {
            int id = Integer.parseInt(orderId);
            
            // Get order details
            Order order = orderService.getOrderById(id);
            
            // Check if order exists and belongs to the user
            if (order == null || order.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/my-orders?error=not-found");
                return;
            }
            
            // Set attributes for the JSP
            request.setAttribute("order", order);
            request.setAttribute("pageTitle", "Order Confirmation");
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/customer/order-confirmation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-orders?error=invalid-id");
        }
    }
}
