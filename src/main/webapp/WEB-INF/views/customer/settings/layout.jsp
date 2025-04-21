<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
                       class="list-group-item list-group-item-action ${activeCategory eq 'account' ? 'active' : ''}">
                        <i class="fas fa-user"></i> Account
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/notifications" 
                       class="list-group-item list-group-item-action ${activeCategory eq 'notifications' ? 'active' : ''}">
                        <i class="fas fa-bell"></i> Notifications
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/payment" 
                       class="list-group-item list-group-item-action ${activeCategory eq 'payment' ? 'active' : ''}">
                        <i class="fas fa-credit-card"></i> Payment Methods
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/privacy" 
                       class="list-group-item list-group-item-action ${activeCategory eq 'privacy' ? 'active' : ''}">
                        <i class="fas fa-shield-alt"></i> Privacy
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/preferences" 
                       class="list-group-item list-group-item-action ${activeCategory eq 'preferences' ? 'active' : ''}">
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
                    <h2 class="card-title">
                        <c:choose>
                            <c:when test="${activeCategory eq 'account'}">Account Settings</c:when>
                            <c:when test="${activeCategory eq 'notifications'}">Notification Settings</c:when>
                            <c:when test="${activeCategory eq 'payment'}">Payment Methods</c:when>
                            <c:when test="${activeCategory eq 'privacy'}">Privacy Settings</c:when>
                            <c:when test="${activeCategory eq 'preferences'}">Preferences</c:when>
                            <c:otherwise>Account Settings</c:otherwise>
                        </c:choose>
                    </h2>
                </div>
                <div class="card-body">
                    <!-- Content will be included here -->
                    <jsp:doBody />
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
