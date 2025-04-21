<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - ${pageTitle}" />
</jsp:include>

<!-- Include custom CSS for admin settings -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-settings.css">

<div class="admin-container">
    <!-- Admin Sidebar -->
    <div class="admin-sidebar">
        <div class="admin-menu-title">Admin Menu</div>
        <ul class="admin-menu">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Users
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/restaurants">
                    <i class="fas fa-utensils"></i> Restaurants
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/menu-items">
                    <i class="fas fa-hamburger"></i> Menu Items
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/reporting">
                    <i class="fas fa-chart-bar"></i> Reports
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/settings" class="active">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
    </div>

    <!-- Admin Content -->
    <div class="admin-content">

        <!-- Settings Header -->
        <div class="settings-header">
            <h1><i class="fas fa-cog"></i> System Settings</h1>
            <p class="settings-description">Configure your system settings to customize how your food delivery platform operates.</p>
        </div>

        <!-- Success and Error Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert" style="border-radius: 8px; border-left: 4px solid var(--success-color);">
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
            <div class="alert alert-danger" role="alert" style="border-radius: 8px; border-left: 4px solid var(--danger-color);">
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
        <div class="settings-tabs-container">
            <div class="settings-tabs-intro">
                <p>Select a category below to configure different aspects of your food delivery system:</p>
            </div>

            <div class="settings-tabs-wrapper">
                <ul class="nav nav-tabs" id="settingsTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="business-hours-tab" data-bs-toggle="tab" data-bs-target="#business-hours" type="button" role="tab" aria-controls="business-hours" aria-selected="true">
                            <div class="tab-icon"><i class="fas fa-clock"></i></div>
                            <div class="tab-content-wrapper">
                                <div class="tab-title">Business Hours</div>
                                <div class="tab-description">Set your restaurant's opening and closing times</div>
                            </div>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="delivery-fees-tab" data-bs-toggle="tab" data-bs-target="#delivery-fees" type="button" role="tab" aria-controls="delivery-fees" aria-selected="false">
                            <div class="tab-icon"><i class="fas fa-truck"></i></div>
                            <div class="tab-content-wrapper">
                                <div class="tab-title">Delivery Fees</div>
                                <div class="tab-description">Configure delivery pricing and free delivery thresholds</div>
                            </div>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="order-settings-tab" data-bs-toggle="tab" data-bs-target="#order-settings" type="button" role="tab" aria-controls="order-settings" aria-selected="false">
                            <div class="tab-icon"><i class="fas fa-shopping-cart"></i></div>
                            <div class="tab-content-wrapper">
                                <div class="tab-title">Order Settings</div>
                                <div class="tab-description">Set minimum order amounts and delivery distances</div>
                            </div>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="contact-info-tab" data-bs-toggle="tab" data-bs-target="#contact-info" type="button" role="tab" aria-controls="contact-info" aria-selected="false">
                            <div class="tab-icon"><i class="fas fa-address-card"></i></div>
                            <div class="tab-content-wrapper">
                                <div class="tab-title">Contact Info</div>
                                <div class="tab-description">Update your business contact information</div>
                            </div>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="all-settings-tab" data-bs-toggle="tab" data-bs-target="#all-settings" type="button" role="tab" aria-controls="all-settings" aria-selected="false">
                            <div class="tab-icon"><i class="fas fa-list"></i></div>
                            <div class="tab-content-wrapper">
                                <div class="tab-title">All Settings</div>
                                <div class="tab-description">View and edit all system settings in one place</div>
                            </div>
                        </button>
                    </li>
                </ul>
            </div>

            <div class="settings-tabs-help">
                <div class="help-icon"><i class="fas fa-lightbulb"></i></div>
                <div class="help-text">Tip: Changes are saved per section. Make sure to click the Save Changes button in each tab.</div>
            </div>
        </div>

        <div class="tab-content" id="settingsTabsContent" style="margin-top: 1rem;">
            <!-- Business Hours Tab -->
            <div class="tab-pane fade show active" id="business-hours" role="tabpanel" aria-labelledby="business-hours-tab">
                <div class="settings-card">
                    <div class="settings-card-header">
                        <i class="settings-card-icon fas fa-clock"></i>
                        <h3 class="settings-card-title">Business Hours</h3>
                    </div>
                    <div class="settings-card-body">
                        <div class="settings-intro">
                            <p>Set your restaurant's operating hours to let customers know when they can place orders. Orders placed outside these hours will be scheduled for the next available time.</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="businessHoursForm">
                            <input type="hidden" name="action" value="update_business_hours">

                            <div class="settings-group">
                                <div class="settings-group-title">Operating Time</div>
                                <div class="form-group">
                                    <label for="openTime" class="form-label">Opening Time <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The time when your business starts accepting orders"><i class="fas fa-info"></i></span></label>
                                    <div class="time-input-group">
                                        <input type="time" class="form-control time-input" id="openTime" name="openTime" value="${openTime}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="closeTime" class="form-label">Closing Time <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The time when your business stops accepting orders"><i class="fas fa-info"></i></span></label>
                                    <div class="time-input-group">
                                        <input type="time" class="form-control time-input" id="closeTime" name="closeTime" value="${closeTime}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="settings-actions">
                                <button type="submit" class="save-button">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                                <button type="button" class="next-tab-button" onclick="document.getElementById('delivery-fees-tab').click()">
                                    Next: Delivery Fees <i class="fas fa-arrow-right"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delivery Fees Tab -->
            <div class="tab-pane fade" id="delivery-fees" role="tabpanel" aria-labelledby="delivery-fees-tab">
                <div class="settings-card">
                    <div class="settings-card-header">
                        <i class="settings-card-icon fas fa-truck"></i>
                        <h3 class="settings-card-title">Delivery Fees</h3>
                    </div>
                    <div class="settings-card-body">
                        <div class="settings-intro">
                            <p>Configure how much customers pay for delivery. Set a base fee, per-kilometer rate, and a threshold for free delivery to encourage larger orders.</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="deliveryFeesForm">
                            <input type="hidden" name="action" value="update_delivery_fees">

                            <div class="settings-group">
                                <div class="settings-group-title">Fee Structure</div>
                                <div class="form-group">
                                    <label for="baseFee" class="form-label">Base Delivery Fee <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The minimum fee charged for all deliveries"><i class="fas fa-info"></i></span></label>
                                    <div class="currency-input-group">
                                        <span class="currency-symbol">$</span>
                                        <input type="number" class="form-control" id="baseFee" name="baseFee" value="${baseFee}" min="0" step="0.01" required>
                                    </div>
                                    <div class="form-text">The base fee charged for all deliveries</div>
                                </div>

                                <div class="form-group">
                                    <label for="feePerKm" class="form-label">Fee Per Kilometer <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="Additional fee charged per kilometer of delivery distance"><i class="fas fa-info"></i></span></label>
                                    <div class="currency-input-group">
                                        <span class="currency-symbol">$</span>
                                        <input type="number" class="form-control" id="feePerKm" name="feePerKm" value="${feePerKm}" min="0" step="0.01" required>
                                    </div>
                                    <div class="form-text">Additional fee charged per kilometer of delivery distance</div>
                                </div>

                                <div class="fee-calculator">
                                    <div class="fee-calculator-header">Delivery Fee Calculator</div>
                                    <div class="fee-calculator-body">
                                        <div class="calculator-row">
                                            <label for="calcDistance">Distance (km):</label>
                                            <input type="number" id="calcDistance" min="1" value="5" class="form-control">
                                        </div>
                                        <div class="calculator-row">
                                            <label for="calcOrderAmount">Order Amount ($):</label>
                                            <input type="number" id="calcOrderAmount" min="0" value="25" class="form-control">
                                        </div>
                                        <button type="button" class="calculate-button" onclick="calculateDeliveryFee()">
                                            <i class="fas fa-calculator"></i> Calculate
                                        </button>
                                        <div class="calculator-result" id="feeCalculatorResult">
                                            Delivery Fee: <span id="calculatedFee">$0.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="settings-group">
                                <div class="settings-group-title">Free Delivery</div>
                                <div class="form-group">
                                    <label for="freeThreshold" class="form-label">Free Delivery Threshold <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="Order amount above which delivery is free"><i class="fas fa-info"></i></span></label>
                                    <div class="currency-input-group">
                                        <span class="currency-symbol">$</span>
                                        <input type="number" class="form-control" id="freeThreshold" name="freeThreshold" value="${freeThreshold}" min="0" step="0.01" required>
                                    </div>
                                    <div class="form-text">Order amount above which delivery is free</div>
                                </div>
                            </div>

                            <div class="settings-actions">
                                <button type="submit" class="save-button">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                                <div class="tab-navigation">
                                    <button type="button" class="prev-tab-button" onclick="document.getElementById('business-hours-tab').click()">
                                        <i class="fas fa-arrow-left"></i> Previous: Business Hours
                                    </button>
                                    <button type="button" class="next-tab-button" onclick="document.getElementById('order-settings-tab').click()">
                                        Next: Order Settings <i class="fas fa-arrow-right"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Order Settings Tab -->
            <div class="tab-pane fade" id="order-settings" role="tabpanel" aria-labelledby="order-settings-tab">
                <div class="settings-card">
                    <div class="settings-card-header">
                        <i class="settings-card-icon fas fa-shopping-cart"></i>
                        <h3 class="settings-card-title">Order Settings</h3>
                    </div>
                    <div class="settings-card-body">
                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="orderSettingsForm">
                            <input type="hidden" name="action" value="update_order_settings">

                            <div class="settings-group">
                                <div class="settings-group-title">Order Limits</div>
                                <div class="form-group">
                                    <label for="minOrderAmount" class="form-label">Minimum Order Amount <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The minimum amount required for an order to be placed"><i class="fas fa-info"></i></span></label>
                                    <div class="currency-input-group">
                                        <span class="currency-symbol">$</span>
                                        <input type="number" class="form-control" id="minOrderAmount" name="minOrderAmount" value="${minOrderAmount}" min="0" step="0.01" required>
                                    </div>
                                    <div class="form-text">Minimum amount required for an order</div>
                                </div>
                            </div>

                            <div class="settings-group">
                                <div class="settings-group-title">Delivery Range</div>
                                <div class="form-group">
                                    <label for="maxDeliveryDistance" class="form-label">Maximum Delivery Distance <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The maximum distance for delivery in kilometers"><i class="fas fa-info"></i></span></label>
                                    <input type="number" class="form-control" id="maxDeliveryDistance" name="maxDeliveryDistance" value="${maxDeliveryDistance}" min="1" step="1" required>
                                    <div class="form-text">Maximum distance for delivery in kilometers</div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Delivery Range Visualization</label>
                                    <input type="range" class="time-range-slider" id="deliveryRangeSlider" min="1" max="50" value="${maxDeliveryDistance}" oninput="updateDeliveryRangeValue(this.value)">
                                    <div class="time-display">
                                        <span>1 km</span>
                                        <span id="deliveryRangeValue">${maxDeliveryDistance} km</span>
                                        <span>50 km</span>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="save-button">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Contact Info Tab -->
            <div class="tab-pane fade" id="contact-info" role="tabpanel" aria-labelledby="contact-info-tab">
                <div class="settings-card">
                    <div class="settings-card-header">
                        <i class="settings-card-icon fas fa-address-card"></i>
                        <h3 class="settings-card-title">Contact Information</h3>
                    </div>
                    <div class="settings-card-body">
                        <form action="${pageContext.request.contextPath}/admin/settings" method="post" id="contactInfoForm">
                            <input type="hidden" name="action" value="update_contact_info">

                            <div class="settings-group">
                                <div class="settings-group-title">Business Contact Details</div>
                                <div class="form-group">
                                    <label for="contactEmail" class="form-label">Contact Email <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The primary email address for customer inquiries"><i class="fas fa-info"></i></span></label>
                                    <input type="email" class="form-control" id="contactEmail" name="contactEmail" value="${contactEmail}" required>
                                    <div class="form-text">This email will be displayed on the website for customer inquiries</div>
                                </div>

                                <div class="form-group">
                                    <label for="contactPhone" class="form-label">Contact Phone <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The primary phone number for customer inquiries"><i class="fas fa-info"></i></span></label>
                                    <input type="text" class="form-control" id="contactPhone" name="contactPhone" value="${contactPhone}" required>
                                    <div class="form-text">This phone number will be displayed on the website for customer inquiries</div>
                                </div>
                            </div>

                            <div class="settings-group">
                                <div class="settings-group-title">Location Information</div>
                                <div class="form-group">
                                    <label for="contactAddress" class="form-label">Business Address <span class="badge bg-info" data-bs-toggle="tooltip" data-bs-placement="top" title="The physical address of your business"><i class="fas fa-info"></i></span></label>
                                    <textarea class="form-control" id="contactAddress" name="contactAddress" rows="3" required>${contactAddress}</textarea>
                                    <div class="form-text">This address will be displayed on the website and used for delivery calculations</div>
                                </div>
                            </div>

                            <button type="submit" class="save-button">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- All Settings Tab -->
            <div class="tab-pane fade" id="all-settings" role="tabpanel" aria-labelledby="all-settings-tab">
                <div class="settings-card">
                    <div class="settings-card-header">
                        <i class="settings-card-icon fas fa-list"></i>
                        <h3 class="settings-card-title">All System Settings</h3>
                    </div>
                    <div class="settings-card-body">
                        <div class="table-responsive">
                            <table class="settings-table">
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
                                            <td><strong>${setting.settingKey}</strong></td>
                                            <td>${setting.settingValue}</td>
                                            <td>${setting.description}</td>
                                            <td>
                                                <fmt:formatDate value="${setting.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                                <div class="last-updated">by <span class="admin-badge">${setting.updatedBy}</span></div>
                                            </td>
                                            <td>
                                                <button type="button" class="edit-button" onclick="editSetting('${setting.settingKey}', '${setting.settingValue}')">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty allSettings}">
                                        <tr>
                                            <td colspan="5" style="text-align: center; padding: 30px;">
                                                <i class="fas fa-cog" style="font-size: 24px; color: #ccc; margin-bottom: 10px;"></i>
                                                <p style="margin: 0;">No settings found.</p>
                                            </td>
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
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header edit-modal-header">
                <h5 class="modal-title" id="editSettingModalLabel">Edit System Setting</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                <input type="hidden" name="action" value="update_setting">
                <input type="hidden" id="settingKey" name="key">

                <div class="modal-body edit-modal-body">
                    <div class="form-group">
                        <label for="settingKeyDisplay" class="form-label">Setting Key</label>
                        <input type="text" class="form-control" id="settingKeyDisplay" disabled>
                        <div class="form-text">The unique identifier for this setting (cannot be changed)</div>
                    </div>

                    <div class="form-group">
                        <label for="settingValue" class="form-label">Setting Value</label>
                        <input type="text" class="form-control" id="settingValue" name="value" required>
                        <div class="form-text">The value to be stored for this setting</div>
                    </div>
                </div>
                <div class="modal-footer edit-modal-footer">
                    <button type="button" class="cancel-modal-button" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="save-modal-button">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Bootstrap will handle the tabs automatically

    // Update delivery range value display
    function updateDeliveryRangeValue(val) {
        document.getElementById('deliveryRangeValue').textContent = val + ' km';
        document.getElementById('maxDeliveryDistance').value = val;
    }

    // Sync range slider with input field
    document.addEventListener('DOMContentLoaded', function() {
        const maxDeliveryDistanceInput = document.getElementById('maxDeliveryDistance');
        const deliveryRangeSlider = document.getElementById('deliveryRangeSlider');

        if (maxDeliveryDistanceInput && deliveryRangeSlider) {
            maxDeliveryDistanceInput.addEventListener('input', function() {
                deliveryRangeSlider.value = this.value;
                document.getElementById('deliveryRangeValue').textContent = this.value + ' km';
            });
        }

        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
    });

    // Calculate delivery fee based on distance and order amount
    function calculateDeliveryFee() {
        const distance = parseFloat(document.getElementById('calcDistance').value) || 0;
        const orderAmount = parseFloat(document.getElementById('calcOrderAmount').value) || 0;
        const baseFee = parseFloat(document.getElementById('baseFee').value) || 0;
        const feePerKm = parseFloat(document.getElementById('feePerKm').value) || 0;
        const freeThreshold = parseFloat(document.getElementById('freeThreshold').value) || 0;

        let fee = 0;

        // Check if order amount is above free delivery threshold
        if (orderAmount >= freeThreshold && freeThreshold > 0) {
            fee = 0;
        } else {
            // Calculate fee based on base fee and distance
            fee = baseFee + (distance * feePerKm);
        }

        // Update the result
        document.getElementById('calculatedFee').textContent = '$' + fee.toFixed(2);

        // Add animation to show the result has been updated
        const resultElement = document.getElementById('feeCalculatorResult');
        resultElement.classList.add('highlight-result');

        // Remove the highlight class after animation completes
        setTimeout(function() {
            resultElement.classList.remove('highlight-result');
        }, 1000);
    }

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
        document.getElementById('settingKeyDisplay').value = key;
        document.getElementById('settingValue').value = value;

        const modal = new bootstrap.Modal(document.getElementById('editSettingModal'));
        modal.show();
    }

    // Initialize Bootstrap tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
