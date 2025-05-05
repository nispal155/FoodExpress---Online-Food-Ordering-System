<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin - User Management" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Include the admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-users.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp">
        <jsp:param name="activeMenu" value="users" />
    </jsp:include>

    <!-- Admin Content -->
    <div class="admin-content">
        <!-- User Management Header -->
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">User Management</h1>
                <div class="admin-breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    <i class="fas fa-chevron-right"></i>
                    <span>Users</span>
                </div>
            </div>
            <div class="admin-page-actions">
                <a href="${pageContext.request.contextPath}/admin/users/create" class="admin-btn admin-btn-primary animate__animated animate__fadeIn">
                    <i class="fas fa-plus"></i> Add New User
                </a>
            </div>
        </div>

        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="admin-alert admin-alert-success animate__animated animate__fadeIn">
                <i class="fas fa-check-circle"></i>
                <c:choose>
                    <c:when test="${param.success == 'created'}">User has been successfully created.</c:when>
                    <c:when test="${param.success == 'updated'}">User has been successfully updated.</c:when>
                    <c:when test="${param.success == 'deleted'}">User has been successfully deleted.</c:when>
                    <c:otherwise>Operation completed successfully.</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="admin-alert admin-alert-danger animate__animated animate__fadeIn">
                <i class="fas fa-exclamation-circle"></i>
                <c:choose>
                    <c:when test="${param.error == 'missing-id'}">User ID is missing.</c:when>
                    <c:when test="${param.error == 'invalid-id'}">Invalid user ID.</c:when>
                    <c:when test="${param.error == 'not-found'}">User not found.</c:when>
                    <c:when test="${param.error == 'delete-failed'}">Failed to delete user.</c:when>
                    <c:when test="${param.error == 'cannot-delete-self'}">You cannot delete your own account.</c:when>
                    <c:otherwise>An error occurred during the operation.</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Search and Filter Section -->
        <div class="admin-card animate__animated animate__fadeIn" style="margin-bottom: 20px;">
            <div class="admin-card-body">
                <div class="admin-d-flex admin-justify-between admin-flex-wrap" style="gap: 15px;">
                    <div style="flex: 1; min-width: 250px;">
                        <form action="${pageContext.request.contextPath}/admin/users" method="get" class="admin-d-flex">
                            <div class="admin-form-group admin-mb-0" style="flex: 1; position: relative;">
                                <input type="text" name="search" class="admin-form-input" placeholder="Search users by name, email or username..." value="${searchQuery}" style="padding-right: 40px;">
                                <button type="submit" style="position: absolute; right: 0; top: 0; height: 100%; width: 40px; background: none; border: none; color: var(--gray-color);">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="admin-d-flex admin-align-center" style="gap: 10px; flex-wrap: wrap;">
                        <span style="color: var(--gray-color); font-size: 14px;">Filter by role:</span>
                        <div class="admin-tabs" style="border-bottom: none; margin-bottom: 0;">
                            <a href="${pageContext.request.contextPath}/admin/users" class="admin-tab ${empty roleFilter ? 'active' : ''}">
                                All
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=ADMIN" class="admin-tab ${roleFilter == 'ADMIN' ? 'active' : ''}" style="${roleFilter == 'ADMIN' ? 'color: var(--danger-color);' : ''}">
                                Admins
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=CUSTOMER" class="admin-tab ${roleFilter == 'CUSTOMER' ? 'active' : ''}" style="${roleFilter == 'CUSTOMER' ? 'color: var(--success-color);' : ''}">
                                Customers
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=DELIVERY" class="admin-tab ${roleFilter == 'DELIVERY' ? 'active' : ''}" style="${roleFilter == 'DELIVERY' ? 'color: var(--purple-color);' : ''}">
                                Delivery
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Users Table -->
        <div class="admin-card animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
            <div class="admin-card-body">
                <table class="admin-table">
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
                                    <div class="admin-d-flex admin-align-center">
                                        <div style="width: 32px; height: 32px; border-radius: 50%; background-color: #f1f1f1; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
                                            <c:choose>
                                                <c:when test="${not empty user.profilePicture}">
                                                    <img src="${pageContext.request.contextPath}/uploads/profile/${user.profilePicture}" alt="${user.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-user" style="color: #999;"></i>
                                                </c:otherwise>
                                            </c:choose>
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
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}" class="action-btn edit" title="Edit User">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button type="button" class="action-btn delete" onclick="confirmDelete(${user.id}, '${user.username}')" title="Delete User">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

        <c:if test="${empty users}">
            <div class="admin-card animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                <div class="admin-card-body admin-text-center" style="padding: 50px 20px;">
                    <div style="font-size: 48px; color: #ddd; margin-bottom: 20px;">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 style="font-size: 20px; margin-bottom: 10px; color: var(--dark-color);">No Users Found</h3>
                    <p style="color: var(--gray-color); margin-bottom: 20px;">There are no users matching your search criteria.</p>
                    <a href="${pageContext.request.contextPath}/admin/users/create" class="admin-btn admin-btn-primary">
                        <i class="fas fa-plus"></i> Add New User
                    </a>
                </div>
            </div>
        </c:if>

        <!-- Pagination -->
        <c:if test="${not empty users && users.size() > 0}">
            <div class="admin-pagination animate__animated animate__fadeIn" style="animation-delay: 0.2s;">
                <a href="${pageContext.request.contextPath}/admin/users?page=1${not empty roleFilter ? '&role='.concat(roleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="First Page"><i class="fas fa-angle-double-left"></i></a>
                <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage > 1 ? currentPage - 1 : 1}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="Previous Page"><i class="fas fa-angle-left"></i></a>

                <c:forEach begin="${Math.max(1, currentPage - 2)}" end="${Math.min(totalPages, currentPage + 2)}" var="page">
                    <a href="${pageContext.request.contextPath}/admin/users?page=${page}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item ${page == currentPage ? 'active' : ''}">${page}</a>
                </c:forEach>

                <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage < totalPages ? currentPage + 1 : totalPages}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="Next Page"><i class="fas fa-angle-right"></i></a>
                <a href="${pageContext.request.contextPath}/admin/users?page=${totalPages}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="Last Page"><i class="fas fa-angle-double-right"></i></a>
            </div>
        </c:if>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: var(--border-radius); overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
            <div class="modal-header" style="background-color: var(--danger-color); color: white; border-bottom: none;">
                <h5 class="modal-title" id="deleteModalLabel" style="font-weight: 600;">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
            </div>
            <div class="modal-body" style="padding: 30px 20px;">
                <div style="text-align: center; margin-bottom: 20px;">
                    <div class="animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                        <i class="fas fa-exclamation-triangle" style="font-size: 48px; color: var(--warning-color); margin-bottom: 15px;"></i>
                    </div>
                    <p class="animate__animated animate__fadeIn" style="animation-delay: 0.2s; font-size: 16px; margin-bottom: 0;">Are you sure you want to delete user <span id="deleteUserName" style="font-weight: bold;"></span>?</p>
                    <p class="animate__animated animate__fadeIn" style="animation-delay: 0.3s; color: #666; margin-top: 10px;">This action cannot be undone.</p>
                </div>
            </div>
            <div class="modal-footer" style="border-top: none; padding: 0 20px 20px;">
                <button type="button" class="admin-btn admin-btn-light" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users/delete" method="post">
                    <input type="hidden" id="deleteUserId" name="id">
                    <button type="submit" class="admin-btn admin-btn-danger">Delete User</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Wait for the DOM to be fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize the delete modal
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));

        // Function to confirm delete
        window.confirmDelete = function(userId, username) {
            document.getElementById('deleteUserId').value = userId;
            document.getElementById('deleteUserName').textContent = username;
            deleteModal.show();
        };

        // Add event listener to delete form
        document.getElementById('deleteForm').addEventListener('submit', function(e) {
            e.preventDefault();
            var userId = document.getElementById('deleteUserId').value;

            // Submit the form using fetch API
            fetch('${pageContext.request.contextPath}/admin/users/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'id=' + userId
            })
            .then(response => {
                if (response.ok) {
                    // Hide the modal
                    deleteModal.hide();
                    // Reload the page to show the updated user list
                    window.location.href = '${pageContext.request.contextPath}/admin/users?success=deleted';
                } else {
                    throw new Error('Failed to delete user');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to delete user. Please try again.');
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
