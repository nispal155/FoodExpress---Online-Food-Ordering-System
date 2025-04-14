<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Order Details #${order.id}" />
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
        <div class="card">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">Order #${order.id}</h2>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left"></i> Back to Orders
                </a>
            </div>

            <div class="card-body">
                <!-- Success and Error Messages -->
                <c:if test="${param.success != null}">
                    <div class="alert alert-success" role="alert">
                        <c:choose>
                            <c:when test="${param.success == 'assigned'}">
                                <i class="fas fa-check-circle"></i> Order has been assigned successfully!
                            </c:when>
                            <c:when test="${param.success == 'status_updated'}">
                                <i class="fas fa-check-circle"></i> Order status has been updated successfully!
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
                            <c:when test="${param.error == 'no_delivery_person'}">
                                <i class="fas fa-exclamation-circle"></i> Please select a delivery person!
                            </c:when>
                            <c:when test="${param.error == 'assign_failed'}">
                                <i class="fas fa-exclamation-circle"></i> Failed to assign delivery person!
                            </c:when>
                            <c:when test="${param.error == 'no_status'}">
                                <i class="fas fa-exclamation-circle"></i> Please select a status!
                            </c:when>
                            <c:when test="${param.error == 'status_update_failed'}">
                                <i class="fas fa-exclamation-circle"></i> Failed to update order status!
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-exclamation-circle"></i> An error occurred!
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <div class="row">
                    <!-- Order Details -->
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h3 class="card-title">Order Details</h3>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <p><strong>Order ID:</strong> #${order.id}</p>
                                        <p><strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy HH:mm" /></p>
                                        <p><strong>Customer:</strong> ${order.customerName}</p>
                                        <p><strong>Restaurant:</strong> ${order.restaurantName}</p>
                                        <p><strong>Status:</strong> <span class="badge ${order.statusCssClass}">${order.statusDisplayName}</span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Payment Method:</strong> ${order.paymentMethod.displayName}</p>
                                        <p><strong>Payment Status:</strong> ${order.paymentStatus.displayName}</p>
                                        <c:if test="${not empty order.estimatedDeliveryTime}">
                                            <p><strong>Estimated Delivery:</strong> <fmt:formatDate value="${order.estimatedDeliveryTime}" pattern="MMM dd, yyyy HH:mm" /></p>
                                        </c:if>
                                        <c:if test="${not empty order.actualDeliveryTime}">
                                            <p><strong>Delivered At:</strong> <fmt:formatDate value="${order.actualDeliveryTime}" pattern="MMM dd, yyyy HH:mm" /></p>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <h5>Delivery Information</h5>
                                    <p><strong>Address:</strong> ${order.deliveryAddress}</p>
                                    <p><strong>Phone:</strong> ${order.deliveryPhone}</p>
                                    <c:if test="${not empty order.deliveryNotes}">
                                        <p><strong>Notes:</strong> ${order.deliveryNotes}</p>
                                    </c:if>
                                </div>

                                <div class="mb-3">
                                    <h5>Delivery Assignment</h5>
                                    <c:choose>
                                        <c:when test="${not empty order.deliveryPersonName}">
                                            <p><strong>Assigned To:</strong> ${order.deliveryPersonName}</p>
                                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#reassignModal">
                                                <i class="fas fa-user-edit"></i> Reassign
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <p><strong>Status:</strong> <span class="badge bg-warning">Not Assigned</span></p>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#assignModal">
                                                <i class="fas fa-user-plus"></i> Assign Delivery Person
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-3">
                                    <h5>Order Status</h5>
                                    <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#statusModal">
                                            <i class="fas fa-edit"></i> Update Status
                                        </button>
                                    </c:if>

                                    <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal">
                                            <i class="fas fa-times-circle"></i> Cancel Order
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Order Items</h3>
                            </div>
                            <div class="card-body">
                                <div style="margin-bottom: 1rem;">
                                    <c:forEach var="item" items="${order.orderItems}">
                                        <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                            <div>
                                                <span>${item.quantity}x ${item.menuItemName}</span>
                                                <c:if test="${not empty item.specialInstructions}">
                                                    <br><small class="text-muted">${item.specialInstructions}</small>
                                                </c:if>
                                            </div>
                                            <span>$<fmt:formatNumber value="${item.price.multiply(item.quantity)}" pattern="#,##0.00" /></span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <hr>

                                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                    <span>Subtotal:</span>
                                    <span>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></span>
                                </div>

                                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; font-weight: bold;">
                                    <span>Total:</span>
                                    <span>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Assign Modal -->
<div class="modal fade" id="assignModal" tabindex="-1" aria-labelledby="assignModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="assignModalLabel">Assign Delivery Person</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/orders/assign-legacy/${order.id}" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="deliveryUserId" class="form-label">Select Delivery Person</label>
                        <select class="form-select" id="deliveryUserId" name="deliveryUserId" required>
                            <option value="">Select Delivery Person</option>
                            <c:forEach var="staff" items="${deliveryStaff}">
                                <option value="${staff.id}">${staff.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Assign</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reassign Modal -->
<div class="modal fade" id="reassignModal" tabindex="-1" aria-labelledby="reassignModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reassignModalLabel">Reassign Delivery Person</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/orders/assign-legacy/${order.id}" method="post">
                <div class="modal-body">
                    <p>Currently assigned to: <strong>${order.deliveryPersonName}</strong></p>
                    <div class="mb-3">
                        <label for="newDeliveryUserId" class="form-label">Select New Delivery Person</label>
                        <select class="form-select" id="newDeliveryUserId" name="deliveryUserId" required>
                            <option value="">Select Delivery Person</option>
                            <c:forEach var="staff" items="${deliveryStaff}">
                                <option value="${staff.id}" ${staff.id == order.deliveryPersonId ? 'selected' : ''}>${staff.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Reassign</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Status Modal -->
<div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="statusModalLabel">Update Order Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/orders/status/${order.id}" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="status" class="form-label">Current Status: <span class="badge ${order.statusCssClass}">${order.statusDisplayName}</span></label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="">Select New Status</option>
                            <c:if test="${order.status == 'PENDING'}">
                                <option value="CONFIRMED">Confirmed</option>
                            </c:if>
                            <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                                <option value="PREPARING">Preparing</option>
                            </c:if>
                            <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED' || order.status == 'PREPARING'}">
                                <option value="READY">Ready</option>
                            </c:if>
                            <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED' || order.status == 'PREPARING' || order.status == 'READY'}">
                                <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
                            </c:if>
                            <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED' || order.status == 'PREPARING' || order.status == 'READY' || order.status == 'OUT_FOR_DELIVERY'}">
                                <option value="DELIVERED">Delivered</option>
                            </c:if>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Status</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Cancel Modal -->
<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cancelModalLabel">Cancel Order</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to cancel order #${order.id}?</p>
                <p>This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, Keep Order</button>
                <form action="${pageContext.request.contextPath}/admin/orders/cancel/${order.id}" method="post">
                    <button type="submit" class="btn btn-danger">Yes, Cancel Order</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
