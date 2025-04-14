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
import java.io.PrintWriter;

/**
 * Servlet for updating delivery location for real-time tracking
 */
@WebServlet(name = "DeliveryLocationUpdateServlet", urlPatterns = {"/delivery/location/update"})
public class DeliveryLocationUpdateServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is a delivery person
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"Not authenticated\"}");
            out.flush();
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"DELIVERY".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"Not authorized\"}");
            out.flush();
            return;
        }
        
        // Get parameters
        String orderId = request.getParameter("orderId");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");
        
        // Validate input
        if (orderId == null || orderId.isEmpty() || latitude == null || latitude.isEmpty() || 
            longitude == null || longitude.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"Missing required parameters\"}");
            out.flush();
            return;
        }
        
        try {
            int orderIdInt = Integer.parseInt(orderId);
            double latitudeDouble = Double.parseDouble(latitude);
            double longitudeDouble = Double.parseDouble(longitude);
            
            // Get the order to check if it's assigned to this delivery person
            Order order = orderService.getOrderById(orderIdInt);
            
            if (order == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": false, \"message\": \"Order not found\"}");
                out.flush();
                return;
            }
            
            // Check if the order is assigned to this delivery person
            if (order.getDeliveryUserId() == null || order.getDeliveryUserId() != user.getId()) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": false, \"message\": \"Order not assigned to you\"}");
                out.flush();
                return;
            }
            
            // Check if the order is in a valid status for location updates
            if (order.getStatus() != Order.Status.OUT_FOR_DELIVERY) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": false, \"message\": \"Order not out for delivery\"}");
                out.flush();
                return;
            }
            
            // Update the location
            boolean success = orderService.updateDeliveryLocation(orderIdInt, latitudeDouble, longitudeDouble);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            if (success) {
                out.print("{\"success\": true, \"message\": \"Location updated\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to update location\"}");
            }
            
            out.flush();
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"Invalid parameters\"}");
            out.flush();
        }
    }
}
