-- Insert admin user with BCrypt hashed password
-- The password is 'admin123' hashed with BCrypt
INSERT INTO users (username, password, email, full_name, phone, address, role, is_active)
VALUES (
    'admin', 
    '$2a$12$tGjVB1ZmGQ5.1sSXHJIFR.HYJtCNqgXlsKaYTJCTBzxRjSqJ2Xvw2', -- BCrypt hash for 'admin123'
    'admin@foodexpress.com', 
    'Admin User', 
    '123-456-7890', 
    '123 Admin St, Admin City', 
    'ADMIN',
    TRUE
) ON DUPLICATE KEY UPDATE 
    password = '$2a$12$tGjVB1ZmGQ5.1sSXHJIFR.HYJtCNqgXlsKaYTJCTBzxRjSqJ2Xvw2',
    is_active = TRUE;

-- Insert customer user with BCrypt hashed password
-- The password is 'customer123' hashed with BCrypt
INSERT INTO users (username, password, email, full_name, phone, address, role, is_active)
VALUES (
    'customer', 
    '$2a$12$Ht0vEKi0Vy2SRGxRYbzRwuVYzEYPGBvXk7NqxEOFEwAeqQlTVPX0G', -- BCrypt hash for 'customer123'
    'customer@example.com', 
    'Sample Customer', 
    '987-654-3210', 
    '456 Customer Ave, Customer City', 
    'CUSTOMER',
    TRUE
) ON DUPLICATE KEY UPDATE 
    password = '$2a$12$Ht0vEKi0Vy2SRGxRYbzRwuVYzEYPGBvXk7NqxEOFEwAeqQlTVPX0G',
    is_active = TRUE;

-- Insert delivery user with BCrypt hashed password
-- The password is 'delivery123' hashed with BCrypt
INSERT INTO users (username, password, email, full_name, phone, address, role, is_active)
VALUES (
    'delivery', 
    '$2a$12$Ht0vEKi0Vy2SRGxRYbzRwuVYzEYPGBvXk7NqxEOFEwAeqQlTVPX0G', -- BCrypt hash for 'delivery123'
    'delivery@example.com', 
    'Delivery Person', 
    '555-123-4567', 
    '789 Delivery Blvd, Delivery City', 
    'DELIVERY',
    TRUE
) ON DUPLICATE KEY UPDATE 
    password = '$2a$12$Ht0vEKi0Vy2SRGxRYbzRwuVYzEYPGBvXk7NqxEOFEwAeqQlTVPX0G',
    is_active = TRUE;
