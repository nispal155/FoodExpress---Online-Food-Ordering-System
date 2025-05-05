package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
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
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 * Servlet for handling profile picture uploads
 */
@WebServlet(name = "ProfilePictureUploadServlet", urlPatterns = {"/upload-profile-picture"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProfilePictureUploadServlet extends HttpServlet {

    private final UserService userService = new UserService();

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

        // For debugging
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Profile Picture Upload</title></head><body>");
        out.println("<h1>Profile Picture Upload</h1>");

        try {
            // Handle profile picture upload
            Part filePart = request.getPart("profilePicture");

            if (filePart == null) {
                out.println("<p style='color: red;'>Error: No file part in the request</p>");
                out.println("<p><a href='" + request.getContextPath() + "/profile'>Back to Profile</a></p>");
                out.println("</body></html>");
                return;
            }

            out.println("<p>File part size: " + filePart.getSize() + " bytes</p>");

            if (filePart.getSize() <= 0) {
                out.println("<p style='color: red;'>Error: Empty file</p>");
                out.println("<p><a href='" + request.getContextPath() + "/profile'>Back to Profile</a></p>");
                out.println("</body></html>");
                return;
            }

            // Get the file name
            String fileName = getSubmittedFileName(filePart);
            out.println("<p>File name: " + fileName + "</p>");

            // Check if the file is an image
            if (!isImageFile(fileName)) {
                out.println("<p style='color: red;'>Error: Only image files (jpg, jpeg, png, gif) are allowed</p>");
                out.println("<p><a href='" + request.getContextPath() + "/profile'>Back to Profile</a></p>");
                out.println("</body></html>");
                return;
            }

            // Generate a unique file name to prevent overwriting
            String uniqueFileName = System.currentTimeMillis() + "_" + user.getId() + "_" + fileName;
            out.println("<p>Unique file name: " + uniqueFileName + "</p>");

            // Create the upload directory if it doesn't exist
            String uploadPath = "/uploads/profile";
            out.println("<p>Upload path: " + uploadPath + "</p>");

            boolean directoryReady = UploadDirectoryChecker.checkAndCreateDirectory(getServletContext(), uploadPath);
            out.println("<p>Directory ready: " + directoryReady + "</p>");

            if (!directoryReady) {
                out.println("<p style='color: red;'>Error: Could not create or access upload directory</p>");
                out.println("<p>Please make sure the application has write permissions to the webapps directory</p>");
                out.println("<p><a href='" + request.getContextPath() + "/profile'>Back to Profile</a></p>");
                out.println("</body></html>");
                return;
            }

            String uploadDir = getServletContext().getRealPath(uploadPath);
            out.println("<p>Upload directory: " + uploadDir + "</p>");

            // Save the file
            Path filePath = Paths.get(uploadDir, uniqueFileName);
            out.println("<p>File path: " + filePath + "</p>");

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                out.println("<p style='color: green;'>File saved successfully!</p>");
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error saving file: " + e.getMessage() + "</p>");
                e.printStackTrace(out);
                out.println("<p><a href='" + request.getContextPath() + "/profile'>Back to Profile</a></p>");
                out.println("</body></html>");
                return;
            }

            // Update user's profile picture path
            user.setProfilePicture("uploads/profile/" + uniqueFileName);

            // Save the updated user
            boolean success = userService.updateUser(user);

            if (success) {
                // Update the session with the updated user
                session.setAttribute("user", user);

                out.println("<p style='color: green;'>Profile picture updated successfully!</p>");
                out.println("<p>New profile picture path: " + user.getProfilePicture() + "</p>");
            } else {
                out.println("<p style='color: red;'>Error updating user profile</p>");
            }

        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }

        out.println("<p><a href='" + request.getContextPath() + "/profile'>Back to Profile</a></p>");
        out.println("</body></html>");
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
}
