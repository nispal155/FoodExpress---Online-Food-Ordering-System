<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Payment Settings" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1>Account Settings</h1>
    
    <!-- Success and Error Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle"></i> ${param.success}
        </div>
    </c:if>
    
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${param.error}
        </div>
    </c:if>
    
    <div class="row">
        <!-- Settings Navigation -->
        <div class="col-md-3 col-sm-12">
            <div class="card" style="margin-bottom: 1.5rem;">
                <div class="card-header">
                    <h2 class="card-title">Settings</h2>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/settings/account" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-user"></i> Account
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/notifications" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-bell"></i> Notifications
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/payment" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-credit-card"></i> Payment Methods
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/privacy" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-shield-alt"></i> Privacy
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/preferences" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-sliders-h"></i> Preferences
                    </a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-block">
                        <i class="fas fa-user-edit"></i> Edit Profile
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Settings Content -->
        <div class="col-md-9 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Payment Methods</h2>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <h3>Saved Payment Methods</h3>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i> You don't have any saved payment methods yet.
                        </div>
                        
                        <button class="btn btn-primary" onclick="showAddPaymentForm()">
                            <i class="fas fa-plus"></i> Add Payment Method
                        </button>
                    </div>
                    
                    <div id="addPaymentForm" style="display: none;">
                        <h3>Add Payment Method</h3>
                        <form action="${pageContext.request.contextPath}/settings/payment" method="post">
                            <div class="mb-3">
                                <label for="cardType" class="form-label">Card Type</label>
                                <select class="form-select" id="cardType" name="cardType" required>
                                    <option value="">Select Card Type</option>
                                    <option value="visa">Visa</option>
                                    <option value="mastercard">Mastercard</option>
                                    <option value="amex">American Express</option>
                                    <option value="discover">Discover</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX" required>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="expiryDate" class="form-label">Expiry Date</label>
                                        <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="cvv" class="form-label">CVV</label>
                                        <input type="text" class="form-control" id="cvv" name="cvv" placeholder="XXX" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="cardholderName" class="form-label">Cardholder Name</label>
                                <input type="text" class="form-control" id="cardholderName" name="cardholderName" placeholder="Name as it appears on card" required>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="defaultCard" name="defaultCard" value="true">
                                    <label class="form-check-label" for="defaultCard">
                                        Set as default payment method
                                    </label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="saveCard" name="saveCard" value="true" checked>
                                    <label class="form-check-label" for="saveCard">
                                        Save card for future payments
                                    </label>
                                </div>
                            </div>
                            
                            <div class="d-flex">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-save"></i> Save Payment Method
                                </button>
                                <button type="button" class="btn btn-secondary" onclick="hideAddPaymentForm()">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <div class="mt-4">
                        <h3>Payment Preferences</h3>
                        <form action="${pageContext.request.contextPath}/settings/payment" method="post">
                            <div class="mb-3">
                                <label for="defaultPaymentMethod" class="form-label">Default Payment Method</label>
                                <select class="form-select" id="defaultPaymentMethod" name="defaultPaymentMethod">
                                    <option value="">Select Default Payment Method</option>
                                    <option value="cash">Cash on Delivery</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="savePaymentInfo" name="savePaymentInfo" value="true" checked>
                                    <label class="form-check-label" for="savePaymentInfo">
                                        Save payment information for future orders
                                    </label>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Preferences
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function showAddPaymentForm() {
        document.getElementById('addPaymentForm').style.display = 'block';
    }
    
    function hideAddPaymentForm() {
        document.getElementById('addPaymentForm').style.display = 'none';
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
