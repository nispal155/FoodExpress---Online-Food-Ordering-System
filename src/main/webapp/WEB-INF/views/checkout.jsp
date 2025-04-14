<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Checkout" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-8 col-sm-12">
        <div class="card" style="margin-bottom: 1.5rem;">
            <div class="card-header">
                <h2 class="card-title">Delivery Information</h2>
            </div>
            <div style="padding: 1rem;">
                <form>
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="fullName" class="required">Full Name:</label>
                                <input type="text" id="fullName" name="fullName" class="form-control" value="${user.fullName}" required>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="phone" class="required">Phone Number:</label>
                                <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="address" class="required">Delivery Address:</label>
                        <textarea id="address" name="address" rows="3" class="form-control" required>${user.address}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="deliveryInstructions">Delivery Instructions (Optional):</label>
                        <textarea id="deliveryInstructions" name="deliveryInstructions" rows="2" class="form-control" placeholder="E.g., Ring the doorbell, leave at the door, etc."></textarea>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="card" style="margin-bottom: 1.5rem;">
            <div class="card-header">
                <h2 class="card-title">Payment Method</h2>
            </div>
            <div style="padding: 1rem;">
                <div class="form-group">
                    <div style="margin-bottom: 1rem;">
                        <input type="radio" id="creditCard" name="paymentMethod" value="creditCard" checked>
                        <label for="creditCard" style="display: inline; margin-left: 0.5rem;">Credit Card</label>
                    </div>
                    
                    <div id="creditCardDetails" style="margin-left: 1.5rem; margin-bottom: 1.5rem;">
                        <div class="row">
                            <div class="col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label for="cardNumber" class="required">Card Number:</label>
                                    <input type="text" id="cardNumber" name="cardNumber" class="form-control" placeholder="1234 5678 9012 3456" required>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label for="cardName" class="required">Name on Card:</label>
                                    <input type="text" id="cardName" name="cardName" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label for="expiryDate" class="required">Expiry Date:</label>
                                    <input type="text" id="expiryDate" name="expiryDate" class="form-control" placeholder="MM/YY" required>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label for="cvv" class="required">CVV:</label>
                                    <input type="text" id="cvv" name="cvv" class="form-control" placeholder="123" required>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div style="margin-bottom: 1rem;">
                        <input type="radio" id="paypal" name="paymentMethod" value="paypal">
                        <label for="paypal" style="display: inline; margin-left: 0.5rem;">PayPal</label>
                    </div>
                    
                    <div style="margin-bottom: 1rem;">
                        <input type="radio" id="cashOnDelivery" name="paymentMethod" value="cashOnDelivery">
                        <label for="cashOnDelivery" style="display: inline; margin-left: 0.5rem;">Cash on Delivery</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-4 col-sm-12">
        <div class="card" style="margin-bottom: 1.5rem;">
            <div class="card-header">
                <h2 class="card-title">Order Summary</h2>
            </div>
            <div style="padding: 1rem;">
                <div style="margin-bottom: 1rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Pizza Palace</h3>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;"><i class="fas fa-map-marker-alt"></i> 123 Main St, Food City</p>
                </div>
                
                <div style="margin-bottom: 1rem; border-bottom: 1px solid var(--medium-gray); padding-bottom: 1rem;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>1 x Margherita Pizza</span>
                        <span>$12.99</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>1 x Spaghetti Bolognese</span>
                        <span>$10.99</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>1 x Coca Cola</span>
                        <span>$2.99</span>
                    </div>
                </div>
                
                <div style="margin-bottom: 1rem;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Subtotal:</span>
                        <span>$26.97</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Delivery Fee:</span>
                        <span>$2.99</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Tax:</span>
                        <span>$2.70</span>
                    </div>
                    <div class="cart-total">
                        <span>Total:</span>
                        <span>$32.66</span>
                    </div>
                </div>
                
                <div style="margin-top: 1.5rem;">
                    <button type="submit" class="btn btn-primary btn-block">Place Order</button>
                </div>
                
                <div style="margin-top: 1rem; text-align: center;">
                    <a href="${pageContext.request.contextPath}/cart">Back to Cart</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
