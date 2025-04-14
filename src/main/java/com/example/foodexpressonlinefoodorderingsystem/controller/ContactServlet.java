package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.SystemSettingsService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet for the Contact Us page
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {
    
    private final SystemSettingsService settingsService = new SystemSettingsService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get contact information from settings
        String contactEmail = settingsService.getSettingValue("contact_email", "info@foodexpress.com");
        String contactPhone = settingsService.getSettingValue("contact_phone", "+1-555-123-4567");
        String contactAddress = settingsService.getSettingValue("contact_address", "123 Main St, Anytown, USA");
        
        // Get user information if logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            request.setAttribute("name", user.getFullName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
        }
        
        // Set attributes for the JSP
        request.setAttribute("contactEmail", contactEmail);
        request.setAttribute("contactPhone", contactPhone);
        request.setAttribute("contactAddress", contactAddress);
        request.setAttribute("pageTitle", "Contact Us");
        
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Validate form inputs
        Map<String, String> errors = validateForm(name, email, subject, message);
        
        if (!errors.isEmpty()) {
            // If there are validation errors, return to the form with error messages
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("subject", subject);
            request.setAttribute("message", message);
            
            // Get contact information from settings
            String contactEmail = settingsService.getSettingValue("contact_email", "info@foodexpress.com");
            String contactPhone = settingsService.getSettingValue("contact_phone", "+1-555-123-4567");
            String contactAddress = settingsService.getSettingValue("contact_address", "123 Main St, Anytown, USA");
            
            request.setAttribute("contactEmail", contactEmail);
            request.setAttribute("contactPhone", contactPhone);
            request.setAttribute("contactAddress", contactAddress);
            request.setAttribute("pageTitle", "Contact Us");
            
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }
        
        // In a real application, you would send the message via email or save to database
        // For now, we'll just simulate success
        
        // Redirect to success page
        response.sendRedirect(request.getContextPath() + "/contact?success=true");
    }
    
    /**
     * Validate the contact form inputs
     * @param name the name
     * @param email the email
     * @param subject the subject
     * @param message the message
     * @return Map of field names to error messages, empty if no errors
     */
    private Map<String, String> validateForm(String name, String email, String subject, String message) {
        Map<String, String> errors = new HashMap<>();
        
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Name is required");
        } else if (name.length() < 2) {
            errors.put("name", "Name must be at least 2 characters");
        } else if (name.length() > 100) {
            errors.put("name", "Name cannot exceed 100 characters");
        }
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required");
        } else if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errors.put("email", "Please enter a valid email address");
        }
        
        // Validate subject
        if (subject == null || subject.trim().isEmpty()) {
            errors.put("subject", "Subject is required");
        } else if (subject.length() < 5) {
            errors.put("subject", "Subject must be at least 5 characters");
        } else if (subject.length() > 200) {
            errors.put("subject", "Subject cannot exceed 200 characters");
        }
        
        // Validate message
        if (message == null || message.trim().isEmpty()) {
            errors.put("message", "Message is required");
        } else if (message.length() < 10) {
            errors.put("message", "Message must be at least 10 characters");
        } else if (message.length() > 2000) {
            errors.put("message", "Message cannot exceed 2000 characters");
        }
        
        return errors;
    }
}
