<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Privacy Settings" />
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
                       class="list-group-item list-group-item-action">
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
                       class="list-group-item list-group-item-action active">
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
                    <h2 class="card-title">Privacy Settings</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/settings/privacy" method="post">
                        <div class="mb-4">
                            <h3>Data Sharing</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="share_order_history" name="privacy_share_order_history" value="true">
                                <label class="form-check-label" for="share_order_history">
                                    Share Order History with Restaurants
                                </label>
                                <small class="form-text text-muted">Allow restaurants to see your order history to provide personalized recommendations.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="share_preferences" name="privacy_share_preferences" value="true" checked>
                                <label class="form-check-label" for="share_preferences">
                                    Share Food Preferences
                                </label>
                                <small class="form-text text-muted">Allow us to use your food preferences to provide personalized recommendations.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="share_location" name="privacy_share_location" value="true" checked>
                                <label class="form-check-label" for="share_location">
                                    Share Location Data
                                </label>
                                <small class="form-text text-muted">Allow us to use your location to show nearby restaurants and delivery options.</small>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Account Privacy</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="two_factor_auth" name="privacy_two_factor_auth" value="true">
                                <label class="form-check-label" for="two_factor_auth">
                                    Enable Two-Factor Authentication
                                </label>
                                <small class="form-text text-muted">Add an extra layer of security to your account by requiring a verification code when logging in.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="login_notifications" name="privacy_login_notifications" value="true" checked>
                                <label class="form-check-label" for="login_notifications">
                                    Login Notifications
                                </label>
                                <small class="form-text text-muted">Receive notifications when your account is accessed from a new device or location.</small>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Cookies and Tracking</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="essential_cookies" name="privacy_essential_cookies" value="true" checked disabled>
                                <label class="form-check-label" for="essential_cookies">
                                    Essential Cookies
                                </label>
                                <small class="form-text text-muted">These cookies are necessary for the website to function and cannot be disabled.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="analytics_cookies" name="privacy_analytics_cookies" value="true" checked>
                                <label class="form-check-label" for="analytics_cookies">
                                    Analytics Cookies
                                </label>
                                <small class="form-text text-muted">These cookies help us understand how visitors interact with our website.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="marketing_cookies" name="privacy_marketing_cookies" value="true">
                                <label class="form-check-label" for="marketing_cookies">
                                    Marketing Cookies
                                </label>
                                <small class="form-text text-muted">These cookies are used to track visitors across websites to display relevant advertisements.</small>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </form>
                    
                    <div class="mt-4">
                        <h3>Data Management</h3>
                        <p>You can request a copy of your data or request to delete all your data from our system.</p>
                        
                        <div class="d-flex">
                            <button class="btn btn-outline-primary me-2" onclick="requestDataExport()">
                                <i class="fas fa-download"></i> Request Data Export
                            </button>
                            
                            <button class="btn btn-outline-danger" onclick="requestDataDeletion()">
                                <i class="fas fa-trash-alt"></i> Request Data Deletion
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function requestDataExport() {
        alert("This feature is not yet implemented. You would receive an email with a link to download your data.");
    }
    
    function requestDataDeletion() {
        if (confirm("Are you sure you want to request deletion of all your data? This process cannot be undone and will permanently remove all your information from our system.")) {
            alert("This feature is not yet implemented. You would receive an email to confirm your data deletion request.");
        }
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
