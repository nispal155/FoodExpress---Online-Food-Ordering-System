<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Track Order" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1 style="margin-bottom: 2rem;">Track Order #${order.id}</h1>

    <div class="row">
        <div class="col-md-8">
            <!-- Order Tracking -->
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h5 style="margin: 0;">Order Status</h5>
                </div>
                <div class="card-body">
                    <div id="orderStatusContainer">
                        <!-- Order Status Timeline -->
                        <div style="display: flex; justify-content: space-between; margin-bottom: 2rem; position: relative;">
                            <!-- Progress Bar -->
                            <div style="position: absolute; top: 24px; left: 0; right: 0; height: 4px; background-color: #eee; z-index: 1;"></div>
                            <div id="progressBar" style="position: absolute; top: 24px; left: 0; height: 4px; background-color: var(--primary-color); z-index: 2; transition: width 0.5s ease-in-out;"></div>

                            <!-- Status Steps -->
                            <div class="status-step" data-status="PENDING" style="position: relative; z-index: 3; text-align: center; flex: 1;">
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: #eee; display: flex; align-items: center; justify-content: center; margin: 0 auto; border: 2px solid #eee;">
                                    <i class="fas fa-clipboard-list" style="font-size: 1.2rem; color: var(--medium-gray);"></i>
                                </div>
                                <p style="margin-top: 0.5rem; font-size: 0.9rem;">Pending</p>
                            </div>

                            <div class="status-step" data-status="CONFIRMED" style="position: relative; z-index: 3; text-align: center; flex: 1;">
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: #eee; display: flex; align-items: center; justify-content: center; margin: 0 auto; border: 2px solid #eee;">
                                    <i class="fas fa-check" style="font-size: 1.2rem; color: var(--medium-gray);"></i>
                                </div>
                                <p style="margin-top: 0.5rem; font-size: 0.9rem;">Confirmed</p>
                            </div>

                            <div class="status-step" data-status="PREPARING" style="position: relative; z-index: 3; text-align: center; flex: 1;">
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: #eee; display: flex; align-items: center; justify-content: center; margin: 0 auto; border: 2px solid #eee;">
                                    <i class="fas fa-utensils" style="font-size: 1.2rem; color: var(--medium-gray);"></i>
                                </div>
                                <p style="margin-top: 0.5rem; font-size: 0.9rem;">Preparing</p>
                            </div>

                            <div class="status-step" data-status="READY" style="position: relative; z-index: 3; text-align: center; flex: 1;">
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: #eee; display: flex; align-items: center; justify-content: center; margin: 0 auto; border: 2px solid #eee;">
                                    <i class="fas fa-box" style="font-size: 1.2rem; color: var(--medium-gray);"></i>
                                </div>
                                <p style="margin-top: 0.5rem; font-size: 0.9rem;">Ready</p>
                            </div>

                            <div class="status-step" data-status="OUT_FOR_DELIVERY" style="position: relative; z-index: 3; text-align: center; flex: 1;">
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: #eee; display: flex; align-items: center; justify-content: center; margin: 0 auto; border: 2px solid #eee;">
                                    <i class="fas fa-motorcycle" style="font-size: 1.2rem; color: var(--medium-gray);"></i>
                                </div>
                                <p style="margin-top: 0.5rem; font-size: 0.9rem;">Out for Delivery</p>
                            </div>

                            <div class="status-step" data-status="DELIVERED" style="position: relative; z-index: 3; text-align: center; flex: 1;">
                                <div style="width: 50px; height: 50px; border-radius: 50%; background-color: #eee; display: flex; align-items: center; justify-content: center; margin: 0 auto; border: 2px solid #eee;">
                                    <i class="fas fa-home" style="font-size: 1.2rem; color: var(--medium-gray);"></i>
                                </div>
                                <p style="margin-top: 0.5rem; font-size: 0.9rem;">Delivered</p>
                            </div>
                        </div>

                        <!-- Current Status -->
                        <div style="text-align: center; margin-bottom: 2rem;">
                            <h3 id="currentStatus" style="margin-bottom: 0.5rem;">
                                ${order.status.displayName}
                            </h3>
                            <p id="statusMessage" style="color: var(--medium-gray);">
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        Your order has been received and is waiting for confirmation.
                                    </c:when>
                                    <c:when test="${order.status == 'CONFIRMED'}">
                                        Your order has been confirmed and will be prepared soon.
                                    </c:when>
                                    <c:when test="${order.status == 'PREPARING'}">
                                        Your order is being prepared by the restaurant.
                                    </c:when>
                                    <c:when test="${order.status == 'READY'}">
                                        Your order is ready and waiting for pickup by the delivery person.
                                    </c:when>
                                    <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                        Your order is on the way to your location.
                                    </c:when>
                                    <c:when test="${order.status == 'DELIVERED'}">
                                        Your order has been delivered. Enjoy your meal!
                                    </c:when>
                                    <c:when test="${order.status == 'CANCELLED'}">
                                        Your order has been cancelled.
                                    </c:when>
                                </c:choose>
                            </p>
                        </div>

                        <!-- Delivery Person Info (shown only when out for delivery) -->
                        <div id="deliveryPersonInfo" style="text-align: center; margin-bottom: 2rem; display: ${order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'block' : 'none'};">
                            <h4 style="margin-bottom: 0.5rem;">Delivery Person</h4>
                            <p id="deliveryPersonName" style="font-weight: bold; font-size: 1.2rem;">
                                ${not empty order.deliveryPersonName ? order.deliveryPersonName : 'Not assigned yet'}
                            </p>
                        </div>

                        <!-- Estimated Delivery Time -->
                        <div style="text-align: center; margin-bottom: 2rem;">
                            <h4 style="margin-bottom: 0.5rem;">Estimated Delivery Time</h4>
                            <p style="font-weight: bold; font-size: 1.2rem;">
                                <c:choose>
                                    <c:when test="${not empty order.estimatedDeliveryTime}">
                                        <fmt:formatDate value="${order.estimatedDeliveryTime}" pattern="h:mm a" />
                                    </c:when>
                                    <c:otherwise>
                                        To be determined
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <!-- Order Summary -->
            <div class="card" style="margin-bottom: 2rem; position: sticky; top: 100px;">
                <div class="card-header">
                    <h5 style="margin: 0;">Order Summary</h5>
                </div>
                <div class="card-body">
                    <p>
                        <strong>Order #:</strong> ${order.id}
                    </p>
                    <p>
                        <strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="MMMM d, yyyy 'at' h:mm a" />
                    </p>
                    <p>
                        <strong>Restaurant:</strong> ${order.restaurantName}
                    </p>
                    <p>
                        <strong>Total:</strong> $<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                    </p>
                    <p>
                        <strong>Payment Method:</strong> ${order.paymentMethod.displayName}
                    </p>
                    <p>
                        <strong>Payment Status:</strong>
                        <c:choose>
                            <c:when test="${order.paymentStatus == 'PAID'}">
                                <span style="color: var(--success-color);">Paid</span>
                            </c:when>
                            <c:when test="${order.paymentStatus == 'PENDING'}">
                                <span style="color: var(--warning-color);">Pending</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: var(--danger-color);">Failed</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <hr>

                    <p>
                        <strong>Delivery Address:</strong><br>
                        ${order.deliveryAddress}
                    </p>
                    <p>
                        <strong>Phone:</strong> ${order.deliveryPhone}
                    </p>
                    <c:if test="${not empty order.deliveryNotes}">
                        <p>
                            <strong>Notes:</strong><br>
                            ${order.deliveryNotes}
                        </p>
                    </c:if>

                    <hr>

                    <h6 style="margin-bottom: 1rem;">Order Items</h6>
                    <div style="max-height: 200px; overflow-y: auto; margin-bottom: 1rem;">
                        <c:forEach var="item" items="${order.orderItems}">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid #eee;">
                                <div>
                                    <span>${item.quantity} × ${item.menuItemName}</span>
                                </div>
                                <div>
                                    $<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" />
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div style="display: flex; justify-content: space-between; padding-top: 1rem; border-top: 2px solid #eee; font-weight: bold;">
                        <span>Total:</span>
                        <span>$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Current order status
    let currentStatus = "${order.status}";

    // Update the status display
    function updateStatusDisplay(status) {
        // Update progress bar width based on status
        const progressWidth = getProgressWidth(status);
        document.getElementById('progressBar').style.width = progressWidth + '%';

        // Update status steps
        const statusSteps = document.querySelectorAll('.status-step');
        const statusOrder = ['PENDING', 'CONFIRMED', 'PREPARING', 'READY', 'OUT_FOR_DELIVERY', 'DELIVERED'];
        const currentIndex = statusOrder.indexOf(status);

        statusSteps.forEach((step, index) => {
            const stepStatus = step.getAttribute('data-status');
            const stepIndex = statusOrder.indexOf(stepStatus);
            const iconContainer = step.querySelector('div');
            const icon = step.querySelector('i');

            if (stepIndex <= currentIndex) {
                // Completed or current step
                iconContainer.style.backgroundColor = stepIndex === currentIndex ? 'var(--primary-color)' : 'var(--success-color)';
                iconContainer.style.borderColor = stepIndex === currentIndex ? 'var(--primary-color)' : 'var(--success-color)';
                icon.style.color = 'white';
            } else {
                // Future step
                iconContainer.style.backgroundColor = '#eee';
                iconContainer.style.borderColor = '#eee';
                icon.style.color = 'var(--medium-gray)';
            }
        });

        // Update current status text
        document.getElementById('currentStatus').textContent = getStatusDisplayName(status);

        // Update status message
        document.getElementById('statusMessage').textContent = getStatusMessage(status);

        // Show/hide delivery person info
        document.getElementById('deliveryPersonInfo').style.display =
            (status === 'OUT_FOR_DELIVERY' || status === 'DELIVERED') ? 'block' : 'none';
    }

    // Get progress bar width based on status
    function getProgressWidth(status) {
        switch (status) {
            case 'PENDING':
                return 0;
            case 'CONFIRMED':
                return 20;
            case 'PREPARING':
                return 40;
            case 'READY':
                return 60;
            case 'OUT_FOR_DELIVERY':
                return 80;
            case 'DELIVERED':
                return 100;
            case 'CANCELLED':
                return 0;
            default:
                return 0;
        }
    }

    // Get status display name
    function getStatusDisplayName(status) {
        switch (status) {
            case 'PENDING':
                return 'Pending';
            case 'CONFIRMED':
                return 'Confirmed';
            case 'PREPARING':
                return 'Preparing';
            case 'READY':
                return 'Ready';
            case 'OUT_FOR_DELIVERY':
                return 'Out for Delivery';
            case 'DELIVERED':
                return 'Delivered';
            case 'CANCELLED':
                return 'Cancelled';
            default:
                return '';
        }
    }

    // Get status message
    function getStatusMessage(status) {
        switch (status) {
            case 'PENDING':
                return 'Your order has been received and is waiting for confirmation.';
            case 'CONFIRMED':
                return 'Your order has been confirmed and will be prepared soon.';
            case 'PREPARING':
                return 'Your order is being prepared by the restaurant.';
            case 'READY':
                return 'Your order is ready and waiting for pickup by the delivery person.';
            case 'OUT_FOR_DELIVERY':
                return 'Your order is on the way to your location.';
            case 'DELIVERED':
                return 'Your order has been delivered. Enjoy your meal!';
            case 'CANCELLED':
                return 'Your order has been cancelled.';
            default:
                return '';
        }
    }

    // Initialize status display
    updateStatusDisplay(currentStatus);

    // Poll for status updates every 30 seconds
    setInterval(function() {
        // Skip polling if order is already delivered or cancelled
        if (currentStatus === 'DELIVERED' || currentStatus === 'CANCELLED') {
            return;
        }

        // Make AJAX request to get updated status
        fetch('${pageContext.request.contextPath}/track-order?id=${order.id}&ajax=true')
            .then(response => response.json())
            .then(data => {
                // Update status if changed
                if (data.status !== currentStatus) {
                    currentStatus = data.status;
                    updateStatusDisplay(currentStatus);

                    // Update delivery person name if available
                    if (data.deliveryPersonName) {
                        document.getElementById('deliveryPersonName').textContent = data.deliveryPersonName;
                    }
                }
            })
            .catch(error => console.error('Error fetching order status:', error));
    }, 30000); // Poll every 30 seconds
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
