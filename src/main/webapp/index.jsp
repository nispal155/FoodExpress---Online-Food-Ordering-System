<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Home" />
</jsp:include>

<!-- Hero Section with Search -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <h1>Delicious Food Delivered to your Door</h1>
            <p>Order from your favorite restaurants with just a few clicks</p>
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/restaurants" method="get" class="search-form">
                    <input type="text" name="search" placeholder="Search for food..." class="search-input">
                    <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Main Content -->
<div class="main-content">
    <!-- Featured Restaurants Section -->
    <section class="container">
        <h2 class="section-title">Featured Restaurants</h2>

        <div class="restaurant-grid">
            <!-- Restaurant 1 -->
            <div class="restaurant-card">
                <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Pizza Palace" class="restaurant-image">
                <div class="restaurant-info">
                    <h3>Pizza Palace</h3>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <span>3</span>
                    </div>
                    <p class="restaurant-description">Best pizza in town with authentic Italian recipes</p>
                    <a href="${pageContext.request.contextPath}/restaurants/1" class="view-menu-btn">View Menu</a>
                </div>
            </div>

            <!-- Restaurant 2 -->
            <div class="restaurant-card">
                <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1599&q=80" alt="Burger Stop" class="restaurant-image">
                <div class="restaurant-info">
                    <h3>Burger Stop</h3>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <span>4</span>
                    </div>
                    <p class="restaurant-description">Best Burger in town with authentic German recipes</p>
                    <a href="${pageContext.request.contextPath}/restaurants/2" class="view-menu-btn">View Menu</a>
                </div>
            </div>

            <!-- Restaurant 3 -->
            <div class="restaurant-card">
                <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Pizza Palace" class="restaurant-image">
                <div class="restaurant-info">
                    <h3>Pizza Palace</h3>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <span>3</span>
                    </div>
                    <p class="restaurant-description">Best pizza in town with authentic Italian recipes</p>
                    <a href="${pageContext.request.contextPath}/restaurants/3" class="view-menu-btn">View Menu</a>
                </div>
            </div>

            <!-- Restaurant 4 -->
            <div class="restaurant-card">
                <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1599&q=80" alt="Burger Stop" class="restaurant-image">
                <div class="restaurant-info">
                    <h3>Burger Stop</h3>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <span>4</span>
                    </div>
                    <p class="restaurant-description">Best Burger in town with authentic German recipes</p>
                    <a href="${pageContext.request.contextPath}/restaurants/4" class="view-menu-btn">View Menu</a>
                </div>
            </div>
        </div>

        <div class="center-text">
            <a href="${pageContext.request.contextPath}/restaurants" class="view-all-link">View All Restaurants</a>
        </div>
    </section>

    <!-- Special Offers Section -->
    <section class="container">
        <h2 class="section-title">Special Offers</h2>
        <div class="special-offers-container">
            <div class="no-offers-message">
                <p>No special offers available at the moment.</p>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="container">
        <h2 class="section-title">How It Works</h2>

        <div class="how-it-works-grid">
            <!-- Step 1 -->
            <div class="how-it-works-item">
                <div class="how-it-works-icon">
                    <i class="fas fa-store"></i>
                </div>
                <h3>Choose a Restaurant</h3>
                <p>Choose through our selection of restaurants and find your favorite.</p>
            </div>

            <!-- Step 2 -->
            <div class="how-it-works-item">
                <div class="how-it-works-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <h3>Select Your Meal</h3>
                <p>Choose from a wide variety of delicious meals and add them to your cart.</p>
            </div>

            <!-- Step 3 -->
            <div class="how-it-works-item">
                <div class="how-it-works-icon">
                    <i class="fas fa-truck"></i>
                </div>
                <h3>Delivery to Your Door</h3>
                <p>Find your meal and we'll deliver it to your door in no time.</p>
            </div>
        </div>
    </section>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />