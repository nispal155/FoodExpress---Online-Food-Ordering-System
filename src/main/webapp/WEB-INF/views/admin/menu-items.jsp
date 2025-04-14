<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Menu Items" />
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
                        <a href="${pageContext.request.contextPath}/admin/restaurants" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-utensils"></i> Restaurants
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-hamburger"></i> Menu Items
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-shopping-cart"></i> Orders
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

        <div class="card">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">${pageTitle}</h2>
                <div>
                    <c:if test="${not empty selectedRestaurant}">
                        <a href="${pageContext.request.contextPath}/admin/menu-items/form?restaurantId=${selectedRestaurant.id}" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Menu Item
                        </a>
                    </c:if>
                    <c:if test="${empty selectedRestaurant}">
                        <a href="${pageContext.request.contextPath}/admin/menu-items/form" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Menu Item
                        </a>
                    </c:if>
                </div>
            </div>
            <div style="padding: 1rem;">
                <!-- Restaurant Filter -->
                <div class="mb-4">
                    <form action="${pageContext.request.contextPath}/admin/menu-items" method="get" class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="restaurantFilter" class="form-label">Filter by Restaurant</label>
                            <select class="form-select" id="restaurantFilter" name="restaurantId">
                                <option value="">All Restaurants</option>
                                <c:forEach var="restaurant" items="${restaurants}">
                                    <option value="${restaurant.id}" ${selectedRestaurant != null && selectedRestaurant.id == restaurant.id ? 'selected' : ''}>
                                        ${restaurant.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Apply Filter</button>
                        </div>
                        <c:if test="${not empty selectedRestaurant}">
                            <div class="col-md-2">
                                <a href="${pageContext.request.contextPath}/admin/menu-items" class="btn btn-outline-secondary w-100">Clear Filter</a>
                            </div>
                        </c:if>
                    </form>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped">
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
                                                <img src="${pageContext.request.contextPath}/${menuItem.imageUrl}" alt="${menuItem.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width: 50px; height: 50px; background-color: #f0f0f0; border-radius: 5px; display: flex; align-items: center; justify-content: center;">
                                                    <i class="fas fa-image" style="color: #aaa;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${menuItem.name}</td>
                                    <td>${menuItem.restaurantName}</td>
                                    <td>${menuItem.categoryName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${menuItem.special && menuItem.discountPrice != null}">
                                                <span style="text-decoration: line-through; color: var(--dark-gray);">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                                <span style="color: var(--primary-color); font-weight: bold;">$<fmt:formatNumber value="${menuItem.discountPrice}" pattern="#,##0.00" /></span>
                                                <span style="background-color: var(--primary-color); color: white; padding: 0.1rem 0.3rem; border-radius: 3px; font-size: 0.8rem; margin-left: 0.3rem;">-${menuItem.discountPercentage}%</span>
                                            </c:when>
                                            <c:otherwise>
                                                $<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${menuItem.available}">
                                                <span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Available</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="background-color: rgba(244, 67, 54, 0.1); color: var(--danger-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Unavailable</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${menuItem.special}">
                                                <span style="background-color: rgba(255, 193, 7, 0.1); color: var(--warning-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Special</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="background-color: rgba(158, 158, 158, 0.1); color: var(--dark-gray); padding: 0.25rem 0.5rem; border-radius: 4px;">Regular</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/admin/menu-items/form?id=${menuItem.id}" class="btn btn-sm btn-secondary" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-danger" title="Delete" onclick="confirmDelete(${menuItem.id}, '${menuItem.name}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton${menuItem.id}" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-cog"></i>
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton${menuItem.id}">
                                                    <c:choose>
                                                        <c:when test="${menuItem.available}">
                                                            <li>
                                                                <a class="dropdown-item" href="#" onclick="toggleAvailable(${menuItem.id}, false)">
                                                                    <i class="fas fa-times-circle"></i> Mark as Unavailable
                                                                </a>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>
                                                                <a class="dropdown-item" href="#" onclick="toggleAvailable(${menuItem.id}, true)">
                                                                    <i class="fas fa-check-circle"></i> Mark as Available
                                                                </a>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${menuItem.special}">
                                                            <li>
                                                                <a class="dropdown-item" href="#" onclick="toggleSpecial(${menuItem.id}, false)">
                                                                    <i class="fas fa-star"></i> Remove Special Status
                                                                </a>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>
                                                                <a class="dropdown-item" href="#" onclick="markAsSpecial(${menuItem.id}, ${menuItem.price})">
                                                                    <i class="fas fa-star"></i> Mark as Special
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
                            <c:if test="${empty menuItems}">
                                <tr>
                                    <td colspan="9" style="text-align: center;">No menu items found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
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
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="specialModalLabel">Set Special Price</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="specialForm" action="${pageContext.request.contextPath}/admin/menu-items/toggle" method="get">
                <div class="modal-body">
                    <input type="hidden" id="specialMenuItemId" name="id">
                    <input type="hidden" name="action" value="special">
                    <input type="hidden" name="value" value="true">

                    <div class="mb-3">
                        <label for="regularPrice" class="form-label">Regular Price</label>
                        <input type="text" class="form-control" id="regularPrice" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="discountPrice" class="form-label">Special Price</label>
                        <input type="number" class="form-control" id="discountPrice" name="discountPrice" step="0.01" min="0.01" required>
                        <div class="form-text">Enter the special discounted price (must be less than the regular price).</div>
                    </div>

                    <div class="mb-3">
                        <label for="discountPercentage" class="form-label">Discount Percentage</label>
                        <input type="text" class="form-control" id="discountPercentage" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
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
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the menu item "<span id="deleteMenuItemName"></span>"?</p>
                <p class="text-danger">This action cannot be undone!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="deleteMenuItem()">Delete</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
