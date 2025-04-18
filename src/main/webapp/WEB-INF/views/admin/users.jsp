<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">User Management</h2>
                <a href="${pageContext.request.contextPath}/admin/users/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New User
                </a>
            </div>
            <div style="padding: 1rem;">
                <!-- Search and Filter -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/admin/users" method="get" class="d-flex">
                            <input type="text" name="search" class="form-control" placeholder="Search users..." value="${searchQuery}">
                            <button type="submit" class="btn btn-secondary ms-2">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex justify-content-end">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary me-2 ${empty roleFilter ? 'active' : ''}">
                                All
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=ADMIN" class="btn btn-outline-secondary me-2 ${roleFilter == 'ADMIN' ? 'active' : ''}">
                                Admins
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=CUSTOMER" class="btn btn-outline-secondary me-2 ${roleFilter == 'CUSTOMER' ? 'active' : ''}">
                                Customers
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=DELIVERY" class="btn btn-outline-secondary ${roleFilter == 'DELIVERY' ? 'active' : ''}">
                                Delivery
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Users Table -->
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Last Login</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge" style="background-color: ${user.role == 'ADMIN' ? '#dc3545' : user.role == 'DELIVERY' ? '#6f42c1' : '#28a745'}; color: white;">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty user.lastLogin}">
                                                <fmt:formatDate value="${user.lastLogin}" pattern="yyyy-MM-dd HH:mm" />
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Never</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" class="btn btn-sm btn-secondary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-danger" onclick="confirmDelete(${user.id}, '${user.username}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <c:if test="${empty users}">
                    <div class="alert alert-info" role="alert">
                        <i class="fas fa-info-circle"></i> No users found.
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete user <span id="deleteUserName"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users/delete" method="post">
                    <input type="hidden" id="deleteUserId" name="id">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(userId, username) {
        document.getElementById('deleteUserId').value = userId;
        document.getElementById('deleteUserName').textContent = username;
        
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
