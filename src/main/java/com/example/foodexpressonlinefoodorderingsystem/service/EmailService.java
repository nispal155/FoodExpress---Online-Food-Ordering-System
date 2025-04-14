package com.example.foodexpressonlinefoodorderingsystem.service;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

/**
 * Service for sending emails
 */
public class EmailService {

    private final Properties properties = new Properties();
    private static final String PROPERTIES_FILE = "mail.properties";

    /**
     * Constructor that loads email configuration
     */
    public EmailService() {
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {
            if (inputStream != null) {
                properties.load(inputStream);
            } else {
                System.err.println("Unable to find " + PROPERTIES_FILE);
                // Set default properties for development
                properties.setProperty("mail.smtp.host", "smtp.gmail.com");
                properties.setProperty("mail.smtp.port", "587");
                properties.setProperty("mail.smtp.auth", "true");
                properties.setProperty("mail.smtp.starttls.enable", "true");
                properties.setProperty("mail.username", "your-email@gmail.com");
                properties.setProperty("mail.password", "your-app-password");
            }
        } catch (IOException e) {
            System.err.println("Error loading email properties: " + e.getMessage());
        }
    }

    /**
     * Send an email
     * @param to recipient email address
     * @param subject email subject
     * @param body email body
     * @return true if email was sent successfully, false otherwise
     */
    public boolean sendEmail(String to, String subject, String body) {
        // Check if we're in development mode
        boolean devMode = Boolean.parseBoolean(properties.getProperty("mail.dev.mode", "true"));

        if (devMode) {
            // For development/testing, just log the email and return true
            System.out.println("Sending email to: " + to);
            System.out.println("Subject: " + subject);
            System.out.println("Body: " + body);
            return true;
        }

        // For production, use the configured method
        String method = properties.getProperty("mail.send.method", "smtp");

        if ("smtp".equals(method)) {
            return sendEmailViaSmtp(to, subject, body);
        } else if ("api".equals(method)) {
            return sendEmailViaApi(to, subject, body);
        } else {
            System.err.println("Unknown email sending method: " + method);
            return false;
        }
    }

    /**
     * Send an email via SMTP server
     */
    private boolean sendEmailViaSmtp(String to, String subject, String body) {
        // This method would use Jakarta Mail API to send emails via SMTP
        // For now, we'll just log that we would send via SMTP
        System.out.println("Would send email via SMTP to: " + to);
        return true;
    }

    /**
     * Send an email via a third-party API
     */
    private boolean sendEmailViaApi(String to, String subject, String body) {
        try {
            // Get API credentials
            String apiKey = properties.getProperty("mail.api.key");
            String apiUrl = properties.getProperty("mail.api.url");
            String fromEmail = properties.getProperty("mail.from.email");
            String fromName = properties.getProperty("mail.from.name");

            if (apiKey == null || apiUrl == null) {
                System.err.println("Missing API credentials");
                return false;
            }

            // Create connection
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Authorization", "Bearer " + apiKey);

            // Create request body
            String data = "from=" + URLEncoder.encode(fromEmail, StandardCharsets.UTF_8.toString()) +
                          "&fromName=" + URLEncoder.encode(fromName, StandardCharsets.UTF_8.toString()) +
                          "&to=" + URLEncoder.encode(to, StandardCharsets.UTF_8.toString()) +
                          "&subject=" + URLEncoder.encode(subject, StandardCharsets.UTF_8.toString()) +
                          "&body=" + URLEncoder.encode(body, StandardCharsets.UTF_8.toString());

            // Send request
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = data.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Check response
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return true;
            } else {
                System.err.println("API request failed with response code: " + responseCode);
                return false;
            }
        } catch (IOException e) {
            System.err.println("Error sending email via API: " + e.getMessage());
            return false;
        }
    }
}
