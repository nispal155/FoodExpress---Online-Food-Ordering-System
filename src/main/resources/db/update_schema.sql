-- Add missing columns to menu_items table
ALTER TABLE menu_items 
ADD COLUMN is_special BOOLEAN DEFAULT FALSE,
ADD COLUMN discount_price DECIMAL(10,2) DEFAULT NULL;

-- Add missing column to users table
ALTER TABLE users
ADD COLUMN last_login TIMESTAMP DEFAULT NULL;

-- Update existing menu items to set is_special to false
UPDATE menu_items SET is_special = FALSE WHERE is_special IS NULL;
