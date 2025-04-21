package com.example.foodexpressonlinefoodorderingsystem.model;

import java.util.Date;

/**
 * Model class representing a food item rating
 */
public class FoodRating {
    private int id;
    private int userId;
    private int menuItemId;
    private int orderId;
    private int rating;
    private String comment;
    private Date createdAt;
    
    // User who made the rating
    private User user;
    // Menu item that was rated
    private MenuItem menuItem;
    // Order associated with the rating
    private Order order;
    
    // Default constructor
    public FoodRating() {
    }
    
    // Constructor with fields
    public FoodRating(int id, int userId, int menuItemId, int orderId, int rating, String comment, Date createdAt) {
        this.id = id;
        this.userId = userId;
        this.menuItemId = menuItemId;
        this.orderId = orderId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
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
    
    public int getMenuItemId() {
        return menuItemId;
    }
    
    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public MenuItem getMenuItem() {
        return menuItem;
    }
    
    public void setMenuItem(MenuItem menuItem) {
        this.menuItem = menuItem;
    }
    
    public Order getOrder() {
        return order;
    }
    
    public void setOrder(Order order) {
        this.order = order;
    }
}
