<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Shopping Cart" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-8 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Your Cart</h2>
                <p>You have 3 items in your cart</p>
            </div>
            <div style="padding: 1rem;">
                <!-- Cart Item 1 -->
                <div class="cart-item">
                    <img src="https://images.unsplash.com/photo-1574071318508-1cdbab80d002?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80" alt="Margherita Pizza" class="cart-item-image">
                    <div class="cart-item-details">
                        <h3 class="cart-item-title">Margherita Pizza</h3>
                        <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Classic pizza with tomato sauce, mozzarella, and basil</p>
                        <p class="cart-item-price">$12.99</p>
                    </div>
                    <div class="cart-item-quantity">
                        <button><i class="fas fa-minus"></i></button>
                        <span>1</span>
                        <button><i class="fas fa-plus"></i></button>
                    </div>
                    <div style="margin-left: 1rem;">
                        <button class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                
                <!-- Cart Item 2 -->
                <div class="cart-item">
                    <img src="https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80" alt="Spaghetti Bolognese" class="cart-item-image">
                    <div class="cart-item-details">
                        <h3 class="cart-item-title">Spaghetti Bolognese</h3>
                        <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Spaghetti with rich meat sauce</p>
                        <p class="cart-item-price">$10.99</p>
                    </div>
                    <div class="cart-item-quantity">
                        <button><i class="fas fa-minus"></i></button>
                        <span>1</span>
                        <button><i class="fas fa-plus"></i></button>
                    </div>
                    <div style="margin-left: 1rem;">
                        <button class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                
                <!-- Cart Item 3 -->
                <div class="cart-item">
                    <img src="https://images.unsplash.com/photo-1581636625402-29b2a704ef13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80" alt="Coca Cola" class="cart-item-image">
                    <div class="cart-item-details">
                        <h3 class="cart-item-title">Coca Cola</h3>
                        <p style="color: var(--dark-gray); margin-bottom: 0.5rem; font-size: 0.9rem;">Refreshing cola drink</p>
                        <p class="cart-item-price">$2.99</p>
                    </div>
                    <div class="cart-item-quantity">
                        <button><i class="fas fa-minus"></i></button>
                        <span>1</span>
                        <button><i class="fas fa-plus"></i></button>
                    </div>
                    <div style="margin-left: 1rem;">
                        <button class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                
                <div style="margin-top: 1.5rem; display: flex; justify-content: space-between;">
                    <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Continue Shopping</a>
                    <button class="btn btn-danger"><i class="fas fa-trash"></i> Clear Cart</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-4 col-sm-12">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Order Summary</h2>
            </div>
            <div style="padding: 1rem;">
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
                
                <div style="margin-top: 1.5rem;">
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-block"><i class="fas fa-credit-card"></i> Proceed to Checkout</a>
                </div>
                
                <div style="margin-top: 1.5rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Have a Promo Code?</h3>
                    <div style="display: flex;">
                        <input type="text" class="form-control" placeholder="Enter promo code" style="margin-right: 0.5rem;">
                        <button class="btn btn-secondary">Apply</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
