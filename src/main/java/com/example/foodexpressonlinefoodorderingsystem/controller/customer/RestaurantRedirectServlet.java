package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet for redirecting old-style restaurant URLs to the new format
 */
@WebServlet(name = "RestaurantRedirectServlet", urlPatterns = {"/restaurants/*"})
public class RestaurantRedirectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the path info (the part after /restaurants/)
        String pathInfo = request.getPathInfo();
        System.out.println("DEBUG - RestaurantRedirectServlet pathInfo: " + pathInfo);

        if (pathInfo == null || pathInfo.equals("/")) {
            // If no ID is provided, redirect to the restaurants list
            System.out.println("DEBUG - No restaurant ID provided, redirecting to restaurants list");
            response.sendRedirect(request.getContextPath() + "/restaurants");
            return;
        }

        // Remove the leading slash
        String restaurantId = pathInfo.substring(1);
        System.out.println("DEBUG - Extracted restaurantId: " + restaurantId);

        try {
            // Try to parse the ID to make sure it's a valid number
            int id = Integer.parseInt(restaurantId);
            System.out.println("DEBUG - Valid restaurant ID: " + id);

            // Redirect to the correct URL
            String redirectUrl = request.getContextPath() + "/restaurant?id=" + restaurantId;
            System.out.println("DEBUG - Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
        } catch (NumberFormatException e) {
            // If the ID is not a valid number, redirect to the restaurants list with an error
            System.out.println("ERROR - Invalid restaurant ID format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/restaurants?error=invalid-id");
        }
    }
}
