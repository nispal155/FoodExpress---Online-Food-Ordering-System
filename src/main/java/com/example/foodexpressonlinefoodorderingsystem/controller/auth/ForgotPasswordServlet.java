package com.example.foodexpressonlinefoodorderingsystem.controller.auth;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.EmailService;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Random;

/**
 * Servlet for handling forgot password requests
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    private final EmailService emailService = new EmailService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Display the forgot password form
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Check if user exists
        User user = userService.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("error", "No account found with this email address");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Generate verification code
        String verificationCode = generateVerificationCode();
        
        // Store verification code in session
        HttpSession session = request.getSession();
        session.setAttribute("resetEmail", email);
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("verificationCodeExpiry", System.currentTimeMillis() + (15 * 60 * 1000)); // 15 minutes
        
        // Send verification code to user's email
        String subject = "Food Express - Password Reset Verification Code";
        String message = "Your verification code for password reset is: " + verificationCode + 
                         "\n\nThis code will expire in 15 minutes.";
        
        boolean emailSent = emailService.sendEmail(email, subject, message);
        
        if (emailSent) {
            // Redirect to verification page
            response.sendRedirect(request.getContextPath() + "/reset-password");
        } else {
            request.setAttribute("error", "Failed to send verification code. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
        }
    }
    
    /**
     * Generate a random 6-digit verification code
     * @return the verification code
     */
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 6-digit code
        return String.valueOf(code);
    }
}
