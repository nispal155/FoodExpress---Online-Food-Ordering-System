-- Add profile_picture column to users table
ALTER TABLE users ADD COLUMN profile_picture VARCHAR(255) DEFAULT NULL;

-- Create uploads directory if it doesn't exist
-- Note: This is a comment for manual action, as SQL cannot create directories
-- You need to manually create the directory: src/main/webapp/uploads/profile
