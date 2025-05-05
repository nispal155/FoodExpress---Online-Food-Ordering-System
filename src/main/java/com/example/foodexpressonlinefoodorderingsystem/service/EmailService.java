package com.example.foodexpressonlinefoodorderingsystem.service;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import com.example.foodexpressonlinefoodorderingsystem.util.PropertyLoader;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * Service for sending emails
 */
public class EmailService {
    private static final String PROPERTIES_FILE = "mail.properties";
    private static String SMTP_HOST;
    private static String SMTP_PORT;
    private static String SMTP_AUTH;
    private static String SMTP_STARTTLS;
    private static String EMAIL_USERNAME;
    private static String EMAIL_PASSWORD;
    private static String EMAIL_FROM;
    private static String EMAIL_REPLY_TO;
    private static boolean EMAIL_ENABLED;
    static {
        try {
            // Load email properties
            Properties properties = PropertyLoader.loadProperties(PROPERTIES_FILE);

            // Get email properties
            SMTP_HOST = properties.getProperty("mail.smtp.host");
            SMTP_PORT = properties.getProperty("mail.smtp.port");
            SMTP_AUTH = properties.getProperty("mail.smtp.auth");
            SMTP_STARTTLS = properties.getProperty("mail.smtp.starttls.enable");
            EMAIL_USERNAME = properties.getProperty("mail.username");
            EMAIL_PASSWORD = properties.getProperty("mail.password");
            EMAIL_FROM = properties.getProperty("mail.from.email");
            EMAIL_REPLY_TO = properties.getProperty("mail.from.email"); // Use from email as reply-to
            EMAIL_ENABLED = !Boolean.parseBoolean(properties.getProperty("mail.dev.mode", "true"));

        } catch (IOException e) {
            System.err.println("Error loading email properties: " + e.getMessage());
            e.printStackTrace();
        }
    }
    public static boolean sendEmail(String to, String subject, String content, boolean isHtml) {
        // If email is disabled, log the email and return success
        if (!EMAIL_ENABLED) {
            System.out.println("Email sending is disabled. Would have sent:");
            System.out.println("To: " + to);
            System.out.println("Subject: " + subject);
            System.out.println("Content: " + content);
            return true;
        }

        try {
            // Set up mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", SMTP_AUTH);
            props.put("mail.smtp.starttls.enable", SMTP_STARTTLS);

            // Create a mail session with authentication
            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            };

            Session session = Session.getInstance(props, auth);

            // Create a message
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(EMAIL_FROM));
            InternetAddress[] toAddresses = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, toAddresses);
            msg.setReplyTo(new InternetAddress[]{new InternetAddress(EMAIL_REPLY_TO)});
            msg.setSubject(subject);
            msg.setSentDate(new Date());

            // Set content type based on isHtml flag
            if (isHtml) {
                msg.setContent(content, "text/html; charset=utf-8");
            } else {
                msg.setText(content);
            }

            // Send the message
            Transport.send(msg);
            System.out.println("Email sent successfully to " + to);
            return true;

        } catch (MessagingException e) {
            System.err.println("Error sending email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    /**
     * Send a verification code email for password reset
     * @param to recipient email address
     * @param verificationCode the verification code
     * @return true if email was sent successfully, false otherwise
     */
    public static boolean sendVerificationCode(String to, String verificationCode) {
        String subject = "Food Express - Your Password Reset Verification Code";

        // Create HTML email body with the verification code
        String htmlTemplate = """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
                    .container { width: 100%%; max-width: 600px; margin: 0 auto; background-color: #ffffff; }
                    .header { background-color: #FF5722; color: white; padding: 20px; text-align: center; }
                    .content { padding: 20px; }
                    .code { font-size: 24px; font-weight: bold; text-align: center; padding: 15px; margin: 20px 0; background-color: #f0f0f0; border-radius: 5px; letter-spacing: 5px; }
                    .footer { font-size: 12px; color: #999; text-align: center; padding: 20px; border-top: 1px solid #eee; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Food Express</h1>
                    </div>
                    <div class="content">
                        <h2>Password Reset Verification</h2>
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
            """;

        // Format the template with the verification code
        String body = String.format(htmlTemplate, verificationCode);

        return sendEmail(to, subject, body, true);
    }
}
