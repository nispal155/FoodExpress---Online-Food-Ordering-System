<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - ${pageTitle}" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-3 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Admin Menu</h2>
            </div>
            <div style="padding: 0;">
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/restaurants" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-utensils"></i> Restaurants
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-list"></i> Menu Items
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/users" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-users"></i> Users
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/settings" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="col-md-9 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">${empty user ? 'Create New User' : 'Edit User'}</h2>
            </div>
            <div style="padding: 1rem;">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}${empty user ? '/admin/users/create' : '/admin/users/edit'}" method="post">
                    <c:if test="${not empty user}">
                        <input type="hidden" name="id" value="${user.id}">
                    </c:if>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username *</label>
                                <input type="text" class="form-control" id="username" name="username" value="${username != null ? username : user.username}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">Password ${empty user ? '*' : '(leave blank to keep current)'}</label>
                                <input type="password" class="form-control" id="password" name="password" ${empty user ? 'required' : ''}>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email *</label>
                                <input type="email" class="form-control" id="email" name="email" value="${email != null ? email : user.email}" required>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name *</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName != null ? fullName : user.fullName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${phone != null ? phone : user.phone}">
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3">${address != null ? address : user.address}</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="role" class="form-label">Role *</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="">Select a role</option>
                            <option value="ADMIN" ${role == 'ADMIN' || user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                            <option value="CUSTOMER" ${role == 'CUSTOMER' || user.role == 'CUSTOMER' ? 'selected' : ''}>Customer</option>
                            <option value="DELIVERY" ${role == 'DELIVERY' || user.role == 'DELIVERY' ? 'selected' : ''}>Delivery Person</option>
                        </select>
                    </div>
                    
                    <div style="margin-top: 1.5rem;">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Users
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${empty user ? 'Create User' : 'Update User'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
