-- Add new tables for delivery person ratings and food item ratings

-- Create table for delivery person ratings
CREATE TABLE IF NOT EXISTS delivery_ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    delivery_user_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (delivery_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    UNIQUE KEY unique_delivery_rating (user_id, order_id),
    INDEX idx_delivery_rating_user (user_id),
    INDEX idx_delivery_rating_delivery_user (delivery_user_id),
    INDEX idx_delivery_rating_order (order_id),
    INDEX idx_delivery_rating_rating (rating)
) ENGINE=InnoDB;

-- Create table for food item ratings
CREATE TABLE IF NOT EXISTS food_ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    UNIQUE KEY unique_food_rating (user_id, menu_item_id, order_id),
    INDEX idx_food_rating_user (user_id),
    INDEX idx_food_rating_menu_item (menu_item_id),
    INDEX idx_food_rating_order (order_id),
    INDEX idx_food_rating_rating (rating)
) ENGINE=InnoDB;

-- Modify the existing reviews table to ensure it has a unique constraint
ALTER TABLE reviews 
ADD CONSTRAINT unique_restaurant_rating UNIQUE (user_id, restaurant_id, order_id);

-- Add a has_rated column to the orders table to track if the customer has rated the order
ALTER TABLE orders
ADD COLUMN has_rated BOOLEAN DEFAULT FALSE;
