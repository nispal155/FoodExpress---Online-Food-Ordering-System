<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - ${pageTitle}" />
</jsp:include>

<!-- Include the admin dashboard CSS and users CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-users.css">

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
                    <i class="fas fa-hamburger"></i> Menu Items
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
        <!-- User Management Header -->
        <div class="user-management-header">
            <h1>User Management</h1>
            <a href="${pageContext.request.contextPath}/admin/users/create" class="add-user-button">
                <i class="fas fa-plus"></i> Add New User
            </a>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/admin/users" method="get" style="display: flex; width: 100%;">
                    <div style="display: flex; width: 100%;">
                        <input type="text" name="search" class="search-input" placeholder="Search users by name, email or username..." value="${searchQuery}">
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

            <div class="filter-box">
                <span class="filter-label">Filter by role:</span>
                <a href="${pageContext.request.contextPath}/admin/users" class="filter-button ${empty roleFilter ? 'active' : ''}" style="${empty roleFilter ? 'background-color: var(--secondary-color); color: white;' : ''}">
                    All
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?role=ADMIN" class="filter-button ${roleFilter == 'ADMIN' ? 'active' : ''}" style="${roleFilter == 'ADMIN' ? 'background-color: var(--danger-color); color: white; border-color: var(--danger-color);' : ''}">
                    Admins
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?role=CUSTOMER" class="filter-button ${roleFilter == 'CUSTOMER' ? 'active' : ''}" style="${roleFilter == 'CUSTOMER' ? 'background-color: var(--success-color); color: white; border-color: var(--success-color);' : ''}">
                    Customers
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?role=DELIVERY" class="filter-button ${roleFilter == 'DELIVERY' ? 'active' : ''}" style="${roleFilter == 'DELIVERY' ? 'background-color: var(--purple-color); color: white; border-color: var(--purple-color);' : ''}">
                    Delivery
                </a>
            </div>
        </div>

        <!-- Users Table -->
        <div class="users-table-container">
            <table class="users-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Last Login</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>
                                <div style="display: flex; align-items: center;">
                                    <div style="width: 32px; height: 32px; border-radius: 50%; background-color: #f1f1f1; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
                                        <i class="fas fa-user" style="color: #999;"></i>
                                    </div>
                                    ${user.fullName}
                                </div>
                            </td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>
                                <span class="role-badge ${user.role == 'ADMIN' ? 'role-admin' : user.role == 'DELIVERY' ? 'role-delivery' : 'role-customer'}">
                                    ${user.role}
                                </span>
                            </td>
                            <td>
                                <div class="user-status">
                                    <div class="status-indicator ${user.active ? 'status-active' : 'status-inactive'}"></div>
                                    ${user.active ? 'Active' : 'Inactive'}
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty user.lastLogin}">
                                        <fmt:formatDate value="${user.lastLogin}" pattern="yyyy-MM-dd HH:mm" />
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #999;">Never</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="user-actions">
                                    <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" class="edit-button" title="Edit User">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button type="button" class="delete-button" onclick="confirmDelete(${user.id}, '${user.username}')" title="Delete User">
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
            <div class="empty-state">
                <i class="fas fa-users"></i>
                <h3>No Users Found</h3>
                <p>There are no users matching your search criteria.</p>
                <a href="${pageContext.request.contextPath}/admin/users/create" class="add-user-button">
                    <i class="fas fa-plus"></i> Add New User
                </a>
            </div>
        </c:if>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" class="pagination-button"><i class="fas fa-angle-double-left"></i></a>
            <a href="#" class="pagination-button"><i class="fas fa-angle-left"></i></a>
            <a href="#" class="pagination-button active">1</a>
            <a href="#" class="pagination-button">2</a>
            <a href="#" class="pagination-button">3</a>
            <a href="#" class="pagination-button"><i class="fas fa-angle-right"></i></a>
            <a href="#" class="pagination-button"><i class="fas fa-angle-double-right"></i></a>
        </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 8px; overflow: hidden;">
            <div class="modal-header" style="background-color: var(--danger-color); color: white; border-bottom: none;">
                <h5 class="modal-title" id="deleteModalLabel" style="font-weight: 600;">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
            </div>
            <div class="modal-body" style="padding: 20px;">
                <div style="text-align: center; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 48px; color: var(--warning-color); margin-bottom: 15px;"></i>
                    <p style="font-size: 16px; margin-bottom: 0;">Are you sure you want to delete user <span id="deleteUserName" style="font-weight: bold;"></span>?</p>
                    <p style="color: #666; margin-top: 10px;">This action cannot be undone.</p>
                </div>
            </div>
            <div class="modal-footer" style="border-top: none; padding: 0 20px 20px;">
                <button type="button" class="filter-button" data-bs-dismiss="modal" style="padding: 8px 16px;">Cancel</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users/delete" method="post">
                    <input type="hidden" id="deleteUserId" name="id">
                    <button type="submit" class="delete-button" style="width: auto; padding: 8px 16px; border-radius: 4px;">Delete User</button>
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
