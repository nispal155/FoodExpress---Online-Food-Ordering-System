<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Orders" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">My Orders</h1>

    <!-- Success and Error Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <c:choose>
                <c:when test="${param.success == 'order_placed'}">
                    <i class="fas fa-check-circle"></i> Your order has been placed successfully!
                </c:when>
                <c:when test="${param.success == 'order_cancelled'}">
                    <i class="fas fa-check-circle"></i> Your order has been cancelled successfully!
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
                <c:when test="${param.error == 'not_found'}">
                    <i class="fas fa-exclamation-circle"></i> Order not found!
                </c:when>
                <c:when test="${param.error == 'invalid_id'}">
                    <i class="fas fa-exclamation-circle"></i> Invalid order ID!
                </c:when>
                <c:when test="${param.error == 'cancel_failed'}">
                    <i class="fas fa-exclamation-circle"></i> Failed to cancel order!
                </c:when>
                <c:when test="${param.error == 'cannot_cancel'}">
                    <i class="fas fa-exclamation-circle"></i> This order cannot be cancelled!
                </c:when>
                <c:otherwise>
                    <i class="fas fa-exclamation-circle"></i> An error occurred!
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- Orders List -->
    <c:choose>
        <c:when test="${not empty orders}">
            <div class="row">
                <c:forEach var="order" items="${orders}">
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                                <h5 class="mb-0">Order #${order.id}</h5>
                                <span class="badge" style="${order.status == 'PENDING' ? 'background-color: #6c757d;' :
                                                    order.status == 'CONFIRMED' ? 'background-color: #007bff;' :
                                                    order.status == 'PREPARING' ? 'background-color: #ffc107;' :
                                                    order.status == 'READY' ? 'background-color: #17a2b8;' :
                                                    order.status == 'OUT_FOR_DELIVERY' ? 'background-color: #6f42c1;' :
                                                    order.status == 'DELIVERED' ? 'background-color: #28a745;' :
                                                    order.status == 'CANCELLED' ? 'background-color: #dc3545;' : 'background-color: #6c757d;'}">${order.status.displayName}</span>
                            </div>
                            <div class="card-body">
                                <p><strong>Restaurant:</strong> ${order.restaurantName}</p>
                                <p><strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy HH:mm" /></p>
                                <p><strong>Total:</strong> $<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></p>

                                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 1rem;">
                                    <a href="${pageContext.request.contextPath}/orders/details/${order.id}" class="btn btn-primary">
                                        <i class="fas fa-info-circle"></i> View Details
                                    </a>

                                    <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                                        <form action="${pageContext.request.contextPath}/orders/cancel/${order.id}" method="post"
                                              onsubmit="return confirm('Are you sure you want to cancel this order?');">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-times-circle"></i> Cancel Order
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info" role="alert">
                <i class="fas fa-info-circle"></i> You don't have any orders yet.
            </div>
            <div style="text-align: center; margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg">
                    <i class="fas fa-utensils"></i> Browse Restaurants
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
