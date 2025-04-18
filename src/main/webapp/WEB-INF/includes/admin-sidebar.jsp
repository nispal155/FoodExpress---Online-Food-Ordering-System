<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="list-group mb-4">
    <a href="${pageContext.request.contextPath}/admin/dashboard" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/dashboard.jsp' ? 'active' : ''}">
        <i class="fas fa-tachometer-alt"></i> Dashboard
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/users" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/users.jsp' ? 'active' : ''}">
        <i class="fas fa-users"></i> Users
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/restaurants" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/restaurants.jsp' ? 'active' : ''}">
        <i class="fas fa-utensils"></i> Restaurants
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/menu-items" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/menu-items.jsp' ? 'active' : ''}">
        <i class="fas fa-hamburger"></i> Menu Items
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/orders" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/orders.jsp' ? 'active' : ''}">
        <i class="fas fa-shopping-cart"></i> Orders
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/reports" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/reports.jsp' ? 'active' : ''}">
        <i class="fas fa-chart-bar"></i> Reports
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/email-config" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/email-config.jsp' ? 'active' : ''}">
        <i class="fas fa-envelope"></i> Email Configuration
    </a>
    
    <a href="${pageContext.request.contextPath}/admin/settings" 
       class="list-group-item list-group-item-action ${pageContext.request.servletPath eq '/WEB-INF/views/admin/settings.jsp' ? 'active' : ''}">
        <i class="fas fa-cog"></i> Settings
    </a>
</div>
