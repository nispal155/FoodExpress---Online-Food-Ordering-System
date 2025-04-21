package com.example.foodexpressonlinefoodorderingsystem.model;

import java.util.Date;

/**
 * Model class representing a delivery person rating
 */
public class DeliveryRating {
    private int id;
    private int userId;
    private int deliveryUserId;
    private int orderId;
    private int rating;
    private String comment;
    private Date createdAt;
    
    // User who made the rating
    private User user;
    // Delivery person who was rated
    private User deliveryUser;
    // Order associated with the rating
    private Order order;
    
    // Default constructor
    public DeliveryRating() {
    }
    
    // Constructor with fields
    public DeliveryRating(int id, int userId, int deliveryUserId, int orderId, int rating, String comment, Date createdAt) {
        this.id = id;
        this.userId = userId;
        this.deliveryUserId = deliveryUserId;
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
    
    public int getDeliveryUserId() {
        return deliveryUserId;
    }
    
    public void setDeliveryUserId(int deliveryUserId) {
        this.deliveryUserId = deliveryUserId;
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
    
    public User getDeliveryUser() {
        return deliveryUser;
    }
    
    public void setDeliveryUser(User deliveryUser) {
        this.deliveryUser = deliveryUser;
    }
    
    public Order getOrder() {
        return order;
    }
    
    public void setOrder(Order order) {
        this.order = order;
    }
}
