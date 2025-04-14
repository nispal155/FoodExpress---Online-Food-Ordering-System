package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.Restaurant;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.RestaurantService;
import com.example.foodexpressonlinefoodorderingsystem.util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet for adding/editing restaurants in the admin panel
 */
@WebServlet(name = "AdminRestaurantFormServlet", urlPatterns = {"/admin/restaurants/form"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class AdminRestaurantFormServlet extends HttpServlet {
    
    private final RestaurantService restaurantService = new RestaurantService();
    
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
        
        // Check if editing an existing restaurant
        String restaurantIdStr = request.getParameter("id");
        Restaurant restaurant = null;
        
        if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restaurantIdStr);
                restaurant = restaurantService.getRestaurantById(restaurantId);
                
                if (restaurant == null) {
                    // Restaurant not found
                    response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=not_found");
                    return;
                }
                
                request.setAttribute("restaurant", restaurant);
                request.setAttribute("pageTitle", "Edit Restaurant");
                
            } catch (NumberFormatException e) {
                // Invalid restaurant ID
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=invalid_id");
                return;
            }
        } else {
            // New restaurant
            request.setAttribute("pageTitle", "Add Restaurant");
        }
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/restaurant-form.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
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
        
        // Get form parameters
        String restaurantIdStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String ratingStr = request.getParameter("rating");
        String isActiveStr = request.getParameter("isActive");
        
        // Validate form inputs
        Map<String, String> errors = validateForm(name, description, address, phone, email, ratingStr);
        
        if (!errors.isEmpty()) {
            // If there are validation errors, return to the form with error messages
            request.setAttribute("errors", errors);
            
            // Populate the form with the submitted values
            Restaurant restaurant = new Restaurant();
            
            if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
                try {
                    restaurant.setId(Integer.parseInt(restaurantIdStr));
                } catch (NumberFormatException e) {
                    // Ignore invalid ID
                }
            }
            
            restaurant.setName(name);
            restaurant.setDescription(description);
            restaurant.setAddress(address);
            restaurant.setPhone(phone);
            restaurant.setEmail(email);
            
            try {
                restaurant.setRating(Double.parseDouble(ratingStr));
            } catch (NumberFormatException e) {
                restaurant.setRating(0.0);
            }
            
            restaurant.setActive(isActiveStr != null && isActiveStr.equals("true"));
            
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("pageTitle", restaurantIdStr != null && !restaurantIdStr.isEmpty() ? "Edit Restaurant" : "Add Restaurant");
            
            request.getRequestDispatcher("/WEB-INF/views/admin/restaurant-form.jsp").forward(request, response);
            return;
        }
        
        // Create or update the restaurant
        Restaurant restaurant = new Restaurant();
        
        if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restaurantIdStr);
                restaurant = restaurantService.getRestaurantById(restaurantId);
                
                if (restaurant == null) {
                    // Restaurant not found
                    response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=not_found");
                    return;
                }
                
            } catch (NumberFormatException e) {
                // Invalid restaurant ID
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?error=invalid_id");
                return;
            }
        }
        
        // Set restaurant properties
        restaurant.setName(name);
        restaurant.setDescription(description);
        restaurant.setAddress(address);
        restaurant.setPhone(phone);
        restaurant.setEmail(email);
        restaurant.setRating(Double.parseDouble(ratingStr));
        restaurant.setActive(isActiveStr != null && isActiveStr.equals("true"));
        
        // Handle image upload
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String imageUrl = FileUploadUtil.uploadRestaurantImage(request, "image");
            if (imageUrl != null) {
                restaurant.setImageUrl(imageUrl);
            }
        }
        
        boolean success;
        
        if (restaurant.getId() == 0) {
            // Create new restaurant
            success = restaurantService.createRestaurant(restaurant);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?success=create");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants/form?error=create");
            }
        } else {
            // Update existing restaurant
            success = restaurantService.updateRestaurant(restaurant);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants?success=update");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/restaurants/form?id=" + restaurant.getId() + "&error=update");
            }
        }
    }
    
    /**
     * Validate the restaurant form inputs
     * @param name the restaurant name
     * @param description the restaurant description
     * @param address the restaurant address
     * @param phone the restaurant phone
     * @param email the restaurant email
     * @param ratingStr the restaurant rating as a string
     * @return Map of field names to error messages, empty if no errors
     */
    private Map<String, String> validateForm(String name, String description, String address, String phone, String email, String ratingStr) {
        Map<String, String> errors = new HashMap<>();
        
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Name is required");
        } else if (name.length() < 2) {
            errors.put("name", "Name must be at least 2 characters");
        } else if (name.length() > 100) {
            errors.put("name", "Name cannot exceed 100 characters");
        }
        
        // Validate description
        if (description == null || description.trim().isEmpty()) {
            errors.put("description", "Description is required");
        } else if (description.length() < 10) {
            errors.put("description", "Description must be at least 10 characters");
        } else if (description.length() > 1000) {
            errors.put("description", "Description cannot exceed 1000 characters");
        }
        
        // Validate address
        if (address == null || address.trim().isEmpty()) {
            errors.put("address", "Address is required");
        } else if (address.length() < 5) {
            errors.put("address", "Address must be at least 5 characters");
        } else if (address.length() > 200) {
            errors.put("address", "Address cannot exceed 200 characters");
        }
        
        // Validate phone
        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phone", "Phone is required");
        } else if (!phone.matches("^[0-9+\\-\\s()]{7,20}$")) {
            errors.put("phone", "Please enter a valid phone number");
        }
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required");
        } else if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errors.put("email", "Please enter a valid email address");
        }
        
        // Validate rating
        if (ratingStr == null || ratingStr.trim().isEmpty()) {
            errors.put("rating", "Rating is required");
        } else {
            try {
                double rating = Double.parseDouble(ratingStr);
                if (rating < 0 || rating > 5) {
                    errors.put("rating", "Rating must be between 0 and 5");
                }
            } catch (NumberFormatException e) {
                errors.put("rating", "Rating must be a number");
            }
        }
        
        return errors;
    }
}
