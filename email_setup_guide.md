# Email Setup and Troubleshooting Guide for Food Express

This guide explains how to set up and troubleshoot email functionality in the Food Express application.

## Email Configuration

The email functionality is configured through the `mail.properties` file located in `src/main/resources/`.

### Key Configuration Properties

```properties
# Development mode settings
# Set to false to actually send emails instead of just logging them
mail.dev.mode=false

# SMTP server settings
mail.smtp.host=smtp.gmail.com
mail.smtp.port=587
mail.smtp.auth=true
mail.smtp.starttls.enable=true

# Email credentials
mail.username=your-email@gmail.com
mail.password=your-app-password

# Sender information
mail.from.email=your-email@gmail.com
mail.from.name=Food Express
```

### Setting Up Gmail for Sending Emails

1. **Create or use an existing Gmail account**
   - It's recommended to create a dedicated Gmail account for your application

2. **Enable 2-Factor Authentication (2FA)**
   - Go to your Google Account settings (https://myaccount.google.com/)
   - Select "Security" from the left menu
   - Under "Signing in to Google," select "2-Step Verification" and turn it on

3. **Generate an App Password**
   - After enabling 2FA, go back to the Security page
   - Select "App passwords" (under "Signing in to Google")
   - Select "Mail" as the app and "Other" as the device
   - Enter "Food Express" as the name
   - Click "Generate"
   - Google will display a 16-character password - copy this password

4. **Update mail.properties**
   - Set `mail.username` to your Gmail address
   - Set `mail.password` to the App Password you generated
   - Set `mail.from.email` to your Gmail address

## Testing Email Functionality

1. **Use the Test Email Servlet**
   - Access http://localhost:8080/FoodExpressOnlineFoodOrderingSystem/test-email
   - Enter your email address
   - Click "Send Test Email"
   - Check your inbox for the test email

2. **Test the Forgot Password Feature**
   - Go to the login page
   - Click "Forgot Password"
   - Enter your email address
   - You should receive an email with a verification code

## Troubleshooting Common Issues

### 1. Emails Not Being Sent

**Check mail.properties configuration:**
- Ensure `mail.dev.mode` is set to `false`
- Verify that all SMTP settings are correct
- Make sure your username and password are correct

**Check server logs for errors:**
- Look for "Error sending email" messages
- Check for authentication failures
- Look for connection timeouts

### 2. Gmail Authentication Issues

**App Password problems:**
- Make sure you're using an App Password if 2FA is enabled
- Generate a new App Password and update mail.properties
- Ensure there are no extra spaces in the App Password

**Security alerts:**
- Check if you received a "Critical security alert" email from Google
- Allow the access from the security alert email
- Visit https://accounts.google.com/DisplayUnlockCaptcha and click "Continue"

### 3. Less Secure Apps Setting

If you're not using 2FA and App Passwords:
- Go to https://myaccount.google.com/lesssecureapps
- Turn on "Allow less secure apps"
- Note: This is less secure and not recommended for production

### 4. Network/Firewall Issues

- Check if port 587 is open for outgoing connections
- Try using port 465 instead (requires SSL)
- Test from a different network

### 5. SSL/TLS Issues

If you're having SSL/TLS problems:
- Try adding these properties to mail.properties:
  ```
  mail.smtp.ssl.trust=smtp.gmail.com
  mail.smtp.ssl.protocols=TLSv1.2
  ```

## Email Implementation Details

The email functionality is implemented in the following classes:

1. **EmailService.java**
   - Handles sending emails via SMTP
   - Provides methods for sending plain text and HTML emails
   - Includes a method for sending verification codes

2. **PropertyLoader.java**
   - Utility class for loading properties files
   - Used by EmailService to load mail.properties

3. **ForgotPasswordServlet.java**
   - Uses EmailService to send verification codes for password reset

4. **TestEmailServlet.java**
   - Provides a simple interface for testing email functionality

## Advanced Configuration

### Using a Different Email Provider

To use a different email provider:
1. Update the SMTP settings in mail.properties
2. Update the username and password
3. Update the from email address

### Using an Email API Service

To use an email API service like SendGrid or Mailgun:
1. Set `mail.send.method=api` in mail.properties
2. Update the API settings:
   ```
   mail.api.url=https://api.example.com/v1/send
   mail.api.key=your-api-key
   ```
3. Implement the API-specific code in EmailService.java
