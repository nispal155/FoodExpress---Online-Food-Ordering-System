<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Shopping Cart" />
</jsp:include>

<div class="cart-page-container">
    <div class="cart-header">
        <h1>Your Cart</h1>
        <c:if test="${not empty cart && not empty cart.items}">
            <div class="cart-restaurant">
                <i class="fas fa-utensils"></i> ${cart.restaurantName}
            </div>
        </c:if>
    </div>

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
            <div class="cart-content">
                <div class="cart-items">
                    <c:forEach var="item" items="${cart.items}">
                        <div class="cart-item">
                            <div class="cart-item-image">
                                <c:choose>
                                    <c:when test="${not empty item.menuItem.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/${item.menuItem.imageUrl}" alt="${item.menuItem.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="cart-item-no-image">
                                            <i class="fas fa-utensils"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="cart-item-details">
                                <div class="cart-item-name">${item.menuItem.name}</div>
                                <div class="cart-item-price">$<fmt:formatNumber value="${item.menuItem.effectivePrice}" pattern="#,##0.00" /></div>
                                <c:if test="${not empty item.specialInstructions}">
                                    <div class="cart-item-instructions">
                                        <i class="fas fa-info-circle"></i> ${item.specialInstructions}
                                    </div>
                                </c:if>
                            </div>
                            <div class="cart-item-quantity">
                                <form action="${pageContext.request.contextPath}/cart" method="post" class="quantity-form">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="menuItemId" value="${item.menuItem.id}">
                                    <div class="quantity-control">
                                        <button type="button" class="quantity-btn minus-btn" onclick="decrementQuantity(this)">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" class="quantity-input" onchange="this.form.submit()">
                                        <button type="button" class="quantity-btn plus-btn" onclick="incrementQuantity(this)">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <div class="cart-item-subtotal">
                                $<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" />
                            </div>
                            <div class="cart-item-actions">
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="menuItemId" value="${item.menuItem.id}">
                                    <button type="submit" class="remove-item-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="cart-summary">
                    <div class="cart-summary-header">
                        <h2>Order Summary</h2>
                    </div>
                    <div class="cart-summary-content">
                        <div class="cart-summary-row">
                            <span>Subtotal</span>
                            <span>$<fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0.00" /></span>
                        </div>
                        <div class="cart-summary-row">
                            <span>Delivery Fee</span>
                            <span>$<fmt:formatNumber value="2.99" pattern="#,##0.00" /></span>
                        </div>
                        <div class="cart-summary-row">
                            <span>Tax</span>
                            <span>$<fmt:formatNumber value="${cart.totalPrice * 0.1}" pattern="#,##0.00" /></span>
                        </div>
                        <div class="cart-summary-total">
                            <span>Total</span>
                            <span>$<fmt:formatNumber value="${cart.totalPrice + 2.99 + (cart.totalPrice * 0.1)}" pattern="#,##0.00" /></span>
                        </div>

                        <div class="cart-summary-actions">
                            <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">
                                <i class="fas fa-credit-card"></i> Proceed to Checkout
                            </a>
                            <a href="${pageContext.request.contextPath}/restaurants?id=${cart.restaurantId}" class="add-more-btn">
                                <i class="fas fa-plus"></i> Add More Items
                            </a>
                        </div>

                        <div class="cart-summary-promo">
                            <h3>Have a Promo Code?</h3>
                            <div class="promo-form">
                                <input type="text" placeholder="Enter promo code" class="promo-input">
                                <button class="promo-btn">Apply</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="cart-actions">
                <form action="${pageContext.request.contextPath}/cart" method="post" onsubmit="return confirm('Are you sure you want to clear your cart?');">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="clear-cart-btn">
                        <i class="fas fa-trash"></i> Clear Cart
                    </button>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-cart">
                <div class="empty-cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h2>Your cart is empty</h2>
                <p>Looks like you haven't added any items to your cart yet.</p>
                <a href="${pageContext.request.contextPath}/restaurants" class="browse-restaurants-btn">
                    <i class="fas fa-utensils"></i> Browse Restaurants
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function decrementQuantity(button) {
        const input = button.parentNode.querySelector('.quantity-input');
        const currentValue = parseInt(input.value);
        if (currentValue > 1) {
            input.value = currentValue - 1;
            input.form.submit();
        }
    }

    function incrementQuantity(button) {
        const input = button.parentNode.querySelector('.quantity-input');
        const currentValue = parseInt(input.value);
        if (currentValue < 99) {
            input.value = currentValue + 1;
            input.form.submit();
        }
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
