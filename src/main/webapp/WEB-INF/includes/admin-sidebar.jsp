<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="admin-sidebar">
    <div class="admin-menu-title">
        Admin Dashboard
    </div>

    <ul class="admin-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/dashboard.jsp' ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/users"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/users.jsp' ? 'active' : ''}">
                <i class="fas fa-users"></i>
                <span>Users</span>
                <c:if test="${pendingUserCount > 0}">
                    <span class="menu-badge">${pendingUserCount}</span>
                </c:if>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/restaurants"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/restaurants.jsp' ? 'active' : ''}">
                <i class="fas fa-utensils"></i>
                <span>Restaurants</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/menu-items"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/menu-items.jsp' ? 'active' : ''}">
                <i class="fas fa-hamburger"></i>
                <span>Menu Items</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/orders"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/orders.jsp' ? 'active' : ''}">
                <i class="fas fa-shopping-cart"></i>
                <span>Orders</span>
                <c:if test="${newOrderCount > 0}">
                    <span class="menu-badge">${newOrderCount}</span>
                </c:if>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/reporting"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/reporting.jsp' ? 'active' : ''}">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/email-config"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/email-config.jsp' ? 'active' : ''}">
                <i class="fas fa-envelope"></i>
                <span>Email Config</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/settings"
               class="${pageContext.request.servletPath eq '/WEB-INF/views/admin/settings.jsp' ? 'active' : ''}">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
        </li>
    </ul>

    <div class="admin-user-info">
        <div class="admin-user-avatar">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicture}">
                    <img src="${pageContext.request.contextPath}/uploads/profile/${sessionScope.user.profilePicture}" alt="${sessionScope.user.username}">
                </c:when>
                <c:otherwise>
                    <i class="fas fa-user"></i>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="admin-user-details">
            <p class="admin-user-name">${sessionScope.user.fullName}</p>
            <p class="admin-user-role">Administrator</p>
        </div>
        <div class="admin-user-actions">
            <a href="${pageContext.request.contextPath}/profile" title="Profile">
                <i class="fas fa-user-cog"></i>
            </a>
            <a href="${pageContext.request.contextPath}/logout" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</div>

<!-- Mobile Sidebar Toggle Button -->
<button class="sidebar-toggle" id="sidebarToggle">
    <i class="fas fa-bars"></i>
</button>

<!-- Overlay for Mobile -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.admin-sidebar');
        const overlay = document.getElementById('sidebarOverlay');

        if (sidebarToggle && sidebar && overlay) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('show');
                overlay.classList.toggle('show');
            });

            overlay.addEventListener('click', function() {
                sidebar.classList.remove('show');
                overlay.classList.remove('show');
            });
        }
    });
</script>
