<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Pizza Palace Menu" />
</jsp:include>

<div style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'); background-size: cover; background-position: center; padding: 3rem 0; color: white; margin-bottom: 2rem;">
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-sm-12">
                <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">Pizza Palace</h1>
                <p style="margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 123 Main St, Food City</p>
                <p style="margin-bottom: 0.5rem;"><i class="fas fa-utensils"></i> Italian, Pizza, Pasta</p>
                <p style="margin-bottom: 0.5rem;"><i class="fas fa-clock"></i> Open: 10:00 AM - 10:00 PM</p>
                <div style="display: flex; align-items: center; margin-top: 1rem;">
                    <span style="background-color: var(--primary-color); color: white; padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold; margin-right: 1rem;">4.5 <i class="fas fa-star"></i></span>
                    <span>(120 reviews)</span>
                </div>
            </div>
            <div class="col-md-4 col-sm-12" style="display: flex; justify-content: flex-end; align-items: center;">
                <a href="#" class="btn btn-primary" style="margin-right: 1rem;"><i class="fas fa-heart"></i> Favorite</a>
                <a href="#" class="btn btn-secondary"><i class="fas fa-share-alt"></i> Share</a>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-3 col-sm-12" style="margin-bottom: 2rem;">
        <div class="card" style="position: sticky; top: 2rem;">
            <div class="card-header">
                <h3 class="card-title">Categories</h3>
            </div>
            <div style="padding: 0;">
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="#pizzas" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            Pizzas
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="#pastas" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            Pastas
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="#salads" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            Salads
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="#desserts" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            Desserts
                        </a>
                    </li>
                    <li>
                        <a href="#beverages" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            Beverages
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="col-md-9 col-sm-12">
        <!-- Pizzas Section -->
        <div id="pizzas" class="card" style="margin-bottom: 2rem;">
            <div class="card-header">
                <h2 class="card-title">Pizzas</h2>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <!-- Pizza 1 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1574071318508-1cdbab80d002?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80" alt="Margherita Pizza" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Margherita Pizza</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$12.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Classic pizza with tomato sauce, mozzarella, and basil</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pizza 2 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" alt="Pepperoni Pizza" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Pepperoni Pizza</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$14.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Pizza with tomato sauce, mozzarella, and pepperoni</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pizza 3 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1594007654729-407eedc4fe24?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80" alt="Vegetarian Pizza" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Vegetarian Pizza</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$13.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Pizza with tomato sauce, mozzarella, and assorted vegetables</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pizza 4 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" alt="Hawaiian Pizza" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Hawaiian Pizza</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$15.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Pizza with tomato sauce, mozzarella, ham, and pineapple</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Pastas Section -->
        <div id="pastas" class="card" style="margin-bottom: 2rem;">
            <div class="card-header">
                <h2 class="card-title">Pastas</h2>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <!-- Pasta 1 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80" alt="Spaghetti Bolognese" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Spaghetti Bolognese</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$10.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Spaghetti with rich meat sauce</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pasta 2 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1608219992759-8d74ed8d76eb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" alt="Fettuccine Alfredo" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Fettuccine Alfredo</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$11.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Fettuccine pasta with creamy Alfredo sauce</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Beverages Section -->
        <div id="beverages" class="card" style="margin-bottom: 2rem;">
            <div class="card-header">
                <h2 class="card-title">Beverages</h2>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <!-- Beverage 1 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1581636625402-29b2a704ef13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80" alt="Coca Cola" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Coca Cola</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$2.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Refreshing cola drink</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Beverage 2 -->
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div style="display: flex;">
                            <img src="https://images.unsplash.com/photo-1603569283847-aa295f0d016a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=722&q=80" alt="Sprite" style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px; margin-right: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                    <h3 style="margin: 0; font-size: 1.2rem;">Sprite</h3>
                                    <span style="font-weight: bold; color: var(--primary-color);">$2.99</span>
                                </div>
                                <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Refreshing lemon-lime soda</p>
                                <button class="btn btn-sm btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div style="position: fixed; bottom: 20px; right: 20px; z-index: 100;">
    <a href="${pageContext.request.contextPath}/cart" class="btn btn-primary" style="display: flex; align-items: center; padding: 0.75rem 1.5rem; border-radius: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
        <i class="fas fa-shopping-cart" style="margin-right: 0.5rem;"></i>
        <span>View Cart</span>
        <span style="background-color: white; color: var(--primary-color); border-radius: 50%; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; margin-left: 0.5rem; font-weight: bold;">3</span>
    </a>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
