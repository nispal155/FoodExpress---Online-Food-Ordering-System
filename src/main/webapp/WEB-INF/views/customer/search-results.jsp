<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Search Results" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">Search Results</h1>

    <!-- Search Form -->
    <div style="margin-bottom: 2rem;">
        <form action="${pageContext.request.contextPath}/search" method="get">
            <div class="row">
                <div class="col-md-8 col-sm-12">
                    <div style="display: flex;">
                        <input type="text" name="q" value="${query}" placeholder="Search for food..." class="form-control" style="border-radius: 4px 0 0 4px;">
                        <button type="submit" class="btn btn-primary" style="border-radius: 0 4px 4px 0;">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- Search Results -->
    <c:if test="${not empty query}">
        <p>Showing results for: <strong>${query}</strong></p>
    </c:if>

    <div class="row">
        <c:forEach var="menuItem" items="${searchResults}">
            <div class="col-md-4 col-sm-6" style="margin-bottom: 2rem;">
                <div class="card" style="height: 100%; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1); position: relative;">
                    <c:if test="${not empty menuItem.imageUrl}">
                        <img src="${pageContext.request.contextPath}/${menuItem.imageUrl}" alt="${menuItem.name}" style="width: 100%; height: 200px; object-fit: cover;">
                    </c:if>
                    <c:if test="${empty menuItem.imageUrl}">
                        <div style="width: 100%; height: 200px; background-color: #f5f5f5; display: flex; align-items: center; justify-content: center;">
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
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray); font-size: 0.9rem;">
                            <i class="fas fa-utensils"></i> ${menuItem.restaurantName}
                        </p>
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray); font-size: 0.9rem;">
                            <i class="fas fa-tag"></i> ${menuItem.categoryName}
                        </p>
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
                        <div style="display: flex; gap: 0.5rem;">
                            <a href="${pageContext.request.contextPath}/restaurant?id=${menuItem.restaurantId}#menu-item-${menuItem.id}" class="btn btn-outline-primary" style="flex: 1;">View</a>
                            <button type="button" class="btn btn-primary" style="flex: 1;" onclick="openAddToCartModal(${menuItem.id}, '${menuItem.name}', ${menuItem.effectivePrice}, '${menuItem.restaurantName}')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty searchResults}">
            <div class="col-12">
                <div class="alert alert-info" role="alert">
                    <c:choose>
                        <c:when test="${not empty query}">
                            No results found for "${query}". Try a different search term.
                        </c:when>
                        <c:otherwise>
                            Enter a search term to find menu items.
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
    </div>
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
                        <label for="restaurantName" class="form-label">Restaurant</label>
                        <input type="text" class="form-control" id="restaurantName" readonly>
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
    function openAddToCartModal(menuItemId, name, price, restaurantName) {
        document.getElementById('menuItemId').value = menuItemId;
        document.getElementById('itemName').value = name;
        document.getElementById('restaurantName').value = restaurantName;
        document.getElementById('itemPrice').value = '$' + price.toFixed(2);

        const modal = new bootstrap.Modal(document.getElementById('addToCartModal'));
        modal.show();
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
