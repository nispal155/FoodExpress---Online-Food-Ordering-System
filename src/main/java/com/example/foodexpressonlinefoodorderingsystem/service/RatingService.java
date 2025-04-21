package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.DeliveryRating;
import com.example.foodexpressonlinefoodorderingsystem.model.FoodRating;
import com.example.foodexpressonlinefoodorderingsystem.model.Review;
import com.example.foodexpressonlinefoodorderingsystem.model.Order;
import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Service class for handling ratings and reviews
 */
public class RatingService {
    
    private UserService userService;
    private RestaurantService restaurantService;
    private OrderService orderService;
    private MenuItemService menuItemService;
    
    public RatingService() {
        this.userService = new UserService();
        this.restaurantService = new RestaurantService();
        this.orderService = new OrderService();
        this.menuItemService = new MenuItemService();
    }
    
    /**
     * Submit a restaurant review
     * @param review the review to submit
     * @return true if successful, false otherwise
     */
    public boolean submitRestaurantReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, restaurant_id, order_id, rating, comment) " +
                     "VALUES (?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE rating = ?, comment = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, review.getUserId());
            stmt.setInt(2, review.getRestaurantId());
            stmt.setInt(3, review.getOrderId());
            stmt.setInt(4, review.getRating());
            stmt.setString(5, review.getComment());
            stmt.setInt(6, review.getRating());
            stmt.setString(7, review.getComment());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        review.setId(generatedKeys.getInt(1));
                    }
                }
                
                // Update restaurant average rating
                updateRestaurantAverageRating(review.getRestaurantId());
                
                // Mark order as rated if all components are rated
                checkAndUpdateOrderRatingStatus(review.getOrderId());
                
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Error submitting restaurant review: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Submit a delivery person rating
     * @param rating the rating to submit
     * @return true if successful, false otherwise
     */
    public boolean submitDeliveryRating(DeliveryRating rating) {
        String sql = "INSERT INTO delivery_ratings (user_id, delivery_user_id, order_id, rating, comment) " +
                     "VALUES (?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE rating = ?, comment = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, rating.getUserId());
            stmt.setInt(2, rating.getDeliveryUserId());
            stmt.setInt(3, rating.getOrderId());
            stmt.setInt(4, rating.getRating());
            stmt.setString(5, rating.getComment());
            stmt.setInt(6, rating.getRating());
            stmt.setString(7, rating.getComment());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        rating.setId(generatedKeys.getInt(1));
                    }
                }
                
                // Mark order as rated if all components are rated
                checkAndUpdateOrderRatingStatus(rating.getOrderId());
                
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Error submitting delivery rating: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Submit a food item rating
     * @param rating the rating to submit
     * @return true if successful, false otherwise
     */
    public boolean submitFoodRating(FoodRating rating) {
        String sql = "INSERT INTO food_ratings (user_id, menu_item_id, order_id, rating, comment) " +
                     "VALUES (?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE rating = ?, comment = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, rating.getUserId());
            stmt.setInt(2, rating.getMenuItemId());
            stmt.setInt(3, rating.getOrderId());
            stmt.setInt(4, rating.getRating());
            stmt.setString(5, rating.getComment());
            stmt.setInt(6, rating.getRating());
            stmt.setString(7, rating.getComment());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        rating.setId(generatedKeys.getInt(1));
                    }
                }
                
                // Mark order as rated if all components are rated
                checkAndUpdateOrderRatingStatus(rating.getOrderId());
                
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Error submitting food rating: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get a restaurant review by order ID and user ID
     * @param orderId the order ID
     * @param userId the user ID
     * @return the review, or null if not found
     */
    public Review getRestaurantReviewByOrderAndUser(int orderId, int userId) {
        String sql = "SELECT * FROM reviews WHERE order_id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            stmt.setInt(2, userId);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToReview(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting restaurant review: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Get a delivery rating by order ID and user ID
     * @param orderId the order ID
     * @param userId the user ID
     * @return the rating, or null if not found
     */
    public DeliveryRating getDeliveryRatingByOrderAndUser(int orderId, int userId) {
        String sql = "SELECT * FROM delivery_ratings WHERE order_id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            stmt.setInt(2, userId);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToDeliveryRating(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting delivery rating: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Get food ratings by order ID and user ID
     * @param orderId the order ID
     * @param userId the user ID
     * @return list of food ratings
     */
    public List<FoodRating> getFoodRatingsByOrderAndUser(int orderId, int userId) {
        List<FoodRating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM food_ratings WHERE order_id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            stmt.setInt(2, userId);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ratings.add(mapResultSetToFoodRating(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting food ratings: " + e.getMessage());
        }
        
        return ratings;
    }
    
    /**
     * Check if an order can be rated (must be delivered)
     * @param orderId the order ID
     * @return true if the order can be rated, false otherwise
     */
    public boolean canRateOrder(int orderId) {
        String sql = "SELECT status, has_rated FROM orders WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String status = rs.getString("status");
                boolean hasRated = rs.getBoolean("has_rated");
                
                // Can rate if the order is delivered and hasn't been rated yet
                return "DELIVERED".equals(status) && !hasRated;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking if order can be rated: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Update the average rating of a restaurant
     * @param restaurantId the restaurant ID
     */
    private void updateRestaurantAverageRating(int restaurantId) {
        String sql = "UPDATE restaurants r " +
                     "SET r.rating = (SELECT AVG(rating) FROM reviews WHERE restaurant_id = ?) " +
                     "WHERE r.id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, restaurantId);
            stmt.setInt(2, restaurantId);
            
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error updating restaurant average rating: " + e.getMessage());
        }
    }
    
    /**
     * Check if all components of an order have been rated and update the order's rating status
     * @param orderId the order ID
     */
    private void checkAndUpdateOrderRatingStatus(int orderId) {
        // Get the order
        Order order = orderService.getOrderById(orderId);
        if (order == null) return;
        
        // Check if restaurant has been rated
        Review restaurantReview = getRestaurantReviewByOrderAndUser(orderId, order.getUserId());
        
        // Check if delivery person has been rated (if applicable)
        boolean deliveryRated = true;
        if (order.getDeliveryUserId() > 0) {
            DeliveryRating deliveryRating = getDeliveryRatingByOrderAndUser(orderId, order.getUserId());
            deliveryRated = (deliveryRating != null);
        }
        
        // Check if all food items have been rated
        List<MenuItem> orderItems = menuItemService.getMenuItemsByOrderId(orderId);
        List<FoodRating> foodRatings = getFoodRatingsByOrderAndUser(orderId, order.getUserId());
        
        boolean allFoodRated = (orderItems.size() == foodRatings.size());
        
        // If all components have been rated, mark the order as rated
        if (restaurantReview != null && deliveryRated && allFoodRated) {
            String sql = "UPDATE orders SET has_rated = TRUE WHERE id = ?";
            
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
                
            } catch (SQLException e) {
                System.err.println("Error updating order rating status: " + e.getMessage());
            }
        }
    }
    
    /**
     * Map a ResultSet to a Review object
     * @param rs the ResultSet
     * @return Review object
     * @throws SQLException if a database access error occurs
     */
    private Review mapResultSetToReview(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setId(rs.getInt("id"));
        review.setUserId(rs.getInt("user_id"));
        review.setRestaurantId(rs.getInt("restaurant_id"));
        review.setOrderId(rs.getInt("order_id"));
        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("comment"));
        review.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Load related objects if needed
        review.setUser(userService.getUserById(review.getUserId()));
        review.setRestaurant(restaurantService.getRestaurantById(review.getRestaurantId()));
        review.setOrder(orderService.getOrderById(review.getOrderId()));
        
        return review;
    }
    
    /**
     * Map a ResultSet to a DeliveryRating object
     * @param rs the ResultSet
     * @return DeliveryRating object
     * @throws SQLException if a database access error occurs
     */
    private DeliveryRating mapResultSetToDeliveryRating(ResultSet rs) throws SQLException {
        DeliveryRating rating = new DeliveryRating();
        rating.setId(rs.getInt("id"));
        rating.setUserId(rs.getInt("user_id"));
        rating.setDeliveryUserId(rs.getInt("delivery_user_id"));
        rating.setOrderId(rs.getInt("order_id"));
        rating.setRating(rs.getInt("rating"));
        rating.setComment(rs.getString("comment"));
        rating.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Load related objects if needed
        rating.setUser(userService.getUserById(rating.getUserId()));
        rating.setDeliveryUser(userService.getUserById(rating.getDeliveryUserId()));
        rating.setOrder(orderService.getOrderById(rating.getOrderId()));
        
        return rating;
    }
    
    /**
     * Map a ResultSet to a FoodRating object
     * @param rs the ResultSet
     * @return FoodRating object
     * @throws SQLException if a database access error occurs
     */
    private FoodRating mapResultSetToFoodRating(ResultSet rs) throws SQLException {
        FoodRating rating = new FoodRating();
        rating.setId(rs.getInt("id"));
        rating.setUserId(rs.getInt("user_id"));
        rating.setMenuItemId(rs.getInt("menu_item_id"));
        rating.setOrderId(rs.getInt("order_id"));
        rating.setRating(rs.getInt("rating"));
        rating.setComment(rs.getString("comment"));
        rating.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Load related objects if needed
        rating.setUser(userService.getUserById(rating.getUserId()));
        rating.setMenuItem(menuItemService.getMenuItemById(rating.getMenuItemId()));
        rating.setOrder(orderService.getOrderById(rating.getOrderId()));
        
        return rating;
    }
}
