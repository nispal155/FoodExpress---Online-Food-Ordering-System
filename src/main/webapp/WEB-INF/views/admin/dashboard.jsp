<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-3 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Admin Menu</h2>
            </div>
            <div style="padding: 0;">
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/users" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-users"></i> Users
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/restaurants" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-utensils"></i> Restaurants
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-hamburger"></i> Menu Items
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/settings" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-9 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Dashboard</h2>
                <p>Welcome to the admin dashboard</p>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="background-color: rgba(33, 150, 243, 0.1); border-color: var(--secondary-color);">
                            <div style="text-align: center;">
                                <i class="fas fa-users" style="font-size: 2.5rem; color: var(--secondary-color);"></i>
                                <h3 style="margin: 0.5rem 0; color: var(--secondary-color);">Users</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">${userCount}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="background-color: rgba(255, 87, 34, 0.1); border-color: var(--primary-color);">
                            <div style="text-align: center;">
                                <i class="fas fa-utensils" style="font-size: 2.5rem; color: var(--primary-color);"></i>
                                <h3 style="margin: 0.5rem 0; color: var(--primary-color);">Restaurants</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">${restaurantCount}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="background-color: rgba(76, 175, 80, 0.1); border-color: var(--success-color);">
                            <div style="text-align: center;">
                                <i class="fas fa-hamburger" style="font-size: 2.5rem; color: var(--success-color);"></i>
                                <h3 style="margin: 0.5rem 0; color: var(--success-color);">Menu Items</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">${menuItemCount}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                        <div class="card" style="background-color: rgba(255, 193, 7, 0.1); border-color: var(--warning-color);">
                            <div style="text-align: center;">
                                <i class="fas fa-star" style="font-size: 2.5rem; color: var(--warning-color);"></i>
                                <h3 style="margin: 0.5rem 0; color: var(--warning-color);">Specials</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">${specialItemCount}</p>
                            </div>
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
                <div class="table-responsive">
                    <table class="table">
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
                                <td><span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Delivered</span></td>
                                <td>2023-04-15</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-secondary"><i class="fas fa-eye"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>#1002</td>
                                <td>Jane Smith</td>
                                <td>Burger King</td>
                                <td>$18.50</td>
                                <td><span style="background-color: rgba(255, 193, 7, 0.1); color: var(--warning-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Out for Delivery</span></td>
                                <td>2023-04-15</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-secondary"><i class="fas fa-eye"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>#1003</td>
                                <td>Robert Johnson</td>
                                <td>Taco Bell</td>
                                <td>$15.75</td>
                                <td><span style="background-color: rgba(33, 150, 243, 0.1); color: var(--secondary-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Preparing</span></td>
                                <td>2023-04-15</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-secondary"><i class="fas fa-eye"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>#1004</td>
                                <td>Emily Davis</td>
                                <td>Subway</td>
                                <td>$12.25</td>
                                <td><span style="background-color: rgba(244, 67, 54, 0.1); color: var(--danger-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Cancelled</span></td>
                                <td>2023-04-14</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-secondary"><i class="fas fa-eye"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>#1005</td>
                                <td>Michael Wilson</td>
                                <td>KFC</td>
                                <td>$22.99</td>
                                <td><span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Delivered</span></td>
                                <td>2023-04-14</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-secondary"><i class="fas fa-eye"></i></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-primary">View All Orders</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
