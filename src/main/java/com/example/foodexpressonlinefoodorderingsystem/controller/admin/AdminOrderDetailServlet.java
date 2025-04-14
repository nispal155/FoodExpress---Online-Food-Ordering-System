package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.Order;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.OrderService;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for viewing order details in the admin panel
 */
@WebServlet(name = "AdminOrderDetailServlet", urlPatterns = {"/admin/orders/detail"})
public class AdminOrderDetailServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    private final UserService userService = new UserService();
    
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
        
        // Get the order ID
        String orderId = request.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        
        try {
            int id = Integer.parseInt(orderId);
            Order order = orderService.getOrderById(id);
            
            if (order == null) {
                // Order not found
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=not-found");
                return;
            }
            
            // Get delivery staff for assignment
            List<User> deliveryStaff = userService.getDeliveryStaff();
            
            // Set attributes for the JSP
            request.setAttribute("order", order);
            request.setAttribute("deliveryStaff", deliveryStaff);
            request.setAttribute("pageTitle", "Order #" + order.getId());
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Invalid order ID
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid-id");
        }
    }
}
