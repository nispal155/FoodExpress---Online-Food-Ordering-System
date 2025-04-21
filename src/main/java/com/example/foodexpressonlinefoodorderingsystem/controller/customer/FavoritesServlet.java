package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.Favorite;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.FavoriteService;
import com.example.foodexpressonlinefoodorderingsystem.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling user favorites
 */
@WebServlet(name = "FavoritesServlet", urlPatterns = {"/favorites", "/favorites/*"})
public class FavoritesServlet extends HttpServlet {

    private final FavoriteService favoriteService = new FavoriteService();

    @Override
    public void init() throws ServletException {
        super.init();
        // Create the favorites table if it doesn't exist
        favoriteService.createFavoritesTableIfNotExists();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the path info to determine the action
        String pathInfo = request.getPathInfo();
        
        // Default view is to show all favorites
        if (pathInfo == null || pathInfo.equals("/")) {
            showFavorites(request, response, user);
            return;
        }
        
        // Handle specific actions
        if (pathInfo.startsWith("/add")) {
            addFavorite(request, response, user);
        } else if (pathInfo.startsWith("/remove")) {
            removeFavorite(request, response, user);
        } else {
            // Invalid path, redirect to favorites page
            response.sendRedirect(request.getContextPath() + "/favorites");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // POST requests are handled the same as GET for add/remove actions
        doGet(request, response);
    }

    /**
     * Show all favorites for a user
     * @param request the HTTP request
     * @param response the HTTP response
     * @param user the current user
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showFavorites(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        // Get favorite restaurants and menu items
        List<Favorite> favoriteRestaurants = favoriteService.getFavoriteRestaurants(user.getId());
        List<Favorite> favoriteMenuItems = favoriteService.getFavoriteMenuItems(user.getId());
        
        // Set attributes for the JSP
        request.setAttribute("favoriteRestaurants", favoriteRestaurants);
        request.setAttribute("favoriteMenuItems", favoriteMenuItems);
        
        // Forward to the favorites JSP
        request.getRequestDispatcher("/WEB-INF/views/customer/favorites.jsp").forward(request, response);
    }

    /**
     * Add a favorite restaurant or menu item
     * @param request the HTTP request
     * @param response the HTTP response
     * @param user the current user
     * @throws IOException if an I/O error occurs
     */
    private void addFavorite(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        // Get parameters
        String restaurantIdParam = request.getParameter("restaurantId");
        String menuItemIdParam = request.getParameter("menuItemId");
        
        boolean success = false;
        
        // Add restaurant to favorites
        if (restaurantIdParam != null && !restaurantIdParam.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restaurantIdParam);
                success = favoriteService.addRestaurantToFavorites(user.getId(), restaurantId);
            } catch (NumberFormatException e) {
                // Invalid restaurant ID
            }
        }
        
        // Add menu item to favorites
        if (menuItemIdParam != null && !menuItemIdParam.isEmpty()) {
            try {
                int menuItemId = Integer.parseInt(menuItemIdParam);
                success = favoriteService.addMenuItemToFavorites(user.getId(), menuItemId);
            } catch (NumberFormatException e) {
                // Invalid menu item ID
            }
        }
        
        // Redirect back to the referring page or favorites page
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/favorites");
        }
    }

    /**
     * Remove a favorite restaurant or menu item
     * @param request the HTTP request
     * @param response the HTTP response
     * @param user the current user
     * @throws IOException if an I/O error occurs
     */
    private void removeFavorite(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        // Get parameters
        String restaurantIdParam = request.getParameter("restaurantId");
        String menuItemIdParam = request.getParameter("menuItemId");
        
        boolean success = false;
        
        // Remove restaurant from favorites
        if (restaurantIdParam != null && !restaurantIdParam.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restaurantIdParam);
                success = favoriteService.removeRestaurantFromFavorites(user.getId(), restaurantId);
            } catch (NumberFormatException e) {
                // Invalid restaurant ID
            }
        }
        
        // Remove menu item from favorites
        if (menuItemIdParam != null && !menuItemIdParam.isEmpty()) {
            try {
                int menuItemId = Integer.parseInt(menuItemIdParam);
                success = favoriteService.removeMenuItemFromFavorites(user.getId(), menuItemId);
            } catch (NumberFormatException e) {
                // Invalid menu item ID
            }
        }
        
        // Redirect back to the referring page or favorites page
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty() && referer.contains("/favorites")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/favorites");
        }
    }
}
