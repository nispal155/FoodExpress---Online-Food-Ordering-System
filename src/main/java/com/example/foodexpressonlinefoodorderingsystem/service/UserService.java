package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;
import com.example.foodexpressonlinefoodorderingsystem.util.PasswordUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for User-related operations
 */
public class UserService {

    /**
     * Get a user by ID
     * @param userId the user ID to search for
     * @return User object if found, null otherwise
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE id = ?";
        User user = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
        }

        return user;
    }

    /**
     * Get a user by username
     * @param username the username to search for
     * @return User object if found, null otherwise
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        User user = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting user by username: " + e.getMessage());
        }

        return user;
    }

    /**
     * Get a user by email
     * @param email the email to search for
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        User user = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting user by email: " + e.getMessage());
        }

        return user;
    }

    /**
     * Create a new user
     * @param user the user to create
     * @return true if successful, false otherwise
     */
    public boolean createUser(User user) {
        // Check if columns exist in the database
        boolean hasProfilePicture = false;
        boolean hasIsActive = false;
        try (Connection conn = DBUtil.getConnection()) {
            hasProfilePicture = DBUtil.columnExists(conn, "users", "profile_picture");
            hasIsActive = DBUtil.columnExists(conn, "users", "is_active");
        } catch (SQLException e) {
            System.err.println("Error checking if columns exist: " + e.getMessage());
        }

        // Prepare SQL statement based on which columns exist
        StringBuilder sqlBuilder = new StringBuilder("INSERT INTO users (username, password, email, full_name, phone, address, role");

        if (hasProfilePicture) {
            sqlBuilder.append(", profile_picture");
        }

        if (hasIsActive) {
            sqlBuilder.append(", is_active");
        }

        sqlBuilder.append(") VALUES (?, ?, ?, ?, ?, ?, ?");

        // Add placeholders for additional columns
        if (hasProfilePicture) {
            sqlBuilder.append(", ?");
        }

        if (hasIsActive) {
            sqlBuilder.append(", ?");
        }

        sqlBuilder.append(")");

        String sql = sqlBuilder.toString();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Hash the password before storing it
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

            stmt.setString(1, user.getUsername());
            stmt.setString(2, hashedPassword);
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());

            int paramIndex = 8;

            // Set profile picture if column exists and value is provided
            if (hasProfilePicture) {
                stmt.setString(paramIndex++, user.getProfilePicture() != null ? user.getProfilePicture() : "");
            }

            // Set is_active if column exists
            if (hasIsActive) {
                stmt.setBoolean(paramIndex++, user.isActive());
            }

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                    return true;
                } else {
                    return false;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Update an existing user
     * @param user the user to update
     * @return true if successful, false otherwise
     */
    public boolean updateUser(User user) {
        // Always fetch the existing user to ensure we have all fields
        User existingUser = getUserById(user.getId());
        if (existingUser == null) {
            System.err.println("Error updating user: Could not retrieve existing user");
            return false;
        }

        // Check if password needs to be updated
        boolean updatePassword = user.getPassword() != null && !user.getPassword().isEmpty();

        // If password is not being updated, preserve the existing password
        if (!updatePassword) {
            user.setPassword(existingUser.getPassword());
        }

        // Make sure username is not null or empty
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            user.setUsername(existingUser.getUsername());
        }

        // Check if is_active column exists
        boolean hasIsActive = false;
        try (Connection conn = DBUtil.getConnection()) {
            hasIsActive = DBUtil.columnExists(conn, "users", "is_active");
        } catch (SQLException e) {
            System.err.println("Error checking if is_active column exists: " + e.getMessage());
        }

        StringBuilder sqlBuilder = new StringBuilder("UPDATE users SET username = ?");

        if (updatePassword) {
            sqlBuilder.append(", password = ?");
        }

        sqlBuilder.append(", email = ?, full_name = ?, phone = ?, address = ?, role = ?, profile_picture = ?");

        if (hasIsActive) {
            sqlBuilder.append(", is_active = ?");
        }

        sqlBuilder.append(", updated_at = CURRENT_TIMESTAMP WHERE id = ?");

        String sql = sqlBuilder.toString();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());

            int paramIndex = 2;
            if (updatePassword) {
                // Hash the password before storing it
                String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
                stmt.setString(paramIndex++, hashedPassword);
            }

            stmt.setString(paramIndex++, user.getEmail());
            stmt.setString(paramIndex++, user.getFullName());
            stmt.setString(paramIndex++, user.getPhone());
            stmt.setString(paramIndex++, user.getAddress());
            stmt.setString(paramIndex++, user.getRole());
            stmt.setString(paramIndex++, user.getProfilePicture());

            // Set is_active if column exists
            if (hasIsActive) {
                stmt.setBoolean(paramIndex++, user.isActive());
            }

            stmt.setInt(paramIndex, user.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete a user by ID
     * @param userId the ID of the user to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteUser(int userId) {
        // First, check if the user exists
        User user = getUserById(userId);
        if (user == null) {
            System.err.println("User not found with ID: " + userId);
            return false;
        }

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // Step 1: Check if user has orders
            boolean hasOrders = false;
            try (PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM orders WHERE user_id = ?")) {
                checkStmt.setInt(1, userId);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    hasOrders = true;
                }
            }

            // Step 2: If user has orders, update orders to set user_id to NULL
            if (hasOrders) {
                System.out.println("User has orders, updating orders to set user_id to NULL");
                try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE orders SET user_id = NULL WHERE user_id = ?")) {
                    updateStmt.setInt(1, userId);
                    updateStmt.executeUpdate();
                }
            }

            // Step 3: Check if user is assigned to orders as delivery person
            boolean isDeliveryPerson = false;
            try (PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM orders WHERE delivery_user_id = ?")) {
                checkStmt.setInt(1, userId);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    isDeliveryPerson = true;
                }
            }

            // Step 4: If user is assigned to orders, update orders to set delivery_user_id to NULL
            if (isDeliveryPerson) {
                System.out.println("User is assigned to orders as delivery person, updating orders to set delivery_user_id to NULL");
                try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE orders SET delivery_user_id = NULL WHERE delivery_user_id = ?")) {
                    updateStmt.setInt(1, userId);
                    updateStmt.executeUpdate();
                }
            }

            // Step 5: Delete the user
            try (PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM users WHERE id = ?")) {
                deleteStmt.setInt(1, userId);
                int affectedRows = deleteStmt.executeUpdate();

                // If successful, commit the transaction
                conn.commit();
                System.out.println("Successfully deleted user with ID: " + userId);
                return affectedRows > 0;
            }

        } catch (SQLException e) {
            // If there's an error, roll back the transaction
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                System.err.println("Error rolling back transaction: " + ex.getMessage());
            }

            // Print the error details
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;

        } finally {
            // Reset auto-commit to true and close connection
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException ex) {
                System.err.println("Error resetting auto-commit or closing connection: " + ex.getMessage());
            }
        }
    }

    /**
     * Get all users
     * @return List of all users
     */
    public List<User> getAllUsers() {
        String sql = "SELECT * FROM users ORDER BY id";
        List<User> users = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
        }

        return users;
    }

    /**
     * Get all users with pagination
     * @param page the page number (1-based)
     * @param pageSize the number of users per page
     * @return List of users for the specified page
     */
    public List<User> getAllUsersPaginated(int page, int pageSize) {
        String sql = "SELECT * FROM users ORDER BY id LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting paginated users: " + e.getMessage());
        }

        return users;
    }

    /**
     * Count all users
     * @return Total number of users
     */
    public int countAllUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        int count = 0;

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error counting users: " + e.getMessage());
        }

        return count;
    }

    /**
     * Get users by role
     * @param role the role to filter by (ADMIN, CUSTOMER, DELIVERY)
     * @return List of users with the specified role
     */
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            // Check if is_active column exists
            boolean hasIsActive = DBUtil.columnExists(conn, "users", "is_active");

            String sql;
            if (hasIsActive) {
                sql = "SELECT * FROM users WHERE role = ? ORDER BY id";
            } else {
                sql = "SELECT * FROM users WHERE role = ? ORDER BY id";
            }

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, role);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting users by role: " + e.getMessage());
        }

        return users;
    }

    /**
     * Get users by role with pagination
     * @param role the role to filter by (ADMIN, CUSTOMER, DELIVERY)
     * @param page the page number (1-based)
     * @param pageSize the number of users per page
     * @return List of users with the specified role for the specified page
     */
    public List<User> getUsersByRolePaginated(String role, int page, int pageSize) {
        List<User> users = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try (Connection conn = DBUtil.getConnection()) {
            // Validate role parameter
            if (role == null || role.isEmpty()) {
                return getAllUsersPaginated(page, pageSize);
            }

            // Ensure role is uppercase for comparison
            role = role.toUpperCase();
            if (!role.equals("ADMIN") && !role.equals("CUSTOMER") && !role.equals("DELIVERY")) {
                return getAllUsersPaginated(page, pageSize);
            }

            System.out.println("Executing SQL query for role: " + role);
            String sql = "SELECT * FROM users WHERE role = ? ORDER BY id LIMIT ? OFFSET ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, role);
                stmt.setInt(2, pageSize);
                stmt.setInt(3, offset);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }

                System.out.println("Found " + users.size() + " users with role " + role);
            }
        } catch (SQLException e) {
            System.err.println("Error getting paginated users by role: " + e.getMessage());
            e.printStackTrace();
        }

        return users;
    }

    /**
     * Count users by role
     * @param role the role to filter by (ADMIN, CUSTOMER, DELIVERY)
     * @return Total number of users with the specified role
     */
    public int countUsersByRole(String role) {
        // Validate role parameter
        if (role == null || role.isEmpty()) {
            return countAllUsers();
        }

        // Ensure role is uppercase for comparison
        role = role.toUpperCase();
        if (!role.equals("ADMIN") && !role.equals("CUSTOMER") && !role.equals("DELIVERY")) {
            return countAllUsers();
        }

        System.out.println("Counting users with role: " + role);
        String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
        int count = 0;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
                System.out.println("Found " + count + " users with role " + role);
            }

        } catch (SQLException e) {
            System.err.println("Error counting users by role: " + e.getMessage());
            e.printStackTrace();
        }

        return count;
    }

    /**
     * Authenticate a user
     * @param usernameOrEmail the username or email
     * @param password the password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String usernameOrEmail, String password) {
        // First try to authenticate with username
        String sql = "SELECT * FROM users WHERE username = ? OR email = ?";
        User user = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usernameOrEmail);
            stmt.setString(2, usernameOrEmail);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = mapResultSetToUser(rs);
                String storedPassword = user.getPassword();
                boolean authenticated = false;

                // Check if the password is already hashed (BCrypt hashes start with '$2a$', '$2b$', or '$2y$')
                if (storedPassword.startsWith("$2")) {
                    try {
                        // Verify the password using BCrypt
                        authenticated = PasswordUtil.verifyPassword(password, storedPassword);
                    } catch (IllegalArgumentException e) {
                        // If there's an error with the hash format, fall back to plain text comparison
                        authenticated = password.equals(storedPassword);

                        // If authenticated, update the password to use BCrypt
                        if (authenticated) {
                            updatePasswordWithBCrypt(user.getId(), password);
                        }
                    }
                } else {
                    // Plain text comparison for non-hashed passwords
                    authenticated = password.equals(storedPassword);

                    // If authenticated, update the password to use BCrypt
                    if (authenticated) {
                        updatePasswordWithBCrypt(user.getId(), password);
                    }
                }

                if (!authenticated) {
                    // Password doesn't match
                    user = null;
                } else {
                    // Update last login time
                    updateLastLogin(user.getId());
                }
            }

        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
        }

        return user;
    }

    /**
     * Update a user's password with BCrypt hashing
     * @param userId the user ID
     * @param plainPassword the plain text password
     */
    private void updatePasswordWithBCrypt(int userId, String plainPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Hash the password
            String hashedPassword = PasswordUtil.hashPassword(plainPassword);

            stmt.setString(1, hashedPassword);
            stmt.setInt(2, userId);
            stmt.executeUpdate();

            System.out.println("Updated password with BCrypt hash for user ID: " + userId);

        } catch (SQLException e) {
            System.err.println("Error updating password with BCrypt: " + e.getMessage());
        }
    }

    /**
     * Get the total count of users
     * @return the count of users
     */
    public int getUserCount() {
        String sql = "SELECT COUNT(*) FROM users";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting user count: " + e.getMessage());
        }

        return 0;
    }

    /**
     * Get all delivery staff users
     * @return List of delivery staff users
     */
    public List<User> getDeliveryStaff() {
        String sql = "SELECT * FROM users WHERE role = 'DELIVERY' AND is_active = TRUE ORDER BY full_name";
        List<User> users = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting delivery staff: " + e.getMessage());
        }

        return users;
    }

    /**
     * Update the last login time for a user
     * @param userId the user ID
     * @return true if successful, false otherwise
     */
    public boolean updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating last login time: " + e.getMessage());
            return false;
        }
    }

    /**
     * Helper method to map a ResultSet to a User object
     * @param rs the ResultSet
     * @return User object
     * @throws SQLException if a database access error occurs
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setFullName(rs.getString("full_name"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        user.setRole(rs.getString("role"));

        // Get last_login if it exists in the result set
        try {
            user.setLastLogin(rs.getTimestamp("last_login"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        // Get profile_picture if it exists in the result set
        try {
            user.setProfilePicture(rs.getString("profile_picture"));
        } catch (SQLException e) {
            // Ignore if the column doesn't exist
        }

        // Get verification code fields if they exist in the result set
        try {
            user.setVerificationCode(rs.getString("verification_code"));
            user.setVerificationCodeExpiry(rs.getTimestamp("verification_code_expiry"));
        } catch (SQLException e) {
            // Ignore if the columns don't exist
        }

        // Get is_active if it exists in the result set
        try {
            user.setActive(rs.getBoolean("is_active"));
        } catch (SQLException e) {
            // If the column doesn't exist, default to active
            user.setActive(true);
        }

        return user;
    }

    /**
     * Reset a user's password
     * @param email the user's email
     * @param newPassword the new password
     * @return true if successful, false otherwise
     */
    public boolean resetPassword(String email, String newPassword) {
        String sql = "UPDATE users SET password = ?, updated_at = CURRENT_TIMESTAMP WHERE email = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Hash the new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);

            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error resetting password: " + e.getMessage());
            return false;
        }
    }

    /**
     * Verify a user's password
     * @param userId the user ID
     * @param password the password to verify
     * @return true if the password is correct, false otherwise
     */
    public boolean verifyPassword(int userId, String password) {
        String sql = "SELECT password FROM users WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return PasswordUtil.verifyPassword(password, storedPassword);
            }

            return false;

        } catch (SQLException e) {
            System.err.println("Error verifying password: " + e.getMessage());
            return false;
        }
    }

    /**
     * Search users by name, email, or username
     * @param query the search query
     * @return List of users matching the search criteria
     */
    public List<User> searchUsers(String query) {
        String sql = "SELECT * FROM users WHERE username LIKE ? OR email LIKE ? OR full_name LIKE ? ORDER BY id";
        List<User> users = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching users: " + e.getMessage());
        }

        return users;
    }

    /**
     * Search users by name, email, or username with pagination
     * @param query the search query
     * @param page the page number (1-based)
     * @param pageSize the number of users per page
     * @return List of users matching the search criteria for the specified page
     */
    public List<User> searchUsersPaginated(String query, int page, int pageSize) {
        String sql = "SELECT * FROM users WHERE username LIKE ? OR email LIKE ? OR full_name LIKE ? ORDER BY id LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setInt(4, pageSize);
            stmt.setInt(5, offset);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching users with pagination: " + e.getMessage());
        }

        return users;
    }

    /**
     * Count users matching a search query
     * @param query the search query
     * @return Total number of users matching the search criteria
     */
    public int countSearchUsers(String query) {
        String sql = "SELECT COUNT(*) FROM users WHERE username LIKE ? OR email LIKE ? OR full_name LIKE ?";
        int count = 0;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error counting search results: " + e.getMessage());
        }

        return count;
    }

    /**
     * Set a verification code for a user
     * @param email the user's email
     * @param verificationCode the verification code
     * @param expiryMinutes minutes until the code expires
     * @return true if successful, false otherwise
     */
    public boolean setVerificationCode(String email, String verificationCode, int expiryMinutes) {
        String sql = "UPDATE users SET verification_code = ?, verification_code_expiry = ? " +
                    "WHERE email = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Calculate expiry time
            Timestamp expiryTime = Timestamp.valueOf(LocalDateTime.now().plusMinutes(expiryMinutes));

            stmt.setString(1, verificationCode);
            stmt.setTimestamp(2, expiryTime);
            stmt.setString(3, email);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error setting verification code: " + e.getMessage());
            return false;
        }
    }

    /**
     * Verify a verification code for a user
     * @param email the user's email
     * @param verificationCode the verification code to verify
     * @return true if the code is valid and not expired, false otherwise
     */
    public boolean verifyVerificationCode(String email, String verificationCode) {
        String sql = "SELECT verification_code, verification_code_expiry FROM users WHERE email = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedCode = rs.getString("verification_code");
                Timestamp expiryTime = rs.getTimestamp("verification_code_expiry");

                // Check if code matches and is not expired
                if (storedCode != null && storedCode.equals(verificationCode) &&
                    expiryTime != null && expiryTime.after(new Timestamp(System.currentTimeMillis()))) {
                    return true;
                }
            }

            return false;

        } catch (SQLException e) {
            System.err.println("Error verifying verification code: " + e.getMessage());
            return false;
        }
    }

    /**
     * Clear a user's verification code
     * @param email the user's email
     * @return true if successful, false otherwise
     */
    public boolean clearVerificationCode(String email) {
        String sql = "UPDATE users SET verification_code = NULL, verification_code_expiry = NULL " +
                    "WHERE email = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error clearing verification code: " + e.getMessage());
            return false;
        }
    }
}
