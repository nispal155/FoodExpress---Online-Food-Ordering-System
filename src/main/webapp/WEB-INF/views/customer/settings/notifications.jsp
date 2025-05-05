<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Notification Settings" />
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
                       class="list-group-item list-group-item-action active">
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
                    <h2 class="card-title">Notification Settings</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/settings/notifications" method="post">
                        <div class="mb-4">
                            <h3>Email Notifications</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="email_order_updates" name="notification_email_order_updates" value="true" checked>
                                <label class="form-check-label" for="email_order_updates">
                                    Order Updates
                                </label>
                                <small class="form-text text-muted">Receive email notifications about your order status.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="email_promotions" name="notification_email_promotions" value="true" checked>
                                <label class="form-check-label" for="email_promotions">
                                    Promotions and Deals
                                </label>
                                <small class="form-text text-muted">Receive email notifications about promotions, discounts, and special offers.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="email_newsletter" name="notification_email_newsletter" value="true" checked>
                                <label class="form-check-label" for="email_newsletter">
                                    Newsletter
                                </label>
                                <small class="form-text text-muted">Receive our monthly newsletter with updates and food trends.</small>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Push Notifications</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="push_order_updates" name="notification_push_order_updates" value="true" checked>
                                <label class="form-check-label" for="push_order_updates">
                                    Order Updates
                                </label>
                                <small class="form-text text-muted">Receive push notifications about your order status.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="push_promotions" name="notification_push_promotions" value="true">
                                <label class="form-check-label" for="push_promotions">
                                    Promotions and Deals
                                </label>
                                <small class="form-text text-muted">Receive push notifications about promotions, discounts, and special offers.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="push_reminders" name="notification_push_reminders" value="true" checked>
                                <label class="form-check-label" for="push_reminders">
                                    Reminders
                                </label>
                                <small class="form-text text-muted">Receive reminders about your cart and incomplete orders.</small>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>SMS Notifications</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="sms_order_updates" name="notification_sms_order_updates" value="true" checked>
                                <label class="form-check-label" for="sms_order_updates">
                                    Order Updates
                                </label>
                                <small class="form-text text-muted">Receive SMS notifications about your order status.</small>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="sms_promotions" name="notification_sms_promotions" value="true">
                                <label class="form-check-label" for="sms_promotions">
                                    Promotions and Deals
                                </label>
                                <small class="form-text text-muted">Receive SMS notifications about promotions, discounts, and special offers.</small>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
