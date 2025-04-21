package com.example.foodexpressonlinefoodorderingsystem.model;

import java.sql.Timestamp;

/**
 * Model class for user favorites (restaurants and menu items)
 */
public class Favorite {
    private int id;
    private int userId;
    private Integer restaurantId; // Can be null if it's a menu item favorite
    private Integer menuItemId;   // Can be null if it's a restaurant favorite
    private Timestamp createdAt;
    
    // Additional fields for displaying information
    private String restaurantName;
    private String menuItemName;
    private String menuItemDescription;
    private double menuItemPrice;
    private String menuItemImage;
    
    public Favorite() {
    }
    
    public Favorite(int userId, Integer restaurantId, Integer menuItemId) {
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.menuItemId = menuItemId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(Integer restaurantId) {
        this.restaurantId = restaurantId;
    }

    public Integer getMenuItemId() {
        return menuItemId;
    }

    public void setMenuItemId(Integer menuItemId) {
        this.menuItemId = menuItemId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getMenuItemName() {
        return menuItemName;
    }

    public void setMenuItemName(String menuItemName) {
        this.menuItemName = menuItemName;
    }

    public String getMenuItemDescription() {
        return menuItemDescription;
    }

    public void setMenuItemDescription(String menuItemDescription) {
        this.menuItemDescription = menuItemDescription;
    }

    public double getMenuItemPrice() {
        return menuItemPrice;
    }

    public void setMenuItemPrice(double menuItemPrice) {
        this.menuItemPrice = menuItemPrice;
    }

    public String getMenuItemImage() {
        return menuItemImage;
    }

    public void setMenuItemImage(String menuItemImage) {
        this.menuItemImage = menuItemImage;
    }
    
    public boolean isRestaurantFavorite() {
        return restaurantId != null;
    }
    
    public boolean isMenuItemFavorite() {
        return menuItemId != null;
    }
}
