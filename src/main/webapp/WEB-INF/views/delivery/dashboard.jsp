<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Delivery Dashboard" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-3 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Delivery Menu</h2>
            </div>
            <div style="padding: 0;">
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/delivery/dashboard" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/delivery/orders" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-list-alt"></i> My Orders
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/profile" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-user"></i> Profile
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="col-md-9 col-sm-12">
        <div class="row">
            <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                <div class="card" style="background-color: rgba(76, 175, 80, 0.1); border-color: var(--success-color);">
                    <div style="text-align: center; padding: 1rem;">
                        <i class="fas fa-clipboard-list" style="font-size: 2.5rem; color: var(--success-color);"></i>
                        <h3 style="margin: 0.5rem 0; color: var(--success-color);">Ready for Pickup</h3>
                        <p style="font-size: 2rem; font-weight: bold; margin: 0;">${readyCount}</p>
                        <a href="${pageContext.request.contextPath}/delivery/orders?status=READY" class="btn btn-success" style="margin-top: 0.5rem;">View Orders</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                <div class="card" style="background-color: rgba(156, 39, 176, 0.1); border-color: #9c27b0;">
                    <div style="text-align: center; padding: 1rem;">
                        <i class="fas fa-motorcycle" style="font-size: 2.5rem; color: #9c27b0;"></i>
                        <h3 style="margin: 0.5rem 0; color: #9c27b0;">Out for Delivery</h3>
                        <p style="font-size: 2rem; font-weight: bold; margin: 0;">${outForDeliveryCount}</p>
                        <a href="${pageContext.request.contextPath}/delivery/orders?status=OUT_FOR_DELIVERY" class="btn" style="margin-top: 0.5rem; background-color: #9c27b0; color: white;">View Orders</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 1.5rem;">
                <div class="card" style="background-color: rgba(0, 150, 136, 0.1); border-color: #009688;">
                    <div style="text-align: center; padding: 1rem;">
                        <i class="fas fa-check-circle" style="font-size: 2.5rem; color: #009688;"></i>
                        <h3 style="margin: 0.5rem 0; color: #009688;">Delivered Today</h3>
                        <p style="font-size: 2rem; font-weight: bold; margin: 0;">${deliveredCount}</p>
                        <a href="${pageContext.request.contextPath}/delivery/orders?status=DELIVERED" class="btn" style="margin-top: 0.5rem; background-color: #009688; color: white;">View Orders</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">My Assigned Orders</h2>
            </div>
            <div style="padding: 1rem;">
                <c:choose>
                    <c:when test="${not empty assignedOrders}">
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
                                    <c:forEach var="order" items="${assignedOrders}">
                                        <tr>
                                            <td>#${order.id}</td>
                                            <td>${order.customerName}</td>
                                            <td>${order.restaurantName}</td>
                                            <td>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'READY'}">
                                                        <span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Ready</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                                        <span style="background-color: rgba(156, 39, 176, 0.1); color: #9c27b0; padding: 0.25rem 0.5rem; border-radius: 4px;">Out for Delivery</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <span style="background-color: rgba(0, 150, 136, 0.1); color: #009688; padding: 0.25rem 0.5rem; border-radius: 4px;">Delivered</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="background-color: rgba(158, 158, 158, 0.1); color: var(--dark-gray); padding: 0.25rem 0.5rem; border-radius: 4px;">${order.status.displayName}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/delivery/orders/detail?id=${order.id}" class="btn btn-sm btn-secondary">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info" role="alert">
                            <i class="fas fa-info-circle"></i> You don't have any assigned orders yet.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
