<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
                        <a href="${pageContext.request.contextPath}/admin/users" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-users"></i> Users
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/restaurants" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-utensils"></i> Restaurants
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/menu-items" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-hamburger"></i> Menu Items
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/orders" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li style="border-bottom: 1px solid var(--medium-gray);">
                        <a href="${pageContext.request.contextPath}/admin/reporting" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-chart-bar"></i> Reports
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/settings" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-cog"></i> Settings
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
                    <c:when test="${param.success == 'business_hours'}">
                        <i class="fas fa-check-circle"></i> Business hours updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'delivery_fees'}">
                        <i class="fas fa-check-circle"></i> Delivery fees updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'order_settings'}">
                        <i class="fas fa-check-circle"></i> Order settings updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'contact_info'}">
                        <i class="fas fa-check-circle"></i> Contact information updated successfully!
                    </c:when>
                    <c:when test="${param.success == 'setting_updated'}">
                        <i class="fas fa-check-circle"></i> Setting updated successfully!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-check-circle"></i> Settings updated successfully!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                <c:choose>
                    <c:when test="${param.error == 'business_hours'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update business hours!
                    </c:when>
                    <c:when test="${param.error == 'delivery_fees'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update delivery fees!
                    </c:when>
                    <c:when test="${param.error == 'order_settings'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update order settings!
                    </c:when>
                    <c:when test="${param.error == 'contact_info'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update contact information!
                    </c:when>
                    <c:when test="${param.error == 'invalid_time_format'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid time format!
                    </c:when>
                    <c:when test="${param.error == 'invalid_number_format'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid number format!
                    </c:when>
                    <c:when test="${param.error == 'setting_update_failed'}">
                        <i class="fas fa-exclamation-circle"></i> Failed to update setting!
                    </c:when>
                    <c:when test="${param.error == 'invalid_key'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid setting key!
                    </c:when>
                    <c:when test="${param.error == 'invalid_action'}">
                        <i class="fas fa-exclamation-circle"></i> Invalid action!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-exclamation-circle"></i> An error occurred!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <!-- Settings Tabs -->
        <ul class="nav nav-tabs" id="settingsTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="business-hours-tab" data-bs-toggle="tab" data-bs-target="#business-hours" type="button" role="tab" aria-controls="business-hours" aria-selected="true">
                    <i class="fas fa-clock"></i> Business Hours
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="delivery-fees-tab" data-bs-toggle="tab" data-bs-target="#delivery-fees" type="button" role="tab" aria-controls="delivery-fees" aria-selected="false">
                    <i class="fas fa-truck"></i> Delivery Fees
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="order-settings-tab" data-bs-toggle="tab" data-bs-target="#order-settings" type="button" role="tab" aria-controls="order-settings" aria-selected="false">
                    <i class="fas fa-shopping-cart"></i> Order Settings
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="contact-info-tab" data-bs-toggle="tab" data-bs-target="#contact-info" type="button" role="tab" aria-controls="contact-info" aria-selected="false">
                    <i class="fas fa-address-card"></i> Contact Info
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="all-settings-tab" data-bs-toggle="tab" data-bs-target="#all-settings" type="button" role="tab" aria-controls="all-settings" aria-selected="false">
                    <i class="fas fa-list"></i> All Settings
                </button>
            </li>
        </ul>
        
        <div class="tab-content" id="settingsTabsContent" style="margin-top: 1rem;">
            <!-- Business Hours Tab -->
            <div class="tab-pane fade show active" id="business-hours" role="tabpanel" aria-labelledby="business-hours-tab">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Business Hours</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="businessHoursForm">
                            <input type="hidden" name="action" value="update_business_hours">
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="openTime" class="form-label">Opening Time</label>
                                    <input type="time" class="form-control" id="openTime" name="openTime" value="${openTime}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="closeTime" class="form-label">Closing Time</label>
                                    <input type="time" class="form-control" id="closeTime" name="closeTime" value="${closeTime}" required>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Delivery Fees Tab -->
            <div class="tab-pane fade" id="delivery-fees" role="tabpanel" aria-labelledby="delivery-fees-tab">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Delivery Fees</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="deliveryFeesForm">
                            <input type="hidden" name="action" value="update_delivery_fees">
                            
                            <div class="mb-3">
                                <label for="baseFee" class="form-label">Base Delivery Fee ($)</label>
                                <input type="number" class="form-control" id="baseFee" name="baseFee" value="${baseFee}" min="0" step="0.01" required>
                                <div class="form-text">The base fee charged for all deliveries</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="feePerKm" class="form-label">Fee Per Kilometer ($)</label>
                                <input type="number" class="form-control" id="feePerKm" name="feePerKm" value="${feePerKm}" min="0" step="0.01" required>
                                <div class="form-text">Additional fee charged per kilometer of delivery distance</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="freeThreshold" class="form-label">Free Delivery Threshold ($)</label>
                                <input type="number" class="form-control" id="freeThreshold" name="freeThreshold" value="${freeThreshold}" min="0" step="0.01" required>
                                <div class="form-text">Order amount above which delivery is free</div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Order Settings Tab -->
            <div class="tab-pane fade" id="order-settings" role="tabpanel" aria-labelledby="order-settings-tab">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Order Settings</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="orderSettingsForm">
                            <input type="hidden" name="action" value="update_order_settings">
                            
                            <div class="mb-3">
                                <label for="minOrderAmount" class="form-label">Minimum Order Amount ($)</label>
                                <input type="number" class="form-control" id="minOrderAmount" name="minOrderAmount" value="${minOrderAmount}" min="0" step="0.01" required>
                                <div class="form-text">Minimum amount required for an order</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="maxDeliveryDistance" class="form-label">Maximum Delivery Distance (km)</label>
                                <input type="number" class="form-control" id="maxDeliveryDistance" name="maxDeliveryDistance" value="${maxDeliveryDistance}" min="1" step="1" required>
                                <div class="form-text">Maximum distance for delivery in kilometers</div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Contact Info Tab -->
            <div class="tab-pane fade" id="contact-info" role="tabpanel" aria-labelledby="contact-info-tab">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Contact Information</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="contactInfoForm">
                            <input type="hidden" name="action" value="update_contact_info">
                            
                            <div class="mb-3">
                                <label for="contactEmail" class="form-label">Contact Email</label>
                                <input type="email" class="form-control" id="contactEmail" name="contactEmail" value="${contactEmail}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="contactPhone" class="form-label">Contact Phone</label>
                                <input type="text" class="form-control" id="contactPhone" name="contactPhone" value="${contactPhone}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="contactAddress" class="form-label">Business Address</label>
                                <textarea class="form-control" id="contactAddress" name="contactAddress" rows="3" required>${contactAddress}</textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- All Settings Tab -->
            <div class="tab-pane fade" id="all-settings" role="tabpanel" aria-labelledby="all-settings-tab">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">All System Settings</h3>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Key</th>
                                        <th>Value</th>
                                        <th>Description</th>
                                        <th>Last Updated</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="setting" items="${allSettings}">
                                        <tr>
                                            <td>${setting.settingKey}</td>
                                            <td>${setting.settingValue}</td>
                                            <td>${setting.description}</td>
                                            <td><fmt:formatDate value="${setting.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-primary" onclick="editSetting('${setting.settingKey}', '${setting.settingValue}')">
                                                    <i class="fas fa-edit"></i> Edit
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty allSettings}">
                                        <tr>
                                            <td colspan="5" style="text-align: center;">No settings found.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Edit Setting Modal -->
<div class="modal fade" id="editSettingModal" tabindex="-1" aria-labelledby="editSettingModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editSettingModalLabel">Edit Setting</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                <input type="hidden" name="action" value="update_setting">
                <input type="hidden" id="settingKey" name="key">
                
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="settingValue" class="form-label">Value</label>
                        <input type="text" class="form-control" id="settingValue" name="value" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Form validation for business hours
    document.getElementById('businessHoursForm').addEventListener('submit', function(event) {
        const openTime = document.getElementById('openTime').value;
        const closeTime = document.getElementById('closeTime').value;
        
        if (!openTime || !closeTime) {
            event.preventDefault();
            alert('Please enter both opening and closing times.');
        }
    });
    
    // Form validation for delivery fees
    document.getElementById('deliveryFeesForm').addEventListener('submit', function(event) {
        const baseFee = document.getElementById('baseFee').value;
        const feePerKm = document.getElementById('feePerKm').value;
        const freeThreshold = document.getElementById('freeThreshold').value;
        
        if (!baseFee || !feePerKm || !freeThreshold) {
            event.preventDefault();
            alert('Please fill in all delivery fee fields.');
        }
        
        if (parseFloat(baseFee) < 0 || parseFloat(feePerKm) < 0 || parseFloat(freeThreshold) < 0) {
            event.preventDefault();
            alert('All fee values must be non-negative.');
        }
    });
    
    // Form validation for order settings
    document.getElementById('orderSettingsForm').addEventListener('submit', function(event) {
        const minOrderAmount = document.getElementById('minOrderAmount').value;
        const maxDeliveryDistance = document.getElementById('maxDeliveryDistance').value;
        
        if (!minOrderAmount || !maxDeliveryDistance) {
            event.preventDefault();
            alert('Please fill in all order setting fields.');
        }
        
        if (parseFloat(minOrderAmount) < 0) {
            event.preventDefault();
            alert('Minimum order amount must be non-negative.');
        }
        
        if (parseInt(maxDeliveryDistance) < 1) {
            event.preventDefault();
            alert('Maximum delivery distance must be at least 1 km.');
        }
    });
    
    // Form validation for contact info
    document.getElementById('contactInfoForm').addEventListener('submit', function(event) {
        const contactEmail = document.getElementById('contactEmail').value;
        const contactPhone = document.getElementById('contactPhone').value;
        const contactAddress = document.getElementById('contactAddress').value;
        
        if (!contactEmail || !contactPhone || !contactAddress) {
            event.preventDefault();
            alert('Please fill in all contact information fields.');
        }
        
        // Simple email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(contactEmail)) {
            event.preventDefault();
            alert('Please enter a valid email address.');
        }
    });
    
    // Function to open the edit setting modal
    function editSetting(key, value) {
        document.getElementById('settingKey').value = key;
        document.getElementById('settingValue').value = value;
        
        const modal = new bootstrap.Modal(document.getElementById('editSettingModal'));
        modal.show();
    }
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
