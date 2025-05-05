package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.service.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet for testing email functionality
 */
@WebServlet("/test-email")
public class TestEmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Email</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
        out.println("h1 { color: #FF5722; }");
        out.println("form { margin-top: 20px; }");
        out.println("label { display: block; margin-bottom: 5px; }");
        out.println("input[type=email] { width: 300px; padding: 8px; margin-bottom: 15px; }");
        out.println("input[type=submit] { background-color: #FF5722; color: white; padding: 10px 15px; border: none; cursor: pointer; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Test Email Functionality</h1>");

        // Display message if any
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
            out.println("<p style='color: green;'>" + message + "</p>");
        }

        // Display error if any
        String error = request.getParameter("error");
        if (error != null && !error.isEmpty()) {
            out.println("<p style='color: red;'>" + error + "</p>");
        }

        out.println("<form method='post'>");
        out.println("<label for='email'>Email Address:</label>");
        out.println("<input type='email' id='email' name='email' required>");
        out.println("<input type='submit' value='Send Test Email'>");
        out.println("</form>");
        out.println("</body>");
        out.println("</html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/test-email?error=Please+enter+an+email+address");
            return;
        }

        // Generate a test code
        String testCode = "TEST123";

        try {
            // Send the test email using the static method
            boolean emailSent = EmailService.sendEmail(email, "Test Email from Food Express",
                    "This is a test email from Food Express. Your verification code is: " + testCode, true);

            if (emailSent) {
                response.sendRedirect(request.getContextPath() + "/test-email?message=Test+email+sent+successfully+to+" + email);
            } else {
                response.sendRedirect(request.getContextPath() + "/test-email?error=Failed+to+send+test+email.+Check+server+logs+for+details.");
            }
        } catch (Exception e) {
            System.err.println("Error sending test email: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/test-email?error=Error+sending+email:+" + e.getMessage());
        }
    }
}
