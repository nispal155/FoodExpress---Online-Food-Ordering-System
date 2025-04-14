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
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h2 class="card-title">${pageTitle}</h2>
            </div>
            <div style="padding: 1rem;">
                <form action="${pageContext.request.contextPath}/admin/menu-items/save" method="post" enctype="multipart/form-data">
                    <!-- Hidden ID field for edit mode -->
                    <c:if test="${not empty menuItem.id}">
                        <input type="hidden" name="id" value="${menuItem.id}">
                    </c:if>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="restaurantId" class="form-label">Restaurant <span class="text-danger">*</span></label>
                                <select class="form-select" id="restaurantId" name="restaurantId" required>
                                    <option value="">Select Restaurant</option>
                                    <c:forEach var="restaurant" items="${restaurants}">
                                        <option value="${restaurant.id}" <c:if test="${restaurant.id == menuItem.restaurantId || restaurant.id == selectedRestaurantId}">selected</c:if>>
                                            ${restaurant.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="categoryId" class="form-label">Category <span class="text-danger">*</span></label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="">Select Category</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" <c:if test="${category.id == menuItem.categoryId}">selected</c:if>>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name" value="${menuItem.name}" required>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3">${menuItem.description}</textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="price" name="price" step="0.01" min="0.01" value="${menuItem.price}" required>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="image" class="form-label">Image</label>
                                <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                <div class="form-text">Upload a new image (max 10MB). Leave empty to keep the current image.</div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty menuItem.imageUrl}">
                        <div class="mb-3">
                            <label class="form-label">Current Image</label>
                            <div>
                                <img src="${pageContext.request.contextPath}/${menuItem.imageUrl}" alt="${menuItem.name}" style="max-width: 200px; max-height: 200px; object-fit: cover; border-radius: 5px;">
                            </div>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="isAvailable" name="isAvailable" <c:if test="${empty menuItem.id || menuItem.available}">checked</c:if>>
                                <label class="form-check-label" for="isAvailable">Available</label>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="isSpecial" name="isSpecial" <c:if test="${menuItem.special}">checked</c:if> onchange="toggleDiscountPrice()">
                                <label class="form-check-label" for="isSpecial">Mark as Special</label>
                            </div>
                        </div>
                    </div>

                    <div id="discountPriceSection" class="mb-3" <c:if test="${!menuItem.special}">style="display: none;"</c:if>>
                        <label for="discountPrice" class="form-label">Special Price <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="discountPrice" name="discountPrice" step="0.01" min="0.01" value="${menuItem.discountPrice}">
                        </div>
                        <div class="form-text">Enter the special discounted price (must be less than the regular price).</div>
                    </div>

                    <div class="mb-3">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleDiscountPrice() {
        var isSpecial = document.getElementById('isSpecial').checked;
        var discountPriceSection = document.getElementById('discountPriceSection');

        if (isSpecial) {
            discountPriceSection.style.display = 'block';
            document.getElementById('discountPrice').setAttribute('required', 'required');
        } else {
            discountPriceSection.style.display = 'none';
            document.getElementById('discountPrice').removeAttribute('required');
        }
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        toggleDiscountPrice();
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
