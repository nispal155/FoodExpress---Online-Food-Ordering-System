package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Model class representing a shopping cart
 */
public class Cart {
    private int restaurantId; // Cart is limited to items from a single restaurant
    private String restaurantName;
    private Map<Integer, CartItem> items; // Map of menu item ID to cart item
    
    // Default constructor
    public Cart() {
        this.items = new HashMap<>();
    }
    
    // Constructor with restaurant
    public Cart(int restaurantId, String restaurantName) {
        this.restaurantId = restaurantId;
        this.restaurantName = restaurantName;
        this.items = new HashMap<>();
    }
    
    // Getters and Setters
    public int getRestaurantId() {
        return restaurantId;
    }
    
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
    
    public String getRestaurantName() {
        return restaurantName;
    }
    
    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }
    
    public List<CartItem> getItems() {
        return new ArrayList<>(items.values());
    }
    
    /**
     * Add an item to the cart
     * @param menuItem the menu item to add
     * @param quantity the quantity to add
     * @param specialInstructions special instructions for the item
     * @return true if successful, false if the item is from a different restaurant
     */
    public boolean addItem(MenuItem menuItem, int quantity, String specialInstructions) {
        // If cart is empty, set the restaurant
        if (items.isEmpty()) {
            this.restaurantId = menuItem.getRestaurantId();
            this.restaurantName = menuItem.getRestaurantName();
        } 
        // If item is from a different restaurant, return false
        else if (this.restaurantId != menuItem.getRestaurantId()) {
            return false;
        }
        
        // Check if item already exists in cart
        CartItem existingItem = items.get(menuItem.getId());
        if (existingItem != null) {
            // Update quantity and special instructions
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            if (specialInstructions != null && !specialInstructions.isEmpty()) {
                existingItem.setSpecialInstructions(specialInstructions);
            }
        } else {
            // Add new item to cart
            CartItem newItem = new CartItem(menuItem, quantity, specialInstructions);
            items.put(menuItem.getId(), newItem);
        }
        
        return true;
    }
    
    /**
     * Update the quantity of an item in the cart
     * @param menuItemId the menu item ID
     * @param quantity the new quantity
     * @return true if successful, false if the item is not in the cart
     */
    public boolean updateItemQuantity(int menuItemId, int quantity) {
        CartItem item = items.get(menuItemId);
        if (item == null) {
            return false;
        }
        
        if (quantity <= 0) {
            // Remove item if quantity is 0 or negative
            items.remove(menuItemId);
        } else {
            // Update quantity
            item.setQuantity(quantity);
        }
        
        return true;
    }
    
    /**
     * Update the special instructions for an item in the cart
     * @param menuItemId the menu item ID
     * @param specialInstructions the new special instructions
     * @return true if successful, false if the item is not in the cart
     */
    public boolean updateItemInstructions(int menuItemId, String specialInstructions) {
        CartItem item = items.get(menuItemId);
        if (item == null) {
            return false;
        }
        
        item.setSpecialInstructions(specialInstructions);
        return true;
    }
    
    /**
     * Remove an item from the cart
     * @param menuItemId the menu item ID
     * @return true if successful, false if the item is not in the cart
     */
    public boolean removeItem(int menuItemId) {
        if (!items.containsKey(menuItemId)) {
            return false;
        }
        
        items.remove(menuItemId);
        
        // If cart is now empty, reset restaurant
        if (items.isEmpty()) {
            this.restaurantId = 0;
            this.restaurantName = null;
        }
        
        return true;
    }
    
    /**
     * Clear all items from the cart
     */
    public void clear() {
        items.clear();
        this.restaurantId = 0;
        this.restaurantName = null;
    }
    
    /**
     * Get the total number of items in the cart
     * @return the total number of items
     */
    public int getTotalItems() {
        int total = 0;
        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }
    
    /**
     * Get the total price of all items in the cart
     * @return the total price
     */
    public BigDecimal getTotalPrice() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items.values()) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
    
    /**
     * Check if the cart is empty
     * @return true if the cart is empty, false otherwise
     */
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    /**
     * Check if the cart contains a specific item
     * @param menuItemId the menu item ID
     * @return true if the cart contains the item, false otherwise
     */
    public boolean containsItem(int menuItemId) {
        return items.containsKey(menuItemId);
    }
    
    /**
     * Get a specific item from the cart
     * @param menuItemId the menu item ID
     * @return the cart item, or null if not found
     */
    public CartItem getItem(int menuItemId) {
        return items.get(menuItemId);
    }
    
    @Override
    public String toString() {
        return "Cart{" +
                "restaurantId=" + restaurantId +
                ", restaurantName='" + restaurantName + '\'' +
                ", items=" + items.size() +
                ", totalItems=" + getTotalItems() +
                ", totalPrice=" + getTotalPrice() +
                '}';
    }
}
