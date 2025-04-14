<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - About Us" />
</jsp:include>

<!-- Hero Section -->
<div class="hero-section" style="background-image: url('${pageContext.request.contextPath}/assets/images/about-hero.jpg'); background-size: cover; background-position: center; padding: 5rem 0; text-align: center; color: white; position: relative;">
    <div style="background-color: rgba(0, 0, 0, 0.6); position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
    <div style="position: relative; z-index: 1;">
        <h1 style="font-size: 3rem; margin-bottom: 1rem;">About Food Express</h1>
        <p style="font-size: 1.2rem; margin-bottom: 0; max-width: 800px; margin-left: auto; margin-right: auto;">Connecting food lovers with their favorite restaurants since 2023</p>
    </div>
</div>

<div class="container" style="padding: 4rem 0;">
    <!-- Our Story Section -->
    <div class="row align-items-center" style="margin-bottom: 4rem;">
        <div class="col-md-6">
            <h2 style="margin-bottom: 1.5rem; color: var(--primary-color);">Our Story</h2>
            <p style="margin-bottom: 1rem; line-height: 1.6;">Food Express was founded in 2023 with a simple mission: to connect food lovers with their favorite restaurants in the most convenient way possible. What started as a small startup has quickly grown into a trusted platform serving thousands of customers daily.</p>
            <p style="margin-bottom: 1rem; line-height: 1.6;">Our journey began when our founders, a group of food enthusiasts and tech innovators, recognized the need for a better food delivery experience. They envisioned a platform that would not only make ordering food easy but also support local restaurants and provide reliable delivery services.</p>
            <p style="line-height: 1.6;">Today, Food Express partners with hundreds of restaurants across the country, offering a diverse range of cuisines to satisfy every craving. We're proud to be a part of our customers' daily lives, delivering not just food, but moments of joy and connection.</p>
        </div>
        <div class="col-md-6">
            <img src="${pageContext.request.contextPath}/assets/images/about-story.jpg" alt="Our Story" style="width: 100%; border-radius: 8px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
        </div>
    </div>
    
    <!-- Our Mission Section -->
    <div class="row align-items-center" style="margin-bottom: 4rem; flex-direction: row-reverse;">
        <div class="col-md-6">
            <h2 style="margin-bottom: 1.5rem; color: var(--primary-color);">Our Mission</h2>
            <p style="margin-bottom: 1rem; line-height: 1.6;">At Food Express, our mission is to transform the way people experience food delivery. We believe that ordering food should be simple, reliable, and enjoyable from start to finish.</p>
            <p style="margin-bottom: 1rem; line-height: 1.6;">We're committed to:</p>
            <ul style="margin-bottom: 1rem; line-height: 1.6;">
                <li><strong>Quality:</strong> Partnering with the best restaurants to ensure high-quality food</li>
                <li><strong>Convenience:</strong> Making food ordering as easy and intuitive as possible</li>
                <li><strong>Reliability:</strong> Ensuring timely and accurate deliveries</li>
                <li><strong>Community:</strong> Supporting local restaurants and creating opportunities for delivery partners</li>
                <li><strong>Innovation:</strong> Continuously improving our platform to enhance the customer experience</li>
            </ul>
            <p style="line-height: 1.6;">We measure our success not just by the number of orders we process, but by the satisfaction of our customers, restaurant partners, and delivery team members.</p>
        </div>
        <div class="col-md-6">
            <img src="${pageContext.request.contextPath}/assets/images/about-mission.jpg" alt="Our Mission" style="width: 100%; border-radius: 8px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
        </div>
    </div>
    
    <!-- Our Team Section -->
    <div style="margin-bottom: 4rem; text-align: center;">
        <h2 style="margin-bottom: 2rem; color: var(--primary-color);">Meet Our Team</h2>
        <div class="row">
            <div class="col-md-3 col-sm-6" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <img src="${pageContext.request.contextPath}/assets/images/team-1.jpg" alt="Team Member" style="width: 100%; height: 200px; object-fit: cover;">
                    <div style="padding: 1rem;">
                        <h4 style="margin-bottom: 0.25rem;">John Doe</h4>
                        <p style="color: var(--primary-color); margin-bottom: 0.5rem;">CEO & Co-Founder</p>
                        <p style="font-size: 0.9rem; color: var(--medium-gray); margin-bottom: 0;">Food enthusiast and tech innovator with a passion for creating exceptional customer experiences.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <img src="${pageContext.request.contextPath}/assets/images/team-2.jpg" alt="Team Member" style="width: 100%; height: 200px; object-fit: cover;">
                    <div style="padding: 1rem;">
                        <h4 style="margin-bottom: 0.25rem;">Jane Smith</h4>
                        <p style="color: var(--primary-color); margin-bottom: 0.5rem;">CTO & Co-Founder</p>
                        <p style="font-size: 0.9rem; color: var(--medium-gray); margin-bottom: 0;">Tech wizard with a background in software engineering and a love for solving complex problems.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <img src="${pageContext.request.contextPath}/assets/images/team-3.jpg" alt="Team Member" style="width: 100%; height: 200px; object-fit: cover;">
                    <div style="padding: 1rem;">
                        <h4 style="margin-bottom: 0.25rem;">Michael Johnson</h4>
                        <p style="color: var(--primary-color); margin-bottom: 0.5rem;">COO</p>
                        <p style="font-size: 0.9rem; color: var(--medium-gray); margin-bottom: 0;">Operations expert with experience in logistics and a commitment to efficiency and excellence.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <img src="${pageContext.request.contextPath}/assets/images/team-4.jpg" alt="Team Member" style="width: 100%; height: 200px; object-fit: cover;">
                    <div style="padding: 1rem;">
                        <h4 style="margin-bottom: 0.25rem;">Emily Chen</h4>
                        <p style="color: var(--primary-color); margin-bottom: 0.5rem;">CMO</p>
                        <p style="font-size: 0.9rem; color: var(--medium-gray); margin-bottom: 0;">Marketing strategist with a creative approach to building brand awareness and customer engagement.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Testimonials Section -->
    <div style="margin-bottom: 4rem; text-align: center;">
        <h2 style="margin-bottom: 2rem; color: var(--primary-color);">What Our Customers Say</h2>
        <div class="row">
            <div class="col-md-4" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; padding: 2rem; height: 100%; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <div style="color: var(--warning-color); margin-bottom: 1rem;">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p style="font-style: italic; margin-bottom: 1.5rem; line-height: 1.6;">"Food Express has been a game-changer for me. The app is so easy to use, and the delivery is always on time. I love being able to track my order in real-time!"</p>
                    <div>
                        <h5 style="margin-bottom: 0.25rem;">Sarah Thompson</h5>
                        <p style="color: var(--medium-gray); margin-bottom: 0;">Loyal Customer</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; padding: 2rem; height: 100%; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <div style="color: var(--warning-color); margin-bottom: 1rem;">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p style="font-style: italic; margin-bottom: 1.5rem; line-height: 1.6;">"As a restaurant owner, partnering with Food Express has helped us reach new customers and increase our sales. Their platform is reliable and their team is always responsive."</p>
                    <div>
                        <h5 style="margin-bottom: 0.25rem;">David Rodriguez</h5>
                        <p style="color: var(--medium-gray); margin-bottom: 0;">Restaurant Partner</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4" style="margin-bottom: 2rem;">
                <div style="background-color: #f9f9f9; border-radius: 8px; padding: 2rem; height: 100%; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <div style="color: var(--warning-color); margin-bottom: 1rem;">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p style="font-style: italic; margin-bottom: 1.5rem; line-height: 1.6;">"I love the variety of restaurants available on Food Express. It's my go-to app for ordering food, whether it's for a quick lunch or a family dinner. The special offers are a nice bonus too!"</p>
                    <div>
                        <h5 style="margin-bottom: 0.25rem;">Alex Johnson</h5>
                        <p style="color: var(--medium-gray); margin-bottom: 0;">Regular User</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Call to Action -->
    <div style="text-align: center; background-color: #f9f9f9; padding: 3rem; border-radius: 8px; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
        <h2 style="margin-bottom: 1rem; color: var(--primary-color);">Ready to Order?</h2>
        <p style="margin-bottom: 2rem; max-width: 600px; margin-left: auto; margin-right: auto;">Join thousands of satisfied customers and experience the convenience of Food Express today.</p>
        <div>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg" style="margin-right: 1rem;">Browse Restaurants</a>
            <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-primary btn-lg">Contact Us</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
