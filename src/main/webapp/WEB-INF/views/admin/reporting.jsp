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
                        <a href="${pageContext.request.contextPath}/admin/reporting" style="display: block; padding: 1rem; color: var(--primary-color); text-decoration: none; font-weight: bold; background-color: rgba(255, 87, 34, 0.1);">
                            <i class="fas fa-chart-bar"></i> Reports
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/settings" style="display: block; padding: 1rem; color: var(--dark-gray); text-decoration: none;">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="col-md-9 col-sm-12">
        <div class="card" style="margin-bottom: 2rem;">
            <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="card-title">Sales Reports</h2>
                <div>
                    <form action="${pageContext.request.contextPath}/admin/reporting" method="get" class="d-flex">
                        <select name="type" class="form-select me-2" style="width: auto;">
                            <option value="today" ${reportType == 'today' ? 'selected' : ''}>Today</option>
                            <option value="week" ${reportType == 'week' ? 'selected' : ''}>This Week</option>
                            <option value="month" ${reportType == 'month' ? 'selected' : ''}>This Month</option>
                            <option value="year" ${reportType == 'year' ? 'selected' : ''}>This Year</option>
                            <option value="custom" ${reportType == 'custom' ? 'selected' : ''}>Custom Range</option>
                        </select>
                        <div id="customDateRange" style="display: ${reportType == 'custom' ? 'flex' : 'none'}; gap: 0.5rem;">
                            <input type="date" name="startDate" class="form-control" value="${startDate}" style="width: auto;">
                            <span style="align-self: center;">to</span>
                            <input type="date" name="endDate" class="form-control" value="${endDate}" style="width: auto;">
                        </div>
                        <button type="submit" class="btn btn-primary ms-2">Apply</button>
                    </form>
                </div>
            </div>
            <div style="padding: 1rem;">
                <!-- Sales Summary -->
                <div class="row">
                    <div class="col-md-3 col-sm-6" style="margin-bottom: 1rem;">
                        <div class="card" style="background-color: rgba(33, 150, 243, 0.1); border-color: var(--secondary-color);">
                            <div style="text-align: center; padding: 1rem;">
                                <h3 style="margin: 0; color: var(--secondary-color);">Total Orders</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">${salesSummary.totalOrders}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 col-sm-6" style="margin-bottom: 1rem;">
                        <div class="card" style="background-color: rgba(76, 175, 80, 0.1); border-color: var(--success-color);">
                            <div style="text-align: center; padding: 1rem;">
                                <h3 style="margin: 0; color: var(--success-color);">Total Sales</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">$<fmt:formatNumber value="${salesSummary.totalSales}" pattern="#,##0.00" /></p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 col-sm-6" style="margin-bottom: 1rem;">
                        <div class="card" style="background-color: rgba(255, 193, 7, 0.1); border-color: var(--warning-color);">
                            <div style="text-align: center; padding: 1rem;">
                                <h3 style="margin: 0; color: var(--warning-color);">Total Items</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">${salesSummary.totalItems}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 col-sm-6" style="margin-bottom: 1rem;">
                        <div class="card" style="background-color: rgba(255, 87, 34, 0.1); border-color: var(--primary-color);">
                            <div style="text-align: center; padding: 1rem;">
                                <h3 style="margin: 0; color: var(--primary-color);">Avg. Order</h3>
                                <p style="font-size: 2rem; font-weight: bold; margin: 0;">$<fmt:formatNumber value="${salesSummary.averageOrderValue}" pattern="#,##0.00" /></p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Sales Chart -->
                <div style="margin-top: 2rem;">
                    <h3>Sales Trend</h3>
                    <canvas id="salesChart" style="width: 100%; height: 300px;"></canvas>
                </div>
                
                <!-- Sales Data Table -->
                <div style="margin-top: 2rem;">
                    <h3>Daily Sales</h3>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Orders</th>
                                    <th>Items</th>
                                    <th>Sales</th>
                                    <th>Avg. Order</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="report" items="${salesReports}">
                                    <tr>
                                        <td><fmt:formatDate value="${report.date}" pattern="yyyy-MM-dd" /></td>
                                        <td>${report.totalOrders}</td>
                                        <td>${report.totalItems}</td>
                                        <td>$<fmt:formatNumber value="${report.totalSales}" pattern="#,##0.00" /></td>
                                        <td>$<fmt:formatNumber value="${report.averageOrderValue}" pattern="#,##0.00" /></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty salesReports}">
                                    <tr>
                                        <td colspan="5" style="text-align: center;">No sales data available for the selected period.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Popular Items</h2>
            </div>
            <div style="padding: 1rem;">
                <!-- Popular Items Chart -->
                <div style="margin-bottom: 2rem;">
                    <canvas id="popularItemsChart" style="width: 100%; height: 300px;"></canvas>
                </div>
                
                <!-- Popular Items Table -->
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Restaurant</th>
                                <th>Category</th>
                                <th>Orders</th>
                                <th>Quantity</th>
                                <th>Sales</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${popularItems}">
                                <tr>
                                    <td>${item.menuItemName}</td>
                                    <td>${item.restaurantName}</td>
                                    <td>${item.categoryName}</td>
                                    <td>${item.totalOrders}</td>
                                    <td>${item.totalQuantity}</td>
                                    <td>$<fmt:formatNumber value="${item.totalSales}" pattern="#,##0.00" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty popularItems}">
                                <tr>
                                    <td colspan="6" style="text-align: center;">No popular items data available for the selected period.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    // Show/hide custom date range based on report type selection
    document.querySelector('select[name="type"]').addEventListener('change', function() {
        const customDateRange = document.getElementById('customDateRange');
        if (this.value === 'custom') {
            customDateRange.style.display = 'flex';
        } else {
            customDateRange.style.display = 'none';
        }
    });
    
    // Sales Chart
    const salesChartCtx = document.getElementById('salesChart').getContext('2d');
    const salesChart = new Chart(salesChartCtx, {
        type: 'line',
        data: {
            labels: [
                <c:forEach var="report" items="${salesReports}" varStatus="status">
                    '<fmt:formatDate value="${report.date}" pattern="MM/dd" />'${!status.last ? ',' : ''}
                </c:forEach>
            ],
            datasets: [{
                label: 'Sales ($)',
                data: [
                    <c:forEach var="report" items="${salesReports}" varStatus="status">
                        ${report.totalSales}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                borderColor: 'rgba(76, 175, 80, 1)',
                backgroundColor: 'rgba(76, 175, 80, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.4
            }, {
                label: 'Orders',
                data: [
                    <c:forEach var="report" items="${salesReports}" varStatus="status">
                        ${report.totalOrders}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                borderColor: 'rgba(33, 150, 243, 1)',
                backgroundColor: 'rgba(33, 150, 243, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.4,
                yAxisID: 'y1'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Sales ($)'
                    }
                },
                y1: {
                    beginAtZero: true,
                    position: 'right',
                    title: {
                        display: true,
                        text: 'Orders'
                    },
                    grid: {
                        drawOnChartArea: false
                    }
                }
            }
        }
    });
    
    // Popular Items Chart
    const popularItemsChartCtx = document.getElementById('popularItemsChart').getContext('2d');
    const popularItemsChart = new Chart(popularItemsChartCtx, {
        type: 'bar',
        data: {
            labels: [
                <c:forEach var="item" items="${popularItems}" varStatus="status">
                    '${item.menuItemName}'${!status.last ? ',' : ''}
                </c:forEach>
            ],
            datasets: [{
                label: 'Quantity Sold',
                data: [
                    <c:forEach var="item" items="${popularItems}" varStatus="status">
                        ${item.totalQuantity}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                backgroundColor: 'rgba(255, 87, 34, 0.7)',
                borderColor: 'rgba(255, 87, 34, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Quantity Sold'
                    }
                }
            }
        }
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
