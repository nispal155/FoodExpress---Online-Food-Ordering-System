<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin Dashboard" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Include the admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp">
        <jsp:param name="activeMenu" value="dashboard" />
    </jsp:include>

    <!-- Admin Content -->
    <div class="admin-content">
        <!-- Dashboard Header -->
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Dashboard</h1>
                <div class="admin-breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </div>
                <p>Welcome to the admin dashboard</p>
            </div>
            <div class="admin-page-actions">
                <a href="${pageContext.request.contextPath}/admin/settings" class="admin-btn admin-btn-light">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="admin-stats-container">
            <a href="${pageContext.request.contextPath}/admin/users" class="admin-stat-card animate__animated animate__fadeIn" style="animation-delay: 0.1s;">
                <div class="admin-stat-icon" style="background-color: rgba(33, 150, 243, 0.1); color: #2196F3;">
                    <i class="fas fa-users"></i>
                </div>
                <div class="admin-stat-title">Total Users</div>
                <div class="admin-stat-value">${userCount != null ? userCount : 5}</div>
                <div class="admin-stat-change positive">
                    <i class="fas fa-arrow-up"></i> 12% from last month
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/restaurants" class="admin-stat-card animate__animated animate__fadeIn" style="animation-delay: 0.2s;">
                <div class="admin-stat-icon" style="background-color: rgba(255, 87, 34, 0.1); color: #FF5722;">
                    <i class="fas fa-utensils"></i>
                </div>
                <div class="admin-stat-title">Restaurants</div>
                <div class="admin-stat-value">${restaurantCount != null ? restaurantCount : 3}</div>
                <div class="admin-stat-change positive">
                    <i class="fas fa-arrow-up"></i> 5% from last month
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/menu-items" class="admin-stat-card animate__animated animate__fadeIn" style="animation-delay: 0.3s;">
                <div class="admin-stat-icon" style="background-color: rgba(76, 175, 80, 0.1); color: #4CAF50;">
                    <i class="fas fa-hamburger"></i>
                </div>
                <div class="admin-stat-title">Menu Items</div>
                <div class="admin-stat-value">${menuItemCount != null ? menuItemCount : 9}</div>
                <div class="admin-stat-change positive">
                    <i class="fas fa-arrow-up"></i> 8% from last month
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/reporting" class="admin-stat-card animate__animated animate__fadeIn" style="animation-delay: 0.4s;">
                <div class="admin-stat-icon" style="background-color: rgba(255, 193, 7, 0.1); color: #FFC107;">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="admin-stat-title">Reports</div>
                <div class="admin-stat-value"><i class="fas fa-chart-line"></i></div>
                <div class="admin-stat-change">
                    <i class="fas fa-info-circle"></i> View detailed reports
                </div>
            </a>
        </div>

        <!-- Recent Orders -->
        <div class="admin-card animate__animated animate__fadeIn" style="animation-delay: 0.5s;">
            <div class="admin-card-header">
                <h2 class="admin-card-title">Recent Orders</h2>
                <p class="admin-card-subtitle">Latest orders from customers</p>
            </div>
            <div class="admin-card-body">
                <table class="admin-table">
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
                            <td class="actions">
                                <a href="#" class="action-btn view" title="View Order"><i class="fas fa-eye"></i></a>
                                <a href="#" class="action-btn edit" title="Edit Order"><i class="fas fa-edit"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>#1002</td>
                            <td>Ankita Raut</td>
                            <td>Falaicha</td>
                            <td>$55.99</td>
                            <td><span class="status-badge status-preparing">Preparing</span></td>
                            <td>2025-04-10</td>
                            <td class="actions">
                                <a href="#" class="action-btn view" title="View Order"><i class="fas fa-eye"></i></a>
                                <a href="#" class="action-btn edit" title="Edit Order"><i class="fas fa-edit"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>#1003</td>
                            <td>John Doe</td>
                            <td>Pizza Palace</td>
                            <td>$24.99</td>
                            <td><span class="status-badge status-out-for-delivery">Out for Delivery</span></td>
                            <td>2025-04-15</td>
                            <td class="actions">
                                <a href="#" class="action-btn view" title="View Order"><i class="fas fa-eye"></i></a>
                                <a href="#" class="action-btn edit" title="Edit Order"><i class="fas fa-edit"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>#1004</td>
                            <td>Ankita Raut</td>
                            <td>Falaicha</td>
                            <td>$55.99</td>
                            <td><span class="status-badge status-cancelled">Cancelled</span></td>
                            <td>2025-04-10</td>
                            <td class="actions">
                                <a href="#" class="action-btn view" title="View Order"><i class="fas fa-eye"></i></a>
                                <a href="#" class="action-btn edit" title="Edit Order"><i class="fas fa-edit"></i></a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="admin-card-footer">
                <a href="${pageContext.request.contextPath}/admin/orders" class="admin-btn admin-btn-primary">
                    <i class="fas fa-list"></i> View all orders
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
