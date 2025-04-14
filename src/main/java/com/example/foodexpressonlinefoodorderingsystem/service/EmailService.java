package com.example.foodexpressonlinefoodorderingsystem.service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
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
        // For development/testing, just log the email and return true
        // In production, uncomment the actual email sending code
        System.out.println("Sending email to: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Body: " + body);
        return true;
        
        /*
        // Uncomment this code for actual email sending in production
        try {
            // Get email credentials
            final String username = properties.getProperty("mail.username");
            final String password = properties.getProperty("mail.password");
            
            // Create session
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            
            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);
            
            // Send message
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            System.err.println("Error sending email: " + e.getMessage());
            return false;
        }
        */
    }
}
