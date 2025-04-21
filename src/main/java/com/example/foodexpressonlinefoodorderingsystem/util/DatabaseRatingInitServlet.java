package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet that initializes the rating tables on application startup
 */
@WebServlet(name = "DatabaseRatingInitServlet", urlPatterns = {}, loadOnStartup = 2)
public class DatabaseRatingInitServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseRatingInitServlet.class.getName());
    
    @Override
    public void init() throws ServletException {
        LOGGER.info("Initializing rating tables...");
        createRatingTables();
    }
    
    private void createRatingTables() {
        // SQL to create delivery ratings table
        String createDeliveryRatingsTable = 
            "CREATE TABLE IF NOT EXISTS delivery_ratings (" +
            "id INT AUTO_INCREMENT PRIMARY KEY, " +
            "user_id INT NOT NULL, " +
            "delivery_user_id INT NOT NULL, " +
            "order_id INT NOT NULL, " +
            "rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), " +
            "comment TEXT, " +
            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
            "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, " +
            "FOREIGN KEY (delivery_user_id) REFERENCES users(id) ON DELETE CASCADE, " +
            "FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE, " +
            "UNIQUE KEY unique_delivery_rating (user_id, order_id), " +
            "INDEX idx_delivery_rating_user (user_id), " +
            "INDEX idx_delivery_rating_delivery_user (delivery_user_id), " +
            "INDEX idx_delivery_rating_order (order_id), " +
            "INDEX idx_delivery_rating_rating (rating)" +
            ") ENGINE=InnoDB";
        
        // SQL to create food ratings table
        String createFoodRatingsTable = 
            "CREATE TABLE IF NOT EXISTS food_ratings (" +
            "id INT AUTO_INCREMENT PRIMARY KEY, " +
            "user_id INT NOT NULL, " +
            "menu_item_id INT NOT NULL, " +
            "order_id INT NOT NULL, " +
            "rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), " +
            "comment TEXT, " +
            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
            "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, " +
            "FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE, " +
            "FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE, " +
            "UNIQUE KEY unique_food_rating (user_id, menu_item_id, order_id), " +
            "INDEX idx_food_rating_user (user_id), " +
            "INDEX idx_food_rating_menu_item (menu_item_id), " +
            "INDEX idx_food_rating_order (order_id), " +
            "INDEX idx_food_rating_rating (rating)" +
            ") ENGINE=InnoDB";
        
        // SQL to add unique constraint to reviews table
        String alterReviewsTable = 
            "ALTER TABLE reviews " +
            "ADD CONSTRAINT IF NOT EXISTS unique_restaurant_rating UNIQUE (user_id, restaurant_id, order_id)";
        
        // SQL to add has_rated column to orders table
        String alterOrdersTable = 
            "ALTER TABLE orders " +
            "ADD COLUMN IF NOT EXISTS has_rated BOOLEAN DEFAULT FALSE";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Execute the SQL statements
            stmt.execute(createDeliveryRatingsTable);
            LOGGER.info("delivery_ratings table created successfully");
            
            stmt.execute(createFoodRatingsTable);
            LOGGER.info("food_ratings table created successfully");
            
            try {
                stmt.execute(alterReviewsTable);
                LOGGER.info("reviews table altered successfully");
            } catch (SQLException e) {
                // MySQL 5.7 doesn't support IF NOT EXISTS for constraints
                // Try without the IF NOT EXISTS clause
                try {
                    stmt.execute("ALTER TABLE reviews ADD CONSTRAINT unique_restaurant_rating UNIQUE (user_id, restaurant_id, order_id)");
                    LOGGER.info("reviews table altered successfully (without IF NOT EXISTS)");
                } catch (SQLException ex) {
                    // Constraint might already exist, which is fine
                    LOGGER.log(Level.INFO, "Constraint might already exist: " + ex.getMessage());
                }
            }
            
            try {
                stmt.execute(alterOrdersTable);
                LOGGER.info("orders table altered successfully");
            } catch (SQLException e) {
                // MySQL 5.7 doesn't support IF NOT EXISTS for columns
                // Try without the IF NOT EXISTS clause
                try {
                    stmt.execute("ALTER TABLE orders ADD COLUMN has_rated BOOLEAN DEFAULT FALSE");
                    LOGGER.info("orders table altered successfully (without IF NOT EXISTS)");
                } catch (SQLException ex) {
                    // Column might already exist, which is fine
                    LOGGER.log(Level.INFO, "Column might already exist: " + ex.getMessage());
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating rating tables: " + e.getMessage(), e);
        }
    }
}
