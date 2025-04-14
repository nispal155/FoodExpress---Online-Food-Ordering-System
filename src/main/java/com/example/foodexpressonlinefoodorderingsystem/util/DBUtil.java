package com.example.foodexpressonlinefoodorderingsystem.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Database Utility class for managing database connections
 */
public class DBUtil {
    private static final Properties properties = new Properties();
    private static final String PROPERTIES_FILE = "db.properties";

    static {
        try (InputStream inputStream = DBUtil.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {
            if (inputStream != null) {
                properties.load(inputStream);
                // Load the JDBC driver
                Class.forName(properties.getProperty("db.driver"));

                // Update the database schema if needed
                DatabaseSchemaUpdater.updateSchema();
            } else {
                throw new RuntimeException("Unable to find " + PROPERTIES_FILE);
            }
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Error initializing database: " + e.getMessage(), e);
        }
    }

    /**
     * Get a database connection
     * @return Connection object
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                properties.getProperty("db.url"),
                properties.getProperty("db.username"),
                properties.getProperty("db.password")
        );
    }

    /**
     * Close a database connection
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
