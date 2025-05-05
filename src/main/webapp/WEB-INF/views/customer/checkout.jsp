<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Checkout" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">Checkout</h1>

    <!-- Error Messages -->
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">
            <c:choose>
                <c:when test="${param.error == 'missing-fields'}">
                    <i class="fas fa-exclamation-circle"></i> Please fill in all required fields!
                </c:when>
                <c:when test="${param.error == 'order-failed'}">
                    <i class="fas fa-exclamation-circle"></i> Failed to create order. Please try again.
                </c:when>
                <c:when test="${param.error == 'invalid-payment-method'}">
                    <i class="fas fa-exclamation-circle"></i> Invalid payment method selected!
                </c:when>
                <c:otherwise>
                    <i class="fas fa-exclamation-circle"></i> An error occurred!
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-8">
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h5 style="margin: 0;">Delivery Information</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                        <div class="mb-3">
                            <label for="deliveryAddress" class="form-label">Delivery Address *</label>
                            <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" rows="3" required>${user.address}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="deliveryPhone" class="form-label">Phone Number *</label>
                            <input type="tel" class="form-control" id="deliveryPhone" name="deliveryPhone" value="${user.phone}" required>
                        </div>

                        <div class="mb-3">
                            <label for="deliveryNotes" class="form-label">Delivery Notes (optional)</label>
                            <textarea class="form-control" id="deliveryNotes" name="deliveryNotes" rows="2" placeholder="E.g., Ring the doorbell, leave at the door, etc."></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Payment Method *</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="paymentCash" value="CASH" checked>
                                    <label class="form-check-label" for="paymentCash">Cash on Delivery</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="paymentCreditCard" value="CREDIT_CARD">
                                    <label class="form-check-label" for="paymentCreditCard">Credit Card</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="paymentDebitCard" value="DEBIT_CARD">
                                    <label class="form-check-label" for="paymentDebitCard">Debit Card</label>
                                </div>
                            </div>
                        </div>

                        <!-- Credit Card Details (shown only when Credit Card is selected) -->
                        <div id="creditCardDetails" style="display: none;">
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="expiryDate" class="form-label">Expiry Date</label>
                                        <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="cvv" class="form-label">CVV</label>
                                        <input type="text" class="form-control" id="cvv" placeholder="123">
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="cardholderName" class="form-label">Cardholder Name</label>
                                <input type="text" class="form-control" id="cardholderName" placeholder="John Doe">
                            </div>
                        </div>

                        <div style="margin-top: 2rem;">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-check"></i> Place Order
                            </button>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary btn-lg" style="margin-left: 1rem;">
                                <i class="fas fa-arrow-left"></i> Back to Cart
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card" style="margin-bottom: 2rem; position: sticky; top: 100px;">
                <div class="card-header">
                    <h5 style="margin: 0;">Order Summary</h5>
                </div>
                <div class="card-body">
                    <p>
                        <strong>Restaurant:</strong> ${cart.restaurantName}
                    </p>

                    <div style="margin-bottom: 1rem; max-height: 300px; overflow-y: auto;">
                        <c:forEach var="item" items="${cart.items}">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid #eee;">
                                <div>
                                    <span>${item.quantity} × ${item.menuItem.name}</span>
                                    <c:if test="${not empty item.specialInstructions}">
                                        <p style="margin: 0; font-size: 0.8rem; color: var(--medium-gray);">
                                            <i class="fas fa-info-circle"></i> ${item.specialInstructions}
                                        </p>
                                    </c:if>
                                </div>
                                <div>
                                    $<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" />
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div style="display: flex; justify-content: space-between; padding-top: 1rem; border-top: 2px solid #eee; font-weight: bold;">
                        <span>Total:</span>
                        <span>$<fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0.00" /></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Show/hide credit card details based on payment method selection
    document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
        radio.addEventListener('change', function() {
            const creditCardDetails = document.getElementById('creditCardDetails');
            if (this.value === 'CREDIT_CARD' || this.value === 'DEBIT_CARD') {
                creditCardDetails.style.display = 'block';
            } else {
                creditCardDetails.style.display = 'none';
            }
        });
    });

    // Form validation
    document.getElementById('checkoutForm').addEventListener('submit', function(event) {
        const deliveryAddress = document.getElementById('deliveryAddress').value.trim();
        const deliveryPhone = document.getElementById('deliveryPhone').value.trim();

        if (deliveryAddress === '' || deliveryPhone === '') {
            event.preventDefault();
            alert('Please fill in all required fields!');
        }

        // Validate credit card details if credit card payment is selected
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        if (paymentMethod === 'CREDIT_CARD' || paymentMethod === 'DEBIT_CARD') {
            const cardNumber = document.getElementById('cardNumber').value.trim();
            const expiryDate = document.getElementById('expiryDate').value.trim();
            const cvv = document.getElementById('cvv').value.trim();
            const cardholderName = document.getElementById('cardholderName').value.trim();

            if (cardNumber === '' || expiryDate === '' || cvv === '' || cardholderName === '') {
                event.preventDefault();
                alert('Please fill in all credit card details!');
            }
        }
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
