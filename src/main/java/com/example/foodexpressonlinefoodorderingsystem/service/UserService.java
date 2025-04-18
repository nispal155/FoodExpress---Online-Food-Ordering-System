package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;
import com.example.foodexpressonlinefoodorderingsystem.util.PasswordUtil;

import java.sql.*;
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
        String sql = "INSERT INTO users (username, password, email, full_name, phone, address, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

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
        // Check if password needs to be updated
        boolean updatePassword = user.getPassword() != null && !user.getPassword().isEmpty();

        String sql;
        if (updatePassword) {
            sql = "UPDATE users SET username = ?, password = ?, email = ?, full_name = ?, " +
                  "phone = ?, address = ?, role = ?, updated_at = CURRENT_TIMESTAMP " +
                  "WHERE id = ?";
        } else {
            sql = "UPDATE users SET username = ?, email = ?, full_name = ?, " +
                  "phone = ?, address = ?, role = ?, updated_at = CURRENT_TIMESTAMP " +
                  "WHERE id = ?";
        }

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
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Get all users
     * @return List of all users
     */
    public List<User> getAllUsers() {
        String sql = "SELECT * FROM users";
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
                sql = "SELECT * FROM users WHERE role = ? AND is_active = TRUE ORDER BY full_name";
            } else {
                sql = "SELECT * FROM users WHERE role = ? ORDER BY full_name";
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
     * Authenticate a user
     * @param username the username
     * @param password the password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ?";
        User user = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
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
     */
    private void updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error updating last login time: " + e.getMessage());
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
     * Search users by name, email, or username
     * @param query the search query
     * @return List of users matching the search criteria
     */
    public List<User> searchUsers(String query) {
        String sql = "SELECT * FROM users WHERE username LIKE ? OR email LIKE ? OR full_name LIKE ? ORDER BY full_name";
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
}
