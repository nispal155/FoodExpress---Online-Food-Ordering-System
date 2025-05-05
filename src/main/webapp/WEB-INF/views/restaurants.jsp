<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Restaurants" />
</jsp:include>

<section class="search-section">
    <div class="container">
        <div class="search-container-large">
            <form action="${pageContext.request.contextPath}/restaurants" method="get" class="search-form">
                <input type="text" name="search" placeholder="Search restaurants or cuisines..." class="search-input">
                <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </div>
</section>

<section class="container">
    <h2 class="section-title">Popular Restaurants</h2>

    <div class="restaurant-grid">
        <!-- Restaurant 1 -->
        <div class="restaurant-card">
            <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Pizza Palace" class="restaurant-image">
            <div class="restaurant-info">
                <div class="restaurant-header">
                    <h3>Pizza Palace</h3>
                    <div class="rating">
                        <span class="rating-score">4.5</span>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="restaurant-location"><i class="fas fa-map-marker-alt"></i> 123 Main St, Food City</p>
                <p class="restaurant-cuisine"><i class="fas fa-utensils"></i> Italian, Pizza, Pasta</p>
                <div class="restaurant-footer">
                    <span class="delivery-time"><i class="fas fa-clock"></i> 30-45 min</span>
                    <a href="${pageContext.request.contextPath}/restaurants/1" class="button">View Menu</a>
                </div>
            </div>
        </div>

        <!-- Restaurant 2 -->
        <div class="restaurant-card">
            <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1599&q=80" alt="Burger King" class="restaurant-image">
            <div class="restaurant-info">
                <div class="restaurant-header">
                    <h3>Burger King</h3>
                    <div class="rating">
                        <span class="rating-score">4.2</span>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="restaurant-location"><i class="fas fa-map-marker-alt"></i> 456 Oak St, Food City</p>
                <p class="restaurant-cuisine"><i class="fas fa-utensils"></i> American, Burgers, Fast Food</p>
                <div class="restaurant-footer">
                    <span class="delivery-time"><i class="fas fa-clock"></i> 15-30 min</span>
                    <a href="${pageContext.request.contextPath}/restaurants/2" class="button">View Menu</a>
                </div>
            </div>
        </div>

        <!-- Restaurant 3 -->
        <div class="restaurant-card">
            <img src="https://images.unsplash.com/photo-1563245372-f21724e3856d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" alt="Sushi World" class="restaurant-image">
            <div class="restaurant-info">
                <div class="restaurant-header">
                    <h3>Sushi World</h3>
                    <div class="rating">
                        <span class="rating-score">4.8</span>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="restaurant-location"><i class="fas fa-map-marker-alt"></i> 789 Pine St, Food City</p>
                <p class="restaurant-cuisine"><i class="fas fa-utensils"></i> Japanese, Sushi, Asian</p>
                <div class="restaurant-footer">
                    <span class="delivery-time"><i class="fas fa-clock"></i> 45-60 min</span>
                    <a href="${pageContext.request.contextPath}/restaurants/3" class="button">View Menu</a>
                </div>
            </div>
        </div>

        <!-- Restaurant 4 -->
        <div class="restaurant-card">
            <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Taco Bell" class="restaurant-image">
            <div class="restaurant-info">
                <div class="restaurant-header">
                    <h3>Taco Bell</h3>
                    <div class="rating">
                        <span class="rating-score">4.0</span>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="restaurant-location"><i class="fas fa-map-marker-alt"></i> 101 Elm St, Food City</p>
                <p class="restaurant-cuisine"><i class="fas fa-utensils"></i> Mexican, Tacos, Fast Food</p>
                <div class="restaurant-footer">
                    <span class="delivery-time"><i class="fas fa-clock"></i> 20-35 min</span>
                    <a href="${pageContext.request.contextPath}/restaurants/4" class="button">View Menu</a>
                </div>
            </div>
        </div>

        <!-- Restaurant 5 -->
        <div class="restaurant-card">
            <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" alt="Subway" class="restaurant-image">
            <div class="restaurant-info">
                <div class="restaurant-header">
                    <h3>Subway</h3>
                    <div class="rating">
                        <span class="rating-score">4.3</span>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="restaurant-location"><i class="fas fa-map-marker-alt"></i> 202 Maple St, Food City</p>
                <p class="restaurant-cuisine"><i class="fas fa-utensils"></i> Sandwiches, Healthy, Fast Food</p>
                <div class="restaurant-footer">
                    <span class="delivery-time"><i class="fas fa-clock"></i> 15-25 min</span>
                    <a href="${pageContext.request.contextPath}/restaurants/5" class="button">View Menu</a>
                </div>
            </div>
        </div>

        <!-- Restaurant 6 -->
        <div class="restaurant-card">
            <img src="https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="KFC" class="restaurant-image">
            <div class="restaurant-info">
                <div class="restaurant-header">
                    <h3>KFC</h3>
                    <div class="rating">
                        <span class="rating-score">4.1</span>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="restaurant-location"><i class="fas fa-map-marker-alt"></i> 303 Cedar St, Food City</p>
                <p class="restaurant-cuisine"><i class="fas fa-utensils"></i> American, Chicken, Fast Food</p>
                <div class="restaurant-footer">
                    <span class="delivery-time"><i class="fas fa-clock"></i> 25-40 min</span>
                    <a href="${pageContext.request.contextPath}/restaurants/6" class="button">View Menu</a>
                </div>
            </div>
        </div>
    </div>

    <div class="center-text load-more">
        <a href="#" class="view-all-link">Load More</a>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
