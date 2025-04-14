package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.Cart;
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
 * Servlet for customer orders
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/orders", "/orders/*"})
public class OrderServlet extends HttpServlet {
    
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
        
        // Get the path info to determine the action
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show all orders
            List<Order> orders = orderService.getOrdersByUser(user.getId());
            request.setAttribute("orders", orders);
            request.setAttribute("pageTitle", "My Orders");
            request.getRequestDispatcher("/WEB-INF/views/customer/orders.jsp").forward(request, response);
            
        } else if (pathInfo.startsWith("/details/")) {
            // Show order details
            try {
                int orderId = Integer.parseInt(pathInfo.substring(9));
                Order order = orderService.getOrderById(orderId);
                
                if (order == null || order.getUserId() != user.getId()) {
                    // Order not found or doesn't belong to the user
                    response.sendRedirect(request.getContextPath() + "/orders?error=not_found");
                    return;
                }
                
                request.setAttribute("order", order);
                request.setAttribute("pageTitle", "Order Details #" + order.getId());
                request.getRequestDispatcher("/WEB-INF/views/customer/order-details.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                // Invalid order ID
                response.sendRedirect(request.getContextPath() + "/orders?error=invalid_id");
            }
            
        } else if (pathInfo.equals("/checkout")) {
            // Show checkout page
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (cart == null || cart.getItems().isEmpty()) {
                // Cart is empty
                response.sendRedirect(request.getContextPath() + "/cart?error=empty_cart");
                return;
            }
            
            request.setAttribute("cart", cart);
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "Checkout");
            request.getRequestDispatcher("/WEB-INF/views/customer/checkout.jsp").forward(request, response);
            
        } else {
            // Invalid path
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get the path info to determine the action
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Default action - place order
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (cart == null || cart.getItems().isEmpty()) {
                // Cart is empty
                response.sendRedirect(request.getContextPath() + "/cart?error=empty_cart");
                return;
            }
            
            // Get form parameters
            String paymentMethodStr = request.getParameter("paymentMethod");
            String deliveryAddress = request.getParameter("deliveryAddress");
            String deliveryPhone = request.getParameter("deliveryPhone");
            String deliveryNotes = request.getParameter("deliveryNotes");
            
            // Validate form inputs
            if (paymentMethodStr == null || paymentMethodStr.isEmpty() ||
                deliveryAddress == null || deliveryAddress.isEmpty() ||
                deliveryPhone == null || deliveryPhone.isEmpty()) {
                
                request.setAttribute("error", "Please fill in all required fields");
                request.setAttribute("cart", cart);
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Checkout");
                request.getRequestDispatcher("/WEB-INF/views/customer/checkout.jsp").forward(request, response);
                return;
            }
            
            // Parse payment method
            Order.PaymentMethod paymentMethod;
            try {
                paymentMethod = Order.PaymentMethod.valueOf(paymentMethodStr);
            } catch (IllegalArgumentException e) {
                // Invalid payment method
                request.setAttribute("error", "Invalid payment method");
                request.setAttribute("cart", cart);
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Checkout");
                request.getRequestDispatcher("/WEB-INF/views/customer/checkout.jsp").forward(request, response);
                return;
            }
            
            // Create the order
            int orderId = orderService.createOrder(
                user.getId(),
                cart,
                paymentMethod,
                Order.PaymentStatus.PENDING,
                deliveryAddress,
                deliveryPhone,
                deliveryNotes
            );
            
            if (orderId > 0) {
                // Order created successfully
                session.removeAttribute("cart"); // Clear the cart
                response.sendRedirect(request.getContextPath() + "/orders/details/" + orderId + "?success=order_placed");
            } else {
                // Failed to create order
                request.setAttribute("error", "Failed to place order. Please try again.");
                request.setAttribute("cart", cart);
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Checkout");
                request.getRequestDispatcher("/WEB-INF/views/customer/checkout.jsp").forward(request, response);
            }
            
        } else if (pathInfo.startsWith("/cancel/")) {
            // Cancel order
            try {
                int orderId = Integer.parseInt(pathInfo.substring(8));
                Order order = orderService.getOrderById(orderId);
                
                if (order == null || order.getUserId() != user.getId()) {
                    // Order not found or doesn't belong to the user
                    response.sendRedirect(request.getContextPath() + "/orders?error=not_found");
                    return;
                }
                
                // Check if order can be cancelled
                if (order.getStatus() == Order.Status.PENDING || order.getStatus() == Order.Status.CONFIRMED) {
                    boolean success = orderService.cancelOrder(orderId);
                    
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/orders?success=order_cancelled");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/orders?error=cancel_failed");
                    }
                } else {
                    // Order cannot be cancelled
                    response.sendRedirect(request.getContextPath() + "/orders?error=cannot_cancel");
                }
                
            } catch (NumberFormatException e) {
                // Invalid order ID
                response.sendRedirect(request.getContextPath() + "/orders?error=invalid_id");
            }
            
        } else {
            // Invalid path
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
}
