<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Dashboard" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-4 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">User Profile</h2>
            </div>
            <div class="user-info" style="padding: 1rem;">
                <div style="text-align: center; margin-bottom: 1.5rem;">
                    <c:choose>
                        <c:when test="${not empty user.profilePicture}">
                            <img src="${pageContext.request.contextPath}${user.profilePicture}" alt="${user.fullName}" style="border-radius: 50%; width: 100px; height: 100px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="https://ui-avatars.com/api/?name=${user.fullName}&background=FF5722&color=fff&size=100" alt="${user.fullName}" style="border-radius: 50%;">
                        </c:otherwise>
                    </c:choose>
                    <h3 style="margin-top: 0.5rem;">${user.fullName}</h3>
                    <p style="color: var(--primary-color);">${user.role}</p>
                </div>

                <div style="margin-bottom: 1rem;">
                    <p><strong><i class="fas fa-envelope"></i> Email:</strong> ${user.email}</p>
                    <p><strong><i class="fas fa-phone"></i> Phone:</strong> ${user.phone != null ? user.phone : 'Not provided'}</p>
                    <p><strong><i class="fas fa-map-marker-alt"></i> Address:</strong> ${user.address != null ? user.address : 'Not provided'}</p>
                </div>

                <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary btn-block"><i class="fas fa-user-edit"></i> Edit Profile</a>
            </div>
        </div>
    </div>

    <div class="col-md-8 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Quick Actions</h2>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="height: 100%;">
                            <div style="text-align: center; margin-bottom: 1rem;">
                                <i class="fas fa-utensils" style="font-size: 3rem; color: var(--primary-color);"></i>
                            </div>
                            <h3 style="text-align: center;">Order Food</h3>
                            <p>Browse our restaurants and order your favorite food.</p>
                            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-block">Browse Restaurants</a>
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="height: 100%;">
                            <div style="text-align: center; margin-bottom: 1rem;">
                                <i class="fas fa-list-alt" style="font-size: 3rem; color: var(--primary-color);"></i>
                            </div>
                            <h3 style="text-align: center;">Track Orders</h3>
                            <p>Track your current orders and view order history.</p>
                            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary btn-block">View Orders</a>
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="height: 100%;">
                            <div style="text-align: center; margin-bottom: 1rem;">
                                <i class="fas fa-heart" style="font-size: 3rem; color: var(--primary-color);"></i>
                            </div>
                            <h3 style="text-align: center;">Favorites</h3>
                            <p>View and manage your favorite restaurants and dishes.</p>
                            <a href="${pageContext.request.contextPath}/favorites" class="btn btn-primary btn-block">My Favorites</a>
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="height: 100%;">
                            <div style="text-align: center; margin-bottom: 1rem;">
                                <i class="fas fa-cog" style="font-size: 3rem; color: var(--primary-color);"></i>
                            </div>
                            <h3 style="text-align: center;">Settings</h3>
                            <p>Manage your account settings and preferences.</p>
                            <a href="${pageContext.request.contextPath}/settings" class="btn btn-primary btn-block">Account Settings</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card" style="margin-top: 1.5rem;">
            <div class="card-header">
                <h2 class="card-title">Recent Orders</h2>
            </div>
            <div style="padding: 1rem;">
                <p>You don't have any recent orders.</p>
                <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">Order Now</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
