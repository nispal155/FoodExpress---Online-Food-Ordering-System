package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
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
 * Utility class for handling file uploads
 */
public class FileUploadUtil {
    
    // Base directory for file uploads
    private static final String UPLOAD_DIR = "uploads";
    
    // Subdirectories for different types of uploads
    private static final String MENU_ITEMS_DIR = "menu-items";
    private static final String RESTAURANTS_DIR = "restaurants";
    
    /**
     * Upload a menu item image
     * @param request the HTTP request
     * @param fieldName the form field name
     * @return the relative path to the uploaded file, or null if no file was uploaded
     * @throws IOException if an I/O error occurs
     * @throws ServletException if a servlet error occurs
     */
    public static String uploadMenuItemImage(HttpServletRequest request, String fieldName) 
            throws IOException, ServletException {
        return uploadFile(request, fieldName, MENU_ITEMS_DIR);
    }
    
    /**
     * Upload a restaurant image
     * @param request the HTTP request
     * @param fieldName the form field name
     * @return the relative path to the uploaded file, or null if no file was uploaded
     * @throws IOException if an I/O error occurs
     * @throws ServletException if a servlet error occurs
     */
    public static String uploadRestaurantImage(HttpServletRequest request, String fieldName) 
            throws IOException, ServletException {
        return uploadFile(request, fieldName, RESTAURANTS_DIR);
    }
    
    /**
     * Upload a file
     * @param request the HTTP request
     * @param fieldName the form field name
     * @param subDir the subdirectory to store the file in
     * @return the relative path to the uploaded file, or null if no file was uploaded
     * @throws IOException if an I/O error occurs
     * @throws ServletException if a servlet error occurs
     */
    private static String uploadFile(HttpServletRequest request, String fieldName, String subDir) 
            throws IOException, ServletException {
        Part filePart = request.getPart(fieldName);
        
        // Check if a file was uploaded
        if (filePart == null || filePart.getSize() <= 0 || filePart.getSubmittedFileName() == null || 
                filePart.getSubmittedFileName().isEmpty()) {
            return null;
        }
        
        // Get the file name and extension
        String fileName = filePart.getSubmittedFileName();
        String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
        
        // Generate a unique file name
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        
        // Create the upload directory if it doesn't exist
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + 
                            UPLOAD_DIR + File.separator + subDir;
        Path uploadDir = Paths.get(uploadPath);
        
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        
        // Save the file
        Path filePath = uploadDir.resolve(uniqueFileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        
        // Return the relative path to the file
        return UPLOAD_DIR + "/" + subDir + "/" + uniqueFileName;
    }
    
    /**
     * Delete a file
     * @param request the HTTP request
     * @param filePath the relative path to the file
     * @return true if the file was deleted, false otherwise
     */
    public static boolean deleteFile(HttpServletRequest request, String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }
        
        try {
            String fullPath = request.getServletContext().getRealPath("") + File.separator + filePath;
            Path path = Paths.get(fullPath);
            return Files.deleteIfExists(path);
        } catch (IOException e) {
            System.err.println("Error deleting file: " + e.getMessage());
            return false;
        }
    }
}
