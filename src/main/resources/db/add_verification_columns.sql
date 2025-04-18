-- Add verification code columns to users table
ALTER TABLE users 
ADD COLUMN verification_code VARCHAR(10) DEFAULT NULL,
ADD COLUMN verification_code_expiry TIMESTAMP DEFAULT NULL;
