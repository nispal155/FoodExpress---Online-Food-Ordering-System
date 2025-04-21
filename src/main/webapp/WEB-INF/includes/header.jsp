<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Food Express</title>
    <!-- Custom CSS instead of Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom-bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/terms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/">Food Express</a>
                </div>
                <button class="mobile-menu-btn" id="mobileMenuBtn">
                    <i class="fas fa-bars"></i>
                </button>
                <nav class="${not empty sessionScope.user and (sessionScope.user.role eq 'ADMIN' ? 'admin-nav' : (sessionScope.user.role eq 'DELIVERY' ? 'delivery-nav' : ''))}">
                    <ul id="navMenu">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user and sessionScope.user.role eq 'ADMIN'}">
                                <!-- Admin Navigation Menu -->
                                <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/restaurants"><i class="fas fa-utensils"></i> Restaurants</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                                <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> AdminProfile</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                            </c:when>
                            <c:when test="${not empty sessionScope.user and sessionScope.user.role eq 'DELIVERY'}">
                                <!-- Delivery Person Navigation Menu -->
                                <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/restaurants"><i class="fas fa-utensils"></i> Restaurants</a></li>
                                <li><a href="${pageContext.request.contextPath}/terms"><i class="fas fa-file-contract"></i> Terms</a></li>
                                <li><a href="${pageContext.request.contextPath}/delivery/dashboard"><i class="fas fa-motorcycle"></i> Dashboard</a></li>
                                <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                            </c:when>
                            <c:otherwise>
                                <!-- Regular User Navigation Menu -->
                                <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-info-circle"></i> About</a></li>
                                <li><a href="${pageContext.request.contextPath}/restaurants"><i class="fas fa-utensils"></i> Restaurants</a></li>
                                <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-envelope"></i> Contact</a></li>
                                <li><a href="${pageContext.request.contextPath}/terms"><i class="fas fa-file-contract"></i> Terms</a></li>

                                <c:choose>
                                    <c:when test="${empty sessionScope.user}">
                                        <li><a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                                        <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Register</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="cart-menu-item">
                                            <a href="${pageContext.request.contextPath}/cart" class="cart-link">
                                                <i class="fas fa-shopping-cart"></i> Cart
                                                <c:if test="${not empty sessionScope.cart and sessionScope.cart.totalItems > 0}">
                                                    <span class="cart-badge">${sessionScope.cart.totalItems}</span>
                                                </c:if>
                                            </a>
                                        </li>
                                        <li><a href="${pageContext.request.contextPath}/orders"><i class="fas fa-list-alt"></i> My Orders</a></li>
                                        <li><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-user"></i> ${sessionScope.user.username}</a></li>
                                        <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main>
        <!-- Main content will be here -->
