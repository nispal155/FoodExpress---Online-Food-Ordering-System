package com.example.foodexpressonlinefoodorderingsystem.test;

import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;

/**
 * Simple test class to verify the admin dashboard functionality
 */
public class AdminDashboardTest {
    
    public static void main(String[] args) {
        testDashboardCounts();
    }
    
    /**
     * Test the dashboard count methods
     */
    private static void testDashboardCounts() {
        UserService userService = new UserService();
        RestaurantService restaurantService = new RestaurantService();
        MenuItemService menuItemService = new MenuItemService();
        
        System.out.println("=== Admin Dashboard Test ===");
        System.out.println("User Count: " + userService.getUserCount());
        System.out.println("Restaurant Count: " + restaurantService.getRestaurantCount());
        System.out.println("Menu Item Count: " + menuItemService.getMenuItemCount());
        System.out.println("Special Menu Item Count: " + menuItemService.getSpecialMenuItemCount());
        System.out.println("============================");
    }
}
