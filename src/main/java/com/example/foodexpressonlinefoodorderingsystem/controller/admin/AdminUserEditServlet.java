package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import java.io.IOException;

/**
 * Servlet for editing a user (admin view)
 */
@WebServlet(name = "AdminUserEditServlet", urlPatterns = {"/admin/users/edit"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5,      // 5 MB
        maxRequestSize = 1024 * 1024 * 10)   // 10 MB
public class AdminUserEditServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Get user ID from request
        String userId = request.getParameter("id");
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=missing-id");
            return;
        }

        try {
            int id = Integer.parseInt(userId);
            User user = userService.getUserById(id);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=not-found");
                return;
            }

            // Set attributes for the JSP
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "Edit User");

            // Make sure these attributes are set for proper form handling
            request.setAttribute("username", user.getUsername());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("fullName", user.getFullName());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("address", user.getAddress());
            request.setAttribute("role", user.getRole());

            // Forward to the JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
        }
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

        User currentUser = (User) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            // Get form parameters
            String userId = request.getParameter("id");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");

            // Get profile picture part
            Part profilePicturePart = null;
            try {
                profilePicturePart = request.getPart("profilePicture");
            } catch (Exception e) {
                // No file uploaded or not a multipart request
                System.err.println("No profile picture uploaded: " + e.getMessage());
            }

            // Validate input
            if (userId == null || userId.isEmpty() ||
                username == null || username.isEmpty() ||
                email == null || email.isEmpty() ||
                fullName == null || fullName.isEmpty() ||
                role == null || role.isEmpty()) {

                request.setAttribute("error", "All required fields must be filled out");

                try {
                    int id = Integer.parseInt(userId);
                    User user = userService.getUserById(id);
                    request.setAttribute("user", user);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
                    return;
                }

                request.setAttribute("pageTitle", "Edit User");
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                return;
            }

            try {
                int id = Integer.parseInt(userId);
                User user = userService.getUserById(id);

                if (user == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=not-found");
                    return;
                }

                // Check if username is changed and already exists
                if (!user.getUsername().equals(username)) {
                    User existingUser = userService.getUserByUsername(username);
                    if (existingUser != null) {
                        request.setAttribute("error", "Username already exists");
                        request.setAttribute("user", user);
                        request.setAttribute("pageTitle", "Edit User");
                        request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                        return;
                    }
                }

                // Check if email is changed and already exists
                if (!user.getEmail().equals(email)) {
                    User existingUser = userService.getUserByEmail(email);
                    if (existingUser != null) {
                        request.setAttribute("error", "Email already exists");
                        request.setAttribute("user", user);
                        request.setAttribute("pageTitle", "Edit User");
                        request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                        return;
                    }
                }

                // Process profile picture if uploaded
                String profilePictureName = user.getProfilePicture(); // Keep existing profile picture by default
                if (profilePicturePart != null && profilePicturePart.getSize() > 0) {
                    try {
                        // Create uploads directory if it doesn't exist
                        String uploadPath = getServletContext().getRealPath("/uploads/profile");
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        // Generate unique filename
                        String fileName = username + "_" + UUID.randomUUID().toString() + getFileExtension(profilePicturePart);
                        profilePictureName = fileName;

                        // Save the file
                        try (InputStream input = profilePicturePart.getInputStream()) {
                            Path filePath = Paths.get(uploadPath, fileName);
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                        }
                    } catch (Exception e) {
                        System.err.println("Error saving profile picture: " + e.getMessage());
                    }
                }

                // Update the user
                user.setUsername(username);
                if (password != null && !password.isEmpty()) {
                    user.setPassword(password);
                }
                user.setEmail(email);
                user.setFullName(fullName);
                user.setPhone(phone);
                user.setAddress(address);
                user.setRole(role);

                // Update profile picture if uploaded
                if (profilePictureName != null && !profilePictureName.isEmpty()) {
                    user.setProfilePicture(profilePictureName);
                }

                // Update active status
                boolean isActive = request.getParameter("isActive") != null;
                user.setActive(isActive);

                boolean success = userService.updateUser(user);

                if (success) {
                    // Redirect to user list with success message
                    response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
                } else {
                    // Show error message
                    request.setAttribute("error", "Failed to update user");
                    request.setAttribute("user", user);
                    request.setAttribute("pageTitle", "Edit User");
                    request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid-id");
            }
        } catch (Exception e) {
            System.err.println("Error updating user: " + e.getMessage());
            request.setAttribute("error", "An error occurred while updating the user: " + e.getMessage());
            request.setAttribute("pageTitle", "Edit User");
            request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
        }
    }

    /**
     * Get file extension from Part
     * @param part the Part object
     * @return the file extension including the dot (e.g., ".jpg")
     */
    private String getFileExtension(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                int dotIndex = fileName.lastIndexOf(".");
                if (dotIndex > 0) {
                    return fileName.substring(dotIndex);
                }
            }
        }
        return ""; // Default extension if none found
    }
}
