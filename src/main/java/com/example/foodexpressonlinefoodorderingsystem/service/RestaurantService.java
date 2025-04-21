package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for restaurant operations
 */
public class RestaurantService {

    /**
     * Get all restaurants
     * @return List of all restaurants
     */
    public List<Restaurant> getAllRestaurants() {
        String sql = "SELECT * FROM restaurants ORDER BY name";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting all restaurants: " + e.getMessage());
        }

        return restaurants;
    }

    /**
     * Get all active restaurants
     * @return List of all active restaurants
     */
    public List<Restaurant> getAllActiveRestaurants() {
        String sql = "SELECT * FROM restaurants WHERE is_active = TRUE ORDER BY name";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting active restaurants: " + e.getMessage());
        }

        return restaurants;
    }

    /**
     * Search active restaurants by name or description
     * @param searchTerm the search term
     * @return List of matching active restaurants
     */
    public List<Restaurant> searchActiveRestaurants(String searchTerm) {
        String sql = "SELECT * FROM restaurants WHERE is_active = TRUE AND (name LIKE ? OR description LIKE ? OR address LIKE ?) ORDER BY name";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching restaurants: " + e.getMessage());
        }

        return restaurants;
    }

    /**
     * Search all restaurants by name, description, or address (for admin)
     * @param searchTerm the search term
     * @return List of matching restaurants
     */
    public List<Restaurant> searchRestaurants(String searchTerm) {
        String sql = "SELECT * FROM restaurants WHERE name LIKE ? OR description LIKE ? OR address LIKE ? ORDER BY name";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching restaurants: " + e.getMessage());
        }

        return restaurants;
    }

    /**
     * Get a restaurant by ID
     * @param id the restaurant ID
     * @return Restaurant object if found, null otherwise
     */
    public Restaurant getRestaurantById(int id) {
        String sql = "SELECT * FROM restaurants WHERE id = ?";
        Restaurant restaurant = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                restaurant = mapResultSetToRestaurant(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting restaurant by ID: " + e.getMessage());
        }

        return restaurant;
    }

    /**
     * Get the total count of restaurants
     * @return the count of restaurants
     */
    public int getRestaurantCount() {
        String sql = "SELECT COUNT(*) FROM restaurants";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting restaurant count: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Get top rated restaurants
     * @param limit the maximum number of restaurants to return
     * @return List of top rated restaurants
     */
    public List<Restaurant> getTopRatedRestaurants(int limit) {
        String sql = "SELECT * FROM restaurants WHERE is_active = TRUE ORDER BY rating DESC LIMIT ?";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting top rated restaurants: " + e.getMessage());
        }

        return restaurants;
    }

    /**
     * Create a new restaurant
     * @param restaurant the restaurant to create
     * @return true if successful, false otherwise
     */
    public boolean createRestaurant(Restaurant restaurant) {
        String sql = "INSERT INTO restaurants (name, description, address, phone, email, image_url, rating, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getDescription());
            stmt.setString(3, restaurant.getAddress());
            stmt.setString(4, restaurant.getPhone());
            stmt.setString(5, restaurant.getEmail());
            stmt.setString(6, restaurant.getImageUrl());
            stmt.setDouble(7, restaurant.getRating());
            stmt.setBoolean(8, restaurant.isActive());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    restaurant.setId(generatedKeys.getInt(1));
                    return true;
                } else {
                    return false;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error creating restaurant: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update an existing restaurant
     * @param restaurant the restaurant to update
     * @return true if successful, false otherwise
     */
    public boolean updateRestaurant(Restaurant restaurant) {
        String sql = "UPDATE restaurants SET name = ?, description = ?, address = ?, phone = ?, " +
                     "email = ?, image_url = ?, rating = ?, is_active = ?, updated_at = CURRENT_TIMESTAMP " +
                     "WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getDescription());
            stmt.setString(3, restaurant.getAddress());
            stmt.setString(4, restaurant.getPhone());
            stmt.setString(5, restaurant.getEmail());
            stmt.setString(6, restaurant.getImageUrl());
            stmt.setDouble(7, restaurant.getRating());
            stmt.setBoolean(8, restaurant.isActive());
            stmt.setInt(9, restaurant.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error updating restaurant: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete a restaurant by ID
     * @param id the restaurant ID
     * @return true if successful, false otherwise
     */
    public boolean deleteRestaurant(int id) {
        String sql = "DELETE FROM restaurants WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting restaurant: " + e.getMessage());
            return false;
        }
    }

    /**
     * Toggle the active status of a restaurant
     * @param id the restaurant ID
     * @param isActive the new active status
     * @return true if successful, false otherwise
     */
    public boolean toggleRestaurantActive(int id, boolean isActive) {
        String sql = "UPDATE restaurants SET is_active = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isActive);
            stmt.setInt(2, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error toggling restaurant active status: " + e.getMessage());
            return false;
        }
    }

    /**
     * Map a ResultSet to a Restaurant object
     * @param rs the ResultSet
     * @return Restaurant object
     * @throws SQLException if a database access error occurs
     */
    private Restaurant mapResultSetToRestaurant(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();
        restaurant.setId(rs.getInt("id"));
        restaurant.setName(rs.getString("name"));
        restaurant.setDescription(rs.getString("description"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setPhone(rs.getString("phone"));
        restaurant.setEmail(rs.getString("email"));
        restaurant.setImageUrl(rs.getString("image_url"));
        restaurant.setRating(rs.getDouble("rating"));
        restaurant.setActive(rs.getBoolean("is_active"));
        restaurant.setCreatedAt(rs.getTimestamp("created_at"));
        restaurant.setUpdatedAt(rs.getTimestamp("updated_at"));
        return restaurant;
    }
}
