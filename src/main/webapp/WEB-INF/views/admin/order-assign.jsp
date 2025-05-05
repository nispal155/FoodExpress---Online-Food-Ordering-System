<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <a href="${pageContext.request.contextPath}/admin/restaurants" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-utensils"></i> Restaurants
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-list"></i> Menu Items
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/users" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-users"></i> Users
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
                <h2 class="card-title">Assign Order #${order.id} to Delivery Person</h2>
            </div>
            <div style="padding: 1rem;">
                <div class="row">
                    <div class="col-md-6">
                        <h3>Order Information</h3>
                        <div class="card" style="margin-bottom: 1rem;">
                            <div style="padding: 1rem;">
                                <p><strong>Customer:</strong> ${order.customerName}</p>
                                <p><strong>Restaurant:</strong> ${order.restaurantName}</p>
                                <p><strong>Amount:</strong> $<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></p>
                                <p><strong>Status:</strong> ${order.status.displayName}</p>
                                <p><strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMMM d, yyyy 'at' h:mm a" /></p>
                                <p><strong>Delivery Address:</strong> ${order.deliveryAddress}</p>
                                <p><strong>Delivery Phone:</strong> ${order.deliveryPhone}</p>
                                <c:if test="${not empty order.deliveryNotes}">
                                    <p><strong>Delivery Notes:</strong> ${order.deliveryNotes}</p>
                                </c:if>
                                <c:if test="${order.deliveryUserId != null}">
                                    <p><strong>Currently Assigned To:</strong> ${order.deliveryPersonName}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <h3>Assign to Delivery Person</h3>
                        <form action="${pageContext.request.contextPath}/admin/orders/assign" method="post">
                            <input type="hidden" name="orderId" value="${order.id}">
                            
                            <div class="form-group">
                                <label for="deliveryUserId">Select Delivery Person:</label>
                                <select id="deliveryUserId" name="deliveryUserId" class="form-control">
                                    <option value="0">-- Unassign --</option>
                                    <c:forEach var="deliveryPerson" items="${deliveryPersonnel}">
                                        <option value="${deliveryPerson.id}" ${order.deliveryUserId == deliveryPerson.id ? 'selected' : ''}>
                                            ${deliveryPerson.fullName} (${deliveryPerson.username})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div style="margin-top: 1.5rem;">
                                <a href="${pageContext.request.contextPath}/admin/orders/detail?id=${order.id}" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back to Order
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Assignment
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
