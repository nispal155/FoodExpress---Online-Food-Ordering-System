<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restro Foodie - Login</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-container {
            display: flex;
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            width: 900px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .login-form-container {
            flex: 1;
            padding: 40px;
        }

        .login-image {
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

        .login-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .login-image-content {
            position: relative;
            z-index: 1;
            padding: 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 40px;
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

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #333;
        }

        input[type="email"],
        input[type="password"],
        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #f5f5f5;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .password-field {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
            font-size: 16px;
            z-index: 10;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: #FF5722;
        }

        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="text"]:focus {
            outline: none;
            border-color: #FF5722;
            background-color: #fff;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-me input {
            margin-right: 8px;
        }

        .forgot-password {
            color: #666;
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password:hover {
            color: #FF5722;
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: #FF5722;
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-login:hover {
            background-color: #E64A19;
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
            padding: 10px 15px;
            background-color: #f5f5f5;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            color: #333;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .google-login-btn:hover {
            background-color: #e8e8e8;
        }

        .google-icon {
            width: 20px;
            margin-right: 10px;
        }

        .register-link {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        .register-link a {
            color: #FF5722;
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
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

        /* Error message styling */
        .error-message {
            color: #f44336;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
            font-size: 14px;
        }

        /* Success message styling */
        .success-message {
            color: #4CAF50;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #E8F5E9;
            border-radius: 4px;
            font-size: 14px;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                width: 90%;
            }

            .login-image {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-form-container">
            <div class="logo">
                <span class="logo-icon"><i class="fas fa-utensils"></i></span>
                <span class="logo-text">Food Express</span>
            </div>

            <h1>Log in</h1>
            <p class="welcome-text">Welcome back! please enter your details.</p>

            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="usernameOrEmail">Username or Email</label>
                    <input type="text" id="usernameOrEmail" name="username" placeholder="Enter Your Username or Email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="password-field">
                        <input type="password" id="password" name="password" placeholder="••••••••" required>
                        <span class="password-toggle" id="password-toggle" onclick="togglePasswordVisibility('password', 'password-toggle')">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>

                <div class="remember-forgot">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-password">Forgot Password</a>
                </div>

                <button type="submit" class="btn-login">Log in</button>
                <p style="text-align: center; margin: 1em 0;">OR</p>
                <div class="social-login">
                    <a href="${pageContext.request.contextPath}/auth/google" class="google-login-btn">
                        <img src="https://www.svgrepo.com/show/303108/google-icon-logo.svg" alt="Google" class="google-icon">
                        <span>Login with Google</span>
                    </a>
                </div>

                <div class="register-link">
                    Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign up</a>
                </div>

                <div class="support-email">
                    <i class="fas fa-envelope"></i> Email: Support@foodexpress.com
                </div>
            </form>
        </div>

        <div class="login-image">
            <div class="login-image-content">
                <h2 class="image-heading">Craving Something ?</h2>
                <p class="image-text">Let's get you started!</p>
                <a href="${pageContext.request.contextPath}/" class="get-started-btn">Get's Started</a>
            </div>
        </div>
    </div>
    <script>
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
    </script>
</body>
</html>
