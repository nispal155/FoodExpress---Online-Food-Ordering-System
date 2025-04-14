<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Delivery - ${pageTitle}" />
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
                    <c:when test="${param.error == 'status-update-failed'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update order status!
                    </c:when>
                    <c:when test="${param.error == 'invalid-status'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid status update!
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
                        <c:when test="${order.status == 'READY'}">
                            <span style="background-color: rgba(76, 175, 80, 0.1); color: var(--success-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Ready for Pickup</span>
                        </c:when>
                        <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                            <span style="background-color: rgba(156, 39, 176, 0.1); color: #9c27b0; padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Out for Delivery</span>
                        </c:when>
                        <c:when test="${order.status == 'DELIVERED'}">
                            <span style="background-color: rgba(0, 150, 136, 0.1); color: #009688; padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Delivered</span>
                        </c:when>
                        <c:otherwise>
                            <span style="background-color: rgba(158, 158, 158, 0.1); color: var(--dark-gray); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">${order.status.displayName}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <div class="col-md-6">
                        <h3>Restaurant Information</h3>
                        <div class="card" style="margin-bottom: 1rem;">
                            <div style="padding: 1rem;">
                                <h4>${order.restaurantName}</h4>
                                <p><i class="fas fa-map-marker-alt"></i> Restaurant Address Goes Here</p>
                                <p><i class="fas fa-phone"></i> Restaurant Phone Goes Here</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <h3>Customer Information</h3>
                        <div class="card" style="margin-bottom: 1rem;">
                            <div style="padding: 1rem;">
                                <h4>${order.customerName}</h4>
                                <p><i class="fas fa-map-marker-alt"></i> ${order.deliveryAddress}</p>
                                <p><i class="fas fa-phone"></i> ${order.deliveryPhone}</p>
                                <c:if test="${not empty order.deliveryNotes}">
                                    <p><i class="fas fa-info-circle"></i> <strong>Notes:</strong> ${order.deliveryNotes}</p>
                                </c:if>
                            </div>
                        </div>
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
                
                <div style="margin-top: 1.5rem;">
                    <a href="${pageContext.request.contextPath}/delivery/orders" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Orders
                    </a>
                    
                    <c:if test="${order.status == 'READY'}">
                        <form action="${pageContext.request.contextPath}/delivery/orders/update" method="post" style="display: inline;">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <input type="hidden" name="status" value="OUT_FOR_DELIVERY">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-motorcycle"></i> Mark as Out for Delivery
                            </button>
                        </form>
                    </c:if>
                    
                    <c:if test="${order.status == 'OUT_FOR_DELIVERY'}">
                        <form action="${pageContext.request.contextPath}/delivery/orders/update" method="post" style="display: inline;">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <input type="hidden" name="status" value="DELIVERED">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-check"></i> Mark as Delivered
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
