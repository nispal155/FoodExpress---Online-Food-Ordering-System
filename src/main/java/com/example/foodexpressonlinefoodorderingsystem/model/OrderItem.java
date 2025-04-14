package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;

/**
 * Model class representing an order item
 */
public class OrderItem {
    private int id;
    private int orderId;
    private int menuItemId;
    private int quantity;
    private BigDecimal price;
    private String specialInstructions;
    
    // For joining with other tables
    private String menuItemName;
    private String menuItemDescription;
    private String menuItemImageUrl;
    
    // Default constructor
    public OrderItem() {
    }
    
    // Constructor with fields
    public OrderItem(int id, int orderId, int menuItemId, int quantity, BigDecimal price, String specialInstructions) {
        this.id = id;
        this.orderId = orderId;
        this.menuItemId = menuItemId;
        this.quantity = quantity;
        this.price = price;
        this.specialInstructions = specialInstructions;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getMenuItemId() {
        return menuItemId;
    }
    
    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public String getSpecialInstructions() {
        return specialInstructions;
    }
    
    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
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
    
    public String getMenuItemImageUrl() {
        return menuItemImageUrl;
    }
    
    public void setMenuItemImageUrl(String menuItemImageUrl) {
        this.menuItemImageUrl = menuItemImageUrl;
    }
    
    /**
     * Calculate the subtotal for this order item
     * @return the subtotal
     */
    public BigDecimal getSubtotal() {
        return price.multiply(new BigDecimal(quantity));
    }
    
    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", menuItemId=" + menuItemId +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
}
