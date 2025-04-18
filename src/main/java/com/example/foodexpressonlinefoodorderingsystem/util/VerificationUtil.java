package com.example.foodexpressonlinefoodorderingsystem.util;

import java.security.SecureRandom;
import java.time.LocalDateTime;

/**
 * Utility class for generating and validating verification codes
 */
public class VerificationUtil {
    
    private static final SecureRandom RANDOM = new SecureRandom();
    private static final String DIGITS = "0123456789";
    
    /**
     * Generate a random numeric verification code
     * @param length the length of the code
     * @return the generated code
     */
    public static String generateVerificationCode(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(DIGITS.charAt(RANDOM.nextInt(DIGITS.length())));
        }
        return sb.toString();
    }
    
    /**
     * Calculate the expiration time for a verification code
     * @param minutes minutes from now when the code will expire
     * @return the expiration time
     */
    public static LocalDateTime calculateExpirationTime(int minutes) {
        return LocalDateTime.now().plusMinutes(minutes);
    }
    
    /**
     * Check if a verification code has expired
     * @param expirationTime the expiration time
     * @return true if the code has expired, false otherwise
     */
    public static boolean isExpired(LocalDateTime expirationTime) {
        return LocalDateTime.now().isAfter(expirationTime);
    }
}
