-- Fix admin user role and status
-- This script updates the user with ID 7 to have ADMIN role and be active

UPDATE users 
SET role = 'ADMIN', is_active = TRUE 
WHERE id = 7;

-- Verify the change
SELECT id, username, email, role, is_active FROM users WHERE id = 7;
