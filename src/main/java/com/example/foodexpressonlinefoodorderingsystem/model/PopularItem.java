package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;

/**
 * Model class representing a popular menu item for reporting
 */
public class PopularItem {
    private int menuItemId;
    private String menuItemName;
    private String restaurantName;
    private String categoryName;
    private int totalOrders;
    private int totalQuantity;
    private BigDecimal totalSales;
    
    // Default constructor
    public PopularItem() {
    }
    
    // Constructor with fields
    public PopularItem(int menuItemId, String menuItemName, String restaurantName, String categoryName, 
                      int totalOrders, int totalQuantity, BigDecimal totalSales) {
        this.menuItemId = menuItemId;
        this.menuItemName = menuItemName;
        this.restaurantName = restaurantName;
        this.categoryName = categoryName;
        this.totalOrders = totalOrders;
        this.totalQuantity = totalQuantity;
        this.totalSales = totalSales;
    }
    
    // Getters and Setters
    public int getMenuItemId() {
        return menuItemId;
    }
    
    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }
    
    public String getMenuItemName() {
        return menuItemName;
    }
    
    public void setMenuItemName(String menuItemName) {
        this.menuItemName = menuItemName;
    }
    
    public String getRestaurantName() {
        return restaurantName;
    }
    
    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public int getTotalOrders() {
        return totalOrders;
    }
    
    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }
    
    public int getTotalQuantity() {
        return totalQuantity;
    }
    
    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
    
    public BigDecimal getTotalSales() {
        return totalSales;
    }
    
    public void setTotalSales(BigDecimal totalSales) {
        this.totalSales = totalSales;
    }
    
    /**
     * Get the average quantity per order
     * @return the average quantity per order
     */
    public double getAverageQuantityPerOrder() {
        if (totalOrders > 0) {
            return (double) totalQuantity / totalOrders;
        }
        return 0;
    }
    
    @Override
    public String toString() {
        return "PopularItem{" +
                "menuItemId=" + menuItemId +
                ", menuItemName='" + menuItemName + '\'' +
                ", restaurantName='" + restaurantName + '\'' +
                ", totalOrders=" + totalOrders +
                ", totalQuantity=" + totalQuantity +
                ", totalSales=" + totalSales +
                '}';
    }
}
