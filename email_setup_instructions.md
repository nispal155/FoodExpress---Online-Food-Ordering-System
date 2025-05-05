# Email Setup Instructions for Food Express

This document explains how to set up email functionality for the Food Express application, particularly for sending OTP (One-Time Password) verification codes during password reset.

## Prerequisites

1. A Gmail account
2. App Password (if 2FA is enabled on your Gmail account)

## Setting Up App Password (for Gmail with 2FA)

If you have 2-Factor Authentication enabled on your Gmail account, you'll need to create an App Password:

1. Go to your Google Account settings (https://myaccount.google.com/)
2. Select "Security" from the left menu
3. Under "Signing in to Google," select "2-Step Verification"
4. Scroll down and select "App passwords"
5. Select "Mail" as the app and "Other" as the device
6. Enter "Food Express" as the name
7. Click "Generate"
8. Google will display a 16-character password - copy this password

## Configuring the Application

1. Open the `mail.properties` file located at `src/main/resources/mail.properties`
2. Set `mail.dev.mode=false` to enable actual email sending
3. Update the following properties with your Gmail information:
   ```
   mail.username=your-email@gmail.com
   mail.password=your-app-password
   mail.from.email=your-email@gmail.com
   ```
   Replace `your-email@gmail.com` with your actual Gmail address and `your-app-password` with the App Password you generated.

4. Save the file

## Testing the Email Functionality

1. Start the application
2. Go to the "Forgot Password" page
3. Enter your email address
4. Click "Send Verification Code"
5. Check your email for the verification code
6. Enter the verification code on the verification page
7. Set your new password

## Troubleshooting

If you encounter issues with sending emails:

1. **Check Console Logs**: Look for error messages in the server logs
2. **Verify Credentials**: Make sure your email and password are correct
3. **Check Gmail Settings**: Ensure that "Less secure app access" is turned on if you're not using an App Password
4. **Firewall Issues**: Make sure your firewall isn't blocking outgoing SMTP connections
5. **SMTP Settings**: Verify that the SMTP settings (host, port) are correct for Gmail

## Development Mode

If you want to test the application without sending actual emails:

1. Set `mail.dev.mode=true` in the `mail.properties` file
2. The application will log the email content to the console instead of sending it
3. The verification code will be displayed on the screen for testing purposes

## Security Considerations

- Never commit your actual email password to version control
- Consider using environment variables for sensitive information in production
- Regularly rotate your App Passwords for better security
