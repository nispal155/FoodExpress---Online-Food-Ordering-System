-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS foodexpress;
USE foodexpress;

-- Create the user_sessions table if it doesn't exist
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

-- Display the tables in the database
SHOW TABLES;
