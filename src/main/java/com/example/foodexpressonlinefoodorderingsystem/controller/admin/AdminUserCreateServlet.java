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
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

/**
 * Servlet for creating a new user (admin view)
 */
@WebServlet(name = "AdminUserCreateServlet", urlPatterns = {"/admin/users/create"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5,      // 5 MB
        maxRequestSize = 1024 * 1024 * 10)   // 10 MB
public class AdminUserCreateServlet extends HttpServlet {

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

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Set attributes for the JSP
        request.setAttribute("pageTitle", "Create User");

        // Explicitly set user to null to ensure the form shows "Create New User"
        request.setAttribute("user", null);

        // Set default values for the form
        request.setAttribute("username", "");
        request.setAttribute("email", "");
        request.setAttribute("fullName", "");
        request.setAttribute("phone", "");
        request.setAttribute("address", "");
        request.setAttribute("role", "CUSTOMER"); // Default role

        // Forward to the create user JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
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
            if (username == null || username.isEmpty() ||
                password == null || password.isEmpty() ||
                confirmPassword == null || confirmPassword.isEmpty() ||
                email == null || email.isEmpty() ||
                fullName == null || fullName.isEmpty() ||
                role == null || role.isEmpty()) {

                request.setAttribute("error", "All required fields must be filled out");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("role", role);
                request.setAttribute("pageTitle", "Create User");

                request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
                return;
            }

            // Check if passwords match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("role", role);
                request.setAttribute("pageTitle", "Create User");

                request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
                return;
            }

            // Check if username or email already exists
            User existingUser = userService.getUserByUsername(username);
            if (existingUser != null) {
                request.setAttribute("error", "Username already exists");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("role", role);
                request.setAttribute("pageTitle", "Create User");

                request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
                return;
            }

            existingUser = userService.getUserByEmail(email);
            if (existingUser != null) {
                request.setAttribute("error", "Email already exists");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("role", role);
                request.setAttribute("pageTitle", "Create User");

                request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
                return;
            }

            // Get isActive parameter - default to true if not specified
            boolean isActive = request.getParameter("isActive") != null;

            // Process profile picture if uploaded
            String profilePictureName = "";
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

            // Create the user
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setEmail(email);
            newUser.setFullName(fullName);
            newUser.setPhone(phone);
            newUser.setAddress(address);
            newUser.setRole(role);
            newUser.setActive(isActive);

            // Set profile picture if uploaded
            if (!profilePictureName.isEmpty()) {
                newUser.setProfilePicture(profilePictureName);
            }

            boolean success = userService.createUser(newUser);

            if (success) {
                // Redirect to user list with success message
                response.sendRedirect(request.getContextPath() + "/admin/users?success=created");
            } else {
                // Show error message
                request.setAttribute("error", "Failed to create user");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("role", role);
                request.setAttribute("pageTitle", "Create User");

                request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error creating user: " + e.getMessage());
            request.setAttribute("error", "An error occurred while creating the user: " + e.getMessage());
            request.setAttribute("pageTitle", "Create User");
            request.getRequestDispatcher("/WEB-INF/views/admin/user-create.jsp").forward(request, response);
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
