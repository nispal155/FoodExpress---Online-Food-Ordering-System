<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Menu Items" />
</jsp:include>

<!-- Include the admin menu items CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-menu-items.css">

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
                <a href="${pageContext.request.contextPath}/admin/restaurants">
                    <i class="fas fa-utensils"></i> Restaurants
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/menu-items" class="active">
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
                        <i class="fas fa-check-circle"></i> Menu item created successfully!
                    </c:when>
                    <c:when test="${param.success == 'update'}">
                        <i class="fas fa-check-circle"></i> Menu item updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'delete'}">
                        <i class="fas fa-check-circle"></i> Menu item deleted successfully!
                    </c:when>
                    <c:when test="${param.success == 'toggle_available'}">
                        <i class="fas fa-check-circle"></i> Menu item availability updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'toggle_special'}">
                        <i class="fas fa-check-circle"></i> Menu item special status updated successfully!
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
                    <c:when test="${param.error == 'not_found'}">
                        <i class="fas fa-exclamation-circle"></i> Menu item not found!
                    </c:when>
                    <c:when test="${param.error == 'delete'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to delete menu item!
                    </c:when>
                    <c:when test="${param.error == 'toggle_available'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update menu item availability!
                    </c:when>
                    <c:when test="${param.error == 'toggle_special'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update menu item special status!
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

        <!-- Menu Items Management Header -->
        <div class="menu-items-management-header">
            <h1>${pageTitle}</h1>
            <div>
                <c:if test="${not empty selectedRestaurant}">
                    <a href="${pageContext.request.contextPath}/admin/menu-items/form?restaurantId=${selectedRestaurant.id}" class="add-menu-item-button">
                        <i class="fas fa-plus"></i> Add Menu Item
                    </a>
                </c:if>
                <c:if test="${empty selectedRestaurant}">
                    <a href="${pageContext.request.contextPath}/admin/menu-items/form" class="add-menu-item-button">
                        <i class="fas fa-plus"></i> Add Menu Item
                    </a>
                </c:if>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <form action="${pageContext.request.contextPath}/admin/menu-items" method="get" class="filter-form">
                <div class="filter-group">
                    <label for="restaurantFilter" class="filter-label">Filter by Restaurant</label>
                    <select class="filter-select" id="restaurantFilter" name="restaurantId">
                        <option value="">All Restaurants</option>
                        <c:forEach var="restaurant" items="${restaurants}">
                            <option value="${restaurant.id}" ${selectedRestaurant != null && selectedRestaurant.id == restaurant.id ? 'selected' : ''}>
                                ${restaurant.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="categoryFilter" class="filter-label">Filter by Category</label>
                    <select class="filter-select" id="categoryFilter" name="categoryId">
                        <option value="">All Categories</option>
                        <option value="1" ${param.categoryId == '1' ? 'selected' : ''}>Pizza</option>
                        <option value="2" ${param.categoryId == '2' ? 'selected' : ''}>Pasta</option>
                        <option value="3" ${param.categoryId == '3' ? 'selected' : ''}>Burger</option>
                        <option value="4" ${param.categoryId == '4' ? 'selected' : ''}>Dessert</option>
                        <option value="5" ${param.categoryId == '5' ? 'selected' : ''}>Beverage</option>
                    </select>
                </div>

                <div class="search-box">
                    <label for="searchInput" class="filter-label">Search Menu Items</label>
                    <div class="search-input-container">
                        <input type="text" id="searchInput" name="search" class="search-input" placeholder="Search by name or description..." value="${param.search}">
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>

                <div class="filter-group" style="flex: 0 0 auto;">
                    <button type="submit" class="filter-button">Apply Filters</button>
                </div>

                <c:if test="${not empty selectedRestaurant || not empty param.categoryId || not empty param.search}">
                    <div class="filter-group" style="flex: 0 0 auto;">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" class="clear-filter-button">Clear Filters</a>
                    </div>
                </c:if>
            </form>
        </div>

        <!-- Menu Items Table -->
        <div class="menu-items-table-container">
            <table class="menu-items-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Restaurant</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Special</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="menuItem" items="${menuItems}">
                        <tr>
                            <td>${menuItem.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty menuItem.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/${menuItem.imageUrl}" alt="${menuItem.name}" class="menu-item-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="menu-item-image-placeholder">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong>${menuItem.name}</strong></td>
                            <td>${menuItem.restaurantName}</td>
                            <td>${menuItem.categoryName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${menuItem.special && menuItem.discountPrice != null}">
                                        <div class="menu-item-price">
                                            <span class="regular-price">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                            <span class="discount-price">$<fmt:formatNumber value="${menuItem.discountPrice}" pattern="#,##0.00" /></span>
                                            <span class="discount-badge">-${menuItem.discountPercentage}%</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="menu-item-price">
                                            <span class="discount-price">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="status-badge ${menuItem.available ? 'status-available' : 'status-unavailable'}">
                                    ${menuItem.available ? 'Available' : 'Unavailable'}
                                </span>
                            </td>
                            <td>
                                <span class="status-badge ${menuItem.special ? 'status-special' : 'status-regular'}">
                                    ${menuItem.special ? 'Special' : 'Regular'}
                                </span>
                            </td>
                            <td>
                                <div class="menu-item-actions">
                                    <a href="${pageContext.request.contextPath}/admin/menu-items/form?id=${menuItem.id}" class="action-button edit-button" title="Edit Menu Item">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button type="button" class="action-button delete-button" title="Delete Menu Item" onclick="confirmDelete(${menuItem.id}, '${menuItem.name}')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                    <div class="dropdown">
                                        <button class="action-button settings-button" type="button" id="dropdownMenuButton${menuItem.id}" data-bs-toggle="dropdown" aria-expanded="false" title="More Actions">
                                            <i class="fas fa-cog"></i>
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton${menuItem.id}">
                                            <c:choose>
                                                <c:when test="${menuItem.available}">
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="toggleAvailable(${menuItem.id}, false)">
                                                            <i class="fas fa-times-circle text-danger"></i> Mark as Unavailable
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="toggleAvailable(${menuItem.id}, true)">
                                                            <i class="fas fa-check-circle text-success"></i> Mark as Available
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${menuItem.special}">
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="toggleSpecial(${menuItem.id}, false)">
                                                            <i class="fas fa-star text-warning"></i> Remove Special Status
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="markAsSpecial(${menuItem.id}, ${menuItem.price})">
                                                            <i class="fas fa-star text-warning"></i> Mark as Special
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty menuItems}">
                <div class="empty-state">
                    <i class="fas fa-hamburger"></i>
                    <h3>No Menu Items Found</h3>
                    <p>There are no menu items matching your search criteria.</p>
                    <c:if test="${not empty selectedRestaurant}">
                        <a href="${pageContext.request.contextPath}/admin/menu-items/form?restaurantId=${selectedRestaurant.id}" class="add-menu-item-button">
                            <i class="fas fa-plus"></i> Add Menu Item
                        </a>
                    </c:if>
                    <c:if test="${empty selectedRestaurant}">
                        <a href="${pageContext.request.contextPath}/admin/menu-items/form" class="add-menu-item-button">
                            <i class="fas fa-plus"></i> Add Menu Item
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>
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
                Are you sure you want to delete the menu item "<span id="menuItemName"></span>"?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="deleteLink" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- Special Discount Modal -->
<div class="modal fade" id="specialModal" tabindex="-1" aria-labelledby="specialModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 8px; overflow: hidden;">
            <div class="modal-header special-modal-header">
                <h5 class="modal-title" id="specialModalLabel" style="font-weight: 600;">Set Special Price</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="specialForm" action="${pageContext.request.contextPath}/admin/menu-items/toggle" method="get">
                <div class="modal-body special-modal-body">
                    <input type="hidden" id="specialMenuItemId" name="id">
                    <input type="hidden" name="action" value="special">
                    <input type="hidden" name="value" value="true">

                    <div class="form-group">
                        <label for="regularPrice" class="form-label">Regular Price</label>
                        <input type="text" class="form-control" id="regularPrice" readonly>
                    </div>

                    <div class="form-group">
                        <label for="discountPrice" class="form-label">Special Price</label>
                        <input type="number" class="form-control" id="discountPrice" name="discountPrice" step="0.01" min="0.01" required>
                        <div class="form-text">Enter the special discounted price (must be less than the regular price).</div>
                    </div>

                    <div class="form-group">
                        <label for="discountPercentage" class="form-label">Discount Percentage</label>
                        <input type="text" class="form-control" id="discountPercentage" readonly>
                    </div>
                </div>
                <div class="modal-footer special-modal-footer">
                    <button type="button" class="cancel-button" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="save-button">Save Special Price</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Toggle menu item availability
    function toggleAvailable(id, isAvailable) {
        document.getElementById('toggleAvailableId').value = id;
        document.getElementById('toggleAvailableValue').value = isAvailable;
        document.getElementById('toggleAvailableForm').submit();
    }

    // Toggle menu item special status
    function toggleSpecial(id, isSpecial) {
        document.getElementById('toggleSpecialId').value = id;
        document.getElementById('toggleSpecialValue').value = isSpecial;
        document.getElementById('toggleSpecialForm').submit();
    }

    // Confirm delete menu item
    function confirmDelete(id, name) {
        document.getElementById('deleteId').value = id;
        document.getElementById('deleteMenuItemName').textContent = name;

        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    // Submit delete form
    function deleteMenuItem() {
        document.getElementById('deleteForm').submit();
    }

    // Function to mark as special
    function markAsSpecial(id, price) {
        document.getElementById('specialMenuItemId').value = id;
        document.getElementById('regularPrice').value = '$' + price.toFixed(2);
        document.getElementById('discountPrice').value = '';
        document.getElementById('discountPercentage').value = '';

        // Calculate discount percentage on input change
        document.getElementById('discountPrice').addEventListener('input', function() {
            var regularPrice = price;
            var discountPrice = parseFloat(this.value);

            if (!isNaN(discountPrice) && discountPrice > 0 && discountPrice < regularPrice) {
                var discountPercentage = ((regularPrice - discountPrice) / regularPrice) * 100;
                document.getElementById('discountPercentage').value = discountPercentage.toFixed(2) + '%';
            } else {
                document.getElementById('discountPercentage').value = '';
            }
        });

        var specialModal = new bootstrap.Modal(document.getElementById('specialModal'));
        specialModal.show();
    }
</script>

<!-- Toggle Available Form -->
<form id="toggleAvailableForm" action="${pageContext.request.contextPath}/admin/menu-items" method="post" style="display: none;">
    <input type="hidden" name="action" value="toggle_available">
    <input type="hidden" name="id" id="toggleAvailableId">
    <input type="hidden" name="isAvailable" id="toggleAvailableValue">
</form>

<!-- Toggle Special Form -->
<form id="toggleSpecialForm" action="${pageContext.request.contextPath}/admin/menu-items" method="post" style="display: none;">
    <input type="hidden" name="action" value="toggle_special">
    <input type="hidden" name="id" id="toggleSpecialId">
    <input type="hidden" name="isSpecial" id="toggleSpecialValue">
</form>

<!-- Delete Form -->
<form id="deleteForm" action="${pageContext.request.contextPath}/admin/menu-items" method="post" style="display: none;">
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
                    <p style="font-size: 16px; margin-bottom: 0;">Are you sure you want to delete menu item <span id="deleteMenuItemName" class="delete-modal-menu-item-name"></span>?</p>
                    <p class="delete-modal-warning">This action cannot be undone.</p>
                </div>
            </div>
            <div class="modal-footer delete-modal-footer">
                <button type="button" class="cancel-button" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="confirm-delete-button" onclick="deleteMenuItem()">Delete Menu Item</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
