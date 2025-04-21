package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for handling the admin dashboard
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    
    private final UserService userService = new UserService();
    private final RestaurantService restaurantService = new RestaurantService();
    private final MenuItemService menuItemService = new MenuItemService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Get dashboard statistics
        int userCount = userService.getUserCount();
        int restaurantCount = restaurantService.getRestaurantCount();
        int menuItemCount = menuItemService.getMenuItemCount();
        int specialItemCount = menuItemService.getSpecialMenuItemCount();
        
        // Set attributes for the JSP
        request.setAttribute("userCount", userCount);
        request.setAttribute("restaurantCount", restaurantCount);
        request.setAttribute("menuItemCount", menuItemCount);
        request.setAttribute("specialItemCount", specialItemCount);
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
