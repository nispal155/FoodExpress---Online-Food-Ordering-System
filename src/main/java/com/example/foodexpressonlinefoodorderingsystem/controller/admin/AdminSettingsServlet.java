package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.SystemSettings;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.SystemSettingsService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

/**
 * Servlet for admin settings management
 */
@WebServlet(name = "AdminSettingsServlet", urlPatterns = {"/admin/settings"})
public class AdminSettingsServlet extends HttpServlet {
    
    private final SystemSettingsService settingsService = new SystemSettingsService();
    
    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize system settings with default values if they don't exist
        settingsService.initializeSettings();
    }
    
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
        
        // Get all settings
        List<SystemSettings> allSettings = settingsService.getAllSettings();
        
        // Get business hours
        LocalTime[] businessHours = settingsService.getBusinessHours();
        LocalTime openTime = businessHours[0];
        LocalTime closeTime = businessHours[1];
        
        // Get delivery fees
        String baseFee = settingsService.getSettingValue("delivery_fee_base", "3.99");
        String feePerKm = settingsService.getSettingValue("delivery_fee_per_km", "0.50");
        String freeThreshold = settingsService.getSettingValue("delivery_free_threshold", "30.00");
        
        // Get other settings
        String minOrderAmount = settingsService.getSettingValue("min_order_amount", "10.00");
        String maxDeliveryDistance = settingsService.getSettingValue("max_delivery_distance", "15");
        
        // Get contact information
        String contactEmail = settingsService.getSettingValue("contact_email", "info@foodexpress.com");
        String contactPhone = settingsService.getSettingValue("contact_phone", "+1-555-123-4567");
        String contactAddress = settingsService.getSettingValue("contact_address", "123 Main St, Anytown, USA");
        
        // Set attributes for the JSP
        request.setAttribute("allSettings", allSettings);
        request.setAttribute("openTime", openTime.format(DateTimeFormatter.ofPattern("HH:mm")));
        request.setAttribute("closeTime", closeTime.format(DateTimeFormatter.ofPattern("HH:mm")));
        request.setAttribute("baseFee", baseFee);
        request.setAttribute("feePerKm", feePerKm);
        request.setAttribute("freeThreshold", freeThreshold);
        request.setAttribute("minOrderAmount", minOrderAmount);
        request.setAttribute("maxDeliveryDistance", maxDeliveryDistance);
        request.setAttribute("contactEmail", contactEmail);
        request.setAttribute("contactPhone", contactPhone);
        request.setAttribute("contactAddress", contactAddress);
        request.setAttribute("pageTitle", "System Settings");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        
        if ("update_business_hours".equals(action)) {
            // Update business hours
            String openTimeStr = request.getParameter("openTime");
            String closeTimeStr = request.getParameter("closeTime");
            
            try {
                LocalTime openTime = LocalTime.parse(openTimeStr);
                LocalTime closeTime = LocalTime.parse(closeTimeStr);
                
                boolean success = settingsService.updateBusinessHours(openTime, closeTime);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?success=business_hours");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?error=business_hours");
                }
                
            } catch (DateTimeParseException e) {
                response.sendRedirect(request.getContextPath() + "/admin/settings?error=invalid_time_format");
            }
            
        } else if ("update_delivery_fees".equals(action)) {
            // Update delivery fees
            String baseFeeStr = request.getParameter("baseFee");
            String feePerKmStr = request.getParameter("feePerKm");
            String freeThresholdStr = request.getParameter("freeThreshold");
            
            try {
                double baseFee = Double.parseDouble(baseFeeStr);
                double feePerKm = Double.parseDouble(feePerKmStr);
                double freeThreshold = Double.parseDouble(freeThresholdStr);
                
                boolean success = settingsService.updateDeliveryFees(baseFee, feePerKm, freeThreshold);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?success=delivery_fees");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?error=delivery_fees");
                }
                
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/settings?error=invalid_number_format");
            }
            
        } else if ("update_order_settings".equals(action)) {
            // Update order settings
            String minOrderAmountStr = request.getParameter("minOrderAmount");
            String maxDeliveryDistanceStr = request.getParameter("maxDeliveryDistance");
            
            try {
                double minOrderAmount = Double.parseDouble(minOrderAmountStr);
                int maxDeliveryDistance = Integer.parseInt(maxDeliveryDistanceStr);
                
                boolean success = true;
                
                if (!settingsService.updateSetting("min_order_amount", String.valueOf(minOrderAmount))) {
                    success = false;
                }
                
                if (!settingsService.updateSetting("max_delivery_distance", String.valueOf(maxDeliveryDistance))) {
                    success = false;
                }
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?success=order_settings");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?error=order_settings");
                }
                
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/settings?error=invalid_number_format");
            }
            
        } else if ("update_contact_info".equals(action)) {
            // Update contact information
            String contactEmail = request.getParameter("contactEmail");
            String contactPhone = request.getParameter("contactPhone");
            String contactAddress = request.getParameter("contactAddress");
            
            boolean success = true;
            
            if (!settingsService.updateSetting("contact_email", contactEmail)) {
                success = false;
            }
            
            if (!settingsService.updateSetting("contact_phone", contactPhone)) {
                success = false;
            }
            
            if (!settingsService.updateSetting("contact_address", contactAddress)) {
                success = false;
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/settings?success=contact_info");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings?error=contact_info");
            }
            
        } else if ("update_setting".equals(action)) {
            // Update a specific setting
            String key = request.getParameter("key");
            String value = request.getParameter("value");
            
            if (key != null && !key.isEmpty()) {
                boolean success = settingsService.updateSetting(key, value);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?success=setting_updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/settings?error=setting_update_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings?error=invalid_key");
            }
            
        } else {
            // Invalid action
            response.sendRedirect(request.getContextPath() + "/admin/settings?error=invalid_action");
        }
    }
}
