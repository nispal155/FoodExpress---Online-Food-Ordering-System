package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.Setting;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.SettingsService;
import com.example.foodexpressonlinefoodorderingsystem.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet for handling user account settings
 */
@WebServlet(name = "SettingsServlet", urlPatterns = {"/settings", "/settings/*"})
public class SettingsServlet extends HttpServlet {

    private final SettingsService settingsService = new SettingsService();

    @Override
    public void init() throws ServletException {
        super.init();
        // Create the settings table if it doesn't exist
        settingsService.createSettingsTableIfNotExists();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the path info to determine the settings category
        String pathInfo = request.getPathInfo();
        String category = "account"; // Default category
        
        if (pathInfo != null && !pathInfo.equals("/")) {
            category = pathInfo.substring(1); // Remove the leading slash
        }
        
        // Set the user in the request
        request.setAttribute("user", user);
        
        // Set the active category
        request.setAttribute("activeCategory", category);
        
        // Forward to the appropriate settings page based on category
        switch (category) {
            case "notifications":
                showNotificationSettings(request, response);
                break;
            case "payment":
                showPaymentSettings(request, response);
                break;
            case "privacy":
                showPrivacySettings(request, response);
                break;
            case "preferences":
                showPreferenceSettings(request, response);
                break;
            case "account":
            default:
                showAccountSettings(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the path info to determine the settings category
        String pathInfo = request.getPathInfo();
        String category = "account"; // Default category
        
        if (pathInfo != null && !pathInfo.equals("/")) {
            category = pathInfo.substring(1); // Remove the leading slash
        }
        
        // Process the form submission based on category
        boolean success = false;
        String message = "";
        
        switch (category) {
            case "notifications":
                success = updateNotificationSettings(request, user);
                message = success ? "Notification settings updated successfully" : "Failed to update notification settings";
                break;
            case "payment":
                success = updatePaymentSettings(request, user);
                message = success ? "Payment settings updated successfully" : "Failed to update payment settings";
                break;
            case "privacy":
                success = updatePrivacySettings(request, user);
                message = success ? "Privacy settings updated successfully" : "Failed to update privacy settings";
                break;
            case "preferences":
                success = updatePreferenceSettings(request, user);
                message = success ? "Preference settings updated successfully" : "Failed to update preference settings";
                break;
            case "account":
            default:
                success = updateAccountSettings(request, user);
                message = success ? "Account settings updated successfully" : "Failed to update account settings";
                break;
        }
        
        // Redirect back to the settings page with a success/error message
        if (success) {
            response.sendRedirect(request.getContextPath() + "/settings/" + category + "?success=" + message);
        } else {
            response.sendRedirect(request.getContextPath() + "/settings/" + category + "?error=" + message);
        }
    }

    /**
     * Show account settings page
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showAccountSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Forward to the account settings page
        request.getRequestDispatcher("/WEB-INF/views/customer/settings/account.jsp").forward(request, response);
    }

    /**
     * Show notification settings page
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showNotificationSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get notification settings
        List<Setting> notificationSettings = settingsService.getSettingsByCategory("notifications");
        request.setAttribute("notificationSettings", notificationSettings);
        
        // Forward to the notification settings page
        request.getRequestDispatcher("/WEB-INF/views/customer/settings/notifications.jsp").forward(request, response);
    }

    /**
     * Show payment settings page
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showPaymentSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Forward to the payment settings page
        request.getRequestDispatcher("/WEB-INF/views/customer/settings/payment.jsp").forward(request, response);
    }

    /**
     * Show privacy settings page
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showPrivacySettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get privacy settings
        List<Setting> privacySettings = settingsService.getSettingsByCategory("privacy");
        request.setAttribute("privacySettings", privacySettings);
        
        // Forward to the privacy settings page
        request.getRequestDispatcher("/WEB-INF/views/customer/settings/privacy.jsp").forward(request, response);
    }

    /**
     * Show preference settings page
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showPreferenceSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get preference settings
        List<Setting> preferenceSettings = settingsService.getSettingsByCategory("preferences");
        request.setAttribute("preferenceSettings", preferenceSettings);
        
        // Forward to the preference settings page
        request.getRequestDispatcher("/WEB-INF/views/customer/settings/preferences.jsp").forward(request, response);
    }

    /**
     * Update account settings
     * @param request the HTTP request
     * @param user the current user
     * @return true if successful, false otherwise
     */
    private boolean updateAccountSettings(HttpServletRequest request, User user) {
        // Account settings are handled by the ProfileServlet
        // This is just a placeholder for now
        return true;
    }

    /**
     * Update notification settings
     * @param request the HTTP request
     * @param user the current user
     * @return true if successful, false otherwise
     */
    private boolean updateNotificationSettings(HttpServletRequest request, User user) {
        List<Setting> settings = new ArrayList<>();
        
        // Get all notification settings from the form
        Map<String, String[]> parameterMap = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String paramName = entry.getKey();
            if (paramName.startsWith("notification_")) {
                String settingName = paramName.substring("notification_".length());
                String value = entry.getValue()[0];
                
                Setting setting = new Setting();
                setting.setCategory("notifications");
                setting.setName(settingName);
                setting.setValue(value);
                
                settings.add(setting);
            }
        }
        
        // Update the settings
        return settingsService.updateSettings(settings);
    }

    /**
     * Update payment settings
     * @param request the HTTP request
     * @param user the current user
     * @return true if successful, false otherwise
     */
    private boolean updatePaymentSettings(HttpServletRequest request, User user) {
        // Payment settings implementation
        // This is just a placeholder for now
        return true;
    }

    /**
     * Update privacy settings
     * @param request the HTTP request
     * @param user the current user
     * @return true if successful, false otherwise
     */
    private boolean updatePrivacySettings(HttpServletRequest request, User user) {
        List<Setting> settings = new ArrayList<>();
        
        // Get all privacy settings from the form
        Map<String, String[]> parameterMap = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String paramName = entry.getKey();
            if (paramName.startsWith("privacy_")) {
                String settingName = paramName.substring("privacy_".length());
                String value = entry.getValue()[0];
                
                Setting setting = new Setting();
                setting.setCategory("privacy");
                setting.setName(settingName);
                setting.setValue(value);
                
                settings.add(setting);
            }
        }
        
        // Update the settings
        return settingsService.updateSettings(settings);
    }

    /**
     * Update preference settings
     * @param request the HTTP request
     * @param user the current user
     * @return true if successful, false otherwise
     */
    private boolean updatePreferenceSettings(HttpServletRequest request, User user) {
        List<Setting> settings = new ArrayList<>();
        
        // Get all preference settings from the form
        Map<String, String[]> parameterMap = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String paramName = entry.getKey();
            if (paramName.startsWith("preference_")) {
                String settingName = paramName.substring("preference_".length());
                String value = entry.getValue()[0];
                
                Setting setting = new Setting();
                setting.setCategory("preferences");
                setting.setName(settingName);
                setting.setValue(value);
                
                settings.add(setting);
            }
        }
        
        // Update the settings
        return settingsService.updateSettings(settings);
    }
}
