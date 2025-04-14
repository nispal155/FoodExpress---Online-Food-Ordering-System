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
import java.util.List;

/**
 * Servlet for listing orders in the admin panel
 */
@WebServlet(name = "AdminOrderListServlet", urlPatterns = {"/admin/orders-list"})
public class AdminOrderListServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

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

        // Get filter parameters
        String statusFilter = request.getParameter("status");

        // Get orders based on filter
        List<Order> orders;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            try {
                Order.Status status = Order.Status.valueOf(statusFilter);
                orders = orderService.getOrdersByStatus(status);
                request.setAttribute("statusFilter", status.name());
            } catch (IllegalArgumentException e) {
                // Invalid status, get all orders
                orders = orderService.getAllOrders();
            }
        } else {
            // No filter, get all orders
            orders = orderService.getAllOrders();
        }

        // Get order counts for dashboard
        int pendingCount = orderService.getOrderCountByStatus(Order.Status.PENDING);
        int confirmedCount = orderService.getOrderCountByStatus(Order.Status.CONFIRMED);
        int preparingCount = orderService.getOrderCountByStatus(Order.Status.PREPARING);
        int readyCount = orderService.getOrderCountByStatus(Order.Status.READY);
        int outForDeliveryCount = orderService.getOrderCountByStatus(Order.Status.OUT_FOR_DELIVERY);
        int deliveredCount = orderService.getOrderCountByStatus(Order.Status.DELIVERED);
        int cancelledCount = orderService.getOrderCountByStatus(Order.Status.CANCELLED);
        int needAssignmentCount = orderService.getOrderCountNeedingAssignment();

        // Set attributes for the JSP
        request.setAttribute("orders", orders);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("preparingCount", preparingCount);
        request.setAttribute("readyCount", readyCount);
        request.setAttribute("outForDeliveryCount", outForDeliveryCount);
        request.setAttribute("deliveredCount", deliveredCount);
        request.setAttribute("cancelledCount", cancelledCount);
        request.setAttribute("needAssignmentCount", needAssignmentCount);
        request.setAttribute("pageTitle", "Orders");

        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);
    }
}
