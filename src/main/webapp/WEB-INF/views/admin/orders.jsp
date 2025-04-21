<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Orders" />
</jsp:include>

<!-- Include custom CSS for admin orders -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-orders.css">

<div class="admin-container">
    <!-- Admin Sidebar -->
    <div class="admin-sidebar">
        <div class="admin-menu-title">Admin Menu</div>
        <ul class="admin-menu">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard">
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
                    <i class="fas fa-utensils"></i> Restaurants
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/menu-items">
                    <i class="fas fa-hamburger"></i> Menu Items
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders" class="active">
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

        <!-- Orders Header -->
        <div class="orders-header">
            <h1>Order Management</h1>
        </div>

        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert" style="border-radius: 8px; border-left: 4px solid var(--success-color);">
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
            <div class="alert alert-danger" role="alert" style="border-radius: 8px; border-left: 4px solid var(--danger-color);">
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
        <div class="status-cards-container">
            <div class="status-cards-row">
                <div class="status-card pending">
                    <div class="status-card-title">Pending</div>
                    <div class="status-card-count">${pendingCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=PENDING" class="status-card-link">View</a>
                </div>

                <div class="status-card confirmed">
                    <div class="status-card-title">Confirmed</div>
                    <div class="status-card-count">${confirmedCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=CONFIRMED" class="status-card-link">View</a>
                </div>

                <div class="status-card preparing">
                    <div class="status-card-title">Preparing</div>
                    <div class="status-card-count">${preparingCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=PREPARING" class="status-card-link">View</a>
                </div>

                <div class="status-card ready">
                    <div class="status-card-title">Ready</div>
                    <div class="status-card-count">${readyCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=READY" class="status-card-link">View</a>
                </div>
            </div>

            <div class="status-cards-row">
                <div class="status-card out-for-delivery">
                    <div class="status-card-title">Out for Delivery</div>
                    <div class="status-card-count">${outForDeliveryCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=OUT_FOR_DELIVERY" class="status-card-link">View</a>
                </div>

                <div class="status-card delivered">
                    <div class="status-card-title">Delivered</div>
                    <div class="status-card-count">${deliveredCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=DELIVERED" class="status-card-link">View</a>
                </div>

                <div class="status-card cancelled">
                    <div class="status-card-title">Cancelled</div>
                    <div class="status-card-count">${cancelledCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders?status=CANCELLED" class="status-card-link">View</a>
                </div>

                <div class="status-card need-assignment">
                    <div class="status-card-title">Need Assignment</div>
                    <div class="status-card-count">${needAssignmentCount}</div>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="status-card-link">View All</a>
                </div>
            </div>
        </div>

        <!-- Orders Table Container -->
        <div class="orders-table-container">
            <div class="orders-table-header">
                <h2 class="orders-table-title">
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
                        <a href="${pageContext.request.contextPath}/admin/orders" class="clear-filter-button">
                            <i class="fas fa-times"></i> Clear Filter
                        </a>
                    </c:if>
                </div>
            </div>

            <table class="orders-table">
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
                            <td><strong>#${order.id}</strong></td>
                            <td>${order.customerName}</td>
                            <td>${order.restaurantName}</td>
                            <td>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        <span class="order-status-badge order-status-pending">Pending</span>
                                    </c:when>
                                    <c:when test="${order.status == 'CONFIRMED'}">
                                        <span class="order-status-badge order-status-confirmed">Confirmed</span>
                                    </c:when>
                                    <c:when test="${order.status == 'PREPARING'}">
                                        <span class="order-status-badge order-status-preparing">Preparing</span>
                                    </c:when>
                                    <c:when test="${order.status == 'READY'}">
                                        <span class="order-status-badge order-status-ready">Ready</span>
                                    </c:when>
                                    <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                        <span class="order-status-badge order-status-out-for-delivery">Out for Delivery</span>
                                    </c:when>
                                    <c:when test="${order.status == 'DELIVERED'}">
                                        <span class="order-status-badge order-status-delivered">Delivered</span>
                                    </c:when>
                                    <c:when test="${order.status == 'CANCELLED'}">
                                        <span class="order-status-badge order-status-cancelled">Cancelled</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty order.deliveryPersonName}">
                                        <div class="delivery-person">
                                            <span class="delivery-person-name">${order.deliveryPersonName}</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="not-assigned">Not Assigned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                            <td>
                                <div class="order-actions">
                                    <a href="${pageContext.request.contextPath}/admin/orders/detail?id=${order.id}" class="action-button view-button" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <c:if test="${order.canBeCancelled()}">
                                        <button type="button" class="action-button cancel-button" title="Cancel Order" onclick="confirmCancel(${order.id})">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty orders}">
                <div class="empty-state">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>No Orders Found</h3>
                    <p>There are no orders matching your current filter criteria.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Cancel Order Confirmation Modal -->
<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header cancellation-modal-header">
                <h5 class="modal-title" id="cancelModalLabel">Confirm Order Cancellation</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body cancellation-modal-body">
                <div style="text-align: center; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 48px; color: var(--danger-color);"></i>
                </div>
                <p style="text-align: center; font-size: 16px;">
                    Are you sure you want to cancel this order? <br>
                    <strong>This action cannot be undone.</strong>
                </p>
            </div>
            <div class="modal-footer cancellation-modal-footer">
                <button type="button" class="cancel-modal-button" data-bs-dismiss="modal">No, Keep Order</button>
                <form action="${pageContext.request.contextPath}/admin/orders/cancel" method="post">
                    <input type="hidden" id="cancelOrderId" name="orderId" value="">
                    <button type="submit" class="confirm-cancel-button">Yes, Cancel Order</button>
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

    // Add animation to status cards
    document.addEventListener('DOMContentLoaded', function() {
        const statusCards = document.querySelectorAll('.status-card');
        statusCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = '0 2px 5px rgba(0,0,0,0.1)';
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
