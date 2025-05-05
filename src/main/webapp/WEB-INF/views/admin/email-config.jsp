<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin - Email Configuration" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Include the admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp" />

    <!-- Admin Content -->
    <div class="admin-content">
        <!-- Email Configuration Header -->
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Email Configuration</h1>
                <div class="admin-breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    <i class="fas fa-chevron-right"></i>
                    <span>Email Configuration</span>
                </div>
            </div>
            <div class="admin-page-actions">
                <button type="button" class="admin-btn admin-btn-primary" onclick="document.getElementById('emailConfigForm').submit()">
                    <i class="fas fa-save"></i> Save Configuration
                </button>
            </div>
        </div>

        <!-- Email Configuration Card -->
        <div class="admin-card animate__animated animate__fadeIn">
            <div class="admin-card-header">
                <h2 class="admin-card-title">SMTP Server Settings</h2>
                <p class="admin-card-subtitle">Configure your email server settings for sending verification codes and notifications</p>
            </div>
            <div class="admin-card-body">
                <c:if test="${not empty error}">
                    <div class="admin-alert admin-alert-danger animate__animated animate__fadeIn">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="admin-alert admin-alert-success animate__animated animate__fadeIn">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>

                <form id="emailConfigForm" action="${pageContext.request.contextPath}/admin/email-config" method="post">
                    <div class="admin-form-grid">
                        <div class="admin-form-group">
                            <label for="username" class="admin-form-label">Email Username</label>
                            <input type="text" class="admin-form-input" id="username" name="username"
                                   value="${param.username}" required>
                            <div class="admin-form-text">Your email address (e.g., example@gmail.com)</div>
                        </div>

                        <div class="admin-form-group">
                            <label for="password" class="admin-form-label">Email Password</label>
                            <input type="password" class="admin-form-input" id="password" name="password"
                                   value="${param.password}" required>
                            <div class="admin-form-text">For Gmail, use an App Password (not your regular password)</div>
                        </div>

                        <div class="admin-form-group">
                            <label for="host" class="admin-form-label">SMTP Host</label>
                            <input type="text" class="admin-form-input" id="host" name="host"
                                   value="${param.host != null ? param.host : 'smtp.gmail.com'}" required>
                            <div class="admin-form-text">SMTP server address (e.g., smtp.gmail.com)</div>
                        </div>

                        <div class="admin-form-group">
                            <label for="port" class="admin-form-label">SMTP Port</label>
                            <input type="number" class="admin-form-input" id="port" name="port"
                                   value="${param.port != null ? param.port : '587'}" required>
                            <div class="admin-form-text">SMTP server port (e.g., 587 for TLS, 465 for SSL)</div>
                        </div>

                        <div class="admin-form-group">
                            <label for="from" class="admin-form-label">From Address</label>
                            <input type="text" class="admin-form-input" id="from" name="from"
                                   value="${param.from != null ? param.from : 'Food Express <your-email@gmail.com>'}" required>
                            <div class="admin-form-text">The name and email that will appear in the From field</div>
                        </div>

                        <div class="admin-form-group">
                            <div class="admin-form-check">
                                <input type="checkbox" class="admin-form-check-input" id="enabled" name="enabled"
                                       ${param.enabled == 'on' ? 'checked' : ''}>
                                <label class="admin-form-check-label" for="enabled">Enable Email Sending</label>
                            </div>
                            <div class="admin-form-text">If disabled, verification codes will be displayed on screen instead of sent by email</div>
                        </div>
                    </div>

                    <div class="admin-card animate__animated animate__fadeIn" style="margin-top: 20px; animation-delay: 0.1s;">
                        <div class="admin-card-body">
                            <h5 style="display: flex; align-items: center; gap: 8px; color: var(--primary-color); margin-bottom: 15px;">
                                <i class="fas fa-info-circle"></i> Gmail Configuration Instructions
                            </h5>
                            <ol style="padding-left: 20px; margin-bottom: 0;">
                                <li style="margin-bottom: 8px;">Enable 2-Step Verification on your Google Account</li>
                                <li style="margin-bottom: 8px;">Go to your Google Account → Security → App passwords</li>
                                <li style="margin-bottom: 8px;">Select "Mail" and "Other (Custom name)"</li>
                                <li style="margin-bottom: 8px;">Enter "Food Express" and click "Generate"</li>
                                <li>Use the generated 16-character password in the "Email Password" field above</li>
                            </ol>
                        </div>
                    </div>

                    <div class="admin-form-actions" style="margin-top: 20px;">
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <i class="fas fa-save"></i> Save Configuration
                        </button>

                        <button type="submit" name="action" value="test" class="admin-btn admin-btn-secondary">
                            <i class="fas fa-vial"></i> Test Connection
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
