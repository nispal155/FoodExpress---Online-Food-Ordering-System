package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet that initializes the database on application startup
 */
@WebServlet(name = "DatabaseInitServlet", urlPatterns = {}, loadOnStartup = 1)
public class DatabaseInitServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseInitServlet.class.getName());
    
    @Override
    public void init() throws ServletException {
        LOGGER.info("Initializing database tables...");
        createUserSessionsTable();
    }
    
    private void createUserSessionsTable() {
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
            LOGGER.info("user_sessions table created successfully");
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating user_sessions table: " + e.getMessage(), e);
        }
    }
}
