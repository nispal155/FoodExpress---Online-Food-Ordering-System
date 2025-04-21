package com.example.foodexpressonlinefoodorderingsystem.model;

import java.sql.Timestamp;

/**
 * Model class for application settings
 */
public class Setting {
    private int id;
    private String category;
    private String name;
    private String value;
    private String description;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public Setting() {
    }
    
    // Constructor with fields
    public Setting(String category, String name, String value, String description) {
        this.category = category;
        this.name = name;
        this.value = value;
        this.description = description;
    }
    
    // Constructor with all fields
    public Setting(int id, String category, String name, String value, String description, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.value = value;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "Setting{" +
                "id=" + id +
                ", category='" + category + '\'' +
                ", name='" + name + '\'' +
                ", value='" + value + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
