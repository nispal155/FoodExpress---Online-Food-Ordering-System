<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Order Confirmation" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <div class="card" style="max-width: 800px; margin: 0 auto; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
        <div style="background-color: var(--success-color); color: white; padding: 2rem; text-align: center;">
            <i class="fas fa-check-circle" style="font-size: 4rem; margin-bottom: 1rem;"></i>
            <h1 style="margin-bottom: 0.5rem;">Order Confirmed!</h1>
            <p style="font-size: 1.2rem; margin: 0;">Your order has been placed successfully.</p>
        </div>
        
        <div style="padding: 2rem;">
            <div style="margin-bottom: 2rem;">
                <h2 style="margin-bottom: 1rem;">Order Details</h2>
                <div style="display: flex; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Order Number</p>
                        <p style="font-weight: bold; font-size: 1.2rem;">#${order.id}</p>
                    </div>
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Date</p>
                        <p style="font-weight: bold;"><fmt:formatDate value="${order.orderDate}" pattern="MMMM d, yyyy 'at' h:mm a" /></p>
                    </div>
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Status</p>
                        <p>
                            <span style="background-color: rgba(33, 150, 243, 0.1); color: var(--secondary-color); padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">
                                ${order.status.displayName}
                            </span>
                        </p>
                    </div>
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Total</p>
                        <p style="font-weight: bold; font-size: 1.2rem;">$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></p>
                    </div>
                </div>
            </div>
            
            <div style="margin-bottom: 2rem;">
                <h2 style="margin-bottom: 1rem;">Restaurant</h2>
                <p style="font-weight: bold; font-size: 1.2rem;">${order.restaurantName}</p>
            </div>
            
            <div style="margin-bottom: 2rem;">
                <h2 style="margin-bottom: 1rem;">Delivery Information</h2>
                <div style="display: flex; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Address</p>
                        <p style="font-weight: bold;">${order.deliveryAddress}</p>
                    </div>
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Phone</p>
                        <p style="font-weight: bold;">${order.deliveryPhone}</p>
                    </div>
                </div>
                <c:if test="${not empty order.deliveryNotes}">
                    <div style="margin-top: 0.5rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Notes</p>
                        <p>${order.deliveryNotes}</p>
                    </div>
                </c:if>
            </div>
            
            <div style="margin-bottom: 2rem;">
                <h2 style="margin-bottom: 1rem;">Order Items</h2>
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
                                        <div>
                                            <strong>${item.menuItemName}</strong>
                                            <c:if test="${not empty item.specialInstructions}">
                                                <p style="margin: 0; font-size: 0.8rem; color: var(--medium-gray);">
                                                    <i class="fas fa-info-circle"></i> ${item.specialInstructions}
                                                </p>
                                            </c:if>
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
            </div>
            
            <div style="margin-bottom: 2rem;">
                <h2 style="margin-bottom: 1rem;">Payment Information</h2>
                <div style="display: flex; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Payment Method</p>
                        <p style="font-weight: bold;">${order.paymentMethod.displayName}</p>
                    </div>
                    <div style="flex: 1; min-width: 200px; margin-bottom: 1rem;">
                        <p style="margin-bottom: 0.5rem; color: var(--medium-gray);">Payment Status</p>
                        <p>
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'PAID'}">
                                    <span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">Paid</span>
                                </c:when>
                                <c:when test="${order.paymentStatus == 'PENDING'}">
                                    <span style="background-color: rgba(255, 193, 7, 0.1); color: var(--warning-color); padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">Pending</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="background-color: rgba(244, 67, 54, 0.1); color: var(--danger-color); padding: 0.25rem 0.5rem; border-radius: 4px; font-weight: bold;">Failed</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/track-order?id=${order.id}" class="btn btn-primary btn-lg" style="margin-right: 1rem;">
                    <i class="fas fa-truck"></i> Track Order
                </a>
                <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary btn-lg">
                    <i class="fas fa-list"></i> My Orders
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
