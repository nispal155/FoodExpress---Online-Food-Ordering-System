package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

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
 * Servlet for assigning orders to delivery staff in the admin panel
 */
@WebServlet(name = "AdminOrderAssignServlet", urlPatterns = {"/admin/orders/assign-legacy"})
public class AdminOrderAssignServlet extends HttpServlet {

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

        // Get form parameters
        String orderId = request.getParameter("orderId");
        String deliveryUserId = request.getParameter("deliveryUserId");

        // Validate input
        if (orderId == null || orderId.isEmpty() || deliveryUserId == null || deliveryUserId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=missing-params");
            return;
        }

        try {
            int orderIdInt = Integer.parseInt(orderId);
            int deliveryUserIdInt = Integer.parseInt(deliveryUserId);

            // Assign the order to the delivery person
            boolean success = orderService.assignOrderToDeliveryPerson(orderIdInt, deliveryUserIdInt);

            if (success) {
                // Redirect to order detail with success message
                response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderIdInt + "&success=assigned");
            } else {
                // Redirect to order detail with error message
                response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderIdInt + "&error=assign-failed");
            }

        } catch (NumberFormatException e) {
            // Invalid IDs
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid-params");
        }
    }
}
