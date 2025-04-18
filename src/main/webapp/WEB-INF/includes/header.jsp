<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Food Express</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/">Food Express</a>
                </div>
                <button class="mobile-menu-btn" id="mobileMenuBtn">
                    <span class="icon-menu"></span>
                </button>
                <nav>
                    <ul id="navMenu">
                        <li><a href="${pageContext.request.contextPath}/"><span class="icon-home"></span> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/restaurants"><span class="icon-menu"></span> Restaurants</a></li>
                        <li><a href="${pageContext.request.contextPath}/about"><span class="icon-info"></span> About</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact"><span class="icon-envelope"></span> Contact</a></li>

                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <li><a href="${pageContext.request.contextPath}/login"><span class="icon-lock"></span> Login</a></li>
                                <li><a href="${pageContext.request.contextPath}/register"><span class="icon-user"></span> Register</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${pageContext.request.contextPath}/cart"><span class="icon-cart"></span> Cart</a></li>
                                <li><a href="${pageContext.request.contextPath}/orders"><span class="icon-menu"></span> My Orders</a></li>

                                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><span class="icon-settings"></span> Admin</a></li>
                                </c:if>

                                <li><a href="${pageContext.request.contextPath}/profile"><span class="icon-user"></span> ${sessionScope.user.username}</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout"><span class="icon-unlock"></span> Logout</a></li>
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
