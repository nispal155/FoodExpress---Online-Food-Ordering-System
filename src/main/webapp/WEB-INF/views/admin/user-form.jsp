<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - ${pageTitle}" />
</jsp:include>

<!-- Include the admin dashboard CSS and user form CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-user-form.css">

<div class="admin-container">
    <!-- Admin Sidebar -->
    <div class="admin-sidebar">
        <div class="admin-menu-title">Admin Menu</div>
        <ul class="admin-menu">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/users" class="active">
                    <i class="fas fa-users"></i> Users
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/restaurants">
                    <i class="fas fa-utensils"></i> Restaurant
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/menu-items">
                    <i class="fas fa-list"></i> Menu Items
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/reporting">
                    <i class="fas fa-chart-bar"></i> Reports
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/settings">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
    </div>

    <!-- Admin Content -->
    <div class="admin-content">
        <!-- User Form Header -->
        <div class="user-form-header">
            <div class="header-left">
                <h1>${empty user ? 'Create New User' : 'Edit User'}</h1>
                <p class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a> /
                    <a href="${pageContext.request.contextPath}/admin/users">Users</a> /
                    <span>${empty user ? 'Create New User' : 'Edit User'}</span>
                </p>
                <c:if test="${not empty user}">
                    <p class="user-info">Editing user: <strong>${user.username}</strong></p>
                </c:if>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/users" class="back-button">
                    <i class="fas fa-arrow-left"></i> Back to Users
                </a>
            </div>
        </div>

        <!-- User Form Card -->
        <div class="user-form-card">
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

            <form action="${pageContext.request.contextPath}${empty user ? '/admin/users/create' : '/admin/users/edit'}" method="post" enctype="multipart/form-data" class="user-form">
                <c:if test="${not empty user}">
                    <input type="hidden" name="id" value="${user.id}">
                </c:if>

                <div class="form-grid">
                    <div class="form-section">
                        <h3 class="section-title">Account Information</h3>

                        <div class="form-group">
                            <label for="username" class="form-label">Username <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="fas fa-user"></i>
                                <input type="text" class="form-input" id="username" name="username" value="${username != null ? username : (user != null ? user.username : '')}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label">
                                Password ${empty user ? '<span class="required">*</span>' : '<span class="optional">(leave blank to keep current)</span>'}
                            </label>
                            <div class="input-with-icon">
                                <i class="fas fa-lock"></i>
                                <input type="password" class="form-input" id="password" name="password" ${empty user ? 'required' : ''}>
                                <button type="button" class="toggle-password" onclick="togglePasswordVisibility('password')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="password-strength-meter">
                                <div class="password-strength-meter-fill" id="password-strength-meter-fill"></div>
                            </div>
                            <div class="strength-text" id="password-strength-text">Password strength</div>
                        </div>

                        <c:if test="${empty user}">
                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Confirm Password <span class="required">*</span></label>
                                <div class="input-with-icon">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" class="form-input" id="confirmPassword" name="confirmPassword" required>
                                    <button type="button" class="toggle-password" onclick="togglePasswordVisibility('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </c:if>

                        <div class="form-group">
                            <label for="email" class="form-label">Email <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="fas fa-envelope"></i>
                                <input type="email" class="form-input" id="email" name="email" value="${email != null ? email : (user != null ? user.email : '')}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="role" class="form-label">Role <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="fas fa-user-tag"></i>
                                <select class="form-input" id="role" name="role" required>
                                    <option value="">Select a role</option>
                                    <option value="ADMIN" ${role == 'ADMIN' || (user != null && user.role == 'ADMIN') ? 'selected' : ''}>Admin</option>
                                    <option value="CUSTOMER" ${role == 'CUSTOMER' || (user != null && user.role == 'CUSTOMER') ? 'selected' : ''}>Customer</option>
                                    <option value="DELIVERY" ${role == 'DELIVERY' || (user != null && user.role == 'DELIVERY') ? 'selected' : ''}>Delivery Person</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Personal Information</h3>

                        <div class="form-group">
                            <label for="fullName" class="form-label">Full Name <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="fas fa-id-card"></i>
                                <input type="text" class="form-input" id="fullName" name="fullName" value="${fullName != null ? fullName : (user != null ? user.fullName : '')}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="form-label">Phone</label>
                            <div class="input-with-icon">
                                <i class="fas fa-phone"></i>
                                <input type="text" class="form-input" id="phone" name="phone" value="${phone != null ? phone : (user != null ? user.phone : '')}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="form-label">Address</label>
                            <div class="input-with-icon textarea">
                                <i class="fas fa-map-marker-alt"></i>
                                <textarea class="form-input" id="address" name="address" rows="3">${address != null ? address : (user != null ? user.address : '')}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="profilePicture" class="form-label">Profile Picture</label>
                            <div class="profile-upload-container">
                                <div class="profile-preview">
                                    <c:choose>
                                        <c:when test="${not empty user && not empty user.profilePicture}">
                                            <img id="profileImagePreview" src="${pageContext.request.contextPath}/uploads/profile/${user.profilePicture}" alt="Profile Preview">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="profile-image-placeholder" id="profileImagePlaceholder">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <img id="profileImagePreview" src="#" alt="Profile Preview" style="display: none;">
                                        </c:otherwise>
                                    </c:choose>
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

                        <div class="form-group">
                            <label class="form-label">Account Status</label>
                            <div class="toggle-switch-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="isActive" ${empty user || user.active ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                                <span class="toggle-label">Active Account</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn-cancel">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn-save">
                        <i class="fas fa-save"></i> ${empty user ? 'Create User' : 'Update User'}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Password visibility toggle
        window.togglePasswordVisibility = function(inputId) {
            const passwordInput = document.getElementById(inputId);
            const toggleButton = passwordInput.parentElement.querySelector('.toggle-password i');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleButton.classList.remove('fa-eye');
                toggleButton.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleButton.classList.remove('fa-eye-slash');
                toggleButton.classList.add('fa-eye');
            }
        };

        // Profile image preview
        window.previewImage = function(input) {
            const preview = document.getElementById('profileImagePreview');
            const placeholder = document.getElementById('profileImagePlaceholder');

            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    if (placeholder) {
                        placeholder.style.display = 'none';
                    }
                };

                reader.readAsDataURL(input.files[0]);
            }
        };

        // Password strength meter
        const passwordInput = document.getElementById('password');
        const strengthMeter = document.getElementById('password-strength-meter-fill');
        const strengthText = document.getElementById('password-strength-text');

        if (passwordInput && strengthMeter && strengthText) {
            passwordInput.addEventListener('input', function() {
                const password = passwordInput.value;
                const strength = calculatePasswordStrength(password);

                // Update the strength meter
                strengthMeter.style.width = strength.score * 25 + '%';

                // Update color based on strength
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

                // Update text
                strengthText.textContent = strength.feedback;
            });
        }

        // Confirm password validation
        const confirmPasswordInput = document.getElementById('confirmPassword');
        if (confirmPasswordInput && passwordInput) {
            confirmPasswordInput.addEventListener('input', function() {
                if (passwordInput.value !== confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity('Passwords do not match');
                    confirmPasswordInput.classList.add('is-invalid');
                } else {
                    confirmPasswordInput.setCustomValidity('');
                    confirmPasswordInput.classList.remove('is-invalid');
                }
            });

            passwordInput.addEventListener('input', function() {
                if (confirmPasswordInput.value && passwordInput.value !== confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity('Passwords do not match');
                    confirmPasswordInput.classList.add('is-invalid');
                } else if (confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity('');
                    confirmPasswordInput.classList.remove('is-invalid');
                }
            });
        }

        // Form submission handling
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
                } else {
                    field.classList.remove('is-invalid');
                }
            });

            // Check if passwords match for new user
            if (confirmPasswordInput && passwordInput && passwordInput.value !== confirmPasswordInput.value) {
                isValid = false;
                confirmPasswordInput.classList.add('is-invalid');
                alert('Passwords do not match');
                return;
            }

            if (!isValid) {
                alert('Please fill in all required fields');
                return;
            }

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
                alert('Failed to save user. Please try again.');
            });
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
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
