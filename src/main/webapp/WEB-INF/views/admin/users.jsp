<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="custom" uri="http://foodexpress.com/functions" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin - User Management" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Include the admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-users.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<!-- Include the admin delete JS -->
<script src="${pageContext.request.contextPath}/js/admin-delete.js"></script>

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

        <!-- Alert Messages -->
        <c:if test="${param.error != null}">
            <div class="admin-alert admin-alert-danger animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                <i class="fas fa-exclamation-circle"></i>
                <c:choose>
                    <c:when test="${param.error eq 'delete-failed'}">
                        Failed to delete user. Please try again.
                    </c:when>
                    <c:when test="${param.error eq 'cannot-delete-self'}">
                        You cannot delete your own account.
                    </c:when>
                    <c:when test="${param.error eq 'user-has-orders'}">
                        Cannot delete user because they have orders in the system. Consider deactivating the account instead.
                    </c:when>
                    <c:when test="${param.error eq 'user-assigned-to-orders'}">
                        Cannot delete user because they are assigned as a delivery person to orders. Reassign the orders first.
                    </c:when>
                    <c:when test="${param.error eq 'missing-id'}">
                        User ID is missing.
                    </c:when>
                    <c:when test="${param.error eq 'invalid-id'}">
                        Invalid user ID.
                    </c:when>
                    <c:otherwise>
                        An error occurred. Please try again.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${param.success != null}">
            <div class="admin-alert admin-alert-success animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                <i class="fas fa-check-circle"></i>
                <c:choose>
                    <c:when test="${param.success eq 'deleted'}">
                        User has been successfully deleted.
                    </c:when>
                    <c:when test="${param.success eq 'created'}">
                        User has been successfully created.
                    </c:when>
                    <c:when test="${param.success eq 'updated'}">
                        User has been successfully updated.
                    </c:when>
                    <c:otherwise>
                        Operation completed successfully.
                    </c:otherwise>
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

                    <!-- Role Filter Tabs -->
                    <div class="admin-d-flex admin-align-center" style="gap: 10px; flex-wrap: wrap;">
                        <span style="color: var(--gray-color); font-size: 14px;">Filter by role:</span>
                        <div class="admin-tabs" style="border-bottom: none; margin-bottom: 0;">
                            <a href="${pageContext.request.contextPath}/admin/users" class="admin-tab ${empty roleFilter ? 'active' : ''}">
                                All
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=ADMIN" class="admin-tab ${roleFilter eq 'ADMIN' ? 'active' : ''}" style="${roleFilter eq 'ADMIN' ? 'color: var(--danger-color);' : ''}">
                                Admins
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=CUSTOMER" class="admin-tab ${roleFilter eq 'CUSTOMER' ? 'active' : ''}" style="${roleFilter eq 'CUSTOMER' ? 'color: var(--success-color);' : ''}">
                                Customers
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users?role=DELIVERY" class="admin-tab ${roleFilter eq 'DELIVERY' ? 'active' : ''}" style="${roleFilter eq 'DELIVERY' ? 'color: var(--purple-color);' : ''}">
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
                                                <c:when test="${not empty user.profilePicture && custom:fileExists(pageContext, user.profilePicture)}">
                                                    <img src="${pageContext.request.contextPath}/${user.profilePicture}" alt="${user.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                </c:when>
                                                <c:when test="${not empty user.profilePicture}">
                                                    <c:set var="profilePath" value="${user.profilePicture}" />
                                                    <c:if test="${fn:startsWith(profilePath, 'uploads/')}">
                                                        <img src="${pageContext.request.contextPath}/${profilePath}" alt="${user.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                    </c:if>
                                                    <c:if test="${!fn:startsWith(profilePath, 'uploads/')}">
                                                        <img src="${pageContext.request.contextPath}/uploads/profile/${profilePath}" alt="${user.username}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                    </c:if>
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
                                    <a href="javascript:void(0);" class="action-btn delete" onclick="confirmDelete(${user.id}, '${user.username}')" title="Delete User">
                                        <i class="fas fa-trash"></i>
                                    </a>
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
                <c:set var="validRoleFilter" value="${roleFilter eq 'ADMIN' || roleFilter eq 'CUSTOMER' || roleFilter eq 'DELIVERY' ? roleFilter : ''}" />

                <a href="${pageContext.request.contextPath}/admin/users?page=1${not empty validRoleFilter ? '&role='.concat(validRoleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="First Page"><i class="fas fa-angle-double-left"></i></a>
                <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage > 1 ? currentPage - 1 : 1}${not empty validRoleFilter ? '&role='.concat(validRoleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="Previous Page"><i class="fas fa-angle-left"></i></a>

                <c:forEach begin="${Math.max(1, currentPage - 2)}" end="${Math.min(totalPages, currentPage + 2)}" var="page">
                    <a href="${pageContext.request.contextPath}/admin/users?page=${page}${not empty validRoleFilter ? '&role='.concat(validRoleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item ${page == currentPage ? 'active' : ''}">${page}</a>
                </c:forEach>

                <a href="${pageContext.request.contextPath}/admin/users?page=${currentPage < totalPages ? currentPage + 1 : totalPages}${not empty validRoleFilter ? '&role='.concat(validRoleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="Next Page"><i class="fas fa-angle-right"></i></a>
                <a href="${pageContext.request.contextPath}/admin/users?page=${totalPages}${not empty validRoleFilter ? '&role='.concat(validRoleFilter) : ''}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}" class="admin-pagination-item" title="Last Page"><i class="fas fa-angle-double-right"></i></a>
            </div>
        </c:if>
    </div>
</div>

<!-- Delete Confirmation Modal Styles -->
<style>
    #deleteConfirmOverlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        display: none;
    }

    #deleteConfirmBox {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        width: 90%;
        max-width: 500px;
        z-index: 1001;
    }

    #deleteConfirmHeader {
        background-color: var(--danger-color);
        color: white;
        margin: -20px -20px 20px -20px;
        padding: 15px 20px;
        border-radius: 8px 8px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    #deleteConfirmHeader h3 {
        margin: 0;
        font-weight: 600;
    }

    #deleteConfirmClose {
        background: none;
        border: none;
        color: white;
        font-size: 24px;
        cursor: pointer;
    }

    #deleteConfirmBody {
        text-align: center;
        margin-bottom: 20px;
    }

    #deleteConfirmIcon {
        font-size: 48px;
        color: var(--warning-color);
        margin-bottom: 15px;
    }

    #deleteConfirmFooter {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
</style>

<!-- Simple Delete Confirmation Modal -->
<div id="deleteConfirmOverlay">
    <div id="deleteConfirmBox">
        <div id="deleteConfirmHeader">
            <h3>Confirm Delete</h3>
            <button id="deleteConfirmClose" onclick="hideDeleteConfirm()">&times;</button>
        </div>
        <div id="deleteConfirmBody">
            <div id="deleteConfirmIcon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <p>Are you sure you want to delete user <span id="deleteUserName" style="font-weight: bold;"></span>?</p>
            <p style="color: #666; margin-top: 10px;">This action cannot be undone.</p>
        </div>
        <div id="deleteConfirmFooter">
            <button class="admin-btn admin-btn-light" onclick="hideDeleteConfirm()">Cancel</button>
            <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users/delete" method="post" style="display: inline;">
                <input type="hidden" id="deleteUserId" name="id">
                <button type="submit" class="admin-btn admin-btn-danger">Delete User</button>
            </form>
        </div>
    </div>
</div>

<script>
    // Function to confirm delete
    function confirmDelete(userId, username) {
        console.log("confirmDelete called with userId: " + userId + ", username: " + username);
        document.getElementById('deleteUserId').value = userId;
        document.getElementById('deleteUserName').textContent = username;
        showDeleteConfirm();

        // Debug: Check if the value was set correctly
        console.log("deleteUserId value set to: " + document.getElementById('deleteUserId').value);
    }

    // Function to show delete confirmation
    function showDeleteConfirm() {
        document.getElementById('deleteConfirmOverlay').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    // Function to hide delete confirmation
    function hideDeleteConfirm() {
        document.getElementById('deleteConfirmOverlay').style.display = 'none';
        document.body.style.overflow = '';
    }

    // Close when clicking outside the modal
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('deleteConfirmOverlay').addEventListener('click', function(event) {
            if (event.target === this) {
                hideDeleteConfirm();
            }
        });

        // Add submit event listener to the delete form
        document.getElementById('deleteForm').addEventListener('submit', function(event) {
            console.log("Form submitted with user ID: " + document.getElementById('deleteUserId').value);
        });
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
