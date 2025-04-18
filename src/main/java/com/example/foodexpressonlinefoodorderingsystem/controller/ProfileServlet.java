package com.example.foodexpressonlinefoodorderingsystem.controller;

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
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

/**
 * Servlet for handling user profile
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    public void init() throws ServletException {
        super.init();
        // Check if profile_picture column exists and add it if it doesn't
        checkAndAddProfilePictureColumn();
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

        // Get the current user
        User user = (User) session.getAttribute("user");

        // Set attributes for the JSP
        request.setAttribute("user", user);

        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
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

        // Get the current user
        User user = (User) session.getAttribute("user");

        // Get form parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {

            request.setAttribute("error", "Full name and email are required");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Check if email is already in use by another user
        User existingUser = userService.getUserByEmail(email);
        if (existingUser != null && existingUser.getId() != user.getId()) {
            request.setAttribute("error", "Email is already in use by another user");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Update user information
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);

        // Handle password change if requested
        if (currentPassword != null && !currentPassword.isEmpty() &&
            newPassword != null && !newPassword.isEmpty() &&
            confirmPassword != null && !confirmPassword.isEmpty()) {

            // Verify current password
            if (!userService.verifyPassword(user.getId(), currentPassword)) {
                request.setAttribute("error", "Current password is incorrect");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                return;
            }

            // Verify new password matches confirmation
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New password and confirmation do not match");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                return;
            }

            // Set new password
            user.setPassword(newPassword);
        }

        // Handle profile picture upload
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            // Get the file name
            String fileName = getSubmittedFileName(filePart);

            // Check if the file is an image
            if (!isImageFile(fileName)) {
                request.setAttribute("error", "Only image files (jpg, jpeg, png, gif) are allowed");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                return;
            }

            // Generate a unique file name to prevent overwriting
            String uniqueFileName = System.currentTimeMillis() + "_" + user.getId() + "_" + fileName;

            // Create the upload directory if it doesn't exist
            String uploadDir = getServletContext().getRealPath("/uploads/profile");
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            // Save the file
            Path filePath = Paths.get(uploadDir, uniqueFileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            // Update user's profile picture path
            user.setProfilePicture("uploads/profile/" + uniqueFileName);
        }

        // Save the updated user
        boolean success = userService.updateUser(user);

        if (success) {
            // Update the session with the updated user
            session.setAttribute("user", user);

            // Redirect with success message
            response.sendRedirect(request.getContextPath() + "/profile?success=updated");
        } else {
            // Show error message
            request.setAttribute("error", "Failed to update profile");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        }
    }

    /**
     * Get the submitted file name from a Part
     * @param part the Part
     * @return the file name
     */
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }

    /**
     * Check if a file is an image based on its extension
     * @param fileName the file name
     * @return true if the file is an image, false otherwise
     */
    private boolean isImageFile(String fileName) {
        String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        return extension.equals("jpg") || extension.equals("jpeg") ||
               extension.equals("png") || extension.equals("gif");
    }

    /**
     * Check if profile_picture column exists in users table and add it if it doesn't
     */
    private void checkAndAddProfilePictureColumn() {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn == null) {
                System.err.println("ERROR: Could not connect to database!");
                return;
            }

            // Check if profile_picture column exists
            boolean columnExists = false;
            DatabaseMetaData metaData = conn.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, "users", "profile_picture")) {
                columnExists = columns.next();
            }

            if (columnExists) {
                System.out.println("profile_picture column already exists in users table.");
                return;
            }

            // Add profile_picture column
            System.out.println("Adding profile_picture column to users table...");
            try (Statement stmt = conn.createStatement()) {
                String sql = "ALTER TABLE users ADD COLUMN profile_picture VARCHAR(255) DEFAULT NULL";
                stmt.executeUpdate(sql);
                System.out.println("profile_picture column added successfully!");
            }

        } catch (SQLException e) {
            System.err.println("Error checking/adding profile_picture column: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
