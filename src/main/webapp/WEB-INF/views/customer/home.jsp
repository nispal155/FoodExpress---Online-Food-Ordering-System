<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Home" />
</jsp:include>

<!-- Hero Section -->
<div class="hero-section" style="background-color: #FF5722; padding: 5rem 0; text-align: center; color: white; position: relative;">
    <div style="background-color: rgba(0, 0, 0, 0.5); position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
    <div style="position: relative; z-index: 1;">
        <h1 style="font-size: 3rem; margin-bottom: 1rem;">Delicious Food Delivered to Your Door</h1>
        <p style="font-size: 1.2rem; margin-bottom: 2rem;">Order from your favorite restaurants with just a few clicks</p>
        <form action="${pageContext.request.contextPath}/search" method="get" style="max-width: 600px; margin: 0 auto;">
            <div style="display: flex;">
                <input type="text" name="q" placeholder="Search for food..." style="flex: 1; padding: 1rem; border: none; border-radius: 4px 0 0 4px; font-size: 1rem;">
                <button type="submit" style="background-color: var(--primary-color); color: white; border: none; border-radius: 0 4px 4px 0; padding: 0 1.5rem; font-size: 1rem; cursor: pointer;">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Featured Restaurants Section -->
<div style="padding: 3rem 0;">
    <div class="container">
        <h2 style="text-align: center; margin-bottom: 2rem; color: var(--dark-gray);">Featured Restaurants</h2>

        <div class="row">
            <c:forEach var="restaurant" items="${featuredRestaurants}">
                <div class="col-md-4 col-sm-6" style="margin-bottom: 2rem;">
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
                            <p style="margin-bottom: 1rem; color: var(--medium-gray); height: 48px; overflow: hidden;">
                                ${restaurant.description}
                            </p>
                            <a href="${pageContext.request.contextPath}/restaurant?id=${restaurant.id}" class="btn btn-primary" style="width: 100%;">View Menu</a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty featuredRestaurants}">
                <div class="col-12">
                    <div class="alert alert-info" role="alert">
                        No featured restaurants available at the moment.
                    </div>
                </div>
            </c:if>
        </div>

        <div style="text-align: center; margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-outline-primary">View All Restaurants</a>
        </div>
    </div>
</div>

<!-- Special Offers Section -->
<div style="background-color: #f9f9f9; padding: 3rem 0;">
    <div class="container">
        <h2 style="text-align: center; margin-bottom: 2rem; color: var(--dark-gray);">Special Offers</h2>

        <div class="row">
            <c:forEach var="menuItem" items="${specialMenuItems}" varStatus="status">
                <c:if test="${status.index < 6}">
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
                            <div style="position: absolute; top: 10px; right: 10px; background-color: var(--danger-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">
                                SPECIAL OFFER
                            </div>
                            <div style="padding: 1rem;">
                                <h3 style="margin-bottom: 0.5rem;">${menuItem.name}</h3>
                                <p style="margin-bottom: 0.5rem; color: var(--medium-gray); font-size: 0.9rem;">
                                    ${menuItem.restaurantName}
                                </p>
                                <p style="margin-bottom: 1rem; color: var(--medium-gray); height: 48px; overflow: hidden;">
                                    ${menuItem.description}
                                </p>
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                                    <div>
                                        <c:if test="${not empty menuItem.discountPrice}">
                                            <span style="text-decoration: line-through; color: var(--medium-gray);">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                            <span style="color: var(--danger-color); font-weight: bold; font-size: 1.2rem; margin-left: 0.5rem;">$<fmt:formatNumber value="${menuItem.discountPrice}" pattern="#,##0.00" /></span>
                                        </c:if>
                                        <c:if test="${empty menuItem.discountPrice}">
                                            <span style="color: var(--danger-color); font-weight: bold; font-size: 1.2rem;">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                        </c:if>
                                    </div>
                                    <span style="color: var(--medium-gray); font-size: 0.9rem;">${menuItem.categoryName}</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/restaurant?id=${menuItem.restaurantId}#menu-item-${menuItem.id}" class="btn btn-primary" style="width: 100%;">Order Now</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <c:if test="${empty specialMenuItems}">
                <div class="col-12">
                    <div class="alert alert-info" role="alert">
                        No special offers available at the moment.
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- How It Works Section -->
<div style="padding: 3rem 0;">
    <div class="container">
        <h2 style="text-align: center; margin-bottom: 3rem; color: var(--dark-gray);">How It Works</h2>

        <div class="row">
            <div class="col-md-4 col-sm-12" style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;">
                    <i class="fas fa-store"></i>
                </div>
                <h3 style="margin-bottom: 1rem;">Choose a Restaurant</h3>
                <p style="color: var(--medium-gray);">Browse through our selection of restaurants and find your favorite.</p>
            </div>

            <div class="col-md-4 col-sm-12" style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;">
                    <i class="fas fa-utensils"></i>
                </div>
                <h3 style="margin-bottom: 1rem;">Select Your Meal</h3>
                <p style="color: var(--medium-gray);">Choose from a wide variety of delicious meals and add them to your cart.</p>
            </div>

            <div class="col-md-4 col-sm-12" style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;">
                    <i class="fas fa-truck"></i>
                </div>
                <h3 style="margin-bottom: 1rem;">Delivery to Your Door</h3>
                <p style="color: var(--medium-gray);">Place your order and we'll deliver it to your doorstep in no time.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
