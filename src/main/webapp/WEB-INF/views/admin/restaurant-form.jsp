<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <!-- Error Messages -->
        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                <c:choose>
                    <c:when test="${param.error == 'create'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to create restaurant!
                    </c:when>
                    <c:when test="${param.error == 'update'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update restaurant!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-exclamation-circle"></i> An error occurred!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h2 class="card-title">${empty restaurant ? 'Add' : 'Edit'} Restaurant</h2>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/restaurants/form" method="post" enctype="multipart/form-data" id="restaurantForm">
                    <c:if test="${not empty restaurant}">
                        <input type="hidden" name="id" value="${restaurant.id}">
                    </c:if>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">Restaurant Name *</label>
                            <input type="text" class="form-control ${not empty errors.name ? 'is-invalid' : ''}" id="name" name="name" value="${restaurant.name}" required>
                            <c:if test="${not empty errors.name}">
                                <div class="invalid-feedback">
                                    ${errors.name}
                                </div>
                            </c:if>
                        </div>

                        <div class="col-md-6">
                            <label for="rating" class="form-label">Rating (0-5) *</label>
                            <input type="number" class="form-control ${not empty errors.rating ? 'is-invalid' : ''}" id="rating" name="rating" value="${empty restaurant.rating ? '0.0' : restaurant.rating}" min="0" max="5" step="0.1" required>
                            <c:if test="${not empty errors.rating}">
                                <div class="invalid-feedback">
                                    ${errors.rating}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description *</label>
                        <textarea class="form-control ${not empty errors.description ? 'is-invalid' : ''}" id="description" name="description" rows="3" required>${restaurant.description}</textarea>
                        <c:if test="${not empty errors.description}">
                            <div class="invalid-feedback">
                                ${errors.description}
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Address *</label>
                        <textarea class="form-control ${not empty errors.address ? 'is-invalid' : ''}" id="address" name="address" rows="2" required>${restaurant.address}</textarea>
                        <c:if test="${not empty errors.address}">
                            <div class="invalid-feedback">
                                ${errors.address}
                            </div>
                        </c:if>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone *</label>
                            <input type="tel" class="form-control ${not empty errors.phone ? 'is-invalid' : ''}" id="phone" name="phone" value="${restaurant.phone}" required>
                            <c:if test="${not empty errors.phone}">
                                <div class="invalid-feedback">
                                    ${errors.phone}
                                </div>
                            </c:if>
                        </div>

                        <div class="col-md-6">
                            <label for="email" class="form-label">Email *</label>
                            <input type="email" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" id="email" name="email" value="${restaurant.email}" required>
                            <c:if test="${not empty errors.email}">
                                <div class="invalid-feedback">
                                    ${errors.email}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="image" class="form-label">Restaurant Image</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                        <div class="form-text">Upload a new image (optional). Recommended size: 800x600 pixels.</div>

                        <c:if test="${not empty restaurant.imageUrl}">
                            <div style="margin-top: 1rem;">
                                <p>Current Image:</p>
                                <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}" style="max-width: 200px; max-height: 150px; border-radius: 5px;">
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="isActive" name="isActive" value="true" ${empty restaurant || restaurant.active ? 'checked' : ''}>
                        <label class="form-check-label" for="isActive">Active</label>
                        <div class="form-text">Inactive restaurants will not be visible to customers.</div>
                    </div>

                    <div style="display: flex; gap: 1rem;">
                        <button type="submit" class="btn btn-primary">Save Restaurant</button>
                        <a href="${pageContext.request.contextPath}/admin/restaurants" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Form validation
    document.getElementById('restaurantForm').addEventListener('submit', function(event) {
        let isValid = true;

        // Validate name
        const name = document.getElementById('name').value.trim();
        if (name === '') {
            document.getElementById('name').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('name').classList.remove('is-invalid');
        }

        // Validate description
        const description = document.getElementById('description').value.trim();
        if (description === '') {
            document.getElementById('description').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('description').classList.remove('is-invalid');
        }

        // Validate address
        const address = document.getElementById('address').value.trim();
        if (address === '') {
            document.getElementById('address').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('address').classList.remove('is-invalid');
        }

        // Validate phone
        const phone = document.getElementById('phone').value.trim();
        if (phone === '') {
            document.getElementById('phone').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('phone').classList.remove('is-invalid');
        }

        // Validate email
        const email = document.getElementById('email').value.trim();
        if (email === '') {
            document.getElementById('email').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('email').classList.remove('is-invalid');
        }

        // Validate rating
        const rating = document.getElementById('rating').value;
        if (rating === '' || isNaN(rating) || parseFloat(rating) < 0 || parseFloat(rating) > 5) {
            document.getElementById('rating').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('rating').classList.remove('is-invalid');
        }

        if (!isValid) {
            event.preventDefault();
        }
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
