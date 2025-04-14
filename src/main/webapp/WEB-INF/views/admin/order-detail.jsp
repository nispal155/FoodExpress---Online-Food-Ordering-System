<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - ${pageTitle}" />
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

        <div class="card">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h2 class="card-title">Order #${order.id}</h2>
                    <p style="margin: 0;">
                        <fmt:formatDate value="${order.orderDate}" pattern="MMMM d, yyyy 'at' h:mm a" />
                    </p>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}">
                            <span style="background-color: rgba(33, 150, 243, 0.1); color: var(--secondary-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Pending</span>
                        </c:when>
                        <c:when test="${order.status == 'CONFIRMED'}">
                            <span style="background-color: rgba(255, 193, 7, 0.1); color: var(--warning-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Confirmed</span>
                        </c:when>
                        <c:when test="${order.status == 'PREPARING'}">
                            <span style="background-color: rgba(255, 87, 34, 0.1); color: var(--primary-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Preparing</span>
                        </c:when>
                        <c:when test="${order.status == 'READY'}">
                            <span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Ready</span>
                        </c:when>
                        <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                            <span style="background-color: rgba(156, 39, 176, 0.1); color: #9c27b0; padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Out for Delivery</span>
                        </c:when>
                        <c:when test="${order.status == 'DELIVERED'}">
                            <span style="background-color: rgba(0, 150, 136, 0.1); color: #009688; padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Delivered</span>
                        </c:when>
                        <c:when test="${order.status == 'CANCELLED'}">
                            <span style="background-color: rgba(244, 67, 54, 0.1); color: var(--danger-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Cancelled</span>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <div class="col-md-6">
                        <h3>Order Information</h3>
                        <table class="table">
                            <tr>
                                <th>Customer:</th>
                                <td>${order.customerName}</td>
                            </tr>
                            <tr>
                                <th>Restaurant:</th>
                                <td>${order.restaurantName}</td>
                            </tr>
                            <tr>
                                <th>Total Amount:</th>
                                <td>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></td>
                            </tr>
                            <tr>
                                <th>Payment Method:</th>
                                <td>${order.paymentMethod.displayName}</td>
                            </tr>
                            <tr>
                                <th>Payment Status:</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.paymentStatus == 'PAID'}">
                                            <span style="color: var(--success-color);">Paid</span>
                                        </c:when>
                                        <c:when test="${order.paymentStatus == 'PENDING'}">
                                            <span style="color: var(--warning-color);">Pending</span>
                                        </c:when>
                                        <c:when test="${order.paymentStatus == 'FAILED'}">
                                            <span style="color: var(--danger-color);">Failed</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="col-md-6">
                        <h3>Delivery Information</h3>
                        <table class="table">
                            <tr>
                                <th>Delivery Address:</th>
                                <td>${order.deliveryAddress}</td>
                            </tr>
                            <tr>
                                <th>Delivery Phone:</th>
                                <td>${order.deliveryPhone}</td>
                            </tr>
                            <tr>
                                <th>Delivery Person:</th>
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
                            </tr>
                            <tr>
                                <th>Estimated Delivery:</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty order.estimatedDeliveryTime}">
                                            <fmt:formatDate value="${order.estimatedDeliveryTime}" pattern="h:mm a" />
                                        </c:when>
                                        <c:otherwise>
                                            Not estimated yet
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>Delivery Notes:</th>
                                <td>${not empty order.deliveryNotes ? order.deliveryNotes : 'None'}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <h3>Order Items</h3>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.orderItems}">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center;">
                                            <c:if test="${not empty item.menuItemImageUrl}">
                                                <img src="${pageContext.request.contextPath}/${item.menuItemImageUrl}" alt="${item.menuItemName}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px; margin-right: 10px;">
                                            </c:if>
                                            <div>
                                                <strong>${item.menuItemName}</strong>
                                                <c:if test="${not empty item.specialInstructions}">
                                                    <p style="margin: 0; font-size: 0.8rem; color: var(--dark-gray);">
                                                        <i class="fas fa-info-circle"></i> ${item.specialInstructions}
                                                    </p>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td>$<fmt:formatNumber value="${item.price}" pattern="#,##0.00" /></td>
                                    <td>${item.quantity}</td>
                                    <td>$<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" style="text-align: right;">Total:</th>
                                <th>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="row" style="margin-top: 1.5rem;">
                    <div class="col-md-6">
                        <c:if test="${order.canBeAssigned()}">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Assign to Delivery Person</h3>
                                </div>
                                <div style="padding: 1rem;">
                                    <form action="${pageContext.request.contextPath}/admin/orders/assign" method="post">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <div class="mb-3">
                                            <label for="deliveryUserId" class="form-label">Select Delivery Person</label>
                                            <select class="form-select" id="deliveryUserId" name="deliveryUserId" required>
                                                <option value="">Select Delivery Person</option>
                                                <c:forEach var="deliveryPerson" items="${deliveryStaff}">
                                                    <option value="${deliveryPerson.id}">${deliveryPerson.fullName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Assign Order</button>
                                    </form>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <div class="col-md-6">
                        <c:if test="${order.canUpdateStatus()}">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Update Order Status</h3>
                                </div>
                                <div style="padding: 1rem;">
                                    <form action="${pageContext.request.contextPath}/admin/orders/status" method="post">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <div class="mb-3">
                                            <label for="status" class="form-label">New Status</label>
                                            <select class="form-select" id="status" name="status" required>
                                                <option value="">Select Status</option>
                                                <c:if test="${order.status == 'PENDING'}">
                                                    <option value="CONFIRMED">Confirmed</option>
                                                </c:if>
                                                <c:if test="${order.status == 'CONFIRMED'}">
                                                    <option value="PREPARING">Preparing</option>
                                                </c:if>
                                                <c:if test="${order.status == 'PREPARING'}">
                                                    <option value="READY">Ready</option>
                                                </c:if>
                                                <c:if test="${order.status == 'READY' && not empty order.deliveryUserId}">
                                                    <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
                                                </c:if>
                                                <c:if test="${order.status == 'OUT_FOR_DELIVERY'}">
                                                    <option value="DELIVERED">Delivered</option>
                                                </c:if>
                                                <c:if test="${order.canBeCancelled()}">
                                                    <option value="CANCELLED">Cancelled</option>
                                                </c:if>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update Status</button>
                                    </form>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <div style="margin-top: 1.5rem;">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Orders
                    </a>

                    <c:if test="${order.status == 'READY' || order.status == 'PREPARING' || order.status == 'CONFIRMED'}">
                        <a href="${pageContext.request.contextPath}/admin/orders/assign?id=${order.id}" class="btn btn-primary">
                            <i class="fas fa-user-plus"></i> Assign Delivery Person
                        </a>
                    </c:if>

                    <c:if test="${order.canBeCancelled()}">
                        <button type="button" class="btn btn-danger" onclick="confirmCancel(${order.id})">
                            <i class="fas fa-times"></i> Cancel Order
                        </button>
                    </c:if>
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
