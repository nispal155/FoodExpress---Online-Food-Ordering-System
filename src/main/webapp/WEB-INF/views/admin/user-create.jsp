<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Create New User" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-create-user.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp">
        <jsp:param name="activeMenu" value="users" />
    </jsp:include>

    <div class="admin-content">
        <div class="create-user-container animate__animated animate__fadeIn">
            <!-- User Form Header -->
            <div class="create-user-header">
                <div class="header-left">
                    <h1>Create New User</h1>
                    <p class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                        <i class="fas fa-chevron-right"></i>
                        <a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> Users</a>
                        <i class="fas fa-chevron-right"></i>
                        <span>Create New User</span>
                    </p>
                </div>
                <div class="header-right">
                    <a href="${pageContext.request.contextPath}/admin/users" class="back-button">
                        <i class="fas fa-arrow-left"></i> Back to Users
                    </a>
                </div>
            </div>

            <!-- User Form Content -->
            <div class="create-user-content">
            <c:if test="${not empty error}">
                <div class="alert-message error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert-message success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/users/create" method="post" enctype="multipart/form-data" class="user-form">
                <div class="form-grid">
                    <div class="form-section">
                        <h3 class="section-title">Account Information</h3>

                        <div class="form-group animate__animated animate__fadeInUp">
                            <label for="username" class="form-label">Username <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <input type="text" class="form-input" id="username" name="username" value="${username}" placeholder="Enter username" required>
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="validation-message" id="username-validation"></div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.1s;">
                            <label for="password" class="form-label">
                                Password <span class="required">*</span>
                            </label>
                            <div class="input-with-icon">
                                <input type="password" class="form-input" id="password" name="password" placeholder="Enter secure password" required>
                                <i class="fas fa-lock"></i>
                                <button type="button" class="toggle-password" onclick="togglePasswordVisibility('password')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="password-strength-meter">
                                <div class="password-strength-meter-fill" id="password-strength-meter-fill"></div>
                            </div>
                            <div class="strength-text" id="password-strength-text">Password strength</div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
                            <label for="confirmPassword" class="form-label">Confirm Password <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <input type="password" class="form-input" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                                <i class="fas fa-lock"></i>
                                <button type="button" class="toggle-password" onclick="togglePasswordVisibility('confirmPassword')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="validation-message" id="confirm-password-validation"></div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.3s;">
                            <label for="email" class="form-label">Email <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <input type="email" class="form-input" id="email" name="email" value="${email}" placeholder="Enter email address" required>
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="validation-message" id="email-validation"></div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.4s;">
                            <label for="role" class="form-label">Role <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <select class="form-input" id="role" name="role" required>
                                    <option value="">Select a role</option>
                                    <option value="ADMIN" ${role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                    <option value="CUSTOMER" ${role == 'CUSTOMER' || empty role ? 'selected' : ''}>Customer</option>
                                    <option value="DELIVERY" ${role == 'DELIVERY' ? 'selected' : ''}>Delivery Person</option>
                                </select>
                                <i class="fas fa-user-tag"></i>
                            </div>
                            <div class="validation-message" id="role-validation"></div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Personal Information</h3>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.5s;">
                            <label for="fullName" class="form-label">Full Name <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <input type="text" class="form-input" id="fullName" name="fullName" value="${fullName}" placeholder="Enter full name" required>
                                <i class="fas fa-id-card"></i>
                            </div>
                            <div class="validation-message" id="fullname-validation"></div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.6s;">
                            <label for="phone" class="form-label">Phone <span class="optional">(optional)</span></label>
                            <div class="input-with-icon">
                                <input type="text" class="form-input" id="phone" name="phone" value="${phone}" placeholder="Enter phone number">
                                <i class="fas fa-phone"></i>
                            </div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.7s;">
                            <label for="address" class="form-label">Address <span class="optional">(optional)</span></label>
                            <div class="input-with-icon textarea">
                                <textarea class="form-input" id="address" name="address" rows="3" placeholder="Enter address">${address}</textarea>
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.8s;">
                            <label for="profilePicture" class="form-label">Profile Picture <span class="optional">(optional)</span></label>
                            <div class="profile-upload-container">
                                <div class="profile-preview">
                                    <div class="profile-image-placeholder" id="profileImagePlaceholder">
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
                                        <i class="fas fa-info-circle"></i> Add a profile picture to personalize the account.<br>
                                        Max size: 5MB. Formats: JPG, PNG, GIF
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group animate__animated animate__fadeInUp" style="animation-delay: 0.9s;">
                            <label class="form-label">Account Status</label>
                            <div class="toggle-switch-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="isActive" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                                <span class="toggle-label">Active Account</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-actions animate__animated animate__fadeInUp" style="animation-delay: 1s;">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn-cancel">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn-save">
                        <i class="fas fa-save"></i> Create User
                    </button>
                </div>
            </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add animation to form sections
        const formSections = document.querySelectorAll('.form-section');
        formSections.forEach((section, index) => {
            section.classList.add('animate__animated', 'animate__fadeIn');
            section.style.animationDelay = `${0.2 * index}s`;
        });

        // Password visibility toggle with improved animation
        window.togglePasswordVisibility = function(inputId) {
            const passwordInput = document.getElementById(inputId);
            const toggleButton = passwordInput.parentElement.querySelector('.toggle-password i');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleButton.classList.remove('fa-eye');
                toggleButton.classList.add('fa-eye-slash');
                toggleButton.style.color = '#FF5722'; // Highlight when visible
            } else {
                passwordInput.type = 'password';
                toggleButton.classList.remove('fa-eye-slash');
                toggleButton.classList.add('fa-eye');
                toggleButton.style.color = ''; // Reset color
            }
        };

        // Enhanced profile image preview with animation
        window.previewImage = function(input) {
            const preview = document.getElementById('profileImagePreview');
            const placeholder = document.getElementById('profileImagePlaceholder');

            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.classList.add('animate__animated', 'animate__fadeIn');
                    preview.style.display = 'block';
                    if (placeholder) {
                        placeholder.style.display = 'none';
                    }
                };

                reader.readAsDataURL(input.files[0]);
            }
        };

        // Improved password strength meter with better visual feedback
        const passwordInput = document.getElementById('password');
        const strengthMeter = document.getElementById('password-strength-meter-fill');
        const strengthText = document.getElementById('password-strength-text');
        const passwordValidation = document.getElementById('password-validation');

        if (passwordInput && strengthMeter && strengthText) {
            passwordInput.addEventListener('input', function() {
                const password = passwordInput.value;
                const strength = calculatePasswordStrength(password);

                // Update the strength meter with smooth transition
                strengthMeter.style.width = strength.score * 25 + '%';

                // Update color based on strength with better colors
                if (strength.score === 0) {
                    strengthMeter.style.backgroundColor = '#ddd';
                } else if (strength.score === 1) {
                    strengthMeter.style.backgroundColor = '#f44336'; // Red
                } else if (strength.score === 2) {
                    strengthMeter.style.backgroundColor = '#ff9800'; // Orange
                } else if (strength.score === 3) {
                    strengthMeter.style.backgroundColor = '#4caf50'; // Green
                } else {
                    strengthMeter.style.backgroundColor = '#2e7d32'; // Dark Green
                }

                // Update text with icon
                if (strength.score === 0) {
                    strengthText.innerHTML = '<i class="fas fa-info-circle"></i> ' + strength.feedback;
                } else if (strength.score <= 2) {
                    strengthText.innerHTML = '<i class="fas fa-exclamation-triangle"></i> ' + strength.feedback;
                } else {
                    strengthText.innerHTML = '<i class="fas fa-check-circle"></i> ' + strength.feedback;
                }
            });
        }

        // Enhanced confirm password validation with real-time feedback
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const confirmPasswordValidation = document.getElementById('confirm-password-validation');

        if (confirmPasswordInput && passwordInput) {
            confirmPasswordInput.addEventListener('input', function() {
                validatePasswordMatch();
            });

            passwordInput.addEventListener('input', function() {
                if (confirmPasswordInput.value) {
                    validatePasswordMatch();
                }
            });

            function validatePasswordMatch() {
                if (passwordInput.value !== confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity('Passwords do not match');
                    confirmPasswordInput.classList.add('is-invalid');
                    confirmPasswordValidation.innerHTML = '<i class="fas fa-times-circle"></i> Passwords do not match';
                    confirmPasswordValidation.style.color = '#f44336';
                } else {
                    confirmPasswordInput.setCustomValidity('');
                    confirmPasswordInput.classList.remove('is-invalid');
                    confirmPasswordValidation.innerHTML = '<i class="fas fa-check-circle"></i> Passwords match';
                    confirmPasswordValidation.style.color = '#4caf50';
                }
            }
        }

        // Real-time validation for username
        const usernameInput = document.getElementById('username');
        const usernameValidation = document.getElementById('username-validation');

        if (usernameInput && usernameValidation) {
            usernameInput.addEventListener('input', function() {
                if (usernameInput.value.length < 3) {
                    usernameValidation.innerHTML = '<i class="fas fa-info-circle"></i> Username must be at least 3 characters';
                    usernameValidation.style.color = '#f44336';
                    usernameInput.classList.add('is-invalid');
                } else {
                    usernameValidation.innerHTML = '<i class="fas fa-check-circle"></i> Valid username';
                    usernameValidation.style.color = '#4caf50';
                    usernameInput.classList.remove('is-invalid');
                }
            });
        }

        // Email validation
        const emailInput = document.getElementById('email');
        const emailValidation = document.getElementById('email-validation');

        if (emailInput && emailValidation) {
            emailInput.addEventListener('input', function() {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailInput.value)) {
                    emailValidation.innerHTML = '<i class="fas fa-info-circle"></i> Please enter a valid email address';
                    emailValidation.style.color = '#f44336';
                    emailInput.classList.add('is-invalid');
                } else {
                    emailValidation.innerHTML = '<i class="fas fa-check-circle"></i> Valid email format';
                    emailValidation.style.color = '#4caf50';
                    emailInput.classList.remove('is-invalid');
                }
            });
        }

        // Role validation
        const roleSelect = document.getElementById('role');
        const roleValidation = document.getElementById('role-validation');

        if (roleSelect && roleValidation) {
            roleSelect.addEventListener('change', function() {
                if (!roleSelect.value) {
                    roleValidation.innerHTML = '<i class="fas fa-info-circle"></i> Please select a role';
                    roleValidation.style.color = '#f44336';
                    roleSelect.classList.add('is-invalid');
                } else {
                    roleValidation.innerHTML = '<i class="fas fa-check-circle"></i> Role selected';
                    roleValidation.style.color = '#4caf50';
                    roleSelect.classList.remove('is-invalid');
                }
            });
        }

        // Full name validation
        const fullNameInput = document.getElementById('fullName');
        const fullNameValidation = document.getElementById('fullname-validation');

        if (fullNameInput && fullNameValidation) {
            fullNameInput.addEventListener('input', function() {
                if (fullNameInput.value.length < 2) {
                    fullNameValidation.innerHTML = '<i class="fas fa-info-circle"></i> Please enter a valid name';
                    fullNameValidation.style.color = '#f44336';
                    fullNameInput.classList.add('is-invalid');
                } else {
                    fullNameValidation.innerHTML = '<i class="fas fa-check-circle"></i> Valid name';
                    fullNameValidation.style.color = '#4caf50';
                    fullNameInput.classList.remove('is-invalid');
                }
            });
        }

        // Enhanced form submission with better UX
        const userForm = document.querySelector('.user-form');
        userForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Validate form
            let isValid = true;
            const requiredFields = userForm.querySelectorAll('[required]');

            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.classList.add('is-invalid');
                    // Add shake animation to invalid fields
                    field.classList.add('animate__animated', 'animate__shakeX');
                    setTimeout(() => {
                        field.classList.remove('animate__animated', 'animate__shakeX');
                    }, 1000);
                } else {
                    field.classList.remove('is-invalid');
                }
            });

            // Check if passwords match
            if (confirmPasswordInput && passwordInput && passwordInput.value !== confirmPasswordInput.value) {
                isValid = false;
                confirmPasswordInput.classList.add('is-invalid');
                confirmPasswordInput.classList.add('animate__animated', 'animate__shakeX');
                setTimeout(() => {
                    confirmPasswordInput.classList.remove('animate__animated', 'animate__shakeX');
                }, 1000);
                return;
            }

            if (!isValid) {
                // Scroll to the first invalid field
                const firstInvalidField = userForm.querySelector('.is-invalid');
                if (firstInvalidField) {
                    firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalidField.focus();
                }
                return;
            }

            // Show loading state on submit button
            const submitButton = userForm.querySelector('.btn-save');
            const originalButtonText = submitButton.innerHTML;
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating User...';
            submitButton.disabled = true;

            // Submit the form using fetch API
            const formData = new FormData(userForm);
            const url = userForm.getAttribute('action');
            const method = 'POST';

            fetch(url, {
                method: method,
                body: formData
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else if (response.ok) {
                    // If no redirect, go to users list with success message
                    window.location.href = '${pageContext.request.contextPath}/admin/users?success=created';
                } else {
                    throw new Error('Form submission failed');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                submitButton.innerHTML = originalButtonText;
                submitButton.disabled = false;

                // Show error message with animation
                const errorDiv = document.createElement('div');
                errorDiv.className = 'alert-message error animate__animated animate__fadeIn';
                errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> Failed to save user. Please try again.';
                userForm.prepend(errorDiv);

                // Scroll to error message
                errorDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });

                // Remove error message after 5 seconds
                setTimeout(() => {
                    errorDiv.classList.add('animate__fadeOut');
                    setTimeout(() => {
                        errorDiv.remove();
                    }, 1000);
                }, 5000);
            });
        });

        // Improved password strength calculator
        function calculatePasswordStrength(password) {
            let score = 0;
            let feedback = '';

            if (!password) {
                return { score: 0, feedback: 'Enter a password' };
            }

            // Length check
            if (password.length < 6) {
                feedback = 'Add more characters (min 6)';
            } else if (password.length >= 8) {
                score += 1;
            }

            // Complexity checks
            if (/[A-Z]/.test(password)) score += 1; // Has uppercase
            if (/[0-9]/.test(password)) score += 1; // Has number
            if (/[^A-Za-z0-9]/.test(password)) score += 1; // Has special char

            // Feedback based on score
            if (score === 1) {
                feedback = 'Weak - Try adding numbers';
            } else if (score === 2) {
                feedback = 'Fair - Try adding special characters';
            } else if (score === 3) {
                feedback = 'Good - Almost there!';
            } else if (score === 4) {
                feedback = 'Strong password!';
            }

            return { score: score, feedback: feedback };
        }

        // Add focus effects to form inputs
        const formInputs = document.querySelectorAll('.form-input');
        formInputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('input-focused');
            });

            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('input-focused');
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
