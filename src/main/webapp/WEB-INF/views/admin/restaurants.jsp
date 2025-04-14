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
                        <a href="${pageContext.request.contextPath}/admin/users" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-users"></i> Users
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/restaurants" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-utensils"></i> Restaurants
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-hamburger"></i> Menu Items
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/reporting" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-chart-bar"></i> Reports
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
        
        <div class="card">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">Restaurants</h2>
                <a href="${pageContext.request.contextPath}/admin/restaurants/form" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Restaurant
                </a>
            </div>
            <div style="padding: 1rem;">
                <div class="table-responsive">
                    <table class="table table-striped">
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
                                                <div style="width: 50px; height: 50px; background-color: #f0f0f0; display: flex; align-items: center; justify-content: center; border-radius: 5px;">
                                                    <i class="fas fa-utensils" style="color: #aaa;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${restaurant.name}</td>
                                    <td>${restaurant.address}</td>
                                    <td>
                                        <div style="display: flex; align-items: center;">
                                            <span style="margin-right: 0.5rem;">${restaurant.rating}</span>
                                            <div style="color: var(--warning-color);">
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
                                        <span class="badge ${restaurant.active ? 'bg-success' : 'bg-danger'}">
                                            ${restaurant.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/restaurants/form?id=${restaurant.id}" class="btn btn-sm btn-primary" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/menu-items?restaurantId=${restaurant.id}" class="btn btn-sm btn-info" title="Menu Items">
                                                <i class="fas fa-hamburger"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm ${restaurant.active ? 'btn-warning' : 'btn-success'}" 
                                                    onclick="toggleActive(${restaurant.id}, ${!restaurant.active})" 
                                                    title="${restaurant.active ? 'Deactivate' : 'Activate'}">
                                                <i class="fas ${restaurant.active ? 'fa-ban' : 'fa-check'}"></i>
                                            </button>
                                            <button type="button" class="btn btn-sm btn-danger" 
                                                    onclick="confirmDelete(${restaurant.id}, '${restaurant.name}')" 
                                                    title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty restaurants}">
                                <tr>
                                    <td colspan="7" style="text-align: center;">No restaurants found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
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
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the restaurant "<span id="deleteRestaurantName"></span>"?</p>
                <p class="text-danger">This action cannot be undone!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="deleteRestaurant()">Delete</button>
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
