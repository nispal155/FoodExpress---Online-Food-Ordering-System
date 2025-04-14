package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 * Servlet that runs the schema update when the application starts
 */
@WebServlet(name = "SchemaUpdateServlet", urlPatterns = {}, loadOnStartup = 1)
public class SchemaUpdateServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        super.init();
        
        try {
            // Run the schema update
            DatabaseSchemaUpdater.updateSchema();
        } catch (Exception e) {
            System.err.println("Error updating database schema: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
