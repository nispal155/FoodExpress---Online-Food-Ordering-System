<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
</jsp:include>

<!-- Include the admin dashboard CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">

<div class="admin-container">
    <!-- Admin Sidebar -->
    <div class="admin-sidebar">
        <div class="admin-menu-title">Admin Menu</div>
        <ul class="admin-menu">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Users
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/restaurants">
                    <i class="fas fa-utensils"></i> Restaurant
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/menu-items">
                    <i class="fas fa-hamburger"></i> Menu Items
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/reporting">
                    <i class="fas fa-chart-bar"></i> Reports
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/settings">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
    </div>

    <!-- Admin Content -->
    <div class="admin-content">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1>Dashboard</h1>
            <p>Welcome to the admin dashboard</p>
        </div>

        <!-- Dashboard Cards -->
        <div class="dashboard-cards">
            <a href="${pageContext.request.contextPath}/admin/users" class="dashboard-card-link">
                <div class="dashboard-card dashboard-card-users">
                    <div class="dashboard-card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="dashboard-card-title">Users</div>
                    <div class="dashboard-card-value">${userCount}</div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/restaurants" class="dashboard-card-link">
                <div class="dashboard-card dashboard-card-restaurants">
                    <div class="dashboard-card-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="dashboard-card-title">Restaurants</div>
                    <div class="dashboard-card-value">${restaurantCount}</div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/menu-items" class="dashboard-card-link">
                <div class="dashboard-card dashboard-card-menu">
                    <div class="dashboard-card-icon">
                        <i class="fas fa-hamburger"></i>
                    </div>
                    <div class="dashboard-card-title">Menu Items</div>
                    <div class="dashboard-card-value">${menuItemCount}</div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/reporting" class="dashboard-card-link">
                <div class="dashboard-card dashboard-card-specials">
                    <div class="dashboard-card-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="dashboard-card-title">Reports</div>
                    <div class="dashboard-card-value"><i class="fas fa-chart-line"></i></div>
                </div>
            </a>
        </div>

        <!-- Recent Orders -->
        <div class="recent-orders">
            <div class="recent-orders-header">
                <h2>Recent Orders</h2>
            </div>
            <div class="recent-orders-content">
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Restaurant</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#1001</td>
                            <td>John Doe</td>
                            <td>Pizza Palace</td>
                            <td>$24.99</td>
                            <td><span class="status-badge status-delivered">Delivered</span></td>
                            <td>2025-04-15</td>
                            <td>
                                <a href="#" class="action-button"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>#1002</td>
                            <td>Ankita Raut</td>
                            <td>Falaicha</td>
                            <td>$55.99</td>
                            <td><span class="status-badge status-preparing">Preparing</span></td>
                            <td>2025-04-10</td>
                            <td>
                                <a href="#" class="action-button"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>#1003</td>
                            <td>John Doe</td>
                            <td>Pizza Palace</td>
                            <td>$24.99</td>
                            <td><span class="status-badge status-out-for-delivery">Out of Delivery</span></td>
                            <td>2025-04-15</td>
                            <td>
                                <a href="#" class="action-button"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>#1004</td>
                            <td>Ankita Raut</td>
                            <td>Falaicha</td>
                            <td>$55.99</td>
                            <td><span class="status-badge status-cancelled">Cancelled</span></td>
                            <td>2025-04-10</td>
                            <td>
                                <a href="#" class="action-button"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <a href="${pageContext.request.contextPath}/admin/orders" class="view-all-button">View all orders</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
