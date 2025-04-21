package com.example.foodexpressonlinefoodorderingsystem.controller.customer;

import com.example.foodexpressonlinefoodorderingsystem.model.DeliveryRating;
import com.example.foodexpressonlinefoodorderingsystem.model.FoodRating;
import com.example.foodexpressonlinefoodorderingsystem.model.Review;
import com.example.foodexpressonlinefoodorderingsystem.model.Order;
import com.example.foodexpressonlinefoodorderingsystem.model.MenuItem;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.RatingService;
import com.example.foodexpressonlinefoodorderingsystem.service.OrderService;
import com.example.foodexpressonlinefoodorderingsystem.service.MenuItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling order rating
 */
@WebServlet(name = "RateOrderServlet", urlPatterns = {"/rate-order"})
public class RateOrderServlet extends HttpServlet {
    
    private RatingService ratingService;
    private OrderService orderService;
    private MenuItemService menuItemService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        ratingService = new RatingService();
        orderService = new OrderService();
        menuItemService = new MenuItemService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get order ID from request
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        // Get the order
        Order order = orderService.getOrderById(orderId);
        if (order == null || order.getUserId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        // Check if the order can be rated
        if (!ratingService.canRateOrder(orderId)) {
            request.setAttribute("error", "This order cannot be rated. It must be delivered and not already rated.");
            request.getRequestDispatcher("/WEB-INF/views/customer/orders.jsp").forward(request, response);
            return;
        }
        
        // Get menu items for the order
        List<MenuItem> menuItems = menuItemService.getMenuItemsByOrderId(orderId);
        
        // Set attributes for the rating form
        request.setAttribute("order", order);
        request.setAttribute("menuItems", menuItems);
        
        // Forward to the rating form
        request.getRequestDispatcher("/WEB-INF/views/customer/rate-order.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get order ID from request
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        // Get the order
        Order order = orderService.getOrderById(orderId);
        if (order == null || order.getUserId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }
        
        // Check if the order can be rated
        if (!ratingService.canRateOrder(orderId)) {
            request.setAttribute("error", "This order cannot be rated. It must be delivered and not already rated.");
            request.getRequestDispatcher("/WEB-INF/views/customer/orders.jsp").forward(request, response);
            return;
        }
        
        // Process restaurant rating
        String restaurantRatingParam = request.getParameter("restaurantRating");
        String restaurantComment = request.getParameter("restaurantComment");
        
        if (restaurantRatingParam != null && !restaurantRatingParam.isEmpty()) {
            try {
                int restaurantRating = Integer.parseInt(restaurantRatingParam);
                if (restaurantRating >= 1 && restaurantRating <= 5) {
                    Review review = new Review();
                    review.setUserId(user.getId());
                    review.setRestaurantId(order.getRestaurantId());
                    review.setOrderId(orderId);
                    review.setRating(restaurantRating);
                    review.setComment(restaurantComment);
                    
                    ratingService.submitRestaurantReview(review);
                }
            } catch (NumberFormatException e) {
                // Invalid rating, ignore
            }
        }
        
        // Process delivery rating if applicable
        if (order.getDeliveryUserId() > 0) {
            String deliveryRatingParam = request.getParameter("deliveryRating");
            String deliveryComment = request.getParameter("deliveryComment");
            
            if (deliveryRatingParam != null && !deliveryRatingParam.isEmpty()) {
                try {
                    int deliveryRating = Integer.parseInt(deliveryRatingParam);
                    if (deliveryRating >= 1 && deliveryRating <= 5) {
                        DeliveryRating rating = new DeliveryRating();
                        rating.setUserId(user.getId());
                        rating.setDeliveryUserId(order.getDeliveryUserId());
                        rating.setOrderId(orderId);
                        rating.setRating(deliveryRating);
                        rating.setComment(deliveryComment);
                        
                        ratingService.submitDeliveryRating(rating);
                    }
                } catch (NumberFormatException e) {
                    // Invalid rating, ignore
                }
            }
        }
        
        // Process food ratings
        List<MenuItem> menuItems = menuItemService.getMenuItemsByOrderId(orderId);
        
        for (MenuItem menuItem : menuItems) {
            String foodRatingParam = request.getParameter("foodRating_" + menuItem.getId());
            String foodComment = request.getParameter("foodComment_" + menuItem.getId());
            
            if (foodRatingParam != null && !foodRatingParam.isEmpty()) {
                try {
                    int foodRating = Integer.parseInt(foodRatingParam);
                    if (foodRating >= 1 && foodRating <= 5) {
                        FoodRating rating = new FoodRating();
                        rating.setUserId(user.getId());
                        rating.setMenuItemId(menuItem.getId());
                        rating.setOrderId(orderId);
                        rating.setRating(foodRating);
                        rating.setComment(foodComment);
                        
                        ratingService.submitFoodRating(rating);
                    }
                } catch (NumberFormatException e) {
                    // Invalid rating, ignore
                }
            }
        }
        
        // Redirect to orders page with success message
        request.getSession().setAttribute("message", "Thank you for your ratings!");
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}
