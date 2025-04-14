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
import java.io.PrintWriter;

/**
 * Servlet for tracking order status
 */
@WebServlet(name = "OrderTrackingServlet", urlPatterns = {"/track-order"})
public class OrderTrackingServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=track-order");
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
            
            // Check if this is an AJAX request for status updates
            String ajaxParam = request.getParameter("ajax");
            if (ajaxParam != null && ajaxParam.equals("true")) {
                // Return only the order status as JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                PrintWriter out = response.getWriter();
                out.print("{\"status\":\"" + order.getStatus().name() + "\",");
                out.print("\"statusDisplay\":\"" + order.getStatus().getDisplayName() + "\",");
                out.print("\"deliveryPersonName\":\"" + (order.getDeliveryPersonName() != null ? order.getDeliveryPersonName() : "") + "\"}");
                out.flush();
                return;
            }
            
            // Set attributes for the JSP
            request.setAttribute("order", order);
            request.setAttribute("pageTitle", "Track Order #" + order.getId());
            
            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/customer/order-tracking.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-orders?error=invalid-id");
        }
    }
}
