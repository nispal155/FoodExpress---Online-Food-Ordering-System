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

/**
 * Servlet for handling the checkout process
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    
    private final OrderService orderService = new OrderService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=checkout");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty-cart");
            return;
        }
        
        // Set attributes for the JSP
        request.setAttribute("cart", cart);
        request.setAttribute("user", user);
        request.setAttribute("pageTitle", "Checkout");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/customer/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=checkout");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty-cart");
            return;
        }
        
        // Get form parameters
        String deliveryAddress = request.getParameter("deliveryAddress");
        String deliveryPhone = request.getParameter("deliveryPhone");
        String deliveryNotes = request.getParameter("deliveryNotes");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Validate input
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty() ||
            deliveryPhone == null || deliveryPhone.trim().isEmpty() ||
            paymentMethod == null || paymentMethod.trim().isEmpty()) {
            
            response.sendRedirect(request.getContextPath() + "/checkout?error=missing-fields");
            return;
        }
        
        try {
            // Parse payment method
            Order.PaymentMethod method = Order.PaymentMethod.valueOf(paymentMethod);
            
            // Create order
            int orderId = orderService.createOrder(
                user.getId(),
                cart,
                method,
                Order.PaymentStatus.PENDING, // Default to pending payment
                deliveryAddress,
                deliveryPhone,
                deliveryNotes
            );
            
            if (orderId > 0) {
                // Clear cart after successful order
                cart.clear();
                session.setAttribute("cart", cart);
                
                // Redirect to order confirmation page
                response.sendRedirect(request.getContextPath() + "/order-confirmation?id=" + orderId);
            } else {
                // Order creation failed
                response.sendRedirect(request.getContextPath() + "/checkout?error=order-failed");
            }
            
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=invalid-payment-method");
        }
    }
}
