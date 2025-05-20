package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.UUID;

/**
 * Utility class for session and cookie management
 */
public class SessionUtil {

    private static final String REMEMBER_ME_COOKIE = "remember_me";
    private static final int COOKIE_MAX_AGE = 60 * 60 * 24 * 30; // 30 days

    /**
     * Create a session for the user
     * @param request the HTTP request
     * @param user the user
     * @param rememberMe whether to remember the user
     * @return the session
     */
    public static HttpSession createSession(HttpServletRequest request, User user, boolean rememberMe) {
        System.out.println("Creating session for user: " + user.getUsername() + " (ID: " + user.getId() + ")");
        System.out.println("Remember me: " + rememberMe);

        // Create a new session
        HttpSession session = request.getSession(true);

        // Log session ID (for debugging only - don't log this in production)
        System.out.println("Session ID: " + session.getId());

        // Set session attributes
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());

        // Store remember-me preference in session
        session.setAttribute("rememberMe", rememberMe);

        // Set session timeout (30 minutes by default)
        int timeout = 30 * 60; // 30 minutes in seconds
        session.setMaxInactiveInterval(timeout);

        System.out.println("Session timeout set to " + timeout + " seconds (" + (timeout / 60) + " minutes)");
        System.out.println("Session created successfully");

        return session;
    }

    /**
     * Create a remember-me cookie for the user
     * @param response the HTTP response
     * @param user the user
     */
    public static void createRememberMeCookie(HttpServletResponse response, User user) {
        // Generate a unique token
        String token = UUID.randomUUID().toString();

        System.out.println("Creating remember-me cookie for user: " + user.getUsername() + " (ID: " + user.getId() + ")");
        System.out.println("Generated token: " + token);

        // Save the token in the database
        saveRememberMeToken(user.getId(), token);

        // Create a cookie with the token
        Cookie cookie = new Cookie(REMEMBER_ME_COOKIE, token);
        cookie.setMaxAge(COOKIE_MAX_AGE);
        cookie.setPath("/");
        cookie.setHttpOnly(true); // For security, not accessible by JavaScript

        // Set secure flag if using HTTPS (commented out for development)
        // cookie.setSecure(true);

        System.out.println("Setting remember-me cookie: " + REMEMBER_ME_COOKIE + "=" + token);
        System.out.println("Cookie max age: " + COOKIE_MAX_AGE + " seconds (" + (COOKIE_MAX_AGE / 86400) + " days)");
        System.out.println("Cookie path: " + cookie.getPath());

        // Add the cookie to the response
        response.addCookie(cookie);
    }

    /**
     * Get the user from the remember-me cookie
     * @param request the HTTP request
     * @return the user, or null if not found
     */
    public static User getUserFromRememberMeCookie(HttpServletRequest request) {
        // Get the remember-me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            System.out.println("No cookies found in request");
            return null;
        }

        // Find the remember-me cookie
        String token = null;
        for (Cookie cookie : cookies) {
            if (REMEMBER_ME_COOKIE.equals(cookie.getName())) {
                token = cookie.getValue();
                System.out.println("Found remember-me cookie with token: " + token);
                break;
            }
        }

        if (token == null) {
            System.out.println("Remember-me cookie not found");
            return null;
        }

        // Get the user ID from the token
        int userId = getUserIdFromToken(token);
        if (userId == -1) {
            System.out.println("No valid user ID found for token: " + token);
            return null;
        }

        System.out.println("Found user ID " + userId + " for remember-me token");

        // Get the user from the database
        UserService userService = new UserService();
        User user = userService.getUserById(userId);

        if (user == null) {
            System.out.println("User not found in database for ID: " + userId);
        } else {
            System.out.println("Successfully retrieved user: " + user.getUsername() + " (ID: " + userId + ")");
        }

        return user;
    }

    /**
     * Clear the remember-me cookie
     * @param request the HTTP request
     * @param response the HTTP response
     */
    public static void clearRememberMeCookie(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Attempting to clear remember-me cookie");

        // Get the remember-me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            System.out.println("No cookies found in request");
            return;
        }

        boolean cookieFound = false;

        // Find and clear the remember-me cookie
        for (Cookie cookie : cookies) {
            if (REMEMBER_ME_COOKIE.equals(cookie.getName())) {
                cookieFound = true;
                System.out.println("Found remember-me cookie with value: " + cookie.getValue());

                // Delete the token from the database
                deleteRememberMeToken(cookie.getValue());

                // Clear the cookie
                cookie.setValue("");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);

                System.out.println("Remember-me cookie cleared");
                break;
            }
        }

        if (!cookieFound) {
            System.out.println("Remember-me cookie not found in request");
        }
    }

    /**
     * Save a remember-me token in the database
     * @param userId the user ID
     * @param token the token
     */
    private static void saveRememberMeToken(int userId, String token) {
        // First, check if the table exists and create it if it doesn't
        ensureUserSessionsTableExists();

        // Delete any existing tokens for this user to prevent duplicates
        deleteExistingTokensForUser(userId);

        String sql = "INSERT INTO user_sessions (user_id, session_token, expiry_date, ip_address, user_agent) " +
                     "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 30 DAY), ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, token);
            stmt.setString(3, "127.0.0.1"); // Default IP address
            stmt.setString(4, "Web Browser"); // Default user agent

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Remember-me token saved for user ID " + userId + ". Rows affected: " + rowsAffected);

        } catch (SQLException e) {
            System.err.println("Error saving remember-me token: " + e.getMessage());
            e.printStackTrace(); // Print stack trace for better debugging
        }
    }

    /**
     * Delete existing tokens for a user
     * @param userId the user ID
     */
    private static void deleteExistingTokensForUser(int userId) {
        String sql = "DELETE FROM user_sessions WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Deleted " + rowsAffected + " existing token(s) for user ID " + userId);
            }

        } catch (SQLException e) {
            System.err.println("Error deleting existing tokens: " + e.getMessage());
        }
    }

    /**
     * Ensures that the user_sessions table exists in the database
     */
    private static void ensureUserSessionsTableExists() {
        String sql = "CREATE TABLE IF NOT EXISTS user_sessions (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "user_id INT NOT NULL, " +
                "session_token VARCHAR(255) NOT NULL, " +
                "expiry_date TIMESTAMP NOT NULL, " +
                "ip_address VARCHAR(45), " +
                "user_agent TEXT, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, " +
                "UNIQUE INDEX idx_session_token (session_token), " +
                "INDEX idx_session_user (user_id), " +
                "INDEX idx_session_expiry (expiry_date)" +
                ") ENGINE=InnoDB";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.execute(sql);

        } catch (SQLException e) {
            System.err.println("Error creating user_sessions table: " + e.getMessage());
        }
    }

    /**
     * Get the user ID from a remember-me token
     * @param token the token
     * @return the user ID, or -1 if not found
     */
    private static int getUserIdFromToken(String token) {
        // Ensure the table exists
        ensureUserSessionsTableExists();

        // First, clean up expired tokens
        cleanupExpiredTokens();

        String sql = "SELECT user_id, expiry_date FROM user_sessions WHERE session_token = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                Timestamp expiryDate = rs.getTimestamp("expiry_date");
                Timestamp now = new Timestamp(System.currentTimeMillis());

                if (expiryDate.after(now)) {
                    System.out.println("Valid token found for user ID: " + userId + ", expires: " + expiryDate);
                    return userId;
                } else {
                    System.out.println("Token expired for user ID: " + userId + ", expired: " + expiryDate);
                    // Delete the expired token
                    deleteRememberMeToken(token);
                }
            } else {
                System.out.println("No token found in database: " + token);
            }

        } catch (SQLException e) {
            System.err.println("Error getting user ID from token: " + e.getMessage());
            e.printStackTrace();
        }

        return -1;
    }

    /**
     * Clean up expired tokens
     */
    private static void cleanupExpiredTokens() {
        String sql = "DELETE FROM user_sessions WHERE expiry_date <= NOW()";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            int rowsAffected = stmt.executeUpdate(sql);
            if (rowsAffected > 0) {
                System.out.println("Cleaned up " + rowsAffected + " expired token(s)");
            }

        } catch (SQLException e) {
            System.err.println("Error cleaning up expired tokens: " + e.getMessage());
        }
    }

    /**
     * Delete a remember-me token from the database
     * @param token the token
     */
    private static void deleteRememberMeToken(String token) {
        // Ensure the table exists
        ensureUserSessionsTableExists();

        String sql = "DELETE FROM user_sessions WHERE session_token = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Successfully deleted token from database: " + token);
            } else {
                System.out.println("No token found in database to delete: " + token);
            }

        } catch (SQLException e) {
            System.err.println("Error deleting remember-me token: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Get the current user from the session
     * @param request the HTTP request
     * @return the user, or null if not logged in
     */
    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }

        return (User) session.getAttribute("user");
    }

    /**
     * Update the user in the session
     * @param request the HTTP request
     * @param user the updated user
     */
    public static void updateUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute("user", user);
        }
    }
}
