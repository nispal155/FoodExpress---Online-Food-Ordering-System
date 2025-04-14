package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.Cart;
import com.example.foodexpressonlinefoodorderingsystem.model.CartItem;
import com.example.foodexpressonlinefoodorderingsystem.model.Order;
import com.example.foodexpressonlinefoodorderingsystem.model.OrderItem;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Service class for order operations
 */
public class OrderService {

    /**
     * Get all orders
     * @return List of all orders
     */
    public List<Order> getAllOrders() {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "ORDER BY o.order_date DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting all orders: " + e.getMessage());
        }

        return orders;
    }

    /**
     * Get orders by status
     * @param status the order status
     * @return List of orders with the specified status
     */
    public List<Order> getOrdersByStatus(Order.Status status) {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "WHERE o.status = ? " +
                     "ORDER BY o.order_date DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status.name());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting orders by status: " + e.getMessage());
        }

        return orders;
    }

    /**
     * Get orders for a specific user
     * @param userId the user ID
     * @return List of orders for the user
     */
    public List<Order> getOrdersByUser(int userId) {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "WHERE o.user_id = ? " +
                     "ORDER BY o.order_date DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting orders by user: " + e.getMessage());
        }

        return orders;
    }

    /**
     * Get recent orders for a specific user with order items
     * @param userId the user ID
     * @param limit the maximum number of orders to return
     * @return List of orders for the user with their items
     */
    public List<Order> getRecentOrdersWithItemsByUser(int userId, int limit) {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "WHERE o.user_id = ? " +
                     "ORDER BY o.order_date DESC " +
                     "LIMIT ?";

        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);

                // Get order items
                List<OrderItem> orderItems = getOrderItemsByOrderId(conn, order.getId());
                order.setOrderItems(orderItems);

                orders.add(order);
            }

        } catch (SQLException e) {
            System.err.println("Error getting recent orders by user: " + e.getMessage());
        }

        return orders;
    }

    /**
     * Get orders assigned to a specific delivery person
     * @param deliveryUserId the delivery user ID
     * @return List of orders assigned to the delivery person
     */
    public List<Order> getOrdersByDeliveryPerson(int deliveryUserId) {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "WHERE o.delivery_user_id = ? " +
                     "ORDER BY o.order_date DESC";

        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deliveryUserId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting orders by delivery person: " + e.getMessage());
        }

        return orders;
    }

    /**
     * Get orders that need to be assigned to a delivery person
     * @return List of orders that need to be assigned
     */
    public List<Order> getOrdersNeedingAssignment() {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "WHERE o.delivery_user_id IS NULL " +
                     "AND o.status IN ('CONFIRMED', 'PREPARING', 'READY') " +
                     "ORDER BY o.order_date ASC";

        List<Order> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting orders needing assignment: " + e.getMessage());
        }

        return orders;
    }

    /**
     * Get an order by ID
     * @param id the order ID
     * @return Order object if found, null otherwise
     */
    public Order getOrderById(int id) {
        String sql = "SELECT o.*, " +
                     "u.full_name AS customer_name, " +
                     "r.name AS restaurant_name, " +
                     "du.full_name AS delivery_person_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN restaurants r ON o.restaurant_id = r.id " +
                     "LEFT JOIN users du ON o.delivery_user_id = du.id " +
                     "WHERE o.id = ?";

        Order order = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                order = mapResultSetToOrder(rs);

                // Get order items
                List<OrderItem> orderItems = getOrderItemsByOrderId(conn, id);
                order.setOrderItems(orderItems);
            }

        } catch (SQLException e) {
            System.err.println("Error getting order by ID: " + e.getMessage());
        }

        return order;
    }

    /**
     * Get order items for a specific order
     * @param conn the database connection
     * @param orderId the order ID
     * @return List of order items
     * @throws SQLException if a database access error occurs
     */
    private List<OrderItem> getOrderItemsByOrderId(Connection conn, int orderId) throws SQLException {
        String sql = "SELECT oi.*, " +
                     "m.name AS menu_item_name, " +
                     "m.description AS menu_item_description, " +
                     "m.image_url AS menu_item_image_url " +
                     "FROM order_items oi " +
                     "JOIN menu_items m ON oi.menu_item_id = m.id " +
                     "WHERE oi.order_id = ?";

        List<OrderItem> orderItems = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orderItems.add(mapResultSetToOrderItem(rs));
            }
        }

        return orderItems;
    }

    /**
     * Get order items for a specific order
     * @param orderId the order ID
     * @return List of order items
     */
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        String sql = "SELECT oi.*, " +
                     "m.name AS menu_item_name, " +
                     "m.description AS menu_item_description, " +
                     "m.image_url AS menu_item_image_url " +
                     "FROM order_items oi " +
                     "JOIN menu_items m ON oi.menu_item_id = m.id " +
                     "WHERE oi.order_id = ?";

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orderItems.add(mapResultSetToOrderItem(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting order items: " + e.getMessage());
        }

        return orderItems;
    }

    /**
     * Assign an order to a delivery person
     * @param orderId the order ID
     * @param deliveryUserId the delivery user ID
     * @return true if successful, false otherwise
     */
    public boolean assignOrderToDeliveryPerson(int orderId, int deliveryUserId) {
        String sql = "UPDATE orders SET delivery_user_id = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deliveryUserId);
            stmt.setInt(2, orderId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error assigning order to delivery person: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update the status of an order
     * @param orderId the order ID
     * @param status the new status
     * @return true if successful, false otherwise
     */
    public boolean updateOrderStatus(int orderId, Order.Status status) {
        String sql = "UPDATE orders SET status = ?, updated_at = CURRENT_TIMESTAMP";

        // If status is DELIVERED, set actual delivery time
        if (status == Order.Status.DELIVERED) {
            sql += ", actual_delivery_time = CURRENT_TIMESTAMP";
        }

        sql += " WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status.name());
            stmt.setInt(2, orderId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error updating order status: " + e.getMessage());
            return false;
        }
    }

    /**
     * Cancel an order
     * @param orderId the order ID
     * @return true if successful, false otherwise
     */
    public boolean cancelOrder(int orderId) {
        return updateOrderStatus(orderId, Order.Status.CANCELLED);
    }

    /**
     * Create a new order from a cart
     * @param userId the user ID
     * @param cart the shopping cart
     * @param paymentMethod the payment method
     * @param paymentStatus the payment status
     * @param deliveryAddress the delivery address
     * @param deliveryPhone the delivery phone
     * @param deliveryNotes any delivery notes
     * @return the created order ID, or -1 if failed
     */
    public int createOrder(int userId, Cart cart, Order.PaymentMethod paymentMethod,
                          Order.PaymentStatus paymentStatus, String deliveryAddress,
                          String deliveryPhone, String deliveryNotes) {

        if (cart.isEmpty()) {
            return -1;
        }

        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Insert order
            String orderSql = "INSERT INTO orders (user_id, restaurant_id, order_date, total_amount, " +
                             "status, payment_method, payment_status, delivery_address, delivery_phone, " +
                             "delivery_notes) VALUES (?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?)";

            orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setInt(2, cart.getRestaurantId());
            orderStmt.setBigDecimal(3, cart.getTotalPrice());
            orderStmt.setString(4, Order.Status.PENDING.name());
            orderStmt.setString(5, paymentMethod.name());
            orderStmt.setString(6, paymentStatus.name());
            orderStmt.setString(7, deliveryAddress);
            orderStmt.setString(8, deliveryPhone);
            orderStmt.setString(9, deliveryNotes);

            int affectedRows = orderStmt.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return -1;
            }

            // Get generated order ID
            generatedKeys = orderStmt.getGeneratedKeys();
            if (!generatedKeys.next()) {
                conn.rollback();
                return -1;
            }

            int orderId = generatedKeys.getInt(1);

            // Insert order items
            String itemSql = "INSERT INTO order_items (order_id, menu_item_id, quantity, price, special_instructions) " +
                            "VALUES (?, ?, ?, ?, ?)";

            itemStmt = conn.prepareStatement(itemSql);

            for (CartItem cartItem : cart.getItems()) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, cartItem.getMenuItem().getId());
                itemStmt.setInt(3, cartItem.getQuantity());
                itemStmt.setBigDecimal(4, cartItem.getMenuItem().getEffectivePrice());
                itemStmt.setString(5, cartItem.getSpecialInstructions());

                itemStmt.addBatch();
            }

            int[] itemResults = itemStmt.executeBatch();

            // Check if all items were inserted successfully
            boolean allItemsInserted = true;
            for (int result : itemResults) {
                if (result <= 0) {
                    allItemsInserted = false;
                    break;
                }
            }

            if (!allItemsInserted) {
                conn.rollback();
                return -1;
            }

            // Commit transaction
            conn.commit();
            return orderId;

        } catch (SQLException e) {
            System.err.println("Error creating order: " + e.getMessage());
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                System.err.println("Error rolling back transaction: " + ex.getMessage());
            }
            return -1;
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (itemStmt != null) itemStmt.close();
                if (orderStmt != null) orderStmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }

    /**
     * Get the count of orders by status
     * @param status the order status
     * @return the count of orders
     */
    public int getOrderCountByStatus(Order.Status status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status.name());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting order count by status: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Get the count of orders assigned to a delivery person
     * @param deliveryUserId the delivery user ID
     * @return the count of orders
     */
    public int getOrderCountByDeliveryPerson(int deliveryUserId) {
        String sql = "SELECT COUNT(*) FROM orders WHERE delivery_user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deliveryUserId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting order count by delivery person: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Get the count of orders needing assignment
     * @return the count of orders
     */
    public int getOrderCountNeedingAssignment() {
        String sql = "SELECT COUNT(*) FROM orders WHERE delivery_user_id IS NULL " +
                     "AND status IN ('CONFIRMED', 'PREPARING', 'READY')";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting order count needing assignment: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Map a ResultSet to an Order object
     * @param rs the ResultSet
     * @return Order object
     * @throws SQLException if a database access error occurs
     */
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setRestaurantId(rs.getInt("restaurant_id"));

        // Handle nullable delivery_user_id
        int deliveryUserId = rs.getInt("delivery_user_id");
        if (!rs.wasNull()) {
            order.setDeliveryUserId(deliveryUserId);
        }

        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setStatus(Order.Status.valueOf(rs.getString("status")));
        order.setPaymentMethod(Order.PaymentMethod.valueOf(rs.getString("payment_method")));
        order.setPaymentStatus(Order.PaymentStatus.valueOf(rs.getString("payment_status")));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setDeliveryPhone(rs.getString("delivery_phone"));
        order.setDeliveryNotes(rs.getString("delivery_notes"));

        // Handle nullable timestamps
        Timestamp estimatedDeliveryTime = rs.getTimestamp("estimated_delivery_time");
        if (estimatedDeliveryTime != null) {
            order.setEstimatedDeliveryTime(estimatedDeliveryTime);
        }

        Timestamp actualDeliveryTime = rs.getTimestamp("actual_delivery_time");
        if (actualDeliveryTime != null) {
            order.setActualDeliveryTime(actualDeliveryTime);
        }

        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));

        // Set joined fields if available
        try {
            order.setCustomerName(rs.getString("customer_name"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        try {
            order.setRestaurantName(rs.getString("restaurant_name"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        try {
            order.setDeliveryPersonName(rs.getString("delivery_person_name"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        return order;
    }

    /**
     * Map a ResultSet to an OrderItem object
     * @param rs the ResultSet
     * @return OrderItem object
     * @throws SQLException if a database access error occurs
     */
    private OrderItem mapResultSetToOrderItem(ResultSet rs) throws SQLException {
        OrderItem orderItem = new OrderItem();
        orderItem.setId(rs.getInt("id"));
        orderItem.setOrderId(rs.getInt("order_id"));
        orderItem.setMenuItemId(rs.getInt("menu_item_id"));
        orderItem.setQuantity(rs.getInt("quantity"));
        orderItem.setPrice(rs.getBigDecimal("price"));
        orderItem.setSpecialInstructions(rs.getString("special_instructions"));

        // Set joined fields if available
        try {
            orderItem.setMenuItemName(rs.getString("menu_item_name"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        try {
            orderItem.setMenuItemDescription(rs.getString("menu_item_description"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        try {
            orderItem.setMenuItemImageUrl(rs.getString("menu_item_image_url"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        return orderItem;
    }
}
