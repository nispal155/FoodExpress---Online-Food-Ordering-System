package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.service.SettingsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 * Servlet that initializes the settings table when the application starts
 */
@WebServlet(name = "DatabaseSettingsInitServlet", urlPatterns = {}, loadOnStartup = 4)
public class DatabaseSettingsInitServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        super.init();
        
        try {
            // Initialize the settings table
            SettingsService settingsService = new SettingsService();
            settingsService.createSettingsTableIfNotExists();
            
            System.out.println("Settings table initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing settings table: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
