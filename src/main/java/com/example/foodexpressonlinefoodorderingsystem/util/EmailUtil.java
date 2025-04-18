package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Utility class for sending emails
 */
public class EmailUtil {

    // Default email configuration
    private static String EMAIL_USERNAME = "your-email@gmail.com";
    private static String EMAIL_PASSWORD = "your-app-password"; // Use app password for Gmail
    private static String EMAIL_HOST = "smtp.gmail.com";
    private static int EMAIL_PORT = 587;
    private static String EMAIL_FROM = "Food Express <your-email@gmail.com>";

    // Flag to indicate if email sending is enabled
    private static boolean EMAIL_ENABLED = false;

    // Cache for verification codes (email -> code)
    private static final ConcurrentHashMap<String, String> verificationCodeCache = new ConcurrentHashMap<>();

    // Configuration file path
    private static final String CONFIG_FILE_PATH = "email_config.properties";

    // Static initializer to load configuration
    static {
        loadConfiguration();
    }

    /**
     * Load email configuration from properties file
     */
    private static void loadConfiguration() {
        Properties props = new Properties();
        try (FileInputStream fis = new FileInputStream(CONFIG_FILE_PATH)) {
            props.load(fis);
            EMAIL_USERNAME = props.getProperty("email.username", EMAIL_USERNAME);
            EMAIL_PASSWORD = props.getProperty("email.password", EMAIL_PASSWORD);
            EMAIL_HOST = props.getProperty("email.host", EMAIL_HOST);
            EMAIL_PORT = Integer.parseInt(props.getProperty("email.port", String.valueOf(EMAIL_PORT)));
            EMAIL_FROM = props.getProperty("email.from", EMAIL_FROM);
            EMAIL_ENABLED = Boolean.parseBoolean(props.getProperty("email.enabled", "false"));

            System.out.println("Email configuration loaded successfully.");
        } catch (IOException e) {
            System.out.println("Email configuration file not found. Using default settings.");
            // File doesn't exist yet, that's okay
        } catch (Exception e) {
            System.err.println("Error loading email configuration: " + e.getMessage());
        }
    }

    /**
     * Save email configuration to properties file
     */
    public static boolean saveConfiguration(String username, String password, String host,
                                          int port, String from, boolean enabled) {
        Properties props = new Properties();
        props.setProperty("email.username", username);
        props.setProperty("email.password", password);
        props.setProperty("email.host", host);
        props.setProperty("email.port", String.valueOf(port));
        props.setProperty("email.from", from);
        props.setProperty("email.enabled", String.valueOf(enabled));

        try (FileOutputStream fos = new FileOutputStream(CONFIG_FILE_PATH)) {
            props.store(fos, "Food Express Email Configuration");

            // Update current settings
            EMAIL_USERNAME = username;
            EMAIL_PASSWORD = password;
            EMAIL_HOST = host;
            EMAIL_PORT = port;
            EMAIL_FROM = from;
            EMAIL_ENABLED = enabled;

            System.out.println("Email configuration saved successfully.");
            return true;
        } catch (IOException e) {
            System.err.println("Error saving email configuration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Test email configuration
     * @return true if connection successful, false otherwise
     */
    public static boolean testConnection() {
        try {
            // Set up mail server properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", EMAIL_HOST);
            properties.put("mail.smtp.port", EMAIL_PORT);
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");

            // Create session with authenticator
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });

            // Test connection
            Transport transport = session.getTransport("smtp");
            transport.connect(EMAIL_HOST, EMAIL_PORT, EMAIL_USERNAME, EMAIL_PASSWORD);
            transport.close();

            // If we get here, connection was successful
            EMAIL_ENABLED = true;

            // Save the updated configuration
            saveConfiguration(EMAIL_USERNAME, EMAIL_PASSWORD, EMAIL_HOST, EMAIL_PORT, EMAIL_FROM, true);

            System.out.println("Email connection test successful.");
            return true;
        } catch (MessagingException e) {
            System.err.println("Email connection test failed: " + e.getMessage());
            e.printStackTrace();
            EMAIL_ENABLED = false;
            return false;
        }
    }

    /**
     * Send an email
     * @param to recipient email address
     * @param subject email subject
     * @param body email body (HTML)
     * @return true if email was sent successfully, false otherwise
     */
    public static boolean sendEmail(String to, String subject, String body) {
        // Check if email is enabled
        if (!EMAIL_ENABLED) {
            System.out.println("Email sending is disabled. Skipping email to: " + to);
            return false;
        }

        try {
            // Set up mail server properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", EMAIL_HOST);
            properties.put("mail.smtp.port", EMAIL_PORT);
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");

            // Create session with authenticator
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });

            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");

            // Send message
            Transport.send(message);

            System.out.println("Email sent successfully to: " + to);
            return true;
        } catch (MessagingException e) {
            System.err.println("Failed to send email to " + to + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Send a verification code email
     * @param to recipient email address
     * @param verificationCode the verification code
     * @return true if email was sent successfully, false otherwise
     */
    public static boolean sendVerificationCode(String to, String verificationCode) {
        // Store the verification code in the cache
        verificationCodeCache.put(to, verificationCode);

        // If email is disabled, just store the code and return
        if (!EMAIL_ENABLED) {
            System.out.println("Email sending is disabled. Verification code for " + to + ": " + verificationCode);
            return false;
        }

        String subject = "Food Express - Your Verification Code";

        String body = """
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background-color: #FF5722; color: white; padding: 10px; text-align: center; }
                    .content { padding: 20px; border: 1px solid #ddd; }
                    .code { font-size: 24px; font-weight: bold; text-align: center;
                           padding: 10px; margin: 20px 0; background-color: #f5f5f5; }
                    .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #777; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Food Express</h1>
                    </div>
                    <div class="content">
                        <p>Hello,</p>
                        <p>You have requested to reset your password. Please use the following verification code to complete the process:</p>
                        <div class="code">%s</div>
                        <p>This code will expire in 15 minutes.</p>
                        <p>If you did not request this, please ignore this email or contact support if you have concerns.</p>
                        <p>Thank you,<br>The Food Express Team</p>
                    </div>
                    <div class="footer">
                        <p>This is an automated message, please do not reply to this email.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(verificationCode);

        return sendEmail(to, subject, body);
    }

    /**
     * Get the verification code for an email address
     * @param email the email address
     * @return the verification code, or null if not found
     */
    public static String getVerificationCode(String email) {
        return verificationCodeCache.get(email);
    }

    /**
     * Remove the verification code for an email address
     * @param email the email address
     */
    public static void removeVerificationCode(String email) {
        verificationCodeCache.remove(email);
    }

    /**
     * Check if email sending is enabled
     * @return true if email sending is enabled, false otherwise
     */
    public static boolean isEmailEnabled() {
        return EMAIL_ENABLED;
    }

    /**
     * Get the current email configuration
     * @return a Properties object containing the current email configuration
     */
    public static Properties getCurrentConfiguration() {
        Properties props = new Properties();
        props.setProperty("email.username", EMAIL_USERNAME);
        props.setProperty("email.password", "********"); // Don't return the actual password
        props.setProperty("email.host", EMAIL_HOST);
        props.setProperty("email.port", String.valueOf(EMAIL_PORT));
        props.setProperty("email.from", EMAIL_FROM);
        props.setProperty("email.enabled", String.valueOf(EMAIL_ENABLED));
        return props;
    }
}
