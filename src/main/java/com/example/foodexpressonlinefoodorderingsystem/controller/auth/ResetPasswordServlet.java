package com.example.foodexpressonlinefoodorderingsystem.controller.auth;

import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for handling password reset
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if reset email is in session
        HttpSession session = request.getSession();
        String resetEmail = (String) session.getAttribute("resetEmail");
        
        if (resetEmail == null) {
            // No reset in progress, redirect to forgot password
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }
        
        // Display the reset password form
        request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String resetEmail = (String) session.getAttribute("resetEmail");
        String storedCode = (String) session.getAttribute("verificationCode");
        Long expiry = (Long) session.getAttribute("verificationCodeExpiry");
        
        // Check if reset is in progress
        if (resetEmail == null || storedCode == null || expiry == null) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }
        
        // Check if code has expired
        if (System.currentTimeMillis() > expiry) {
            request.setAttribute("error", "Verification code has expired. Please request a new one.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Get form data
        String verificationCode = request.getParameter("verificationCode");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (verificationCode == null || verificationCode.trim().isEmpty()) {
            request.setAttribute("error", "Verification code is required");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "New password is required");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Verify code
        if (!verificationCode.equals(storedCode)) {
            request.setAttribute("error", "Invalid verification code");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Reset password
        boolean success = userService.resetPassword(resetEmail, newPassword);
        
        if (success) {
            // Clear session attributes
            session.removeAttribute("resetEmail");
            session.removeAttribute("verificationCode");
            session.removeAttribute("verificationCodeExpiry");
            
            // Set success message and redirect to login
            session.setAttribute("message", "Password has been reset successfully. Please login with your new password.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
        }
    }
}
