package com.example.foodexpressonlinefoodorderingsystem.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Model class representing an order
 */
public class Order {
    // Order status enum
    public enum Status {
        PENDING("Pending"),
        CONFIRMED("Confirmed"),
        PREPARING("Preparing"),
        READY("Ready"),
        OUT_FOR_DELIVERY("Out for Delivery"),
        DELIVERED("Delivered"),
        CANCELLED("Cancelled");

        private final String displayName;

        Status(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Payment method enum
    public enum PaymentMethod {
        CASH("Cash"),
        CREDIT_CARD("Credit Card"),
        DEBIT_CARD("Debit Card"),
        PAYPAL("PayPal"),
        OTHER("Other");

        private final String displayName;

        PaymentMethod(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Payment status enum
    public enum PaymentStatus {
        PENDING("Pending"),
        PAID("Paid"),
        FAILED("Failed");

        private final String displayName;

        PaymentStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private int id;
    private int userId;
    private int restaurantId;
    private Integer deliveryUserId; // Can be null
    private Date orderDate;
    private BigDecimal totalAmount;
    private Status status;
    private PaymentMethod paymentMethod;
    private PaymentStatus paymentStatus;
    private String deliveryAddress;
    private String deliveryPhone;
    private String deliveryNotes;
    private Date estimatedDeliveryTime;
    private Date actualDeliveryTime;
    private Date createdAt;
    private Date updatedAt;
    private boolean hasRated;

    // For joining with other tables
    private String customerName;
    private String restaurantName;
    private String deliveryPersonName;

    // Order items
    private List<OrderItem> orderItems;

    // Default constructor
    public Order() {
    }

    // Constructor with fields
    public Order(int id, int userId, int restaurantId, Integer deliveryUserId, Date orderDate,
                BigDecimal totalAmount, Status status, PaymentMethod paymentMethod,
                PaymentStatus paymentStatus, String deliveryAddress, String deliveryPhone,
                String deliveryNotes, Date estimatedDeliveryTime, Date actualDeliveryTime,
                Date createdAt, Date updatedAt) {
        this.id = id;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.deliveryUserId = deliveryUserId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.deliveryAddress = deliveryAddress;
        this.deliveryPhone = deliveryPhone;
        this.deliveryNotes = deliveryNotes;
        this.estimatedDeliveryTime = estimatedDeliveryTime;
        this.actualDeliveryTime = actualDeliveryTime;
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

    public Integer getDeliveryUserId() {
        return deliveryUserId;
    }

    public void setDeliveryUserId(Integer deliveryUserId) {
        this.deliveryUserId = deliveryUserId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getDeliveryPhone() {
        return deliveryPhone;
    }

    public void setDeliveryPhone(String deliveryPhone) {
        this.deliveryPhone = deliveryPhone;
    }

    public String getDeliveryNotes() {
        return deliveryNotes;
    }

    public void setDeliveryNotes(String deliveryNotes) {
        this.deliveryNotes = deliveryNotes;
    }

    public Date getEstimatedDeliveryTime() {
        return estimatedDeliveryTime;
    }

    public void setEstimatedDeliveryTime(Date estimatedDeliveryTime) {
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }

    public Date getActualDeliveryTime() {
        return actualDeliveryTime;
    }

    public void setActualDeliveryTime(Date actualDeliveryTime) {
        this.actualDeliveryTime = actualDeliveryTime;
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

    public boolean isHasRated() {
        return hasRated;
    }

    public void setHasRated(boolean hasRated) {
        this.hasRated = hasRated;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getDeliveryPersonName() {
        return deliveryPersonName;
    }

    public void setDeliveryPersonName(String deliveryPersonName) {
        this.deliveryPersonName = deliveryPersonName;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    /**
     * Check if the order can be cancelled
     * @return true if the order can be cancelled, false otherwise
     */
    public boolean canBeCancelled() {
        return status == Status.PENDING || status == Status.CONFIRMED;
    }

    /**
     * Check if the order can be assigned to a delivery person
     * @return true if the order can be assigned, false otherwise
     */
    public boolean canBeAssigned() {
        return (status == Status.CONFIRMED || status == Status.PREPARING || status == Status.READY)
                && deliveryUserId == null;
    }

    /**
     * Check if the order status can be updated
     * @return true if the order status can be updated, false otherwise
     */
    public boolean canUpdateStatus() {
        return status != Status.DELIVERED && status != Status.CANCELLED;
    }

    /**
     * Get the next possible status for the order
     * @return the next possible status, or null if no next status is available
     */
    public Status getNextStatus() {
        switch (status) {
            case PENDING:
                return Status.CONFIRMED;
            case CONFIRMED:
                return Status.PREPARING;
            case PREPARING:
                return Status.READY;
            case READY:
                return Status.OUT_FOR_DELIVERY;
            case OUT_FOR_DELIVERY:
                return Status.DELIVERED;
            default:
                return null;
        }
    }

    /**
     * Get the display name of the current status
     * @return the display name of the status
     */
    public String getStatusDisplayName() {
        return status != null ? status.getDisplayName() : "";
    }

    /**
     * Get the CSS class for the current status
     * @return the CSS class for styling the status badge
     */
    public String getStatusCssClass() {
        if (status == null) {
            return "";
        }

        switch (status) {
            case PENDING:
                return "bg-secondary";
            case CONFIRMED:
                return "bg-info";
            case PREPARING:
                return "bg-primary";
            case READY:
                return "bg-success";
            case OUT_FOR_DELIVERY:
                return "bg-warning";
            case DELIVERED:
                return "bg-success";
            case CANCELLED:
                return "bg-danger";
            default:
                return "bg-secondary";
        }
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", restaurantId=" + restaurantId +
                ", status=" + status +
                ", totalAmount=" + totalAmount +
                '}';
    }
}
