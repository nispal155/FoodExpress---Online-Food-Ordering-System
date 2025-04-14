<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Shopping Cart" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">Shopping Cart</h1>

    <!-- Success and Error Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <c:choose>
                <c:when test="${param.success == 'added'}">
                    <i class="fas fa-check-circle"></i> Item added to cart successfully!
                </c:when>
                <c:when test="${param.success == 'updated'}">
                    <i class="fas fa-check-circle"></i> Cart updated successfully!
                </c:when>
                <c:when test="${param.success == 'removed'}">
                    <i class="fas fa-check-circle"></i> Item removed from cart successfully!
                </c:when>
                <c:when test="${param.success == 'cleared'}">
                    <i class="fas fa-check-circle"></i> Cart cleared successfully!
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
                <c:when test="${param.error == 'invalid-quantity'}">
                    <i class="fas fa-exclamation-circle"></i> Invalid quantity specified!
                </c:when>
                <c:when test="${param.error == 'item-not-available'}">
                    <i class="fas fa-exclamation-circle"></i> The selected item is not available!
                </c:when>
                <c:when test="${param.error == 'different-restaurant'}">
                    <i class="fas fa-exclamation-circle"></i> You can only order from one restaurant at a time. Please clear your cart first.
                </c:when>
                <c:when test="${param.error == 'update-failed'}">
                    <i class="fas fa-exclamation-circle"></i> Failed to update cart!
                </c:when>
                <c:when test="${param.error == 'remove-failed'}">
                    <i class="fas fa-exclamation-circle"></i> Failed to remove item from cart!
                </c:when>
                <c:when test="${param.error == 'invalid-parameters'}">
                    <i class="fas fa-exclamation-circle"></i> Invalid parameters provided!
                </c:when>
                <c:otherwise>
                    <i class="fas fa-exclamation-circle"></i> An error occurred!
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty cart && not empty cart.items}">
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h5 style="margin: 0;">
                        <i class="fas fa-utensils"></i> ${cart.restaurantName}
                    </h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr>
                                        <td>
                                            <div style="display: flex; align-items: center;">
                                                <c:if test="${not empty item.menuItem.imageUrl}">
                                                    <img src="${pageContext.request.contextPath}/${item.menuItem.imageUrl}" alt="${item.menuItem.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px; margin-right: 10px;">
                                                </c:if>
                                                <div>
                                                    <strong>${item.menuItem.name}</strong>
                                                    <c:if test="${not empty item.specialInstructions}">
                                                        <p style="margin: 0; font-size: 0.8rem; color: var(--medium-gray);">
                                                            <i class="fas fa-info-circle"></i> ${item.specialInstructions}
                                                        </p>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </td>
                                        <td>$<fmt:formatNumber value="${item.menuItem.effectivePrice}" pattern="#,##0.00" /></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display: flex; align-items: center;">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="menuItemId" value="${item.menuItem.id}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" style="width: 60px; text-align: center;" onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <td>$<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" /></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="menuItemId" value="${item.menuItem.id}">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="3" style="text-align: right;">Total:</th>
                                    <th>$<fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0.00" /></th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div style="display: flex; justify-content: space-between; margin-bottom: 2rem;">
                <form action="${pageContext.request.contextPath}/cart" method="post" onsubmit="return confirm('Are you sure you want to clear your cart?');">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn btn-outline-danger">
                        <i class="fas fa-trash"></i> Clear Cart
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/restaurant?id=${cart.restaurantId}" class="btn btn-outline-primary">
                    <i class="fas fa-plus"></i> Add More Items
                </a>

                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary">
                    <i class="fas fa-shopping-cart"></i> Proceed to Checkout
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info" role="alert">
                <i class="fas fa-shopping-cart"></i> Your cart is empty.
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
