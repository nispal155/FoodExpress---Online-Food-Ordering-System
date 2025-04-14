package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Model class representing a sales report entry
 */
public class SalesReport {
    private Date date;
    private int totalOrders;
    private BigDecimal totalSales;
    private int totalItems;
    private BigDecimal averageOrderValue;
    
    // Default constructor
    public SalesReport() {
    }
    
    // Constructor with fields
    public SalesReport(Date date, int totalOrders, BigDecimal totalSales, int totalItems) {
        this.date = date;
        this.totalOrders = totalOrders;
        this.totalSales = totalSales;
        this.totalItems = totalItems;
        
        // Calculate average order value
        if (totalOrders > 0) {
            this.averageOrderValue = totalSales.divide(new BigDecimal(totalOrders), 2, BigDecimal.ROUND_HALF_UP);
        } else {
            this.averageOrderValue = BigDecimal.ZERO;
        }
    }
    
    // Getters and Setters
    public Date getDate() {
        return date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    public int getTotalOrders() {
        return totalOrders;
    }
    
    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
        recalculateAverageOrderValue();
    }
    
    public BigDecimal getTotalSales() {
        return totalSales;
    }
    
    public void setTotalSales(BigDecimal totalSales) {
        this.totalSales = totalSales;
        recalculateAverageOrderValue();
    }
    
    public int getTotalItems() {
        return totalItems;
    }
    
    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }
    
    public BigDecimal getAverageOrderValue() {
        return averageOrderValue;
    }
    
    /**
     * Recalculate the average order value
     */
    private void recalculateAverageOrderValue() {
        if (totalOrders > 0 && totalSales != null) {
            this.averageOrderValue = totalSales.divide(new BigDecimal(totalOrders), 2, BigDecimal.ROUND_HALF_UP);
        } else {
            this.averageOrderValue = BigDecimal.ZERO;
        }
    }
    
    @Override
    public String toString() {
        return "SalesReport{" +
                "date=" + date +
                ", totalOrders=" + totalOrders +
                ", totalSales=" + totalSales +
                ", totalItems=" + totalItems +
                ", averageOrderValue=" + averageOrderValue +
                '}';
    }
}
