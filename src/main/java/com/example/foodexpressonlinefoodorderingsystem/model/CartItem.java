package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;

/**
 * Model class representing an item in the shopping cart
 */
public class CartItem {
    private MenuItem menuItem;
    private int quantity;
    private String specialInstructions;
    
    // Default constructor
    public CartItem() {
    }
    
    // Constructor with fields
    public CartItem(MenuItem menuItem, int quantity, String specialInstructions) {
        this.menuItem = menuItem;
        this.quantity = quantity;
        this.specialInstructions = specialInstructions;
    }
    
    // Getters and Setters
    public MenuItem getMenuItem() {
        return menuItem;
    }
    
    public void setMenuItem(MenuItem menuItem) {
        this.menuItem = menuItem;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getSpecialInstructions() {
        return specialInstructions;
    }
    
    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
    }
    
    /**
     * Calculate the subtotal for this cart item
     * @return the subtotal
     */
    public BigDecimal getSubtotal() {
        return menuItem.getEffectivePrice().multiply(new BigDecimal(quantity));
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "menuItem=" + menuItem.getName() +
                ", quantity=" + quantity +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}
