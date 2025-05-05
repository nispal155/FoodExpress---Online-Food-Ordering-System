<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Account Settings" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1>Account Settings</h1>
    
    <!-- Success and Error Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle"></i> ${param.success}
        </div>
    </c:if>
    
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${param.error}
        </div>
    </c:if>
    
    <div class="row">
        <!-- Settings Navigation -->
        <div class="col-md-3 col-sm-12">
            <div class="card" style="margin-bottom: 1.5rem;">
                <div class="card-header">
                    <h2 class="card-title">Settings</h2>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/settings/account" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-user"></i> Account
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/notifications" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-bell"></i> Notifications
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/payment" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-credit-card"></i> Payment Methods
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/privacy" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-shield-alt"></i> Privacy
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/preferences" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-sliders-h"></i> Preferences
                    </a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-block">
                        <i class="fas fa-user-edit"></i> Edit Profile
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Settings Content -->
        <div class="col-md-9 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Account Settings</h2>
                </div>
                <div class="card-body">
                    <div class="account-info">
                        <div class="mb-4">
                            <h3>Account Information</h3>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Username:</strong> ${user.username}</p>
                                    <p><strong>Email:</strong> ${user.email}</p>
                                    <p><strong>Full Name:</strong> ${user.fullName}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Phone:</strong> ${user.phone != null ? user.phone : 'Not provided'}</p>
                                    <p><strong>Address:</strong> ${user.address != null ? user.address : 'Not provided'}</p>
                                    <p><strong>Account Type:</strong> ${user.role}</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Account Actions</h3>
                            <div class="row">
                                <div class="col-md-6">
                                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary mb-2">
                                        <i class="fas fa-user-edit"></i> Edit Profile
                                    </a>
                                </div>
                                <div class="col-md-6">
                                    <a href="${pageContext.request.contextPath}/forgot-password" class="btn btn-warning mb-2">
                                        <i class="fas fa-key"></i> Reset Password
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Danger Zone</h3>
                            <div class="alert alert-danger">
                                <p><strong>Deactivate Account</strong></p>
                                <p>Deactivating your account will temporarily disable your account. You can reactivate it at any time by logging in.</p>
                                <button class="btn btn-outline-danger" onclick="confirmDeactivate()">
                                    <i class="fas fa-user-slash"></i> Deactivate Account
                                </button>
                            </div>
                            
                            <div class="alert alert-danger mt-3">
                                <p><strong>Delete Account</strong></p>
                                <p>Deleting your account is permanent and cannot be undone. All your data will be permanently removed.</p>
                                <button class="btn btn-danger" onclick="confirmDelete()">
                                    <i class="fas fa-trash-alt"></i> Delete Account
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDeactivate() {
        if (confirm("Are you sure you want to deactivate your account? You can reactivate it at any time by logging in.")) {
            // Implement deactivation logic
            alert("This feature is not yet implemented.");
        }
    }
    
    function confirmDelete() {
        if (confirm("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.")) {
            // Implement deletion logic
            alert("This feature is not yet implemented.");
        }
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
