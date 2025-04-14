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
 * Servlet for handling order assignment to delivery personnel
 */
@WebServlet(name = "DeliveryOrderAssignmentServlet", urlPatterns = {"/admin/orders/assign"})
public class DeliveryOrderAssignmentServlet extends HttpServlet {
    
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
        
        // Get order ID from request
        String orderId = request.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=missing-id");
            return;
        }
        
        try {
            int id = Integer.parseInt(orderId);
            Order order = orderService.getOrderById(id);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=not-found");
                return;
            }
            
            // Get all delivery personnel
            List<User> deliveryPersonnel = userService.getUsersByRole("DELIVERY");
            
            // Set attributes for the JSP
            request.setAttribute("order", order);
            request.setAttribute("deliveryPersonnel", deliveryPersonnel);
            request.setAttribute("pageTitle", "Assign Order #" + order.getId());
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/order-assign.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid-id");
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
        
        // Get form parameters
        String orderId = request.getParameter("orderId");
        String deliveryUserId = request.getParameter("deliveryUserId");
        
        // Validate input
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=missing-order-id");
            return;
        }
        
        try {
            int orderIdInt = Integer.parseInt(orderId);
            Integer deliveryUserIdInt = null;
            
            // If deliveryUserId is not empty, parse it
            if (deliveryUserId != null && !deliveryUserId.isEmpty() && !deliveryUserId.equals("0")) {
                deliveryUserIdInt = Integer.parseInt(deliveryUserId);
            }
            
            // Assign or unassign the order
            boolean success = orderService.assignOrderToDeliveryPerson(orderIdInt, deliveryUserIdInt);
            
            if (success) {
                // Redirect to order detail with success message
                if (deliveryUserIdInt == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderIdInt + "&success=unassigned");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderIdInt + "&success=assigned");
                }
            } else {
                // Redirect to order detail with error message
                response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderIdInt + "&error=assignment-failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid-id");
        }
    }
}
