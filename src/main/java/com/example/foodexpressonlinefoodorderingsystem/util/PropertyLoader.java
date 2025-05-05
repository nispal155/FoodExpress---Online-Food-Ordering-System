package com.example.foodexpressonlinefoodorderingsystem.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Utility class for loading properties files
 */
public class PropertyLoader {
    
    /**
     * Load properties from a file in the classpath
     * 
     * @param filename the name of the properties file
     * @return the loaded properties
     * @throws IOException if the file cannot be read
     */
    public static Properties loadProperties(String filename) throws IOException {
        Properties properties = new Properties();
        
        try (InputStream inputStream = PropertyLoader.class.getClassLoader().getResourceAsStream(filename)) {
            if (inputStream != null) {
                properties.load(inputStream);
                System.out.println("Successfully loaded " + filename);
            } else {
                throw new IOException("Unable to find " + filename);
            }
        }
        
        return properties;
    }
}
