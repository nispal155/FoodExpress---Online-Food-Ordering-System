<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Restaurants" />
</jsp:include>

<div style="background-color: var(--light-gray); padding: 2rem 0;">
    <div class="row">
        <div class="col-md-6 col-sm-12" style="margin: 0 auto; max-width: 600px;">
            <form action="${pageContext.request.contextPath}/restaurants" method="get" style="display: flex;">
                <input type="text" name="search" placeholder="Search restaurants or cuisines..." class="form-control" style="margin-right: 0.5rem;">
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </div>
</div>

<div style="padding: 2rem 0;">
    <h2 style="margin-bottom: 1.5rem;">Popular Restaurants</h2>
    
    <div class="row">
        <!-- Restaurant 1 -->
        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Pizza Palace" style="width: 100%; height: 200px; object-fit: cover;">
                <div style="padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                        <h3 style="margin: 0;">Pizza Palace</h3>
                        <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">4.5 <i class="fas fa-star"></i></span>
                    </div>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 123 Main St, Food City</p>
                    <p style="color: var(--dark-gray); margin-bottom: 1rem;"><i class="fas fa-utensils"></i> Italian, Pizza, Pasta</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span><i class="fas fa-clock"></i> 30-45 min</span>
                        <a href="${pageContext.request.contextPath}/restaurants/1" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Restaurant 2 -->
        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1599&q=80" alt="Burger King" style="width: 100%; height: 200px; object-fit: cover;">
                <div style="padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                        <h3 style="margin: 0;">Burger King</h3>
                        <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">4.2 <i class="fas fa-star"></i></span>
                    </div>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 456 Oak St, Food City</p>
                    <p style="color: var(--dark-gray); margin-bottom: 1rem;"><i class="fas fa-utensils"></i> American, Burgers, Fast Food</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span><i class="fas fa-clock"></i> 15-30 min</span>
                        <a href="${pageContext.request.contextPath}/restaurants/2" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Restaurant 3 -->
        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <img src="https://images.unsplash.com/photo-1563245372-f21724e3856d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" alt="Sushi World" style="width: 100%; height: 200px; object-fit: cover;">
                <div style="padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                        <h3 style="margin: 0;">Sushi World</h3>
                        <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">4.8 <i class="fas fa-star"></i></span>
                    </div>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 789 Pine St, Food City</p>
                    <p style="color: var(--dark-gray); margin-bottom: 1rem;"><i class="fas fa-utensils"></i> Japanese, Sushi, Asian</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span><i class="fas fa-clock"></i> 45-60 min</span>
                        <a href="${pageContext.request.contextPath}/restaurants/3" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Restaurant 4 -->
        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Taco Bell" style="width: 100%; height: 200px; object-fit: cover;">
                <div style="padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                        <h3 style="margin: 0;">Taco Bell</h3>
                        <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">4.0 <i class="fas fa-star"></i></span>
                    </div>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 101 Elm St, Food City</p>
                    <p style="color: var(--dark-gray); margin-bottom: 1rem;"><i class="fas fa-utensils"></i> Mexican, Tacos, Fast Food</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span><i class="fas fa-clock"></i> 20-35 min</span>
                        <a href="${pageContext.request.contextPath}/restaurants/4" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Restaurant 5 -->
        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" alt="Subway" style="width: 100%; height: 200px; object-fit: cover;">
                <div style="padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                        <h3 style="margin: 0;">Subway</h3>
                        <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">4.3 <i class="fas fa-star"></i></span>
                    </div>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 202 Maple St, Food City</p>
                    <p style="color: var(--dark-gray); margin-bottom: 1rem;"><i class="fas fa-utensils"></i> Sandwiches, Healthy, Fast Food</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span><i class="fas fa-clock"></i> 15-25 min</span>
                        <a href="${pageContext.request.contextPath}/restaurants/5" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Restaurant 6 -->
        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <img src="https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="KFC" style="width: 100%; height: 200px; object-fit: cover;">
                <div style="padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                        <h3 style="margin: 0;">KFC</h3>
                        <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">4.1 <i class="fas fa-star"></i></span>
                    </div>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 303 Cedar St, Food City</p>
                    <p style="color: var(--dark-gray); margin-bottom: 1rem;"><i class="fas fa-utensils"></i> American, Chicken, Fast Food</p>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span><i class="fas fa-clock"></i> 25-40 min</span>
                        <a href="${pageContext.request.contextPath}/restaurants/6" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 1rem;">
        <a href="#" class="btn btn-secondary">Load More</a>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
