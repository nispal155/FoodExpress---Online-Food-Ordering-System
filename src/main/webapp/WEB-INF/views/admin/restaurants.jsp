<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - ${pageTitle}" />
</jsp:include>

<!-- Include the admin restaurants CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-restaurants.css">

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
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Users
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/restaurants" class="active">
                    <i class="fas fa-utensils"></i> Restaurants
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
        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert">
                <c:choose>
                    <c:when test="${param.success == 'create'}">
                        <i class="fas fa-check-circle"></i> Restaurant created successfully!
                    </c:when>
                    <c:when test="${param.success == 'update'}">
                        <i class="fas fa-check-circle"></i> Restaurant updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'delete'}">
                        <i class="fas fa-check-circle"></i> Restaurant deleted successfully!
                    </c:when>
                    <c:when test="${param.success == 'toggle_active'}">
                        <i class="fas fa-check-circle"></i> Restaurant status updated successfully!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-check-circle"></i> Operation completed successfully!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                <c:choose>
                    <c:when test="${param.error == 'create'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to create restaurant!
                    </c:when>
                    <c:when test="${param.error == 'update'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update restaurant!
                    </c:when>
                    <c:when test="${param.error == 'delete'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to delete restaurant!
                    </c:when>
                    <c:when test="${param.error == 'toggle_active'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update restaurant status!
                    </c:when>
                    <c:when test="${param.error == 'not_found'}">
                        <i class="fas fa-exclamation-circle"></i> Restaurant not found!
                    </c:when>
                    <c:when test="${param.error == 'invalid_id'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid restaurant ID!
                    </c:when>
                    <c:when test="${param.error == 'invalid_action'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid action!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-exclamation-circle"></i> An error occurred!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Restaurant Management Header -->
        <div class="restaurant-management-header">
            <h1>Restaurant Management</h1>
            <a href="${pageContext.request.contextPath}/admin/restaurants/form" class="add-restaurant-button">
                <i class="fas fa-plus"></i> Add Restaurant
            </a>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/admin/restaurants" method="get" style="display: flex; width: 100%;">
                    <div style="display: flex; width: 100%;">
                        <input type="text" name="search" class="search-input" placeholder="Search restaurants by name or address..." value="${param.search}">
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Restaurants Table -->
        <div class="restaurants-table-container">
                    <table class="restaurants-table">
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
                                                <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}" class="restaurant-image">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="restaurant-image-placeholder">
                                                    <i class="fas fa-utensils"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${restaurant.name}</strong></td>
                                    <td>${restaurant.address}</td>
                                    <td>
                                        <div class="restaurant-rating">
                                            <span class="rating-value">${restaurant.rating}</span>
                                            <div class="rating-stars">
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
                                    <td>
                                        <div class="restaurant-actions">
                                            <a href="${pageContext.request.contextPath}/admin/restaurants/form?id=${restaurant.id}" class="action-button edit-button" title="Edit Restaurant">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/menu-items?restaurantId=${restaurant.id}" class="action-button menu-button" title="Manage Menu Items">
                                                <i class="fas fa-hamburger"></i>
                                            </a>
                                            <button type="button" class="action-button toggle-button ${!restaurant.active ? 'activate' : ''}"
                                                    onclick="toggleActive(${restaurant.id}, ${!restaurant.active})"
                                                    title="${restaurant.active ? 'Deactivate' : 'Activate'} Restaurant">
                                                <i class="fas ${restaurant.active ? 'fa-ban' : 'fa-check'}"></i>
                                            </button>
                                            <button type="button" class="action-button delete-button"
                                                    onclick="confirmDelete(${restaurant.id}, '${restaurant.name}')"
                                                    title="Delete Restaurant">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <c:if test="${empty restaurants}">
                        <div class="empty-state">
                            <i class="fas fa-utensils"></i>
                            <h3>No Restaurants Found</h3>
                            <p>There are no restaurants matching your search criteria.</p>
                            <a href="${pageContext.request.contextPath}/admin/restaurants/form" class="add-restaurant-button">
                                <i class="fas fa-plus"></i> Add New Restaurant
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
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
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 8px; overflow: hidden;">
            <div class="modal-header delete-modal-header">
                <h5 class="modal-title" id="deleteModalLabel" style="font-weight: 600;">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
            </div>
            <div class="modal-body delete-modal-body">
                <div style="text-align: center; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-triangle delete-modal-icon"></i>
                    <p style="font-size: 16px; margin-bottom: 0;">Are you sure you want to delete restaurant <span id="deleteRestaurantName" class="delete-modal-restaurant-name"></span>?</p>
                    <p class="delete-modal-warning">This action cannot be undone.</p>
                </div>
            </div>
            <div class="modal-footer delete-modal-footer">
                <button type="button" class="cancel-button" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="confirm-delete-button" onclick="deleteRestaurant()">Delete Restaurant</button>
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
