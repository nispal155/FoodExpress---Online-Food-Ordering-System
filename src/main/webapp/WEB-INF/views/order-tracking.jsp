<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Order Tracking" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-8 col-sm-12" style="margin: 0 auto;">
        <div class="card" style="margin-bottom: 1.5rem;">
            <div class="card-header">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <h2 class="card-title">Order #1001</h2>
                    <span style="background-color: rgba(255, 193, 7, 0.1); color: var(--warning-color); padding: 0.5rem 1rem; border-radius: 4px; font-weight: bold;">Out for Delivery</span>
                </div>
                <p>Placed on April 15, 2023 at 7:30 PM</p>
            </div>
            <div style="padding: 1rem;">
                <div class="order-status">
                    <div class="status-step completed">
                        <div class="status-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <p>Order Placed</p>
                        <small>7:30 PM</small>
                    </div>
                    <div class="status-step completed">
                        <div class="status-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <p>Order Confirmed</p>
                        <small>7:35 PM</small>
                    </div>
                    <div class="status-step completed">
                        <div class="status-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <p>Preparing</p>
                        <small>7:40 PM</small>
                    </div>
                    <div class="status-step active">
                        <div class="status-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <p>Out for Delivery</p>
                        <small>8:00 PM</small>
                    </div>
                    <div class="status-step">
                        <div class="status-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <p>Delivered</p>
                        <small>Estimated: 8:15 PM</small>
                    </div>
                </div>
                
                <div style="margin-top: 2rem;">
                    <div style="display: flex; align-items: center; margin-bottom: 1.5rem;">
                        <img src="https://ui-avatars.com/api/?name=John+Doe&background=4CAF50&color=fff&size=50" alt="Delivery Person" style="border-radius: 50%; margin-right: 1rem;">
                        <div>
                            <h3 style="margin: 0; font-size: 1.2rem;">John Doe</h3>
                            <p style="margin: 0;">Your Delivery Person</p>
                        </div>
                        <a href="tel:+1234567890" class="btn btn-primary" style="margin-left: auto;"><i class="fas fa-phone"></i> Call</a>
                    </div>
                    
                    <div style="height: 300px; background-color: #eee; border-radius: 5px; display: flex; align-items: center; justify-content: center; margin-bottom: 1.5rem;">
                        <p style="font-size: 1.2rem; color: var(--dark-gray);"><i class="fas fa-map-marker-alt"></i> Map View (Delivery Tracking)</p>
                    </div>
                    
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <h3 style="margin: 0; font-size: 1.2rem;">Estimated Delivery Time</h3>
                            <p style="margin: 0; font-size: 1.5rem; font-weight: bold;">8:15 PM (15 minutes)</p>
                        </div>
                        <button class="btn btn-secondary"><i class="fas fa-sync-alt"></i> Refresh Status</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card" style="margin-bottom: 1.5rem;">
            <div class="card-header">
                <h2 class="card-title">Order Details</h2>
            </div>
            <div style="padding: 1rem;">
                <div style="margin-bottom: 1.5rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Pizza Palace</h3>
                    <p style="color: var(--dark-gray); margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt"></i> 123 Main St, Food City</p>
                    <p style="color: var(--dark-gray);"><i class="fas fa-phone"></i> (123) 456-7890</p>
                </div>
                
                <div style="margin-bottom: 1.5rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Items</h3>
                    
                    <div style="display: flex; margin-bottom: 1rem; padding-bottom: 1rem; border-bottom: 1px solid var(--medium-gray);">
                        <div style="margin-right: 1rem;">
                            <span style="background-color: var(--light-gray); color: var(--dark-gray); width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">1</span>
                        </div>
                        <div style="flex: 1;">
                            <div style="display: flex; justify-content: space-between;">
                                <h4 style="margin: 0; font-size: 1.1rem;">Margherita Pizza</h4>
                                <span style="font-weight: bold;">$12.99</span>
                            </div>
                            <p style="color: var(--dark-gray); margin: 0; font-size: 0.9rem;">Classic pizza with tomato sauce, mozzarella, and basil</p>
                        </div>
                    </div>
                    
                    <div style="display: flex; margin-bottom: 1rem; padding-bottom: 1rem; border-bottom: 1px solid var(--medium-gray);">
                        <div style="margin-right: 1rem;">
                            <span style="background-color: var(--light-gray); color: var(--dark-gray); width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">1</span>
                        </div>
                        <div style="flex: 1;">
                            <div style="display: flex; justify-content: space-between;">
                                <h4 style="margin: 0; font-size: 1.1rem;">Spaghetti Bolognese</h4>
                                <span style="font-weight: bold;">$10.99</span>
                            </div>
                            <p style="color: var(--dark-gray); margin: 0; font-size: 0.9rem;">Spaghetti with rich meat sauce</p>
                        </div>
                    </div>
                    
                    <div style="display: flex;">
                        <div style="margin-right: 1rem;">
                            <span style="background-color: var(--light-gray); color: var(--dark-gray); width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">1</span>
                        </div>
                        <div style="flex: 1;">
                            <div style="display: flex; justify-content: space-between;">
                                <h4 style="margin: 0; font-size: 1.1rem;">Coca Cola</h4>
                                <span style="font-weight: bold;">$2.99</span>
                            </div>
                            <p style="color: var(--dark-gray); margin: 0; font-size: 0.9rem;">Refreshing cola drink</p>
                        </div>
                    </div>
                </div>
                
                <div style="margin-bottom: 1.5rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Delivery Address</h3>
                    <p style="margin: 0;">123 Customer St, Apt 4B</p>
                    <p style="margin: 0;">Food City, FC 12345</p>
                </div>
                
                <div style="margin-bottom: 1.5rem;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Payment Information</h3>
                    <p style="margin: 0;">Payment Method: Credit Card (ending in 1234)</p>
                    <div style="display: flex; justify-content: space-between; margin-top: 1rem;">
                        <span>Subtotal:</span>
                        <span>$26.97</span>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Delivery Fee:</span>
                        <span>$2.99</span>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Tax:</span>
                        <span>$2.70</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-weight: bold; margin-top: 0.5rem; padding-top: 0.5rem; border-top: 1px solid var(--medium-gray);">
                        <span>Total:</span>
                        <span>$32.66</span>
                    </div>
                </div>
                
                <div style="display: flex; justify-content: space-between;">
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Orders</a>
                    <button class="btn btn-danger"><i class="fas fa-times"></i> Cancel Order</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
