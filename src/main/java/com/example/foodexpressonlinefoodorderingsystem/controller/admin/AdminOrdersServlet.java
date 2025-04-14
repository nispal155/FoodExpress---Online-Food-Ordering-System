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
 * Servlet for managing orders in the admin panel
 */
@WebServlet(name = "AdminOrdersServlet", urlPatterns = {"/admin/orders", "/admin/orders/*"})
public class AdminOrdersServlet extends HttpServlet {

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

        // Get the path info to determine the action
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Show all orders

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

            // Get delivery staff for assignment
            List<User> deliveryStaff = userService.getUsersByRole("DELIVERY");

            // Set attributes for the JSP
            request.setAttribute("orders", orders);
            request.setAttribute("deliveryStaff", deliveryStaff);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("preparingCount", preparingCount);
            request.setAttribute("readyCount", readyCount);
            request.setAttribute("outForDeliveryCount", outForDeliveryCount);
            request.setAttribute("deliveredCount", deliveredCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("needAssignmentCount", needAssignmentCount);
            request.setAttribute("pageTitle", "Manage Orders");

            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);

        } else if (pathInfo.startsWith("/details/")) {
            // Show order details
            try {
                int orderId = Integer.parseInt(pathInfo.substring(9));
                Order order = orderService.getOrderById(orderId);

                if (order == null) {
                    // Order not found
                    response.sendRedirect(request.getContextPath() + "/admin/orders?error=not_found");
                    return;
                }

                // Get delivery staff for assignment
                List<User> deliveryStaff = userService.getUsersByRole("DELIVERY");

                request.setAttribute("order", order);
                request.setAttribute("deliveryStaff", deliveryStaff);
                request.setAttribute("pageTitle", "Order Details #" + order.getId());
                request.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                // Invalid order ID
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid_id");
            }

        } else {
            // Invalid path
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

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

        // Get the path info to determine the action
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Default action - redirect to orders list
            response.sendRedirect(request.getContextPath() + "/admin/orders");

        } else if (pathInfo.startsWith("/assign/")) {
            // Assign order to delivery person
            try {
                int orderId = Integer.parseInt(pathInfo.substring(8));
                String deliveryUserIdStr = request.getParameter("deliveryUserId");

                if (deliveryUserIdStr == null || deliveryUserIdStr.isEmpty()) {
                    // No delivery person selected
                    response.sendRedirect(request.getContextPath() + "/admin/orders/details/" + orderId + "?error=no_delivery_person");
                    return;
                }

                int deliveryUserId = Integer.parseInt(deliveryUserIdStr);
                boolean success = orderService.assignOrderToDeliveryPerson(orderId, deliveryUserId);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/details/" + orderId + "?success=assigned");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/details/" + orderId + "?error=assign_failed");
                }

            } catch (NumberFormatException e) {
                // Invalid order ID or delivery user ID
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid_id");
            }

        } else if (pathInfo.startsWith("/status/")) {
            // Update order status
            try {
                int orderId = Integer.parseInt(pathInfo.substring(8));
                String statusStr = request.getParameter("status");

                if (statusStr == null || statusStr.isEmpty()) {
                    // No status selected
                    response.sendRedirect(request.getContextPath() + "/admin/orders/details/" + orderId + "?error=no_status");
                    return;
                }

                Order.Status status = Order.Status.valueOf(statusStr);
                boolean success = orderService.updateOrderStatus(orderId, status);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/details/" + orderId + "?success=status_updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/details/" + orderId + "?error=status_update_failed");
                }

            } catch (IllegalArgumentException e) {
                // Invalid order ID or status
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid_parameter");
            }

        } else if (pathInfo.startsWith("/cancel/")) {
            // Cancel order
            try {
                int orderId = Integer.parseInt(pathInfo.substring(8));
                boolean success = orderService.cancelOrder(orderId);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/orders?success=order_cancelled");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/orders?error=cancel_failed");
                }

            } catch (NumberFormatException e) {
                // Invalid order ID
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid_id");
            }

        } else {
            // Invalid path
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
}
