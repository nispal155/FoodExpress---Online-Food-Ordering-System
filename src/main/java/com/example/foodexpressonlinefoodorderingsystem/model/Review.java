package com.example.foodexpressonlinefoodorderingsystem.model;

import java.util.Date;

/**
 * Model class representing a restaurant review
 */
public class Review {
    private int id;
    private int userId;
    private int restaurantId;
    private int orderId;
    private int rating;
    private String comment;
    private Date createdAt;
    
    // User who made the review
    private User user;
    // Restaurant that was reviewed
    private Restaurant restaurant;
    // Order associated with the review
    private Order order;
    
    // Default constructor
    public Review() {
    }
    
    // Constructor with fields
    public Review(int id, int userId, int restaurantId, int orderId, int rating, String comment, Date createdAt) {
        this.id = id;
        this.userId = userId;
        this.restaurantId = restaurantId;
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
    
    public int getRestaurantId() {
        return restaurantId;
    }
    
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
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
    
    public Restaurant getRestaurant() {
        return restaurant;
    }
    
    public void setRestaurant(Restaurant restaurant) {
        this.restaurant = restaurant;
    }
    
    public Order getOrder() {
        return order;
    }
    
    public void setOrder(Order order) {
        this.order = order;
    }
}
