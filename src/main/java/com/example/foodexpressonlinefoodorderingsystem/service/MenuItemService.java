package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for menu item operations
 */
public class MenuItemService {

    /**
     * Get all menu items
     * @return List of all menu items
     */
    public List<MenuItem> getAllMenuItems() {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "ORDER BY m.restaurant_id, m.category_id, m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting all menu items: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Get menu items for a specific restaurant
     * @param restaurantId the restaurant ID
     * @return List of menu items for the restaurant
     */
    public List<MenuItem> getMenuItemsByRestaurant(int restaurantId) {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "WHERE m.restaurant_id = ? " +
                     "ORDER BY m.category_id, m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, restaurantId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting menu items by restaurant: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Get menu items for a specific category
     * @param categoryId the category ID
     * @return List of menu items for the category
     */
    public List<MenuItem> getMenuItemsByCategory(int categoryId) {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "WHERE m.category_id = ? " +
                     "ORDER BY m.restaurant_id, m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting menu items by category: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Get special menu items
     * @return List of special menu items
     */
    public List<MenuItem> getSpecialMenuItems() {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "WHERE m.is_special = TRUE " +
                     "ORDER BY m.restaurant_id, m.category_id, m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting special menu items: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Get a menu item by ID
     * @param id the menu item ID
     * @return MenuItem object if found, null otherwise
     */
    public MenuItem getMenuItemById(int id) {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "WHERE m.id = ?";

        MenuItem menuItem = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                menuItem = mapResultSetToMenuItem(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting menu item by ID: " + e.getMessage());
        }

        return menuItem;
    }

    /**
     * Create a new menu item
     * @param menuItem the menu item to create
     * @return true if successful, false otherwise
     */
    public boolean createMenuItem(MenuItem menuItem) {
        String sql = "INSERT INTO menu_items (restaurant_id, category_id, name, description, price, " +
                     "image_url, is_available, is_special, discount_price) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, menuItem.getRestaurantId());
            stmt.setInt(2, menuItem.getCategoryId());
            stmt.setString(3, menuItem.getName());
            stmt.setString(4, menuItem.getDescription());
            stmt.setBigDecimal(5, menuItem.getPrice());
            stmt.setString(6, menuItem.getImageUrl());
            stmt.setBoolean(7, menuItem.isAvailable());
            stmt.setBoolean(8, menuItem.isSpecial());

            if (menuItem.getDiscountPrice() != null) {
                stmt.setBigDecimal(9, menuItem.getDiscountPrice());
            } else {
                stmt.setNull(9, Types.DECIMAL);
            }

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    menuItem.setId(generatedKeys.getInt(1));
                    return true;
                } else {
                    return false;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error creating menu item: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update an existing menu item
     * @param menuItem the menu item to update
     * @return true if successful, false otherwise
     */
    public boolean updateMenuItem(MenuItem menuItem) {
        String sql = "UPDATE menu_items SET restaurant_id = ?, category_id = ?, name = ?, " +
                     "description = ?, price = ?, image_url = ?, is_available = ?, " +
                     "is_special = ?, discount_price = ?, updated_at = CURRENT_TIMESTAMP " +
                     "WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, menuItem.getRestaurantId());
            stmt.setInt(2, menuItem.getCategoryId());
            stmt.setString(3, menuItem.getName());
            stmt.setString(4, menuItem.getDescription());
            stmt.setBigDecimal(5, menuItem.getPrice());
            stmt.setString(6, menuItem.getImageUrl());
            stmt.setBoolean(7, menuItem.isAvailable());
            stmt.setBoolean(8, menuItem.isSpecial());

            if (menuItem.getDiscountPrice() != null) {
                stmt.setBigDecimal(9, menuItem.getDiscountPrice());
            } else {
                stmt.setNull(9, Types.DECIMAL);
            }

            stmt.setInt(10, menuItem.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error updating menu item: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete a menu item
     * @param id the ID of the menu item to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteMenuItem(int id) {
        String sql = "DELETE FROM menu_items WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting menu item: " + e.getMessage());
            return false;
        }
    }

    /**
     * Search for menu items by name or description (for customers)
     * @param query the search query
     * @return List of menu items matching the search query
     */
    public List<MenuItem> searchMenuItems(String query) {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "WHERE m.is_available = TRUE " +
                     "AND r.is_active = TRUE " +
                     "AND (m.name LIKE ? OR m.description LIKE ?) " +
                     "ORDER BY r.name, m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching menu items: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Search for menu items by name or description (for admin)
     * @param query the search query
     * @param restaurantId optional restaurant ID filter (0 for all restaurants)
     * @param categoryId optional category ID filter (0 for all categories)
     * @return List of menu items matching the search query and filters
     */
    public List<MenuItem> searchMenuItemsForAdmin(String query, int restaurantId, int categoryId) {
        StringBuilder sqlBuilder = new StringBuilder(
            "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
            "FROM menu_items m " +
            "JOIN restaurants r ON m.restaurant_id = r.id " +
            "JOIN categories c ON m.category_id = c.id " +
            "WHERE (m.name LIKE ? OR m.description LIKE ?) "
        );

        if (restaurantId > 0) {
            sqlBuilder.append("AND m.restaurant_id = ? ");
        }

        if (categoryId > 0) {
            sqlBuilder.append("AND m.category_id = ? ");
        }

        sqlBuilder.append("ORDER BY r.name, c.name, m.name");

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {

            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            int paramIndex = 3;

            if (restaurantId > 0) {
                stmt.setInt(paramIndex++, restaurantId);
            }

            if (categoryId > 0) {
                stmt.setInt(paramIndex, categoryId);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching menu items for admin: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Get menu items by restaurant and category
     * @param restaurantId the restaurant ID
     * @param categoryId the category ID
     * @return List of menu items for the restaurant and category
     */
    public List<MenuItem> getMenuItemsByRestaurantAndCategory(int restaurantId, int categoryId) {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "WHERE m.restaurant_id = ? AND m.category_id = ? AND m.is_available = TRUE " +
                     "ORDER BY m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, restaurantId);
            stmt.setInt(2, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting menu items by restaurant and category: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Toggle the availability of a menu item
     * @param id the ID of the menu item
     * @param isAvailable the new availability status
     * @return true if successful, false otherwise
     */
    public boolean toggleMenuItemAvailability(int id, boolean isAvailable) {
        String sql = "UPDATE menu_items SET is_available = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isAvailable);
            stmt.setInt(2, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error toggling menu item availability: " + e.getMessage());
            return false;
        }
    }

    /**
     * Toggle the special status of a menu item
     * @param id the ID of the menu item
     * @param isSpecial the new special status
     * @param discountPrice the discount price (can be null if not a special)
     * @return true if successful, false otherwise
     */
    public boolean toggleMenuItemSpecial(int id, boolean isSpecial, BigDecimal discountPrice) {
        String sql = "UPDATE menu_items SET is_special = ?, discount_price = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isSpecial);

            if (isSpecial && discountPrice != null) {
                stmt.setBigDecimal(2, discountPrice);
            } else {
                stmt.setNull(2, Types.DECIMAL);
            }

            stmt.setInt(3, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error toggling menu item special status: " + e.getMessage());
            return false;
        }
    }

    /**
     * Get the total count of menu items
     * @return the count of menu items
     */
    public int getMenuItemCount() {
        String sql = "SELECT COUNT(*) FROM menu_items";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting menu item count: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Get the count of special menu items
     * @return the count of special menu items
     */
    public int getSpecialMenuItemCount() {
        String sql = "SELECT COUNT(*) FROM menu_items WHERE is_special = TRUE";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting special menu item count: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Get menu items for a specific order
     * @param orderId the order ID
     * @return List of menu items for the order
     */
    public List<MenuItem> getMenuItemsByOrderId(int orderId) {
        String sql = "SELECT m.*, r.name AS restaurant_name, c.name AS category_name " +
                     "FROM menu_items m " +
                     "JOIN restaurants r ON m.restaurant_id = r.id " +
                     "JOIN categories c ON m.category_id = c.id " +
                     "JOIN order_items oi ON m.id = oi.menu_item_id " +
                     "WHERE oi.order_id = ? " +
                     "ORDER BY m.name";

        List<MenuItem> menuItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                menuItems.add(mapResultSetToMenuItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting menu items by order ID: " + e.getMessage());
        }

        return menuItems;
    }

    /**
     * Map a ResultSet to a MenuItem object
     * @param rs the ResultSet
     * @return MenuItem object
     * @throws SQLException if a database access error occurs
     */
    private MenuItem mapResultSetToMenuItem(ResultSet rs) throws SQLException {
        MenuItem menuItem = new MenuItem();
        menuItem.setId(rs.getInt("id"));
        menuItem.setRestaurantId(rs.getInt("restaurant_id"));
        menuItem.setCategoryId(rs.getInt("category_id"));
        menuItem.setName(rs.getString("name"));
        menuItem.setDescription(rs.getString("description"));
        menuItem.setPrice(rs.getBigDecimal("price"));
        menuItem.setImageUrl(rs.getString("image_url"));
        menuItem.setAvailable(rs.getBoolean("is_available"));
        menuItem.setSpecial(rs.getBoolean("is_special"));
        menuItem.setDiscountPrice(rs.getBigDecimal("discount_price"));
        menuItem.setCreatedAt(rs.getTimestamp("created_at"));
        menuItem.setUpdatedAt(rs.getTimestamp("updated_at"));

        // Set joined fields if available
        try {
            menuItem.setRestaurantName(rs.getString("restaurant_name"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        try {
            menuItem.setCategoryName(rs.getString("category_name"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        return menuItem;
    }
}
