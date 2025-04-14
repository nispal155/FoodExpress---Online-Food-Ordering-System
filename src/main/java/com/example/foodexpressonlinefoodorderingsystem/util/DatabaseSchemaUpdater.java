package com.example.foodexpressonlinefoodorderingsystem.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Utility class to update the database schema
 */
public class DatabaseSchemaUpdater {

    private static boolean schemaUpdated = false;

    /**
     * Update the database schema if needed
     */
    public static synchronized void updateSchema() {
        if (schemaUpdated) {
            return;
        }

        try {
            // Run the regular update script
            executeUpdateScript("db/update_schema.sql");

            // Run the fix script to ensure all required columns exist
            executeUpdateScript("db/fix_schema.sql");

            schemaUpdated = true;
            System.out.println("Database schema updated successfully");
        } catch (Exception e) {
            System.err.println("Error updating database schema: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Execute the update script
     * @param scriptPath the path to the SQL script
     */
    private static void executeUpdateScript(String scriptPath) throws Exception {
        // Load the SQL script
        InputStream inputStream = DatabaseSchemaUpdater.class.getClassLoader().getResourceAsStream(scriptPath);
        if (inputStream == null) {
            throw new Exception("Update script not found: " + scriptPath);
        }

        // Read the SQL script
        String script = new BufferedReader(new InputStreamReader(inputStream))
                .lines()
                .collect(Collectors.joining("\n"));

        // Split the script into individual statements
        List<String> statements = splitSqlScript(script);

        // Execute each statement
        try (Connection conn = DBUtil.getConnection()) {
            for (String statement : statements) {
                if (statement.trim().isEmpty()) {
                    continue;
                }

                try (Statement stmt = conn.createStatement()) {
                    stmt.execute(statement);
                } catch (SQLException e) {
                    // Ignore errors if the column already exists
                    if (e.getMessage().contains("Duplicate column name") ||
                        e.getMessage().contains("Unknown column")) {
                        System.out.println("Skipping statement: " + statement);
                        System.out.println("Reason: " + e.getMessage());
                    } else {
                        throw e;
                    }
                }
            }
        }
    }

    /**
     * Split a SQL script into individual statements
     * @param script the SQL script
     * @return list of SQL statements
     */
    private static List<String> splitSqlScript(String script) {
        List<String> statements = new ArrayList<>();
        StringBuilder currentStatement = new StringBuilder();

        for (String line : script.split("\n")) {
            // Skip comments
            if (line.trim().startsWith("--")) {
                continue;
            }

            currentStatement.append(line).append("\n");

            if (line.trim().endsWith(";")) {
                statements.add(currentStatement.toString());
                currentStatement = new StringBuilder();
            }
        }

        // Add the last statement if it doesn't end with a semicolon
        if (currentStatement.length() > 0) {
            statements.add(currentStatement.toString());
        }

        return statements;
    }
}
