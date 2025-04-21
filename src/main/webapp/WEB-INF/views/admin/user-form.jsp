<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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

            <form action="${pageContext.request.contextPath}${empty user ? '/admin/users/create' : '/admin/users/edit'}" method="post" class="user-form">
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
                                <input type="text" class="form-input" id="username" name="username" value="${username != null ? username : user.username}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label">
                                Password ${empty user ? '<span class="required">*</span>' : '<span class="optional">(leave blank to keep current)</span>'}
                            </label>
                            <div class="input-with-icon">
                                <i class="fas fa-lock"></i>
                                <input type="password" class="form-input" id="password" name="password" ${empty user ? 'required' : ''}>
                                <button type="button" class="toggle-password" onclick="togglePasswordVisibility()">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="form-label">Email <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="fas fa-envelope"></i>
                                <input type="email" class="form-input" id="email" name="email" value="${email != null ? email : user.email}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="role" class="form-label">Role <span class="required">*</span></label>
                            <div class="input-with-icon">
                                <i class="fas fa-user-tag"></i>
                                <select class="form-input" id="role" name="role" required>
                                    <option value="">Select a role</option>
                                    <option value="ADMIN" ${role == 'ADMIN' || user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                    <option value="CUSTOMER" ${role == 'CUSTOMER' || user.role == 'CUSTOMER' ? 'selected' : ''}>Customer</option>
                                    <option value="DELIVERY" ${role == 'DELIVERY' || user.role == 'DELIVERY' ? 'selected' : ''}>Delivery Person</option>
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
                                <input type="text" class="form-input" id="fullName" name="fullName" value="${fullName != null ? fullName : user.fullName}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="form-label">Phone</label>
                            <div class="input-with-icon">
                                <i class="fas fa-phone"></i>
                                <input type="text" class="form-input" id="phone" name="phone" value="${phone != null ? phone : user.phone}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="form-label">Address</label>
                            <div class="input-with-icon textarea">
                                <i class="fas fa-map-marker-alt"></i>
                                <textarea class="form-input" id="address" name="address" rows="3">${address != null ? address : user.address}</textarea>
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
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const toggleButton = document.querySelector('.toggle-password i');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleButton.classList.remove('fa-eye');
            toggleButton.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleButton.classList.remove('fa-eye-slash');
            toggleButton.classList.add('fa-eye');
        }
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
