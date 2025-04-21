package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.Setting;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service class for Settings-related operations
 */
public class SettingsService {

    /**
     * Create the settings table if it doesn't exist
     */
    public void createSettingsTableIfNotExists() {
        String sql = "CREATE TABLE IF NOT EXISTS settings (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "category VARCHAR(50) NOT NULL, " +
                "name VARCHAR(100) NOT NULL, " +
                "value TEXT, " +
                "description TEXT, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, " +
                "UNIQUE KEY unique_setting_name (category, name), " +
                "INDEX idx_setting_category (category)" +
                ")";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            
            // Initialize default settings if the table is empty
            initializeDefaultSettings(conn);
        } catch (SQLException e) {
            System.err.println("Error creating settings table: " + e.getMessage());
        }
    }
    
    /**
     * Initialize default settings if the table is empty
     * @param conn the database connection
     * @throws SQLException if a database access error occurs
     */
    private void initializeDefaultSettings(Connection conn) throws SQLException {
        // Check if settings table is empty
        String countSql = "SELECT COUNT(*) FROM settings";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(countSql)) {
            if (rs.next() && rs.getInt(1) == 0) {
                // Insert default settings
                insertDefaultSettings(conn);
            }
        }
    }
    
    /**
     * Insert default settings into the database
     * @param conn the database connection
     * @throws SQLException if a database access error occurs
     */
    private void insertDefaultSettings(Connection conn) throws SQLException {
        // Business Hours
        insertSetting(conn, "business_hours", "monday_open", "09:00", "Monday opening time");
        insertSetting(conn, "business_hours", "monday_close", "22:00", "Monday closing time");
        insertSetting(conn, "business_hours", "tuesday_open", "09:00", "Tuesday opening time");
        insertSetting(conn, "business_hours", "tuesday_close", "22:00", "Tuesday closing time");
        insertSetting(conn, "business_hours", "wednesday_open", "09:00", "Wednesday opening time");
        insertSetting(conn, "business_hours", "wednesday_close", "22:00", "Wednesday closing time");
        insertSetting(conn, "business_hours", "thursday_open", "09:00", "Thursday opening time");
        insertSetting(conn, "business_hours", "thursday_close", "22:00", "Thursday closing time");
        insertSetting(conn, "business_hours", "friday_open", "09:00", "Friday opening time");
        insertSetting(conn, "business_hours", "friday_close", "23:00", "Friday closing time");
        insertSetting(conn, "business_hours", "saturday_open", "10:00", "Saturday opening time");
        insertSetting(conn, "business_hours", "saturday_close", "23:00", "Saturday closing time");
        insertSetting(conn, "business_hours", "sunday_open", "10:00", "Sunday opening time");
        insertSetting(conn, "business_hours", "sunday_close", "22:00", "Sunday closing time");
        
        // Delivery Fees
        insertSetting(conn, "delivery_fees", "base_fee", "2.99", "Base delivery fee");
        insertSetting(conn, "delivery_fees", "per_km_fee", "0.50", "Additional fee per kilometer");
        insertSetting(conn, "delivery_fees", "min_order_free_delivery", "25.00", "Minimum order amount for free delivery");
        
        // Order Settings
        insertSetting(conn, "order_settings", "min_order_amount", "10.00", "Minimum order amount");
        insertSetting(conn, "order_settings", "max_delivery_distance", "15", "Maximum delivery distance in kilometers");
        insertSetting(conn, "order_settings", "estimated_delivery_time", "30-45", "Estimated delivery time in minutes");
        
        // Contact Information
        insertSetting(conn, "contact_info", "email", "contact@foodexpress.com", "Contact email address");
        insertSetting(conn, "contact_info", "phone", "+1-555-123-4567", "Contact phone number");
        insertSetting(conn, "contact_info", "address", "123 Food Street, Cuisine City, FC 12345", "Physical address");
        
        // Social Media
        insertSetting(conn, "social_media", "facebook", "https://facebook.com/foodexpress", "Facebook page URL");
        insertSetting(conn, "social_media", "instagram", "https://instagram.com/foodexpress", "Instagram profile URL");
        insertSetting(conn, "social_media", "twitter", "https://twitter.com/foodexpress", "Twitter profile URL");
    }
    
    /**
     * Helper method to insert a setting
     * @param conn the database connection
     * @param category the setting category
     * @param name the setting name
     * @param value the setting value
     * @param description the setting description
     * @throws SQLException if a database access error occurs
     */
    private void insertSetting(Connection conn, String category, String name, String value, String description) throws SQLException {
        String sql = "INSERT INTO settings (category, name, value, description) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            stmt.setString(2, name);
            stmt.setString(3, value);
            stmt.setString(4, description);
            stmt.executeUpdate();
        }
    }

    /**
     * Get all settings
     * @return List of all settings
     */
    public List<Setting> getAllSettings() {
        String sql = "SELECT * FROM settings ORDER BY category, name";
        List<Setting> settings = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                settings.add(mapResultSetToSetting(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all settings: " + e.getMessage());
        }

        return settings;
    }

    /**
     * Get settings by category
     * @param category the category to filter by
     * @return List of settings in the specified category
     */
    public List<Setting> getSettingsByCategory(String category) {
        String sql = "SELECT * FROM settings WHERE category = ? ORDER BY name";
        List<Setting> settings = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                settings.add(mapResultSetToSetting(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting settings by category: " + e.getMessage());
        }

        return settings;
    }

    /**
     * Get a setting by category and name
     * @param category the setting category
     * @param name the setting name
     * @return the setting, or null if not found
     */
    public Setting getSetting(String category, String name) {
        String sql = "SELECT * FROM settings WHERE category = ? AND name = ?";
        Setting setting = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            stmt.setString(2, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                setting = mapResultSetToSetting(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting setting: " + e.getMessage());
        }

        return setting;
    }

    /**
     * Get a setting value by category and name
     * @param category the setting category
     * @param name the setting name
     * @return the setting value, or null if not found
     */
    public String getSettingValue(String category, String name) {
        Setting setting = getSetting(category, name);
        return setting != null ? setting.getValue() : null;
    }

    /**
     * Get all settings as a map grouped by category
     * @return Map of settings grouped by category
     */
    public Map<String, List<Setting>> getSettingsByCategories() {
        List<Setting> allSettings = getAllSettings();
        Map<String, List<Setting>> settingsByCategory = new HashMap<>();

        for (Setting setting : allSettings) {
            String category = setting.getCategory();
            if (!settingsByCategory.containsKey(category)) {
                settingsByCategory.put(category, new ArrayList<>());
            }
            settingsByCategory.get(category).add(setting);
        }

        return settingsByCategory;
    }

    /**
     * Update a setting
     * @param setting the setting to update
     * @return true if successful, false otherwise
     */
    public boolean updateSetting(Setting setting) {
        String sql = "UPDATE settings SET value = ?, description = ?, updated_at = CURRENT_TIMESTAMP WHERE category = ? AND name = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, setting.getValue());
            stmt.setString(2, setting.getDescription());
            stmt.setString(3, setting.getCategory());
            stmt.setString(4, setting.getName());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating setting: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update multiple settings at once
     * @param settings the settings to update
     * @return true if all updates were successful, false otherwise
     */
    public boolean updateSettings(List<Setting> settings) {
        String sql = "UPDATE settings SET value = ?, updated_at = CURRENT_TIMESTAMP WHERE category = ? AND name = ?";
        boolean allSuccessful = true;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (Setting setting : settings) {
                stmt.setString(1, setting.getValue());
                stmt.setString(2, setting.getCategory());
                stmt.setString(3, setting.getName());

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    allSuccessful = false;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error updating settings: " + e.getMessage());
            return false;
        }

        return allSuccessful;
    }

    /**
     * Add a new setting
     * @param setting the setting to add
     * @return true if successful, false otherwise
     */
    public boolean addSetting(Setting setting) {
        String sql = "INSERT INTO settings (category, name, value, description) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, setting.getCategory());
            stmt.setString(2, setting.getName());
            stmt.setString(3, setting.getValue());
            stmt.setString(4, setting.getDescription());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error adding setting: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete a setting
     * @param category the setting category
     * @param name the setting name
     * @return true if successful, false otherwise
     */
    public boolean deleteSetting(String category, String name) {
        String sql = "DELETE FROM settings WHERE category = ? AND name = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            stmt.setString(2, name);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting setting: " + e.getMessage());
            return false;
        }
    }

    /**
     * Helper method to map a ResultSet to a Setting object
     * @param rs the ResultSet
     * @return Setting object
     * @throws SQLException if a database access error occurs
     */
    private Setting mapResultSetToSetting(ResultSet rs) throws SQLException {
        Setting setting = new Setting();
        setting.setId(rs.getInt("id"));
        setting.setCategory(rs.getString("category"));
        setting.setName(rs.getString("name"));
        setting.setValue(rs.getString("value"));
        setting.setDescription(rs.getString("description"));
        setting.setCreatedAt(rs.getTimestamp("created_at"));
        setting.setUpdatedAt(rs.getTimestamp("updated_at"));
        return setting;
    }
}
