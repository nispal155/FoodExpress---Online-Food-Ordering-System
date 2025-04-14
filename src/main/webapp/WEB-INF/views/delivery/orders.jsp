<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Delivery - My Orders" />
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
                        <a href="${pageContext.request.contextPath}/delivery/dashboard" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/delivery/orders" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
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
        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert">
                <c:choose>
                    <c:when test="${param.success == 'status-updated'}">
                        <i class="fas fa-check-circle"></i> Order status updated successfully!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-check-circle"></i> Operation completed successfully!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                <c:choose>
                    <c:when test="${param.error == 'not-found'}">
                        <i class="fas fa-exclamation-circle"></i> Order not found!
                    </c:when>
                    <c:when test="${param.error == 'not-assigned'}">
                        <i class="fas fa-exclamation-circle"></i> This order is not assigned to you!
                    </c:when>
                    <c:when test="${param.error == 'status-update-failed'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update order status!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-exclamation-circle"></i> An error occurred!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <div class="card">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">
                    <c:choose>
                        <c:when test="${not empty statusFilter}">
                            ${statusFilter} Orders
                        </c:when>
                        <c:otherwise>
                            All My Orders
                        </c:otherwise>
                    </c:choose>
                </h2>
                <div>
                    <c:if test="${not empty statusFilter}">
                        <a href="${pageContext.request.contextPath}/delivery/orders" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Clear Filter
                        </a>
                    </c:if>
                </div>
            </div>
            <div style="padding: 1rem;">
                <div class="btn-group" style="margin-bottom: 1rem;">
                    <a href="${pageContext.request.contextPath}/delivery/orders?status=READY" class="btn btn-outline-success">
                        Ready for Pickup
                    </a>
                    <a href="${pageContext.request.contextPath}/delivery/orders?status=OUT_FOR_DELIVERY" class="btn btn-outline-primary">
                        Out for Delivery
                    </a>
                    <a href="${pageContext.request.contextPath}/delivery/orders?status=DELIVERED" class="btn btn-outline-secondary">
                        Delivered
                    </a>
                </div>
                
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
                            <c:forEach var="order" items="${orders}">
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
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/delivery/orders/detail?id=${order.id}" class="btn btn-sm btn-secondary" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${order.status == 'READY'}">
                                                <form action="${pageContext.request.contextPath}/delivery/orders/update" method="post" style="display: inline;">
                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                    <input type="hidden" name="status" value="OUT_FOR_DELIVERY">
                                                    <button type="submit" class="btn btn-sm btn-primary" title="Mark as Out for Delivery">
                                                        <i class="fas fa-motorcycle"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${order.status == 'OUT_FOR_DELIVERY'}">
                                                <form action="${pageContext.request.contextPath}/delivery/orders/update" method="post" style="display: inline;">
                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                    <input type="hidden" name="status" value="DELIVERED">
                                                    <button type="submit" class="btn btn-sm btn-success" title="Mark as Delivered">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="7" style="text-align: center;">No orders found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
