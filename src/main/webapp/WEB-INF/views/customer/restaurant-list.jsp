<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Restaurants" />
</jsp:include>

<!-- Include the restaurants CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/restaurants.css">

<div class="main-container">
    <h1 class="page-title">All Restaurants</h1>

    <!-- Search and Sort Section -->
    <div class="search-sort-container">
        <div class="search-container">
            <form action="${pageContext.request.contextPath}/restaurants" method="get">
                <input type="text" name="search" placeholder="Search for restaurants..." class="search-input" value="${param.search}">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>

        <div class="sort-container">
            <select id="sortOrder" class="sort-select" onchange="sortRestaurants()">
                <option value="rating">Sort by Rating</option>
                <option value="name">Sort by Name</option>
            </select>
        </div>
    </div>

    <!-- Restaurant Grid -->
    <div class="restaurant-grid" id="restaurantList">
        <c:forEach var="restaurant" items="${restaurants}">
            <div class="restaurant-card" data-rating="${restaurant.rating}" data-name="${restaurant.name}">
                <c:choose>
                    <c:when test="${not empty restaurant.imageUrl}">
                        <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}" class="restaurant-image">
                    </c:when>
                    <c:otherwise>
                        <div class="restaurant-image ${fn:contains(fn:toLowerCase(restaurant.name), 'pizza') ? 'pizza-image' : 'burger-image'}"></div>
                    </c:otherwise>
                </c:choose>
                <div class="restaurant-content">
                    <h3 class="restaurant-name">${restaurant.name}</h3>
                    <div class="star-rating">
                        <div class="stars">
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
                        </div>
                        <span class="rating-number">${restaurant.rating}</span>
                    </div>
                    <p class="restaurant-description">${restaurant.description}</p>
                    <a href="${pageContext.request.contextPath}/restaurant?id=${restaurant.id}" class="view-menu-button">View Menu</a>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty restaurants}">
            <div class="no-restaurants">
                <p>No restaurants available at the moment.</p>
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
