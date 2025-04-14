<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - My Orders" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">My Orders</h1>
    
    <!-- Error Messages -->
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">
            <c:choose>
                <c:when test="${param.error == 'not-found'}">
                    <i class="fas fa-exclamation-circle"></i> Order not found!
                </c:when>
                <c:when test="${param.error == 'invalid-id'}">
                    <i class="fas fa-exclamation-circle"></i> Invalid order ID!
                </c:when>
                <c:otherwise>
                    <i class="fas fa-exclamation-circle"></i> An error occurred!
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
    
    <c:choose>
        <c:when test="${not empty orders}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Order #</th>
                            <th>Date</th>
                            <th>Restaurant</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>#${order.id}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
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
                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/track-order?id=${order.id}" class="btn btn-sm btn-primary" title="Track Order">
                                            <i class="fas fa-truck"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/order-confirmation?id=${order.id}" class="btn btn-sm btn-secondary" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <c:if test="${order.status == 'DELIVERED'}">
                                            <a href="${pageContext.request.contextPath}/restaurant?id=${order.restaurantId}" class="btn btn-sm btn-success" title="Reorder">
                                                <i class="fas fa-redo"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info" role="alert">
                <i class="fas fa-info-circle"></i> You don't have any orders yet.
            </div>
            
            <div style="text-align: center; margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">
                    <i class="fas fa-utensils"></i> Browse Restaurants
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
