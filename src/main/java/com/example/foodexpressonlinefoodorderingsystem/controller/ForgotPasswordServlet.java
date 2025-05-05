package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.EmailService;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;
import com.example.foodexpressonlinefoodorderingsystem.util.VerificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet for handling forgot password functionality
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private final UserService userService = new UserService();
    // EmailService has static methods, no need to instantiate
    private static final int VERIFICATION_CODE_LENGTH = 6;
    private static final int VERIFICATION_CODE_EXPIRY_MINUTES = 15;

    @Override
    public void init() throws ServletException {
        super.init();
        // Check if verification code columns exist and add them if they don't
        checkAndAddVerificationCodeColumns();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Forward to the forgot password page
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("request".equals(action)) {
            // Step 1: Handle the initial request for password reset
            handlePasswordResetRequest(request, response);
        } else if ("verify".equals(action)) {
            // Step 2: Verify the code and show password reset form
            handleVerificationCode(request, response);
        } else if ("reset".equals(action)) {
            // Step 3: Reset the password
            handlePasswordReset(request, response);
        } else {
            // Invalid action, redirect to forgot password page
            response.sendRedirect(request.getContextPath() + "/forgot-password");
        }
    }

    /**
     * Handle the initial request for password reset
     */
    private void handlePasswordResetRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Please enter your email address");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            return;
        }

        // Check if the email exists in the database
        User user = userService.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "No account found with this email address");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            return;
        }

        // Generate a verification code
        String verificationCode = VerificationUtil.generateVerificationCode(VERIFICATION_CODE_LENGTH);

        // Save the verification code in the database
        boolean success = userService.setVerificationCode(email, verificationCode, VERIFICATION_CODE_EXPIRY_MINUTES);

        if (!success) {
            request.setAttribute("error", "Failed to generate verification code. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            return;
        }

        // Send the verification code via email
        boolean emailSent = EmailService.sendVerificationCode(email, verificationCode);

        if (!emailSent) {
            // Email sending failed
            request.setAttribute("error", "Failed to send verification email. Please try again or contact support.");

            // For development purposes, show the code on screen
            request.setAttribute("showCode", true);
            request.setAttribute("verificationCode", verificationCode);
            request.setAttribute("message", "Email sending failed. Please use the verification code below.");

            // Don't clear the verification code so user can still use it
            // userService.clearVerificationCode(email);

            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            return;
        }

        // Store the email in session for the next step
        HttpSession session = request.getSession();
        session.setAttribute("resetEmail", email);

        // Redirect to the verification page
        request.setAttribute("message", "A verification code has been sent to your email address. Please check your inbox.");
        request.getRequestDispatcher("/WEB-INF/views/verify-code.jsp").forward(request, response);
    }

    /**
     * Handle verification code submission
     */
    private void handleVerificationCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            // No email in session, redirect to forgot password page
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        String verificationCode = request.getParameter("code");

        if (verificationCode == null || verificationCode.trim().isEmpty()) {
            request.setAttribute("error", "Please enter the verification code");
            request.getRequestDispatcher("/WEB-INF/views/verify-code.jsp").forward(request, response);
            return;
        }

        // Verify the code
        boolean isValid = userService.verifyVerificationCode(email, verificationCode);

        if (!isValid) {
            request.setAttribute("error", "Invalid or expired verification code");
            request.getRequestDispatcher("/WEB-INF/views/verify-code.jsp").forward(request, response);
            return;
        }

        // Code is valid, show the reset password form
        request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
    }

    /**
     * Handle password reset
     */
    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            // No email in session, redirect to forgot password page
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "Please enter and confirm your new password");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            return;
        }

        // Reset the password
        boolean success = userService.resetPassword(email, newPassword);

        if (!success) {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            return;
        }

        // Clear the verification code
        userService.clearVerificationCode(email);

        // Clear the session attribute
        session.removeAttribute("resetEmail");

        // Redirect to login page with success message
        response.sendRedirect(request.getContextPath() + "/login?message=Password+reset+successful.+Please+login+with+your+new+password.");
    }

    /**
     * Check if verification code columns exist in users table and add them if they don't
     */
    private void checkAndAddVerificationCodeColumns() {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.err.println("ERROR: Could not connect to database!");
                return;
            }

            // Check if verification_code column exists
            boolean verificationCodeExists = false;
            DatabaseMetaData metaData = conn.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, "users", "verification_code")) {
                verificationCodeExists = columns.next();
            }

            if (!verificationCodeExists) {
                // Add verification_code column
                System.out.println("Adding verification_code column to users table...");
                try (Statement stmt = conn.createStatement()) {
                    String sql = "ALTER TABLE users ADD COLUMN verification_code VARCHAR(10) DEFAULT NULL";
                    stmt.executeUpdate(sql);
                    System.out.println("verification_code column added successfully!");
                }
            }

            // Check if verification_code_expiry column exists
            boolean expiryExists = false;
            try (ResultSet columns = metaData.getColumns(null, null, "users", "verification_code_expiry")) {
                expiryExists = columns.next();
            }

            if (!expiryExists) {
                // Add verification_code_expiry column
                System.out.println("Adding verification_code_expiry column to users table...");
                try (Statement stmt = conn.createStatement()) {
                    String sql = "ALTER TABLE users ADD COLUMN verification_code_expiry TIMESTAMP DEFAULT NULL";
                    stmt.executeUpdate(sql);
                    System.out.println("verification_code_expiry column added successfully!");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error checking/adding verification code columns: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
