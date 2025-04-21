<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - ${restaurant.name}" />
</jsp:include>

<!-- Restaurant Header -->
<div style="background-color: #f9f9f9; padding: 2rem 0; margin-bottom: 2rem;">
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-sm-12">
                <c:if test="${not empty restaurant.imageUrl}">
                    <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                </c:if>
                <c:if test="${empty restaurant.imageUrl}">
                    <div style="width: 100%; height: 200px; background-color: #f5f5f5; display: flex; align-items: center; justify-content: center; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                        <i class="fas fa-utensils" style="font-size: 3rem; color: #ddd;"></i>
                    </div>
                </c:if>
            </div>
            <div class="col-md-9 col-sm-12">
                <h1 style="margin-bottom: 0.5rem;">${restaurant.name}</h1>
                <div style="margin-bottom: 0.5rem; color: var(--warning-color);">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= restaurant.rating}">
                                <i class="fas fa-star"></i>
                            </c:when>
                            <c:when test="${i <= restaurant.rating + 0.5}">
                                <i class="fas fa-star-half-alt"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="far fa-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <span style="color: var(--dark-gray); margin-left: 0.5rem;">${restaurant.rating}</span>
                </div>
                <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">
                    <i class="fas fa-map-marker-alt"></i> ${restaurant.address}
                </p>
                <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">
                    <i class="fas fa-phone"></i> ${restaurant.phone}
                </p>
                <p style="margin-bottom: 1rem; color: var(--medium-gray);">
                    ${restaurant.description}
                </p>

                <!-- Favorite Button -->
                <c:if test="${not empty sessionScope.user}">
                    <div style="margin-top: 1rem;">
                        <c:choose>
                            <c:when test="${isFavorite}">
                                <a href="${pageContext.request.contextPath}/favorites/remove?restaurantId=${restaurant.id}" class="btn btn-outline-danger">
                                    <i class="fas fa-heart"></i> Remove from Favorites
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/favorites/add?restaurantId=${restaurant.id}" class="btn btn-outline-primary">
                                    <i class="far fa-heart"></i> Add to Favorites
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Success and Error Messages -->
    <c:if test="${param.success eq 'added'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> Item added to cart successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${param.error eq 'different-restaurant'}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> Your cart contains items from a different restaurant. Please clear your cart or finish your current order first.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <!-- Category Navigation -->
    <div style="margin-bottom: 2rem; position: sticky; top: 70px; z-index: 100; background-color: white; padding: 1rem 0; border-bottom: 1px solid #eee;">
        <div style="display: flex; overflow-x: auto; white-space: nowrap; padding-bottom: 0.5rem;">
            <c:forEach var="category" items="${categories}">
                <c:if test="${not empty menuItemsByCategory[category.id]}">
                    <a href="#category-${category.id}" style="margin-right: 1rem; padding: 0.5rem 1rem; background-color: #f5f5f5; border-radius: 20px; color: var(--dark-gray); text-decoration: none; display: inline-block;">
                        ${category.name}
                    </a>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <!-- Menu Items by Category -->
    <c:forEach var="category" items="${categories}">
        <c:if test="${not empty menuItemsByCategory[category.id]}">
            <div id="category-${category.id}" style="margin-bottom: 3rem;">
                <h2 style="margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--primary-color);">${category.name}</h2>

                <div class="row">
                    <c:forEach var="menuItem" items="${menuItemsByCategory[category.id]}">
                        <div class="col-md-6 col-lg-4" style="margin-bottom: 2rem;">
                            <div id="menu-item-${menuItem.id}" class="card" style="height: 100%; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1); position: relative;">
                                <c:if test="${not empty menuItem.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/${menuItem.imageUrl}" alt="${menuItem.name}" style="width: 100%; height: 180px; object-fit: cover;">
                                </c:if>
                                <c:if test="${empty menuItem.imageUrl}">
                                    <div style="width: 100%; height: 180px; background-color: #f5f5f5; display: flex; align-items: center; justify-content: center;">
                                        <i class="fas fa-hamburger" style="font-size: 3rem; color: #ddd;"></i>
                                    </div>
                                </c:if>
                                <c:if test="${menuItem.special}">
                                    <div style="position: absolute; top: 10px; right: 10px; background-color: var(--danger-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">
                                        ${menuItem.discountPercentage}% OFF
                                    </div>
                                </c:if>
                                <div style="padding: 1rem;">
                                    <h3 style="margin-bottom: 0.5rem;">${menuItem.name}</h3>
                                    <p style="margin-bottom: 1rem; color: var(--medium-gray); height: 48px; overflow: hidden;">
                                        ${menuItem.description}
                                    </p>
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                                        <div>
                                            <c:if test="${menuItem.special}">
                                                <span style="text-decoration: line-through; color: var(--medium-gray);">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                                <span style="color: var(--danger-color); font-weight: bold; font-size: 1.2rem; margin-left: 0.5rem;">$<fmt:formatNumber value="${menuItem.effectivePrice}" pattern="#,##0.00" /></span>
                                            </c:if>
                                            <c:if test="${!menuItem.special}">
                                                <span style="font-weight: bold; font-size: 1.2rem;">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                            </c:if>
                                        </div>

                                        <!-- Favorite Icon -->
                                        <c:if test="${not empty sessionScope.user}">
                                            <div>
                                                <c:choose>
                                                    <c:when test="${favoriteMenuItems[menuItem.id]}">
                                                        <a href="${pageContext.request.contextPath}/favorites/remove?menuItemId=${menuItem.id}" class="btn btn-sm btn-outline-danger" title="Remove from favorites">
                                                            <i class="fas fa-heart"></i>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/favorites/add?menuItemId=${menuItem.id}" class="btn btn-sm btn-outline-primary" title="Add to favorites">
                                                            <i class="far fa-heart"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="w-100">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="menuItemId" value="${menuItem.id}">
                                            <div class="mb-2">
                                                <label for="quantity-${menuItem.id}" class="form-label">Quantity:</label>
                                                <select name="quantity" id="quantity-${menuItem.id}" class="form-select">
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                </select>
                                            </div>
                                            <div class="mb-2">
                                                <label for="specialInstructions-${menuItem.id}" class="form-label">Special Instructions:</label>
                                                <textarea name="specialInstructions" id="specialInstructions-${menuItem.id}" class="form-control" rows="2" placeholder="E.g., No onions, extra sauce, etc."></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary add-to-cart-button w-100">
                                                <i class="fas fa-cart-plus"></i> Add to Cart
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </c:forEach>

    <c:if test="${empty menuItems}">
        <div class="alert alert-info" role="alert">
            No menu items available for this restaurant.
        </div>
    </c:if>
</div>

<!-- Floating Cart Button -->
<c:if test="${not empty sessionScope.user and not empty sessionScope.cart and sessionScope.cart.totalItems > 0}">
    <div class="floating-cart-button">
        <a href="${pageContext.request.contextPath}/cart" class="floating-cart-link">
            <div class="floating-cart-icon">
                <i class="fas fa-shopping-cart"></i>
                <span class="floating-cart-badge">${sessionScope.cart.totalItems}</span>
            </div>
            <div class="floating-cart-details">
                <span class="floating-cart-text">View Cart</span>
                <span class="floating-cart-total">$${sessionScope.cart.totalPrice}</span>
            </div>
        </a>
    </div>
</c:if>



<script>
    // Update cart badge on page load
    document.addEventListener('DOMContentLoaded', function() {
        // No need for JavaScript alert as we have a proper alert message in the page

        // Smooth scrolling for category navigation
        document.querySelectorAll('a[href^="#category-"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();

                const targetId = this.getAttribute('href');
                const targetElement = document.querySelector(targetId);

                window.scrollTo({
                    top: targetElement.offsetTop - 120, // Adjust for header and sticky nav
                    behavior: 'smooth'
                });
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
