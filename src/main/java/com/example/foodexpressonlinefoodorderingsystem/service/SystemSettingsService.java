package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.SystemSettings;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.sql.*;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service class for system settings operations
 */
public class SystemSettingsService {
    
    // Default settings
    private static final Map<String, String> DEFAULT_SETTINGS = new HashMap<>();
    
    static {
        // Business hours
        DEFAULT_SETTINGS.put("business_hours_open", "09:00");
        DEFAULT_SETTINGS.put("business_hours_close", "22:00");
        
        // Delivery settings
        DEFAULT_SETTINGS.put("delivery_fee_base", "3.99");
        DEFAULT_SETTINGS.put("delivery_fee_per_km", "0.50");
        DEFAULT_SETTINGS.put("delivery_free_threshold", "30.00");
        
        // Order settings
        DEFAULT_SETTINGS.put("min_order_amount", "10.00");
        DEFAULT_SETTINGS.put("max_delivery_distance", "15");
        
        // Contact information
        DEFAULT_SETTINGS.put("contact_email", "info@foodexpress.com");
        DEFAULT_SETTINGS.put("contact_phone", "+1-555-123-4567");
        DEFAULT_SETTINGS.put("contact_address", "123 Main St, Anytown, USA");
    }
    
    /**
     * Initialize system settings with default values if they don't exist
     */
    public void initializeSettings() {
        // Check if settings table exists
        if (!isSettingsTableExists()) {
            createSettingsTable();
        }
        
        // Check if settings are already initialized
        if (getAllSettings().isEmpty()) {
            // Initialize with default settings
            for (Map.Entry<String, String> entry : DEFAULT_SETTINGS.entrySet()) {
                String description = getDescriptionForKey(entry.getKey());
                createSetting(entry.getKey(), entry.getValue(), description);
            }
        }
    }
    
    /**
     * Check if the settings table exists
     * @return true if the table exists, false otherwise
     */
    private boolean isSettingsTableExists() {
        try (Connection conn = DBUtil.getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "system_settings", null);
            return tables.next();
        } catch (SQLException e) {
            System.err.println("Error checking if settings table exists: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Create the settings table
     */
    private void createSettingsTable() {
        String sql = "CREATE TABLE system_settings (" +
                     "id INT AUTO_INCREMENT PRIMARY KEY, " +
                     "setting_key VARCHAR(50) NOT NULL UNIQUE, " +
                     "setting_value TEXT, " +
                     "description VARCHAR(255), " +
                     "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" +
                     ")";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            stmt.executeUpdate(sql);
            System.out.println("System settings table created successfully");
            
        } catch (SQLException e) {
            System.err.println("Error creating settings table: " + e.getMessage());
        }
    }
    
    /**
     * Get a description for a setting key
     * @param key the setting key
     * @return a human-readable description
     */
    private String getDescriptionForKey(String key) {
        switch (key) {
            case "business_hours_open":
                return "Business opening time (24-hour format)";
            case "business_hours_close":
                return "Business closing time (24-hour format)";
            case "delivery_fee_base":
                return "Base delivery fee";
            case "delivery_fee_per_km":
                return "Additional delivery fee per kilometer";
            case "delivery_free_threshold":
                return "Order amount threshold for free delivery";
            case "min_order_amount":
                return "Minimum order amount";
            case "max_delivery_distance":
                return "Maximum delivery distance in kilometers";
            case "contact_email":
                return "Contact email address";
            case "contact_phone":
                return "Contact phone number";
            case "contact_address":
                return "Business address";
            default:
                return "System setting";
        }
    }
    
    /**
     * Get all system settings
     * @return List of all system settings
     */
    public List<SystemSettings> getAllSettings() {
        String sql = "SELECT * FROM system_settings ORDER BY setting_key";
        
        List<SystemSettings> settings = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                settings.add(mapResultSetToSystemSettings(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all settings: " + e.getMessage());
        }
        
        return settings;
    }
    
    /**
     * Get a system setting by key
     * @param key the setting key
     * @return SystemSettings object if found, null otherwise
     */
    public SystemSettings getSettingByKey(String key) {
        String sql = "SELECT * FROM system_settings WHERE setting_key = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, key);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToSystemSettings(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting setting by key: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Get a setting value by key
     * @param key the setting key
     * @param defaultValue the default value to return if the setting is not found
     * @return the setting value, or the default value if not found
     */
    public String getSettingValue(String key, String defaultValue) {
        SystemSettings setting = getSettingByKey(key);
        return setting != null ? setting.getSettingValue() : defaultValue;
    }
    
    /**
     * Get a setting value as an integer
     * @param key the setting key
     * @param defaultValue the default value to return if the setting is not found or not a valid integer
     * @return the setting value as an integer, or the default value if not found or not a valid integer
     */
    public int getSettingValueAsInt(String key, int defaultValue) {
        SystemSettings setting = getSettingByKey(key);
        if (setting != null) {
            try {
                return Integer.parseInt(setting.getSettingValue());
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }
    
    /**
     * Get a setting value as a boolean
     * @param key the setting key
     * @param defaultValue the default value to return if the setting is not found
     * @return the setting value as a boolean, or the default value if not found
     */
    public boolean getSettingValueAsBoolean(String key, boolean defaultValue) {
        SystemSettings setting = getSettingByKey(key);
        if (setting != null) {
            return "true".equalsIgnoreCase(setting.getSettingValue()) || "1".equals(setting.getSettingValue());
        }
        return defaultValue;
    }
    
    /**
     * Get business hours as LocalTime objects
     * @return an array with opening time at index 0 and closing time at index 1
     */
    public LocalTime[] getBusinessHours() {
        LocalTime[] hours = new LocalTime[2];
        
        String openTime = getSettingValue("business_hours_open", "09:00");
        String closeTime = getSettingValue("business_hours_close", "22:00");
        
        try {
            hours[0] = LocalTime.parse(openTime);
        } catch (Exception e) {
            hours[0] = LocalTime.of(9, 0);
        }
        
        try {
            hours[1] = LocalTime.parse(closeTime);
        } catch (Exception e) {
            hours[1] = LocalTime.of(22, 0);
        }
        
        return hours;
    }
    
    /**
     * Create a new system setting
     * @param key the setting key
     * @param value the setting value
     * @param description the setting description
     * @return true if successful, false otherwise
     */
    public boolean createSetting(String key, String value, String description) {
        String sql = "INSERT INTO system_settings (setting_key, setting_value, description) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, key);
            stmt.setString(2, value);
            stmt.setString(3, description);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error creating setting: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update a system setting
     * @param key the setting key
     * @param value the new setting value
     * @return true if successful, false otherwise
     */
    public boolean updateSetting(String key, String value) {
        String sql = "UPDATE system_settings SET setting_value = ? WHERE setting_key = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, value);
            stmt.setString(2, key);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating setting: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update business hours
     * @param openTime the opening time
     * @param closeTime the closing time
     * @return true if successful, false otherwise
     */
    public boolean updateBusinessHours(LocalTime openTime, LocalTime closeTime) {
        boolean success = true;
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        String openTimeStr = openTime.format(formatter);
        String closeTimeStr = closeTime.format(formatter);
        
        if (!updateSetting("business_hours_open", openTimeStr)) {
            success = false;
        }
        
        if (!updateSetting("business_hours_close", closeTimeStr)) {
            success = false;
        }
        
        return success;
    }
    
    /**
     * Update delivery fees
     * @param baseFee the base delivery fee
     * @param feePerKm the fee per kilometer
     * @param freeThreshold the threshold for free delivery
     * @return true if successful, false otherwise
     */
    public boolean updateDeliveryFees(double baseFee, double feePerKm, double freeThreshold) {
        boolean success = true;
        
        if (!updateSetting("delivery_fee_base", String.valueOf(baseFee))) {
            success = false;
        }
        
        if (!updateSetting("delivery_fee_per_km", String.valueOf(feePerKm))) {
            success = false;
        }
        
        if (!updateSetting("delivery_free_threshold", String.valueOf(freeThreshold))) {
            success = false;
        }
        
        return success;
    }
    
    /**
     * Delete a system setting
     * @param key the setting key
     * @return true if successful, false otherwise
     */
    public boolean deleteSetting(String key) {
        String sql = "DELETE FROM system_settings WHERE setting_key = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, key);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting setting: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Map a ResultSet to a SystemSettings object
     * @param rs the ResultSet
     * @return SystemSettings object
     * @throws SQLException if a database access error occurs
     */
    private SystemSettings mapResultSetToSystemSettings(ResultSet rs) throws SQLException {
        SystemSettings settings = new SystemSettings();
        settings.setId(rs.getInt("id"));
        settings.setSettingKey(rs.getString("setting_key"));
        settings.setSettingValue(rs.getString("setting_value"));
        settings.setDescription(rs.getString("description"));
        settings.setUpdatedAt(rs.getTimestamp("updated_at"));
        return settings;
    }
}
