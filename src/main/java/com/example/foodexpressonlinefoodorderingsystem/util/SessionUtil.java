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
        // Create a new session
        HttpSession session = request.getSession(true);
        
        // Set session attributes
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());
        
        // Set session timeout (30 minutes by default)
        session.setMaxInactiveInterval(30 * 60);
        
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
        
        // Save the token in the database
        saveRememberMeToken(user.getId(), token);
        
        // Create a cookie with the token
        Cookie cookie = new Cookie(REMEMBER_ME_COOKIE, token);
        cookie.setMaxAge(COOKIE_MAX_AGE);
        cookie.setPath("/");
        cookie.setHttpOnly(true); // For security, not accessible by JavaScript
        
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
            return null;
        }
        
        // Find the remember-me cookie
        String token = null;
        for (Cookie cookie : cookies) {
            if (REMEMBER_ME_COOKIE.equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }
        
        if (token == null) {
            return null;
        }
        
        // Get the user ID from the token
        int userId = getUserIdFromToken(token);
        if (userId == -1) {
            return null;
        }
        
        // Get the user from the database
        UserService userService = new UserService();
        return userService.getUserById(userId);
    }
    
    /**
     * Clear the remember-me cookie
     * @param request the HTTP request
     * @param response the HTTP response
     */
    public static void clearRememberMeCookie(HttpServletRequest request, HttpServletResponse response) {
        // Get the remember-me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return;
        }
        
        // Find and clear the remember-me cookie
        for (Cookie cookie : cookies) {
            if (REMEMBER_ME_COOKIE.equals(cookie.getName())) {
                // Delete the token from the database
                deleteRememberMeToken(cookie.getValue());
                
                // Clear the cookie
                cookie.setValue("");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
                break;
            }
        }
    }
    
    /**
     * Save a remember-me token in the database
     * @param userId the user ID
     * @param token the token
     */
    private static void saveRememberMeToken(int userId, String token) {
        String sql = "INSERT INTO user_sessions (user_id, session_token, expiry_date, ip_address, user_agent) " +
                     "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 30 DAY), ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, token);
            stmt.setString(3, ""); // IP address (not implemented)
            stmt.setString(4, ""); // User agent (not implemented)
            
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error saving remember-me token: " + e.getMessage());
        }
    }
    
    /**
     * Get the user ID from a remember-me token
     * @param token the token
     * @return the user ID, or -1 if not found
     */
    private static int getUserIdFromToken(String token) {
        String sql = "SELECT user_id FROM user_sessions WHERE session_token = ? AND expiry_date > NOW()";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("user_id");
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting user ID from token: " + e.getMessage());
        }
        
        return -1;
    }
    
    /**
     * Delete a remember-me token from the database
     * @param token the token
     */
    private static void deleteRememberMeToken(String token) {
        String sql = "DELETE FROM user_sessions WHERE session_token = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, token);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error deleting remember-me token: " + e.getMessage());
        }
    }
}
