package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.Favorite;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for Favorite-related operations
 */
public class FavoriteService {

    /**
     * Create the favorites table if it doesn't exist
     */
    public void createFavoritesTableIfNotExists() {
        String sql = "CREATE TABLE IF NOT EXISTS favorites (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "user_id INT NOT NULL, " +
                "restaurant_id INT, " +
                "menu_item_id INT, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, " +
                "FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE, " +
                "FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE, " +
                "UNIQUE KEY unique_user_restaurant (user_id, restaurant_id), " +
                "UNIQUE KEY unique_user_menu_item (user_id, menu_item_id)" +
                ")";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (SQLException e) {
            System.err.println("Error creating favorites table: " + e.getMessage());
        }
    }

    /**
     * Add a restaurant to user's favorites
     * @param userId the user ID
     * @param restaurantId the restaurant ID
     * @return true if successful, false otherwise
     */
    public boolean addRestaurantToFavorites(int userId, int restaurantId) {
        createFavoritesTableIfNotExists();

        String sql = "INSERT INTO favorites (user_id, restaurant_id) VALUES (?, ?) " +
                     "ON DUPLICATE KEY UPDATE created_at = CURRENT_TIMESTAMP";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, restaurantId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error adding restaurant to favorites: " + e.getMessage());
            return false;
        }
    }

    /**
     * Add a menu item to user's favorites
     * @param userId the user ID
     * @param menuItemId the menu item ID
     * @return true if successful, false otherwise
     */
    public boolean addMenuItemToFavorites(int userId, int menuItemId) {
        createFavoritesTableIfNotExists();

        String sql = "INSERT INTO favorites (user_id, menu_item_id) VALUES (?, ?) " +
                     "ON DUPLICATE KEY UPDATE created_at = CURRENT_TIMESTAMP";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, menuItemId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error adding menu item to favorites: " + e.getMessage());
            return false;
        }
    }

    /**
     * Remove a restaurant from user's favorites
     * @param userId the user ID
     * @param restaurantId the restaurant ID
     * @return true if successful, false otherwise
     */
    public boolean removeRestaurantFromFavorites(int userId, int restaurantId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND restaurant_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, restaurantId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error removing restaurant from favorites: " + e.getMessage());
            return false;
        }
    }

    /**
     * Remove a menu item from user's favorites
     * @param userId the user ID
     * @param menuItemId the menu item ID
     * @return true if successful, false otherwise
     */
    public boolean removeMenuItemFromFavorites(int userId, int menuItemId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND menu_item_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, menuItemId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error removing menu item from favorites: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a restaurant is in user's favorites
     * @param userId the user ID
     * @param restaurantId the restaurant ID
     * @return true if it's a favorite, false otherwise
     */
    public boolean isRestaurantFavorite(int userId, int restaurantId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ? AND restaurant_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, restaurantId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking if restaurant is favorite: " + e.getMessage());
        }
        return false;
    }

    /**
     * Check if a menu item is in user's favorites
     * @param userId the user ID
     * @param menuItemId the menu item ID
     * @return true if it's a favorite, false otherwise
     */
    public boolean isMenuItemFavorite(int userId, int menuItemId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ? AND menu_item_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, menuItemId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking if menu item is favorite: " + e.getMessage());
        }
        return false;
    }

    /**
     * Get all favorite restaurants for a user
     * @param userId the user ID
     * @return List of favorite restaurants
     */
    public List<Favorite> getFavoriteRestaurants(int userId) {
        List<Favorite> favorites = new ArrayList<>();
        String sql = "SELECT f.*, r.name as restaurant_name " +
                     "FROM favorites f " +
                     "JOIN restaurants r ON f.restaurant_id = r.id " +
                     "WHERE f.user_id = ? AND f.restaurant_id IS NOT NULL " +
                     "ORDER BY f.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Favorite favorite = new Favorite();
                favorite.setId(rs.getInt("id"));
                favorite.setUserId(rs.getInt("user_id"));
                favorite.setRestaurantId(rs.getInt("restaurant_id"));
                favorite.setCreatedAt(rs.getTimestamp("created_at"));
                favorite.setRestaurantName(rs.getString("restaurant_name"));
                favorites.add(favorite);
            }
        } catch (SQLException e) {
            System.err.println("Error getting favorite restaurants: " + e.getMessage());
        }
        return favorites;
    }

    /**
     * Get all favorite menu items for a user
     * @param userId the user ID
     * @return List of favorite menu items
     */
    public List<Favorite> getFavoriteMenuItems(int userId) {
        List<Favorite> favorites = new ArrayList<>();
        String sql = "SELECT f.*, m.name as menu_item_name, m.description as menu_item_description, " +
                     "m.price as menu_item_price, m.image_url as menu_item_image, r.name as restaurant_name " +
                     "FROM favorites f " +
                     "JOIN menu_items m ON f.menu_item_id = m.id " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "WHERE f.user_id = ? AND f.menu_item_id IS NOT NULL " +
                     "ORDER BY f.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Favorite favorite = new Favorite();
                favorite.setId(rs.getInt("id"));
                favorite.setUserId(rs.getInt("user_id"));
                favorite.setMenuItemId(rs.getInt("menu_item_id"));
                favorite.setCreatedAt(rs.getTimestamp("created_at"));
                favorite.setMenuItemName(rs.getString("menu_item_name"));
                favorite.setMenuItemDescription(rs.getString("menu_item_description"));
                favorite.setMenuItemPrice(rs.getDouble("menu_item_price"));
                favorite.setMenuItemImage(rs.getString("menu_item_image"));
                favorite.setRestaurantName(rs.getString("restaurant_name"));
                favorites.add(favorite);
            }
        } catch (SQLException e) {
            System.err.println("Error getting favorite menu items: " + e.getMessage());
        }
        return favorites;
    }

    /**
     * Get all favorites for a user (both restaurants and menu items)
     * @param userId the user ID
     * @return List of all favorites
     */
    public List<Favorite> getAllFavorites(int userId) {
        List<Favorite> favorites = new ArrayList<>();
        favorites.addAll(getFavoriteRestaurants(userId));
        favorites.addAll(getFavoriteMenuItems(userId));
        return favorites;
    }
}
