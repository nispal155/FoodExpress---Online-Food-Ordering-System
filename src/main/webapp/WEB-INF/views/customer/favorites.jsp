<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Favorites" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1>My Favorites</h1>
    
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle"></i> ${param.success}
        </div>
    </c:if>
    
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${param.error}
        </div>
    </c:if>
    
    <!-- Tabs for Restaurants and Menu Items -->
    <ul class="nav nav-tabs" id="favoritesTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="restaurants-tab" data-bs-toggle="tab" data-bs-target="#restaurants" type="button" role="tab" aria-controls="restaurants" aria-selected="true">
                <i class="fas fa-store"></i> Favorite Restaurants
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="menu-items-tab" data-bs-toggle="tab" data-bs-target="#menu-items" type="button" role="tab" aria-controls="menu-items" aria-selected="false">
                <i class="fas fa-utensils"></i> Favorite Dishes
            </button>
        </li>
    </ul>
    
    <div class="tab-content" id="favoritesTabContent">
        <!-- Favorite Restaurants Tab -->
        <div class="tab-pane fade show active" id="restaurants" role="tabpanel" aria-labelledby="restaurants-tab">
            <div class="row mt-4">
                <c:choose>
                    <c:when test="${empty favoriteRestaurants}">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> You don't have any favorite restaurants yet.
                                <a href="${pageContext.request.contextPath}/restaurants" class="alert-link">Browse restaurants</a> to add some to your favorites.
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="favorite" items="${favoriteRestaurants}">
                            <div class="col-md-4 col-sm-6 mb-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title">${favorite.restaurantName}</h5>
                                        <p class="card-text text-muted">
                                            <small>Added to favorites: <fmt:formatDate value="${favorite.createdAt}" pattern="MMM d, yyyy" /></small>
                                        </p>
                                        <div class="d-flex justify-content-between mt-3">
                                            <a href="${pageContext.request.contextPath}/restaurant?id=${favorite.restaurantId}" class="btn btn-primary">
                                                <i class="fas fa-utensils"></i> View Menu
                                            </a>
                                            <a href="${pageContext.request.contextPath}/favorites/remove?restaurantId=${favorite.restaurantId}" class="btn btn-outline-danger">
                                                <i class="fas fa-heart-broken"></i> Remove
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Favorite Menu Items Tab -->
        <div class="tab-pane fade" id="menu-items" role="tabpanel" aria-labelledby="menu-items-tab">
            <div class="row mt-4">
                <c:choose>
                    <c:when test="${empty favoriteMenuItems}">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> You don't have any favorite dishes yet.
                                <a href="${pageContext.request.contextPath}/restaurants" class="alert-link">Browse restaurants</a> to add some dishes to your favorites.
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="favorite" items="${favoriteMenuItems}">
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card h-100">
                                    <c:if test="${not empty favorite.menuItemImage}">
                                        <img src="${pageContext.request.contextPath}${favorite.menuItemImage}" class="card-img-top" alt="${favorite.menuItemName}" style="height: 200px; object-fit: cover;">
                                    </c:if>
                                    <div class="card-body">
                                        <h5 class="card-title">${favorite.menuItemName}</h5>
                                        <p class="card-text">${favorite.menuItemDescription}</p>
                                        <p class="card-text">
                                            <strong>Price:</strong> $<fmt:formatNumber value="${favorite.menuItemPrice}" pattern="#,##0.00" />
                                        </p>
                                        <p class="card-text text-muted">
                                            <small>From: ${favorite.restaurantName}</small>
                                        </p>
                                        <div class="d-flex justify-content-between mt-3">
                                            <a href="${pageContext.request.contextPath}/cart/add?menuItemId=${favorite.menuItemId}&quantity=1" class="btn btn-primary">
                                                <i class="fas fa-cart-plus"></i> Add to Cart
                                            </a>
                                            <a href="${pageContext.request.contextPath}/favorites/remove?menuItemId=${favorite.menuItemId}" class="btn btn-outline-danger">
                                                <i class="fas fa-heart-broken"></i> Remove
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize tabs
        const tabEls = document.querySelectorAll('[data-bs-toggle="tab"]');
        tabEls.forEach(tabEl => {
            tabEl.addEventListener('click', function(event) {
                event.preventDefault();
                
                // Hide all tab panes
                document.querySelectorAll('.tab-pane').forEach(pane => {
                    pane.classList.remove('show', 'active');
                });
                
                // Deactivate all tabs
                document.querySelectorAll('.nav-link').forEach(tab => {
                    tab.classList.remove('active');
                    tab.setAttribute('aria-selected', 'false');
                });
                
                // Activate clicked tab
                this.classList.add('active');
                this.setAttribute('aria-selected', 'true');
                
                // Show corresponding tab pane
                const target = document.querySelector(this.getAttribute('data-bs-target'));
                if (target) {
                    target.classList.add('show', 'active');
                }
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
