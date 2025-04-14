-- Add missing columns to orders table if they don't exist
SET @column_exists = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'orders'
    AND COLUMN_NAME = 'delivery_user_id'
);

SET @sql = IF(@column_exists = 0,
    'ALTER TABLE orders ADD COLUMN delivery_user_id INT NULL',
    'SELECT "Column delivery_user_id already exists"'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add foreign key constraint if it doesn't exist
-- First check if the constraint exists
SET @constraint_exists = (
    SELECT COUNT(*)
    FROM information_schema.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'orders'
    AND CONSTRAINT_NAME = 'orders_ibfk_3'
);

-- Add the constraint if it doesn't exist
SET @sql = IF(@constraint_exists = 0,
    'ALTER TABLE orders ADD CONSTRAINT orders_ibfk_3 FOREIGN KEY (delivery_user_id) REFERENCES users(id) ON DELETE SET NULL',
    'SELECT "Foreign key constraint already exists"'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add is_active column to users table if it doesn't exist
SET @column_exists = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'users'
    AND COLUMN_NAME = 'is_active'
);

SET @sql = IF(@column_exists = 0,
    'ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT TRUE',
    'SELECT "Column is_active already exists"'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add last_login column to users table if it doesn't exist
SET @column_exists = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'users'
    AND COLUMN_NAME = 'last_login'
);

SET @sql = IF(@column_exists = 0,
    'ALTER TABLE users ADD COLUMN last_login TIMESTAMP NULL',
    'SELECT "Column last_login already exists"'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Create index on orders.delivery_user_id if it doesn't exist
SET @index_exists = (
    SELECT COUNT(*)
    FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'orders'
    AND INDEX_NAME = 'idx_order_delivery_user'
);

SET @sql = IF(@index_exists = 0,
    'CREATE INDEX idx_order_delivery_user ON orders(delivery_user_id)',
    'SELECT "Index idx_order_delivery_user already exists"'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Create index on users.is_active if it doesn't exist
SET @index_exists = (
    SELECT COUNT(*)
    FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'users'
    AND INDEX_NAME = 'idx_user_active'
);

SET @sql = IF(@index_exists = 0,
    'CREATE INDEX idx_user_active ON users(is_active)',
    'SELECT "Index idx_user_active already exists"'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
