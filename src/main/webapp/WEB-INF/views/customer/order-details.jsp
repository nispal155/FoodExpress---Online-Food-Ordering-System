<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Order Details #${order.id}" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <!-- Success Message -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <c:choose>
                <c:when test="${param.success == 'order_placed'}">
                    <i class="fas fa-check-circle"></i> Your order has been placed successfully!
                </c:when>
                <c:otherwise>
                    <i class="fas fa-check-circle"></i> Operation completed successfully!
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
        <h1>Order #${order.id}</h1>
        <div>
            <c:if test="${order.status == 'DELIVERED' && !order.hasRated}">
                <a href="${pageContext.request.contextPath}/rate-order?orderId=${order.id}" class="btn btn-success" style="margin-right: 10px;">
                    <i class="fas fa-star"></i> Rate Order
                </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left"></i> Back to Orders
            </a>
        </div>
    </div>

    <div class="row">
        <!-- Order Details -->
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h2 class="card-title">Order Details</h2>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <p><strong>Order ID:</strong> #${order.id}</p>
                            <p><strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy HH:mm" /></p>
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
                        <c:if test="${not empty order.deliveryPersonName}">
                            <p><strong>Delivery Person:</strong> ${order.deliveryPersonName}</p>
                        </c:if>
                    </div>

                    <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                        <div style="margin-top: 1.5rem;">
                            <form action="${pageContext.request.contextPath}/orders/cancel/${order.id}" method="post"
                                  onsubmit="return confirm('Are you sure you want to cancel this order?');">
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-times-circle"></i> Cancel Order
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h2 class="card-title">Order Summary</h2>
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

            <!-- Order Tracking -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Order Tracking</h2>
                </div>
                <div class="card-body">
                    <div class="timeline">
                        <div class="timeline-item ${order.status == 'PENDING' || order.status == 'CONFIRMED' || order.status == 'PREPARING' || order.status == 'READY' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'active' : ''}">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h3 class="timeline-title">Order Placed</h3>
                                <p><fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy HH:mm" /></p>
                            </div>
                        </div>

                        <div class="timeline-item ${order.status == 'CONFIRMED' || order.status == 'PREPARING' || order.status == 'READY' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'active' : ''}">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h3 class="timeline-title">Order Confirmed</h3>
                            </div>
                        </div>

                        <div class="timeline-item ${order.status == 'PREPARING' || order.status == 'READY' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'active' : ''}">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h3 class="timeline-title">Preparing</h3>
                            </div>
                        </div>

                        <div class="timeline-item ${order.status == 'READY' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'active' : ''}">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h3 class="timeline-title">Ready for Pickup</h3>
                            </div>
                        </div>

                        <div class="timeline-item ${order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'active' : ''}">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h3 class="timeline-title">Out for Delivery</h3>
                            </div>
                        </div>

                        <div class="timeline-item ${order.status == 'DELIVERED' ? 'active' : ''}">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h3 class="timeline-title">Delivered</h3>
                                <c:if test="${not empty order.actualDeliveryTime}">
                                    <p><fmt:formatDate value="${order.actualDeliveryTime}" pattern="MMM dd, yyyy HH:mm" /></p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .timeline {
        position: relative;
        padding-left: 1.5rem;
        margin-bottom: 1rem;
    }

    .timeline:before {
        content: '';
        position: absolute;
        left: 0.5rem;
        top: 0;
        height: 100%;
        width: 2px;
        background-color: #e0e0e0;
    }

    .timeline-item {
        position: relative;
        padding-bottom: 1.5rem;
    }

    .timeline-marker {
        position: absolute;
        left: -1.5rem;
        width: 1rem;
        height: 1rem;
        border-radius: 50%;
        background-color: #e0e0e0;
        border: 2px solid white;
    }

    .timeline-item.active .timeline-marker {
        background-color: var(--primary-color);
    }

    .timeline-content {
        padding-left: 0.5rem;
    }

    .timeline-title {
        font-size: 1rem;
        margin-bottom: 0.25rem;
    }

    .timeline-content p {
        font-size: 0.875rem;
        color: var(--medium-gray);
        margin-bottom: 0;
    }
</style>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
