package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import com.example.foodexpressonlinefoodorderingsystem.util.SessionUtil;
import com.example.foodexpressonlinefoodorderingsystem.util.UploadDirectoryChecker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 * Servlet for handling user registration
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,  // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {

            request.setAttribute("error", "All required fields must be filled");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if username already exists
        if (userService.getUserByUsername(username) != null) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (userService.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // Password will be hashed in the UserService
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("CUSTOMER"); // Default role for new users
        user.setActive(true);

        // Handle profile picture upload
        String profilePicturePath = null;
        try {
            Part filePart = request.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                // Check if the file is an image
                String fileName = filePart.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
                    if (".jpg".equals(fileExtension) || ".jpeg".equals(fileExtension) ||
                        ".png".equals(fileExtension) || ".gif".equals(fileExtension)) {

                        // Create upload directory if it doesn't exist
                        String uploadPath = "/uploads/profile";
                        boolean directoryReady = UploadDirectoryChecker.checkAndCreateDirectory(getServletContext(), uploadPath);

                        if (directoryReady) {
                            // Generate a unique filename
                            String uniqueFileName = System.currentTimeMillis() + "_" + fileExtension;
                            String uploadDir = getServletContext().getRealPath(uploadPath);

                            // Save the file
                            Path filePath = Paths.get(uploadDir, uniqueFileName);
                            try (InputStream input = filePart.getInputStream()) {
                                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                                profilePicturePath = uploadPath + "/" + uniqueFileName;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Log the error but continue with registration
            System.err.println("Error uploading profile picture: " + e.getMessage());
        }

        // Set profile picture path if uploaded successfully
        if (profilePicturePath != null) {
            user.setProfilePicture(profilePicturePath);
        }

        // Save user to database
        boolean success = userService.createUser(user);

        if (success) {
            // Create session
            HttpSession session = SessionUtil.createSession(request, user, false);

            // Redirect to home page after registration
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Registration failed
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}
