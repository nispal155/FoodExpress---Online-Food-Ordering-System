<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin - Restaurant Management" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Include the admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-restaurants.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp">
        <jsp:param name="activeMenu" value="restaurants" />
    </jsp:include>

    <!-- Admin Content -->
    <div class="admin-content">
        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="admin-alert admin-alert-success animate__animated animate__fadeIn">
                <i class="fas fa-check-circle"></i>
                <c:choose>
                    <c:when test="${param.success == 'create'}">
                        Restaurant created successfully!
                    </c:when>
                    <c:when test="${param.success == 'update'}">
                        Restaurant updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'delete'}">
                        Restaurant deleted successfully!
                    </c:when>
                    <c:when test="${param.success == 'toggle_active'}">
                        Restaurant status updated successfully!
                    </c:when>
                    <c:otherwise>
                        Operation completed successfully!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="admin-alert admin-alert-danger animate__animated animate__fadeIn">
                <i class="fas fa-exclamation-circle"></i>
                <c:choose>
                    <c:when test="${param.error == 'create'}">
                        Failed to create restaurant!
                    </c:when>
                    <c:when test="${param.error == 'update'}">
                        Failed to update restaurant!
                    </c:when>
                    <c:when test="${param.error == 'delete'}">
                        Failed to delete restaurant!
                    </c:when>
                    <c:when test="${param.error == 'toggle_active'}">
                        Failed to update restaurant status!
                    </c:when>
                    <c:when test="${param.error == 'not_found'}">
                        Restaurant not found!
                    </c:when>
                    <c:when test="${param.error == 'invalid_id'}">
                        Invalid restaurant ID!
                    </c:when>
                    <c:when test="${param.error == 'invalid_action'}">
                        Invalid action!
                    </c:when>
                    <c:otherwise>
                        An error occurred!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Restaurant Management Header -->
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Restaurant Management</h1>
                <div class="admin-breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    <i class="fas fa-chevron-right"></i>
                    <span>Restaurants</span>
                </div>
            </div>
            <div class="admin-page-actions">
                <a href="${pageContext.request.contextPath}/admin/restaurants/form" class="admin-btn admin-btn-primary animate__animated animate__fadeIn">
                    <i class="fas fa-plus"></i> Add Restaurant
                </a>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="admin-card animate__animated animate__fadeIn" style="margin-bottom: 20px;">
            <div class="admin-card-body">
                <div class="admin-d-flex admin-justify-between admin-flex-wrap" style="gap: 15px;">
                    <div style="flex: 1; min-width: 250px;">
                        <form action="${pageContext.request.contextPath}/admin/restaurants" method="get" class="admin-d-flex">
                            <div class="admin-form-group admin-mb-0" style="flex: 1; position: relative;">
                                <input type="text" name="search" class="admin-form-input" placeholder="Search restaurants by name or address..." value="${param.search}" style="padding-right: 40px;">
                                <button type="submit" style="position: absolute; right: 0; top: 0; height: 100%; width: 40px; background: none; border: none; color: var(--gray-color);">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Restaurants Table -->
        <div class="admin-card animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
            <div class="admin-card-body">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Rating</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="restaurant" items="${restaurants}">
                            <tr>
                                <td>${restaurant.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty restaurant.imageUrl}">
                                            <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width: 50px; height: 50px; background-color: #f1f1f1; display: flex; align-items: center; justify-content: center; border-radius: 5px;">
                                                <i class="fas fa-utensils" style="color: #999;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><strong>${restaurant.name}</strong></td>
                                <td>${restaurant.address}</td>
                                <td>
                                    <div style="display: flex; align-items: center;">
                                        <span style="margin-right: 8px; font-weight: 600;">${restaurant.rating}</span>
                                        <div style="color: #FFC107;">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${restaurant.rating >= i}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:when test="${restaurant.rating >= i - 0.5}">
                                                        <i class="fas fa-star-half-alt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="status-badge ${restaurant.active ? 'status-active' : 'status-inactive'}">
                                        ${restaurant.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/restaurants/form?id=${restaurant.id}" class="action-btn edit" title="Edit Restaurant">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/menu-items?restaurantId=${restaurant.id}" class="action-btn menu" title="Manage Menu Items">
                                        <i class="fas fa-hamburger"></i>
                                    </a>
                                    <button type="button" class="action-btn ${restaurant.active ? 'deactivate' : 'activate'}" onclick="toggleActive(${restaurant.id}, ${!restaurant.active})" title="${restaurant.active ? 'Deactivate' : 'Activate'} Restaurant">
                                        <i class="fas ${restaurant.active ? 'fa-ban' : 'fa-check'}"></i>
                                    </button>
                                    <button type="button" class="action-btn delete" onclick="confirmDelete(${restaurant.id}, '${restaurant.name}')" title="Delete Restaurant">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>

        <c:if test="${empty restaurants}">
            <div class="admin-card animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                <div class="admin-card-body admin-text-center" style="padding: 50px 20px;">
                    <div style="font-size: 48px; color: #ddd; margin-bottom: 20px;">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <h3 style="font-size: 20px; margin-bottom: 10px; color: var(--dark-color);">No Restaurants Found</h3>
                    <p style="color: var(--gray-color); margin-bottom: 20px;">There are no restaurants matching your search criteria.</p>
                    <a href="${pageContext.request.contextPath}/admin/restaurants/form" class="admin-btn admin-btn-primary">
                        <i class="fas fa-plus"></i> Add New Restaurant
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Toggle Active Form -->
<form id="toggleActiveForm" action="${pageContext.request.contextPath}/admin/restaurants" method="post" style="display: none;">
    <input type="hidden" name="action" value="toggle_active">
    <input type="hidden" name="id" id="toggleActiveId">
    <input type="hidden" name="isActive" id="toggleActiveValue">
</form>

<!-- Delete Form -->
<form id="deleteForm" action="${pageContext.request.contextPath}/admin/restaurants" method="post" style="display: none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" id="deleteId">
</form>

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
                    <p class="animate__animated animate__fadeIn" style="animation-delay: 0.2s; font-size: 16px; margin-bottom: 0;">Are you sure you want to delete restaurant <span id="deleteRestaurantName" style="font-weight: bold;"></span>?</p>
                    <p class="animate__animated animate__fadeIn" style="animation-delay: 0.3s; color: #666; margin-top: 10px;">This action cannot be undone.</p>
                </div>
            </div>
            <div class="modal-footer" style="border-top: none; padding: 0 20px 20px;">
                <button type="button" class="admin-btn admin-btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="admin-btn admin-btn-danger" onclick="deleteRestaurant()">Delete Restaurant</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Toggle restaurant active status
    function toggleActive(id, isActive) {
        document.getElementById('toggleActiveId').value = id;
        document.getElementById('toggleActiveValue').value = isActive;
        document.getElementById('toggleActiveForm').submit();
    }

    // Show delete confirmation modal
    function confirmDelete(id, name) {
        document.getElementById('deleteId').value = id;
        document.getElementById('deleteRestaurantName').textContent = name;

        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    // Submit delete form
    function deleteRestaurant() {
        document.getElementById('deleteForm').submit();
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
