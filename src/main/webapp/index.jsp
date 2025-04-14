<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Home" />
</jsp:include>

<section class="hero" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'); background-size: cover; background-position: center; color: white; text-align: center; padding: 100px 0;">
    <h1 style="font-size: 3rem; margin-bottom: 1rem;">Delicious Food Delivered to Your Door</h1>
    <p style="font-size: 1.2rem; margin-bottom: 2rem;">Order from your favorite restaurants and enjoy a tasty meal at home</p>
    <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg">Order Now</a>
</section>

<section style="padding: 3rem 0;">
    <div class="row">
        <div class="col-md-4 col-sm-12" style="text-align: center; margin-bottom: 2rem;">
            <i class="fas fa-utensils" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
            <h3>Wide Selection</h3>
            <p>Choose from hundreds of restaurants and thousands of dishes.</p>
        </div>
        <div class="col-md-4 col-sm-12" style="text-align: center; margin-bottom: 2rem;">
            <i class="fas fa-truck" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
            <h3>Fast Delivery</h3>
            <p>Get your food delivered to your doorstep in minutes.</p>
        </div>
        <div class="col-md-4 col-sm-12" style="text-align: center; margin-bottom: 2rem;">
            <i class="fas fa-mobile-alt" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
            <h3>Easy Ordering</h3>
            <p>Order with just a few clicks and track your delivery in real-time.</p>
        </div>
    </div>
</section>

<section style="background-color: var(--light-gray); padding: 3rem 0;">
    <h2 style="text-align: center; margin-bottom: 2rem;">How It Works</h2>
    <div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: center; margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <div style="background-color: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">1</div>
                <h3>Choose Restaurant</h3>
                <p>Browse through our wide selection of restaurants.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: center; margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <div style="background-color: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">2</div>
                <h3>Select Menu Items</h3>
                <p>Pick your favorite dishes from the restaurant's menu.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: center; margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <div style="background-color: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">3</div>
                <h3>Place Order</h3>
                <p>Confirm your order and proceed to checkout.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 col-xs-12" style="text-align: center; margin-bottom: 2rem;">
            <div class="card" style="height: 100%;">
                <div style="background-color: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">4</div>
                <h3>Enjoy Your Meal</h3>
                <p>Receive your food and enjoy a delicious meal.</p>
            </div>
        </div>
    </div>
</section>

<section style="padding: 3rem 0; text-align: center;">
    <h2 style="margin-bottom: 2rem;">Ready to Order?</h2>
    <p style="margin-bottom: 2rem; font-size: 1.2rem;">Create an account or login to start ordering your favorite food.</p>
    <div>
        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="margin-right: 1rem;">Register</a>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">Login</a>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp" />