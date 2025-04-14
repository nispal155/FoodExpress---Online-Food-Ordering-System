package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet for searching menu items
 */
@WebServlet(name = "MenuSearchServlet", urlPatterns = {"/search"})
public class MenuSearchServlet extends HttpServlet {
    
    private final MenuItemService menuItemService = new MenuItemService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get search query from request parameter
        String query = request.getParameter("q");
        
        List<MenuItem> searchResults = new ArrayList<>();
        
        if (query != null && !query.trim().isEmpty()) {
            // Search for menu items
            searchResults = menuItemService.searchMenuItems(query);
            request.setAttribute("query", query);
        }
        
        // Set attributes for the JSP
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("pageTitle", "Search Results");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/customer/search-results.jsp").forward(request, response);
    }
}
