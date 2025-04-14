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
            </div>
        </div>
    </div>
</div>

<div class="container">
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
                                    </div>
                                    <button type="button" class="btn btn-primary" style="width: 100%;" onclick="openAddToCartModal(${menuItem.id}, '${menuItem.name}', ${menuItem.effectivePrice})">
                                        Add to Cart
                                    </button>
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

<!-- Add to Cart Modal -->
<div class="modal fade" id="addToCartModal" tabindex="-1" aria-labelledby="addToCartModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addToCartModalLabel">Add to Cart</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="menuItemId" id="menuItemId">
                
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="itemName" class="form-label">Item</label>
                        <input type="text" class="form-control" id="itemName" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="itemPrice" class="form-label">Price</label>
                        <input type="text" class="form-control" id="itemPrice" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                    </div>
                    <div class="mb-3">
                        <label for="specialInstructions" class="form-label">Special Instructions (optional)</label>
                        <textarea class="form-control" id="specialInstructions" name="specialInstructions" rows="3" placeholder="E.g., No onions, extra sauce, etc."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add to Cart</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openAddToCartModal(menuItemId, name, price) {
        document.getElementById('menuItemId').value = menuItemId;
        document.getElementById('itemName').value = name;
        document.getElementById('itemPrice').value = '$' + price.toFixed(2);
        
        const modal = new bootstrap.Modal(document.getElementById('addToCartModal'));
        modal.show();
    }
    
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
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
