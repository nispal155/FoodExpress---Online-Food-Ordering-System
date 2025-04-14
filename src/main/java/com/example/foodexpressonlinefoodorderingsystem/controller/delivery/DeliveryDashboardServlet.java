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
import java.util.List;

/**
 * Servlet for handling the delivery staff dashboard
 */
@WebServlet(name = "DeliveryDashboardServlet", urlPatterns = {"/delivery/dashboard"})
public class DeliveryDashboardServlet extends HttpServlet {

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

        // Get assigned orders for the delivery person
        List<Order> assignedOrders = orderService.getOrdersByDeliveryPerson(user.getId());

        // Get orders that are ready for delivery but not yet assigned
        List<Order> availableOrders = orderService.getOrdersReadyForDelivery();

        // Get order counts for dashboard
        int readyCount = 0;
        int outForDeliveryCount = 0;
        int deliveredCount = 0;

        for (Order order : assignedOrders) {
            switch (order.getStatus()) {
                case READY:
                    readyCount++;
                    break;
                case OUT_FOR_DELIVERY:
                    outForDeliveryCount++;
                    break;
                case DELIVERED:
                    deliveredCount++;
                    break;
                default:
                    // Ignore other statuses
                    break;
            }
        }

        // Get completed order count
        int completedCount = orderService.getCompletedOrderCountByDeliveryPerson(user.getId());

        // Set attributes for the JSP
        request.setAttribute("assignedOrders", assignedOrders);
        request.setAttribute("availableOrders", availableOrders);
        request.setAttribute("readyCount", readyCount);
        request.setAttribute("outForDeliveryCount", outForDeliveryCount);
        request.setAttribute("deliveredCount", deliveredCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("totalAssignedCount", assignedOrders.size());

        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/delivery/dashboard.jsp").forward(request, response);
    }
}
