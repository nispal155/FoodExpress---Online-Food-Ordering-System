<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Orders" />
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
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
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
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
        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert">
                <c:choose>
                    <c:when test="${param.success == 'cancelled'}">
                        <i class="fas fa-check-circle"></i> Order cancelled successfully!
                    </c:when>
                    <c:when test="${param.success == 'assigned'}">
                        <i class="fas fa-check-circle"></i> Order assigned successfully!
                    </c:when>
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
                    <c:when test="${param.error == 'cancel-failed'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to cancel order!
                    </c:when>
                    <c:when test="${param.error == 'assign-failed'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to assign order!
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
        
        <!-- Order Status Cards -->
        <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(33, 150, 243, 0.1); border-color: var(--secondary-color);">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: var(--secondary-color);">Pending</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${pendingCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=PENDING" class="btn btn-sm btn-secondary" style="margin-top: 0.5rem;">View</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(255, 193, 7, 0.1); border-color: var(--warning-color);">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: var(--warning-color);">Confirmed</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${confirmedCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=CONFIRMED" class="btn btn-sm btn-warning" style="margin-top: 0.5rem;">View</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(255, 87, 34, 0.1); border-color: var(--primary-color);">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: var(--primary-color);">Preparing</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${preparingCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=PREPARING" class="btn btn-sm btn-primary" style="margin-top: 0.5rem;">View</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(76, 175, 80, 0.1); border-color: var(--success-color);">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: var(--success-color);">Ready</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${readyCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=READY" class="btn btn-sm btn-success" style="margin-top: 0.5rem;">View</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(156, 39, 176, 0.1); border-color: #9c27b0;">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: #9c27b0;">Out for Delivery</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${outForDeliveryCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=OUT_FOR_DELIVERY" class="btn btn-sm" style="margin-top: 0.5rem; background-color: #9c27b0; color: white;">View</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(0, 150, 136, 0.1); border-color: #009688;">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: #009688;">Delivered</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${deliveredCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=DELIVERED" class="btn btn-sm" style="margin-top: 0.5rem; background-color: #009688; color: white;">View</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(244, 67, 54, 0.1); border-color: var(--danger-color);">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: var(--danger-color);">Cancelled</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${cancelledCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders?status=CANCELLED" class="btn btn-sm btn-danger" style="margin-top: 0.5rem;">View</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6 col-xs-12" style="margin-bottom: 1rem;">
                <div class="card" style="background-color: rgba(255, 152, 0, 0.1); border-color: #ff9800;">
                    <div style="text-align: center; padding: 0.5rem;">
                        <h3 style="margin: 0; color: #ff9800;">Need Assignment</h3>
                        <p style="font-size: 1.5rem; font-weight: bold; margin: 0;">${needAssignmentCount}</p>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm" style="margin-top: 0.5rem; background-color: #ff9800; color: white;">View All</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card" style="margin-top: 1rem;">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">
                    <c:choose>
                        <c:when test="${not empty statusFilter}">
                            ${statusFilter} Orders
                        </c:when>
                        <c:otherwise>
                            All Orders
                        </c:otherwise>
                    </c:choose>
                </h2>
                <div>
                    <c:if test="${not empty statusFilter}">
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Clear Filter
                        </a>
                    </c:if>
                </div>
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
                                <th>Delivery Person</th>
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
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span style="background-color: rgba(33, 150, 243, 0.1); color: var(--secondary-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Pending</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <span style="background-color: rgba(255, 193, 7, 0.1); color: var(--warning-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Confirmed</span>
                                            </c:when>
                                            <c:when test="${order.status == 'PREPARING'}">
                                                <span style="background-color: rgba(255, 87, 34, 0.1); color: var(--primary-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Preparing</span>
                                            </c:when>
                                            <c:when test="${order.status == 'READY'}">
                                                <span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Ready</span>
                                            </c:when>
                                            <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                                <span style="background-color: rgba(156, 39, 176, 0.1); color: #9c27b0; padding: 0.25rem 0.5rem; border-radius: 4px;">Out for Delivery</span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <span style="background-color: rgba(0, 150, 136, 0.1); color: #009688; padding: 0.25rem 0.5rem; border-radius: 4px;">Delivered</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span style="background-color: rgba(244, 67, 54, 0.1); color: var(--danger-color); padding: 0.25rem 0.5rem; border-radius: 4px;">Cancelled</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.deliveryPersonName}">
                                                ${order.deliveryPersonName}
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--danger-color);">Not Assigned</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/admin/orders/detail?id=${order.id}" class="btn btn-sm btn-secondary" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${order.canBeCancelled()}">
                                                <button type="button" class="btn btn-sm btn-danger" title="Cancel Order" onclick="confirmCancel(${order.id})">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="8" style="text-align: center;">No orders found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Cancel Order Confirmation Modal -->
<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cancelModalLabel">Confirm Cancellation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to cancel this order? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, Keep Order</button>
                <form action="${pageContext.request.contextPath}/admin/orders/cancel" method="post">
                    <input type="hidden" id="cancelOrderId" name="orderId" value="">
                    <button type="submit" class="btn btn-danger">Yes, Cancel Order</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Function to confirm order cancellation
    function confirmCancel(orderId) {
        document.getElementById('cancelOrderId').value = orderId;
        var cancelModal = new bootstrap.Modal(document.getElementById('cancelModal'));
        cancelModal.show();
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
