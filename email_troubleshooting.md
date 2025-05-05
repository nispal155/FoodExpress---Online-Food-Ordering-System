# Email Troubleshooting Guide for Food Express

If you're experiencing issues with the email functionality in the Food Express application, follow this troubleshooting guide to identify and resolve the problem.

## Common Issues and Solutions

### 1. Gmail App Password Issues

**Problem**: Gmail rejects the authentication attempt.

**Solutions**:
- Make sure you're using an App Password if your Gmail account has 2-Factor Authentication enabled
- Generate a new App Password from your Google Account settings
- Verify that you've entered the App Password correctly (spaces are optional)

### 2. Gmail Security Settings

**Problem**: Gmail blocks the application from sending emails due to security settings.

**Solutions**:
- Check if you received a "Critical security alert" email from Google
- Go to your Google Account > Security > Less secure app access > Turn on (Note: This is less secure)
- Allow access from the security alert email if you received one
- Visit https://accounts.google.com/DisplayUnlockCaptcha and click "Continue"

### 3. Network/Firewall Issues

**Problem**: Your network or firewall is blocking outgoing SMTP connections.

**Solutions**:
- Check if port 587 is open for outgoing connections
- Try using port 465 instead (requires SSL)
- Test from a different network

### 4. Configuration Issues

**Problem**: The mail.properties file is not configured correctly.

**Solutions**:
- Verify that mail.properties is in the correct location (src/main/resources)
- Check that mail.dev.mode is set to false
- Ensure all required properties are set correctly
- Make sure the from email address matches your Gmail account

## Testing Email Functionality

1. Access the test page at: http://localhost:8080/FoodExpressOnlineFoodOrderingSystem/test-email
2. Enter your email address
3. Click "Send Test Email"
4. Check the server logs for detailed information

## Server Logs

Look for these messages in the server logs:

- "Successfully loaded mail.properties" - Confirms the properties file was found
- "Email Properties:" - Shows the loaded properties
- SMTP debugging information - Shows the communication with the SMTP server
- "Email sent successfully" - Confirms the email was sent

## Checking Gmail Settings

1. Go to your Google Account: https://myaccount.google.com/
2. Select "Security" from the left menu
3. Under "Signing in to Google," check if 2-Step Verification is enabled
4. If enabled, go to "App passwords" to generate a new password
5. If not enabled, check "Less secure app access" settings

## Modifying Email Configuration

If you need to change the email configuration:

1. Edit src/main/resources/mail.properties
2. Update the following properties as needed:
   ```
   mail.username=your-email@gmail.com
   mail.password=your-app-password
   mail.from.email=your-email@gmail.com
   ```
3. Restart the application

## Alternative Solutions

If Gmail continues to cause issues:

1. Try using a different email provider
2. Consider using an email API service like SendGrid or Mailgun
3. Set up a dedicated email account just for the application
