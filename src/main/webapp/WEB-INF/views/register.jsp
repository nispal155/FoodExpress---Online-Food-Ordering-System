<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restro Foodie - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f0f2fa;
            background-image: linear-gradient(135deg, #f0f2fa 0%, #e6e9f5 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px 0;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-container {
            display: flex;
            background-color: white;
            border-radius: 16px;
            overflow: hidden;
            width: 900px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-form-container {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
            max-height: 90vh;
            scrollbar-width: thin;
            scrollbar-color: #FF5722 #f0f0f0;
        }

        .register-form-container::-webkit-scrollbar {
            width: 8px;
        }

        .register-form-container::-webkit-scrollbar-track {
            background: #f0f0f0;
            border-radius: 10px;
        }

        .register-form-container::-webkit-scrollbar-thumb {
            background-color: #FF5722;
            border-radius: 10px;
        }

        .register-image {
            flex: 1;
            background-image: url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .register-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .register-image-content {
            position: relative;
            z-index: 1;
            padding: 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .logo-icon {
            color: #FF5722;
            font-size: 24px;
            margin-right: 8px;
        }

        .logo-text {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        h1 {
            font-size: 32px;
            margin-bottom: 10px;
            color: #333;
        }

        .welcome-text {
            color: #666;
            margin-bottom: 30px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px;
            gap: 10px;
        }

        .form-column {
            flex: 1;
            min-width: 250px;
            padding: 0 15px;
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        .form-group label {
            transition: all 0.3s ease;
            margin-bottom: 10px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #333;
        }

        input[type="email"],
        input[type="password"],
        input[type="text"],
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            background-color: #f9f9f9;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
        }

        .password-field {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 14px;
            cursor: pointer;
            color: #666;
            font-size: 16px;
            z-index: 10;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: #FF5722;
        }

        input[type="email"]:hover,
        input[type="password"]:hover,
        input[type="text"]:hover,
        textarea:hover {
            border-color: #d0d0d0;
            background-color: #f7f7f7;
        }

        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #FF5722;
            background-color: #fff;
            box-shadow: 0 0 0 3px rgba(255, 87, 34, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        input[type="file"] {
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 8px;
            border: 1px dashed #ccc;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="file"]:hover {
            background-color: #f0f0f0;
            border-color: #bbb;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            padding: 12px 15px;
            background-color: #f9f9f9;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .checkbox-container:hover {
            background-color: #f5f5f5;
            border-color: #d0d0d0;
        }

        .checkbox-container input {
            margin-right: 12px;
            width: 18px;
            height: 18px;
            accent-color: #FF5722;
            cursor: pointer;
        }

        .checkbox-container label {
            margin-bottom: 0;
            font-size: 15px;
            cursor: pointer;
        }

        .terms-link {
            color: #FF5722;
            text-decoration: none;
            font-weight: 500;
        }

        .terms-link:hover {
            text-decoration: underline;
        }

        .btn-register {
            width: 100%;
            padding: 15px;
            background-color: #FF5722;
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(255, 87, 34, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-register:hover {
            background-color: #E64A19;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(255, 87, 34, 0.4);
        }

        .btn-register:active {
            transform: translateY(1px);
            box-shadow: 0 2px 5px rgba(255, 87, 34, 0.4);
        }

        .btn-register::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .btn-register:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            20% {
                transform: scale(25, 25);
                opacity: 0.3;
            }
            100% {
                opacity: 0;
                transform: scale(40, 40);
            }
        }

        .social-login {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
        }

        .google-login-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 12px 15px;
            background-color: #ffffff;
            border: 2px solid #e0e0e0;
            border-radius: 30px;
            color: #333;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .google-login-btn:hover {
            background-color: #f8f8f8;
            border-color: #d0d0d0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: translateY(-1px);
        }

        .google-icon {
            width: 20px;
            margin-right: 10px;
        }

        /* Password strength indicator */
        .password-strength-meter {
            height: 5px;
            width: 100%;
            background-color: #ddd;
            margin-top: 5px;
            border-radius: 3px;
            position: relative;
            overflow: hidden;
        }

        .password-strength-meter-fill {
            height: 100%;
            border-radius: 3px;
            transition: width 0.3s ease, background-color 0.3s ease;
            width: 0;
        }

        .strength-text {
            font-size: 12px;
            margin-top: 5px;
            color: #666;
            transition: color 0.3s ease;
        }

        .login-link {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        .login-link a {
            color: #FF5722;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .support-email {
            text-align: right;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: flex-end;
        }

        .support-email i {
            margin-right: 8px;
        }

        .image-heading {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .image-text {
            font-size: 16px;
            margin-bottom: 30px;
        }

        .get-started-btn {
            background-color: #FF5722;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .get-started-btn:hover {
            background-color: #E64A19;
        }

        /* Profile picture upload */
        .profile-upload-container {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-top: 10px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 10px;
            border: 2px dashed #e0e0e0;
            transition: all 0.3s ease;
        }

        .profile-upload-container:hover {
            background-color: #f5f5f5;
            border-color: #FF5722;
        }

        .profile-preview {
            position: relative;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            overflow: hidden;
            background-color: #f0f0f0;
            flex-shrink: 0;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 3px solid white;
            transition: all 0.3s ease;
        }

        .profile-preview:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .profile-image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: #ccc;
            background-color: #f5f5f5;
            transition: all 0.3s ease;
        }

        .profile-image-placeholder:hover {
            color: #FF5722;
            background-color: #f0f0f0;
        }

        #profileImagePreview {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .profile-upload-controls {
            flex: 1;
        }

        .profile-upload-help {
            font-size: 0.85rem;
            color: #666;
            margin-top: 8px;
            line-height: 1.4;
        }

        .upload-btn-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            margin-top: 10px;
        }

        .upload-btn {
            border: 2px solid #FF5722;
            color: #FF5722;
            background-color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .upload-btn:hover {
            background-color: #FF5722;
            color: white;
        }

        .upload-btn i {
            margin-right: 8px;
        }

        .upload-btn-wrapper input[type=file] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
            height: 100%;
            width: 100%;
        }

        /* Error message styling */
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #ffebee;
            border-radius: 10px;
            font-size: 14px;
            border-left: 4px solid #f44336;
            box-shadow: 0 2px 8px rgba(244, 67, 54, 0.1);
            display: flex;
            align-items: center;
            animation: shake 0.5s ease-in-out;
        }

        .error-message i {
            margin-right: 10px;
            font-size: 18px;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        /* Success message styling */
        .success-message {
            color: #4CAF50;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #E8F5E9;
            border-radius: 10px;
            font-size: 14px;
            border-left: 4px solid #4CAF50;
            box-shadow: 0 2px 8px rgba(76, 175, 80, 0.1);
            display: flex;
            align-items: center;
            animation: slideDown 0.5s ease-in-out;
        }

        .success-message i {
            margin-right: 10px;
            font-size: 18px;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Required field indicator */
        .required:after {
            content: " *";
            color: #f44336;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .register-container {
                flex-direction: column;
                width: 90%;
            }

            .register-image {
                display: none;
            }

            .form-row {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-form-container">
            <div class="logo">
                <span class="logo-icon"><i class="fas fa-utensils"></i></span>
                <span class="logo-text">Food Express</span>
            </div>

            <h1>Sign up</h1>
            <p class="welcome-text">Create your account to get started with Restro Foodie.</p>

            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-column">
                        <div class="form-group">
                            <label for="username" class="required">Username</label>
                            <input type="text" id="username" name="username" placeholder="Choose a username" required>
                        </div>

                        <div class="form-group">
                            <label for="email" class="required">Email</label>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>

                        <div class="form-group">
                            <label for="password" class="required">Password</label>
                            <div class="password-field">
                                <input type="password" id="password" name="password" placeholder="Create a password" required>
                                <span class="password-toggle" id="password-toggle" onclick="togglePasswordVisibility('password', 'password-toggle')">
                                    <i class="fas fa-eye"></i>
                                </span>
                            </div>
                            <div class="password-strength-meter">
                                <div class="password-strength-meter-fill" id="password-strength-meter-fill"></div>
                            </div>
                            <div class="strength-text" id="password-strength-text">Password strength</div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword" class="required">Confirm Password</label>
                            <div class="password-field">
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                                <span class="password-toggle" id="confirm-password-toggle" onclick="togglePasswordVisibility('confirmPassword', 'confirm-password-toggle')">
                                    <i class="fas fa-eye"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="form-column">
                        <div class="form-group">
                            <label for="fullName" class="required">Full Name</label>
                            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="required">Phone</label>
                            <input type="text" id="phone" name="phone" placeholder="Enter your phone number" required>
                        </div>

                        <div class="form-group">
                            <label for="address" class="required">Address</label>
                            <textarea id="address" name="address" placeholder="Enter your address" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="profilePicture">Profile Picture</label>
                            <div class="profile-upload-container">
                                <div class="profile-preview">
                                    <div class="profile-image-placeholder">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <img id="profileImagePreview" src="#" alt="Profile Preview" style="display: none;">
                                </div>
                                <div class="profile-upload-controls">
                                    <div class="upload-btn-wrapper">
                                        <button type="button" class="upload-btn"><i class="fas fa-camera"></i> Choose Photo</button>
                                        <input type="file" id="profilePicture" name="profilePicture" accept="image/*" onchange="previewImage(this)">
                                    </div>
                                    <div class="profile-upload-help">
                                        <i class="fas fa-info-circle"></i> Add a profile picture to personalize your account.<br>
                                        Max size: 5MB. Formats: JPG, PNG, GIF
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="checkbox-container">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms" class="required">I agree to the <a href="${pageContext.request.contextPath}/terms" class="terms-link">Terms & Conditions</a></label>
                </div>

                <button type="submit" class="btn-register">Create Account</button>

                <p style="text-align: center; margin: 1em 0;">OR</p>

                <div class="social-login">
                    <a href="${pageContext.request.contextPath}/auth/google" class="google-login-btn">
                        <img src="https://www.svgrepo.com/show/303108/google-icon-logo.svg" alt="Google" class="google-icon">
                        <span>Sign up with Google</span>
                    </a>
                </div>

                <div class="login-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
                </div>

                <div class="support-email">
                    <i class="fas fa-envelope"></i> Email: Support@foodexpress.com
                </div>
            </form>
        </div>

        <div class="register-image">
            <div class="register-image-content">
                <h2 class="image-heading">Craving Something ?</h2>
                <p class="image-text">Let's get you started!</p>
                <a href="${pageContext.request.contextPath}/" class="get-started-btn">Get's Started</a>
            </div>
        </div>
    </div>

    <script>
        // Toggle password visibility
        function togglePasswordVisibility(inputId, toggleId) {
            const passwordInput = document.getElementById(inputId);
            const toggleIcon = document.getElementById(toggleId).querySelector('i');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        // Profile image preview
        function previewImage(input) {
            const preview = document.getElementById('profileImagePreview');
            const placeholder = input.parentElement.parentElement.parentElement.querySelector('.profile-image-placeholder');

            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    placeholder.style.display = 'none';
                };

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
                placeholder.style.display = 'flex';
            }
        }

        // Password strength meter
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const strengthMeter = document.getElementById('password-strength-meter-fill');
            const strengthText = document.getElementById('password-strength-text');

            passwordInput.addEventListener('input', function() {
                const password = passwordInput.value;
                const strength = calculatePasswordStrength(password);

                // Update the strength meter
                strengthMeter.style.width = strength.score * 25 + '%';

                // Update color based on strength
                if (strength.score === 0) {
                    strengthMeter.style.backgroundColor = '#ddd';
                    strengthText.style.color = '#666';
                    strengthText.textContent = 'Enter password';
                } else if (strength.score === 1) {
                    strengthMeter.style.backgroundColor = '#f44336';
                    strengthText.style.color = '#f44336';
                    strengthText.textContent = 'Weak: ' + strength.feedback;
                } else if (strength.score === 2) {
                    strengthMeter.style.backgroundColor = '#FF9800';
                    strengthText.style.color = '#FF9800';
                    strengthText.textContent = 'Fair: ' + strength.feedback;
                } else if (strength.score === 3) {
                    strengthMeter.style.backgroundColor = '#4CAF50';
                    strengthText.style.color = '#4CAF50';
                    strengthText.textContent = 'Good: ' + strength.feedback;
                } else {
                    strengthMeter.style.backgroundColor = '#2E7D32';
                    strengthText.style.color = '#2E7D32';
                    strengthText.textContent = 'Strong: Great password!';
                }
            });

            // Simple password strength calculator
            function calculatePasswordStrength(password) {
                let score = 0;
                let feedback = '';

                if (!password) {
                    return { score: 0, feedback: 'Enter a password' };
                }

                // Length check
                if (password.length < 6) {
                    feedback = 'Add more characters';
                } else if (password.length >= 8) {
                    score += 1;
                }

                // Complexity checks
                if (/[A-Z]/.test(password)) score += 1; // Has uppercase
                if (/[0-9]/.test(password)) score += 1; // Has number
                if (/[^A-Za-z0-9]/.test(password)) score += 1; // Has special char

                // Feedback based on score
                if (score === 1) {
                    feedback = 'Try adding numbers';
                } else if (score === 2) {
                    feedback = 'Try adding special characters';
                } else if (score === 3) {
                    feedback = 'Almost there!';
                }

                return { score: score, feedback: feedback };
            }

            // Confirm password validation
            const confirmPasswordInput = document.getElementById('confirmPassword');
            confirmPasswordInput.addEventListener('input', function() {
                if (passwordInput.value !== confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity('Passwords do not match');
                } else {
                    confirmPasswordInput.setCustomValidity('');
                }
            });
        });
    </script>
</body>
</html>
