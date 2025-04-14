<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Food Express</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
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
                <nav>
                    <ul id="navMenu">
                        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/restaurants"><i class="fas fa-utensils"></i> Restaurants</a></li>
                        <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-info-circle"></i> About</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-envelope"></i> Contact</a></li>

                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <li><a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                                <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Register</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                                <li><a href="${pageContext.request.contextPath}/orders"><i class="fas fa-list-alt"></i> My Orders</a></li>

                                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Admin</a></li>
                                </c:if>

                                <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> ${sessionScope.user.username}</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main>
        <div class="container">
            <!-- Main content will be here -->
