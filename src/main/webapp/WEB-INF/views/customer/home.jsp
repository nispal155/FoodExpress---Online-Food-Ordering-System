<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Home" />
</jsp:include>

<!-- Hero Section -->
<div class="hero-section">
    <div class="hero-background">
        <div class="hero-overlay"></div>
    </div>
    <div class="hero-content">
        <div class="hero-text-container">
            <h1 class="hero-title">Delicious Food Delivered to Your Door</h1>
            <p class="hero-subtitle">Order from your favorite restaurants with just a few clicks</p>
            <div class="hero-search-container">
                <form action="${pageContext.request.contextPath}/search" method="get" class="hero-search-form">
                    <div class="search-input-container">
                        <i class="fas fa-utensils search-icon"></i>
                        <input type="text" name="q" placeholder="Search for food or restaurants..." class="hero-search-input">
                    </div>
                    <button type="submit" class="hero-search-button">
                        <i class="fas fa-search"></i> Search
                    </button>
                </form>
            </div>
        </div>
        <div class="hero-features">
            <div class="hero-feature">
                <div class="hero-feature-icon">
                    <i class="fas fa-truck"></i>
                </div>
                <div class="hero-feature-text">Fast Delivery</div>
            </div>
            <div class="hero-feature">
                <div class="hero-feature-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <div class="hero-feature-text">Quality Food</div>
            </div>
            <div class="hero-feature">
                <div class="hero-feature-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="hero-feature-text">Easy Payment</div>
            </div>
        </div>
    </div>
</div>

<!-- Featured Restaurants Section -->
<section class="featured-restaurants-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Featured Restaurants</h2>
            <p class="section-subtitle">Discover the best restaurants in your area</p>
        </div>

        <div class="restaurant-grid">
            <c:forEach var="restaurant" items="${featuredRestaurants}">
                <div class="restaurant-card">
                    <div class="restaurant-card-image">
                        <c:if test="${not empty restaurant.imageUrl}">
                            <img src="${pageContext.request.contextPath}/${restaurant.imageUrl}" alt="${restaurant.name}">
                        </c:if>
                        <c:if test="${empty restaurant.imageUrl}">
                            <div class="restaurant-card-no-image">
                                <i class="fas fa-utensils"></i>
                            </div>
                        </c:if>
                        <div class="restaurant-card-badge">
                            <i class="fas fa-star"></i> ${restaurant.rating}
                        </div>
                    </div>
                    <div class="restaurant-card-content">
                        <h3 class="restaurant-card-title">${restaurant.name}</h3>
                        <div class="restaurant-card-rating">
                            <div class="rating-stars">
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
                            <span class="rating-count">(${restaurant.rating})</span>
                        </div>
                        <p class="restaurant-card-description">${restaurant.description}</p>
                        <div class="restaurant-card-meta">
                            <div class="restaurant-card-location">
                                <i class="fas fa-map-marker-alt"></i> ${restaurant.address}
                            </div>
                            <div class="restaurant-card-time">
                                <i class="fas fa-clock"></i> 30-45 min
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/restaurant?id=${restaurant.id}" class="restaurant-card-button">
                            <span>View Menu</span>
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty featuredRestaurants}">
                <div class="no-restaurants-message">
                    <div class="no-restaurants-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <h3>No Restaurants Available</h3>
                    <p>We're currently adding new restaurants to our platform. Please check back soon!</p>
                </div>
            </c:if>
        </div>

        <div class="section-footer">
            <a href="${pageContext.request.contextPath}/restaurants" class="view-all-button">
                <span>View All Restaurants</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
</section>

<!-- Special Offers Section -->
<section class="special-offers-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Special Offers</h2>
            <p class="section-subtitle">Enjoy exclusive deals and discounts on our featured items</p>
        </div>

        <div class="special-offers-grid">
            <c:forEach var="menuItem" items="${specialMenuItems}" varStatus="status">
                <c:if test="${status.index < 6}">
                    <div class="special-offer-card">
                        <div class="special-offer-image">
                            <c:if test="${not empty menuItem.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${menuItem.imageUrl}" alt="${menuItem.name}">
                            </c:if>
                            <c:if test="${empty menuItem.imageUrl}">
                                <div class="special-offer-no-image">
                                    <i class="fas fa-hamburger"></i>
                                </div>
                            </c:if>
                            <div class="special-offer-badge">
                                <span>SPECIAL OFFER</span>
                            </div>
                        </div>
                        <div class="special-offer-content">
                            <div class="special-offer-restaurant">
                                <i class="fas fa-store"></i> ${menuItem.restaurantName}
                            </div>
                            <h3 class="special-offer-title">${menuItem.name}</h3>
                            <p class="special-offer-description">${menuItem.description}</p>
                            <div class="special-offer-price">
                                <c:if test="${not empty menuItem.discountPrice}">
                                    <span class="original-price">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                    <span class="discounted-price">$<fmt:formatNumber value="${menuItem.discountPrice}" pattern="#,##0.00" /></span>
                                </c:if>
                                <c:if test="${empty menuItem.discountPrice}">
                                    <span class="regular-price">$<fmt:formatNumber value="${menuItem.price}" pattern="#,##0.00" /></span>
                                </c:if>
                                <span class="menu-category">${menuItem.categoryName}</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/restaurant?id=${menuItem.restaurantId}#menu-item-${menuItem.id}" class="special-offer-button">
                                <span>Order Now</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <c:if test="${empty specialMenuItems}">
                <div class="no-offers-message">
                    <div class="no-offers-icon">
                        <i class="fas fa-tag"></i>
                    </div>
                    <h3>No Special Offers Available</h3>
                    <p>We're currently preparing new special offers. Check back soon for exclusive deals!</p>
                </div>
            </c:if>
        </div>
    </div>
</section>

<!-- How It Works Section -->
<section class="how-it-works-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">How It Works</h2>
            <p class="section-subtitle">Order your favorite food in just a few simple steps</p>
        </div>

        <div class="steps-container">
            <div class="step-item">
                <div class="step-number">1</div>
                <div class="step-icon">
                    <i class="fas fa-store"></i>
                </div>
                <div class="step-content">
                    <h3 class="step-title">Choose a Restaurant</h3>
                    <p class="step-description">Browse through our selection of restaurants and find your favorite.</p>
                </div>
            </div>

            <div class="step-connector"></div>

            <div class="step-item">
                <div class="step-number">2</div>
                <div class="step-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <div class="step-content">
                    <h3 class="step-title">Select Your Meal</h3>
                    <p class="step-description">Choose from a wide variety of delicious meals and add them to your cart.</p>
                </div>
            </div>

            <div class="step-connector"></div>

            <div class="step-item">
                <div class="step-number">3</div>
                <div class="step-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="step-content">
                    <h3 class="step-title">Pay Securely</h3>
                    <p class="step-description">Complete your order with our secure payment options.</p>
                </div>
            </div>

            <div class="step-connector"></div>

            <div class="step-item">
                <div class="step-number">4</div>
                <div class="step-icon">
                    <i class="fas fa-truck"></i>
                </div>
                <div class="step-content">
                    <h3 class="step-title">Delivery to Your Door</h3>
                    <p class="step-description">Sit back and relax! We'll deliver your order right to your doorstep.</p>
                </div>
            </div>
        </div>

        <div class="cta-container">
            <a href="${pageContext.request.contextPath}/restaurants" class="cta-button">
                <span>Order Now</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
