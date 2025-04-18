package com.example.foodexpressonlinefoodorderingsystem.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

/**
 * Utility class for sending emails
 */
public class EmailUtil {

    // Email configuration - replace with your actual email credentials
    private static final String EMAIL_USERNAME = "your-email@gmail.com";
    private static final String EMAIL_PASSWORD = "your-app-password"; // Use app password for Gmail
    private static final String EMAIL_HOST = "smtp.gmail.com";
    private static final int EMAIL_PORT = 587;
    private static final String EMAIL_FROM = "Food Express <your-email@gmail.com>";

    /**
     * Send an email
     * @param to recipient email address
     * @param subject email subject
     * @param body email body (HTML)
     * @return true if email was sent successfully, false otherwise
     */
    public static boolean sendEmail(String to, String subject, String body) {
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
}
