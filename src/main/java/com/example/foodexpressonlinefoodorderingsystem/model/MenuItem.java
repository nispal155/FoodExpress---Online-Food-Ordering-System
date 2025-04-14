package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Model class representing a menu item
 */
public class MenuItem {
    private int id;
    private int restaurantId;
    private int categoryId;
    private String name;
    private String description;
    private BigDecimal price;
    private String imageUrl;
    private boolean isAvailable;
    private boolean isSpecial;
    private BigDecimal discountPrice;
    private Date createdAt;
    private Date updatedAt;
    
    // For joining with other tables
    private String restaurantName;
    private String categoryName;
    
    // Default constructor
    public MenuItem() {
    }
    
    // Constructor with fields
    public MenuItem(int id, int restaurantId, int categoryId, String name, String description, 
                   BigDecimal price, String imageUrl, boolean isAvailable, boolean isSpecial, 
                   BigDecimal discountPrice, Date createdAt, Date updatedAt) {
        this.id = id;
        this.restaurantId = restaurantId;
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.isAvailable = isAvailable;
        this.isSpecial = isSpecial;
        this.discountPrice = discountPrice;
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
    
    public int getRestaurantId() {
        return restaurantId;
    }
    
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public boolean isAvailable() {
        return isAvailable;
    }
    
    public void setAvailable(boolean available) {
        isAvailable = available;
    }
    
    public boolean isSpecial() {
        return isSpecial;
    }
    
    public void setSpecial(boolean special) {
        isSpecial = special;
    }
    
    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }
    
    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
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
    
    /**
     * Get the effective price (discount price if available, otherwise regular price)
     * @return the effective price
     */
    public BigDecimal getEffectivePrice() {
        if (isSpecial && discountPrice != null && discountPrice.compareTo(BigDecimal.ZERO) > 0) {
            return discountPrice;
        }
        return price;
    }
    
    /**
     * Calculate the discount percentage
     * @return the discount percentage or 0 if no discount
     */
    public int getDiscountPercentage() {
        if (isSpecial && discountPrice != null && discountPrice.compareTo(BigDecimal.ZERO) > 0 && price.compareTo(BigDecimal.ZERO) > 0) {
            BigDecimal discount = price.subtract(discountPrice);
            return discount.multiply(new BigDecimal(100)).divide(price, 0, BigDecimal.ROUND_HALF_UP).intValue();
        }
        return 0;
    }
    
    @Override
    public String toString() {
        return "MenuItem{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", isAvailable=" + isAvailable +
                ", isSpecial=" + isSpecial +
                '}';
    }
}
