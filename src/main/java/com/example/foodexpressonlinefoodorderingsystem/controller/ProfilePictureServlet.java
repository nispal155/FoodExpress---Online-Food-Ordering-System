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
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 * Servlet for handling profile picture uploads
 */
@WebServlet("/profile-picture-upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 15    // 15 MB
)
public class ProfilePictureServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the current user from the session
        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the uploaded file
        Part filePart = request.getPart("profilePicture");
        if (filePart == null || filePart.getSize() <= 0) {
            request.setAttribute("error", "No file was uploaded");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Check if the file is an image
        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            request.setAttribute("error", "Invalid file");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        if (!".jpg".equals(fileExtension) && !".jpeg".equals(fileExtension) &&
            !".png".equals(fileExtension) && !".gif".equals(fileExtension)) {

            request.setAttribute("error", "Only JPG, JPEG, PNG, and GIF files are allowed");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Create upload directory if it doesn't exist
        String uploadPath = "/uploads/profile";
        boolean directoryReady = UploadDirectoryChecker.checkAndCreateDirectory(getServletContext(), uploadPath);

        if (!directoryReady) {
            request.setAttribute("error", "Could not create upload directory");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Generate a unique filename
        String uniqueFileName = user.getId() + "_" + System.currentTimeMillis() + fileExtension;
        String uploadDir = getServletContext().getRealPath(uploadPath);

        // Save the file
        Path filePath = Paths.get(uploadDir, uniqueFileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            request.setAttribute("error", "Failed to save the file: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Update the user's profile picture in the database
        String profilePicturePath = uploadPath + "/" + uniqueFileName;
        user.setProfilePicture(profilePicturePath);

        boolean updated = userService.updateUser(user);
        if (!updated) {
            request.setAttribute("error", "Failed to update profile picture in the database");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Update the user in the session
        SessionUtil.updateUser(request, user);

        // Redirect to the profile page with a success message
        response.sendRedirect(request.getContextPath() + "/profile?success=true");
    }
}
