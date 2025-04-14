<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Restaurants" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">All Restaurants</h1>
    
    <!-- Search and Filter -->
    <div style="margin-bottom: 2rem;">
        <div class="row">
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/search" method="get">
                    <div style="display: flex;">
                        <input type="text" name="q" placeholder="Search for food..." class="form-control" style="border-radius: 4px 0 0 4px;">
                        <button type="submit" class="btn btn-primary" style="border-radius: 0 4px 4px 0;">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <div class="col-md-6">
                <div style="display: flex; justify-content: flex-end;">
                    <select id="sortOrder" class="form-select" style="width: auto;" onchange="sortRestaurants()">
                        <option value="rating">Sort by Rating</option>
                        <option value="name">Sort by Name</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Restaurant List -->
    <div class="row" id="restaurantList">
        <c:forEach var="restaurant" items="${restaurants}">
            <div class="col-md-4 col-sm-6" style="margin-bottom: 2rem;" data-rating="${restaurant.rating}" data-name="${restaurant.name}">
                <div class="card" style="height: 100%; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <c:if test="${not empty restaurant.imageUrl}">
                        <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}" style="width: 100%; height: 200px; object-fit: cover;">
                    </c:if>
                    <c:if test="${empty restaurant.imageUrl}">
                        <div style="width: 100%; height: 200px; background-color: #f5f5f5; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-utensils" style="font-size: 3rem; color: #ddd;"></i>
                        </div>
                    </c:if>
                    <div style="padding: 1rem;">
                        <h3 style="margin-bottom: 0.5rem;">${restaurant.name}</h3>
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
                        <p style="margin-bottom: 1rem; color: var(--medium-gray); height: 48px; overflow: hidden;">
                            ${restaurant.description}
                        </p>
                        <a href="${pageContext.request.contextPath}/restaurant?id=${restaurant.id}" class="btn btn-primary" style="width: 100%;">View Menu</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty restaurants}">
            <div class="col-12">
                <div class="alert alert-info" role="alert">
                    No restaurants available at the moment.
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>
    function sortRestaurants() {
        const sortOrder = document.getElementById('sortOrder').value;
        const restaurantList = document.getElementById('restaurantList');
        const restaurants = Array.from(restaurantList.children);
        
        restaurants.sort((a, b) => {
            if (sortOrder === 'rating') {
                return parseFloat(b.dataset.rating) - parseFloat(a.dataset.rating);
            } else if (sortOrder === 'name') {
                return a.dataset.name.localeCompare(b.dataset.name);
            }
            return 0;
        });
        
        restaurants.forEach(restaurant => {
            restaurantList.appendChild(restaurant);
        });
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
