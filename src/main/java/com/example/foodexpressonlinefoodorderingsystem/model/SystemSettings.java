package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.Date;

/**
 * Model class representing system settings
 */
public class SystemSettings {
    private int id;
    private String settingKey;
    private String settingValue;
    private String description;
    private Date updatedAt;
    
    // Default constructor
    public SystemSettings() {
    }
    
    // Constructor with fields
    public SystemSettings(int id, String settingKey, String settingValue, String description, Date updatedAt) {
        this.id = id;
        this.settingKey = settingKey;
        this.settingValue = settingValue;
        this.description = description;
        this.updatedAt = updatedAt;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getSettingKey() {
        return settingKey;
    }
    
    public void setSettingKey(String settingKey) {
        this.settingKey = settingKey;
    }
    
    public String getSettingValue() {
        return settingValue;
    }
    
    public void setSettingValue(String settingValue) {
        this.settingValue = settingValue;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    /**
     * Get the setting value as a string
     * @return the setting value
     */
    public String getValueAsString() {
        return settingValue;
    }
    
    /**
     * Get the setting value as an integer
     * @return the setting value as an integer, or 0 if not a valid integer
     */
    public int getValueAsInt() {
        try {
            return Integer.parseInt(settingValue);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    
    /**
     * Get the setting value as a boolean
     * @return the setting value as a boolean, or false if not a valid boolean
     */
    public boolean getValueAsBoolean() {
        return "true".equalsIgnoreCase(settingValue) || "1".equals(settingValue);
    }
    
    /**
     * Get the setting value as a BigDecimal
     * @return the setting value as a BigDecimal, or BigDecimal.ZERO if not a valid decimal
     */
    public BigDecimal getValueAsBigDecimal() {
        try {
            return new BigDecimal(settingValue);
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }
    
    /**
     * Get the setting value as a LocalTime
     * @return the setting value as a LocalTime, or null if not a valid time
     */
    public LocalTime getValueAsTime() {
        try {
            return LocalTime.parse(settingValue);
        } catch (Exception e) {
            return null;
        }
    }
    
    @Override
    public String toString() {
        return "SystemSettings{" +
                "id=" + id +
                ", settingKey='" + settingKey + '\'' +
                ", settingValue='" + settingValue + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
