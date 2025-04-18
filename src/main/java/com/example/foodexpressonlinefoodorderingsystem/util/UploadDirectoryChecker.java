package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.servlet.ServletContext;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.HashSet;
import java.util.Set;

/**
 * Utility class to check and create upload directories
 */
public class UploadDirectoryChecker {
    
    /**
     * Check if the upload directory exists and create it if it doesn't
     * @param context the servlet context
     * @param relativePath the relative path of the directory
     * @return true if the directory exists or was created successfully, false otherwise
     */
    public static boolean checkAndCreateDirectory(ServletContext context, String relativePath) {
        String absolutePath = context.getRealPath(relativePath);
        System.out.println("Checking directory: " + absolutePath);
        
        File directory = new File(absolutePath);
        
        if (directory.exists()) {
            System.out.println("Directory exists: " + absolutePath);
            
            // Check if directory is writable
            if (directory.canWrite()) {
                System.out.println("Directory is writable: " + absolutePath);
                return true;
            } else {
                System.out.println("Directory is not writable: " + absolutePath);
                
                // Try to make the directory writable
                boolean success = directory.setWritable(true, false);
                System.out.println("Set writable result: " + success);
                
                return directory.canWrite();
            }
        } else {
            System.out.println("Directory does not exist, creating: " + absolutePath);
            
            // Create the directory with all parent directories
            boolean created = directory.mkdirs();
            System.out.println("Directory created: " + created);
            
            if (created) {
                // Set directory permissions
                try {
                    directory.setWritable(true, false);
                    directory.setReadable(true, false);
                    directory.setExecutable(true, false);
                    
                    // Try to set POSIX permissions if supported
                    try {
                        Path path = Paths.get(absolutePath);
                        Set<PosixFilePermission> permissions = new HashSet<>();
                        permissions.add(PosixFilePermission.OWNER_READ);
                        permissions.add(PosixFilePermission.OWNER_WRITE);
                        permissions.add(PosixFilePermission.OWNER_EXECUTE);
                        permissions.add(PosixFilePermission.GROUP_READ);
                        permissions.add(PosixFilePermission.GROUP_WRITE);
                        permissions.add(PosixFilePermission.GROUP_EXECUTE);
                        permissions.add(PosixFilePermission.OTHERS_READ);
                        permissions.add(PosixFilePermission.OTHERS_WRITE);
                        permissions.add(PosixFilePermission.OTHERS_EXECUTE);
                        
                        Files.setPosixFilePermissions(path, permissions);
                        System.out.println("POSIX permissions set successfully");
                    } catch (UnsupportedOperationException e) {
                        System.out.println("POSIX file permissions not supported on this platform");
                    }
                    
                    return directory.canWrite();
                } catch (Exception e) {
                    System.err.println("Error setting directory permissions: " + e.getMessage());
                    return false;
                }
            } else {
                return false;
            }
        }
    }
    
    /**
     * Main method for testing
     * @param args command line arguments
     */
    public static void main(String[] args) {
        System.out.println("This utility is meant to be used from a servlet context.");
        System.out.println("Please run the application and access the profile page to test upload functionality.");
    }
}
