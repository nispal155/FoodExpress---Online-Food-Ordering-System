package com.example.foodexpressonlinefoodorderingsystem.util;

import com.example.foodexpressonlinefoodorderingsystem.service.FavoriteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 * Servlet that initializes the favorites table when the application starts
 */
@WebServlet(name = "DatabaseFavoritesInitServlet", urlPatterns = {}, loadOnStartup = 3)
public class DatabaseFavoritesInitServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        super.init();
        
        try {
            // Initialize the favorites table
            FavoriteService favoriteService = new FavoriteService();
            favoriteService.createFavoritesTableIfNotExists();
            
            System.out.println("Favorites table initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing favorites table: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
