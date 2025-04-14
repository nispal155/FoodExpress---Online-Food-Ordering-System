-- Create the database
CREATE DATABASE IF NOT EXISTS foodexpress;
USE foodexpress;

-- Users table with roles (ADMIN, CUSTOMER, DELIVERY)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('ADMIN', 'CUSTOMER', 'DELIVERY') NOT NULL DEFAULT 'CUSTOMER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_user_role (role),
    INDEX idx_user_email (email),
    INDEX idx_user_username (username)
) ENGINE=InnoDB;

-- Restaurants table
CREATE TABLE IF NOT EXISTS restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    address TEXT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    image_url VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 0.0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_restaurant_name (name),
    INDEX idx_restaurant_rating (rating),
    INDEX idx_restaurant_active (is_active)
) ENGINE=InnoDB;

-- Food categories table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    INDEX idx_category_name (name)
) ENGINE=InnoDB;

-- Menu items table
CREATE TABLE IF NOT EXISTS menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    is_available BOOLEAN DEFAULT TRUE,
    is_special BOOLEAN DEFAULT FALSE,
    discount_price DECIMAL(10,2) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
    INDEX idx_menu_restaurant (restaurant_id),
    INDEX idx_menu_category (category_id),
    INDEX idx_menu_price (price),
    INDEX idx_menu_available (is_available),
    INDEX idx_menu_special (is_special)
) ENGINE=InnoDB;

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    delivery_user_id INT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'PREPARING', 'READY', 'OUT_FOR_DELIVERY', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
    payment_method ENUM('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'PAYPAL', 'OTHER') DEFAULT 'CASH',
    payment_status ENUM('PENDING', 'PAID', 'FAILED') DEFAULT 'PENDING',
    delivery_address TEXT NOT NULL,
    delivery_phone VARCHAR(20) NOT NULL,
    delivery_notes TEXT,
    estimated_delivery_time TIMESTAMP NULL,
    actual_delivery_time TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE RESTRICT,
    FOREIGN KEY (delivery_user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_order_user (user_id),
    INDEX idx_order_restaurant (restaurant_id),
    INDEX idx_order_delivery_user (delivery_user_id),
    INDEX idx_order_status (status),
    INDEX idx_order_date (order_date),
    INDEX idx_order_payment_status (payment_status)
) ENGINE=InnoDB;

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    special_instructions TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE RESTRICT,
    INDEX idx_order_item_order (order_id),
    INDEX idx_order_item_menu_item (menu_item_id)
) ENGINE=InnoDB;

-- Reviews table
CREATE TABLE IF NOT EXISTS reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_id INT,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL,
    INDEX idx_review_user (user_id),
    INDEX idx_review_restaurant (restaurant_id),
    INDEX idx_review_order (order_id),
    INDEX idx_review_rating (rating)
) ENGINE=InnoDB;

-- User sessions table for persistent login
CREATE TABLE IF NOT EXISTS user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    session_token VARCHAR(255) NOT NULL,
    expiry_date TIMESTAMP NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE INDEX idx_session_token (session_token),
    INDEX idx_session_user (user_id),
    INDEX idx_session_expiry (expiry_date)
) ENGINE=InnoDB;

-- Insert sample data
-- Default admin user (password will be hashed in the application)
INSERT INTO users (username, password, email, full_name, phone, address, role)
VALUES ('admin', 'admin123', 'admin@foodexpress.com', 'Admin User', '123-456-7890', '123 Admin St, Admin City', 'ADMIN');

-- Default customer (password will be hashed in the application)
INSERT INTO users (username, password, email, full_name, phone, address, role)
VALUES ('customer', 'customer123', 'customer@example.com', 'Sample Customer', '987-654-3210', '456 Customer Ave, Customer City', 'CUSTOMER');

-- Default delivery person (password will be hashed in the application)
INSERT INTO users (username, password, email, full_name, phone, address, role)
VALUES ('delivery', 'delivery123', 'delivery@example.com', 'Delivery Person', '555-123-4567', '789 Delivery Blvd, Delivery City', 'DELIVERY');

-- Sample categories
INSERT INTO categories (name, description) VALUES
('Pizza', 'Delicious Italian pizzas with various toppings'),
('Burger', 'Juicy burgers with fresh ingredients'),
('Pasta', 'Authentic Italian pasta dishes'),
('Salad', 'Fresh and healthy salads'),
('Dessert', 'Sweet treats to satisfy your cravings'),
('Beverage', 'Refreshing drinks to complement your meal');

-- Sample restaurant
INSERT INTO restaurants (name, description, address, phone, email, image_url, rating)
VALUES ('Pizza Palace', 'Best pizza in town with authentic Italian recipes', '789 Main St, Food City', '555-123-4567', 'info@pizzapalace.com', 'pizza_palace.jpg', 4.5);

-- Sample menu items
INSERT INTO menu_items (restaurant_id, category_id, name, description, price, image_url)
VALUES
(1, 1, 'Margherita Pizza', 'Classic pizza with tomato sauce, mozzarella, and basil', 12.99, 'margherita.jpg'),
(1, 1, 'Pepperoni Pizza', 'Pizza with tomato sauce, mozzarella, and pepperoni', 14.99, 'pepperoni.jpg'),
(1, 3, 'Spaghetti Bolognese', 'Spaghetti with rich meat sauce', 10.99, 'spaghetti.jpg'),
(1, 6, 'Coca Cola', 'Refreshing cola drink', 2.99, 'coke.jpg'),
(1, 5, 'Tiramisu', 'Classic Italian dessert with coffee and mascarpone', 6.99, 'tiramisu.jpg');

-- Sample order for testing
INSERT INTO orders (user_id, restaurant_id, delivery_user_id, total_amount, status, payment_method, payment_status, delivery_address, delivery_phone)
VALUES (2, 1, 3, 28.97, 'CONFIRMED', 'CREDIT_CARD', 'PAID', '456 Customer Ave, Customer City', '987-654-3210');

-- Sample order items
INSERT INTO order_items (order_id, menu_item_id, quantity, price)
VALUES
(1, 1, 1, 12.99),
(1, 3, 1, 10.99),
(1, 4, 1, 2.99);

-- Sample review
INSERT INTO reviews (user_id, restaurant_id, order_id, rating, comment)
VALUES (2, 1, 1, 5, 'Excellent food and fast delivery!');

-- Test queries

-- 1. Get all active restaurants with their average rating
SELECT r.id, r.name, r.address, r.phone, r.rating, COUNT(rv.id) AS review_count
FROM restaurants r
LEFT JOIN reviews rv ON r.id = rv.restaurant_id
WHERE r.is_active = TRUE
GROUP BY r.id
ORDER BY r.rating DESC;

-- 2. Get menu items for a specific restaurant and category
SELECT m.id, m.name, m.description, m.price, c.name AS category
FROM menu_items m
JOIN categories c ON m.category_id = c.id
WHERE m.restaurant_id = 1 AND m.is_available = TRUE
ORDER BY c.name, m.name;

-- 3. Get order details with items
SELECT o.id, o.order_date, o.total_amount, o.status,
       u.full_name AS customer_name, r.name AS restaurant_name,
       du.full_name AS delivery_person
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN restaurants r ON o.restaurant_id = r.id
LEFT JOIN users du ON o.delivery_user_id = du.id
WHERE o.id = 1;

-- 4. Get order items for a specific order
SELECT oi.id, oi.quantity, oi.price, oi.special_instructions,
       m.name, m.description
FROM order_items oi
JOIN menu_items m ON oi.menu_item_id = m.id
WHERE oi.order_id = 1;

-- 5. Get all orders for a specific user
SELECT o.id, o.order_date, o.total_amount, o.status, r.name AS restaurant_name
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.id
WHERE o.user_id = 2
ORDER BY o.order_date DESC;

-- 6. Get all orders assigned to a delivery person
SELECT o.id, o.order_date, o.total_amount, o.status,
       u.full_name AS customer_name, r.name AS restaurant_name,
       o.delivery_address, o.delivery_phone
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN restaurants r ON o.restaurant_id = r.id
WHERE o.delivery_user_id = 3 AND o.status IN ('CONFIRMED', 'PREPARING', 'READY', 'OUT_FOR_DELIVERY')
ORDER BY o.order_date;
