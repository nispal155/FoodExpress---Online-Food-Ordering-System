<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="Admin - Sales Reports" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Include the admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-reporting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp">
        <jsp:param name="activeMenu" value="reports" />
    </jsp:include>

    <!-- Admin Content -->
    <div class="admin-content">

        <!-- Reporting Header -->
        <div class="reporting-header">
            <h1>Sales Reports</h1>
        </div>

        <!-- Date Range Filter -->
        <div class="date-range-filter">
            <form action="${pageContext.request.contextPath}/admin/reporting" method="get" class="filter-form">
                <div class="filter-group">
                    <label class="filter-label">Report Period</label>
                    <select name="type" class="filter-select">
                        <option value="today" ${reportType == 'today' ? 'selected' : ''}>Today</option>
                        <option value="week" ${reportType == 'week' ? 'selected' : ''}>This Week</option>
                        <option value="month" ${reportType == 'month' ? 'selected' : ''}>This Month</option>
                        <option value="year" ${reportType == 'year' ? 'selected' : ''}>This Year</option>
                        <option value="custom" ${reportType == 'custom' ? 'selected' : ''}>Custom Range</option>
                    </select>
                </div>

                <div id="customDateRange" class="filter-group" style="display: ${reportType == 'custom' ? 'flex' : 'none'}; gap: 10px; align-items: center;">
                    <div>
                        <label class="filter-label">Start Date</label>
                        <input type="date" name="startDate" class="filter-input" value="${startDate}">
                    </div>
                    <div style="margin-top: 25px;">to</div>
                    <div>
                        <label class="filter-label">End Date</label>
                        <input type="date" name="endDate" class="filter-input" value="${endDate}">
                    </div>
                </div>

                <div class="filter-group" style="flex: 0 0 auto; align-self: flex-end;">
                    <button type="submit" class="filter-button">
                        <i class="fas fa-filter"></i> Apply Filter
                    </button>
                </div>

                <div class="filter-group" style="flex: 0 0 auto; align-self: flex-end; margin-left: 10px;">
                    <a href="${pageContext.request.contextPath}/admin/reporting/pdf?type=${reportType}&startDate=${startDate}&endDate=${endDate}"
                       class="pdf-button" target="_blank" title="Download PDF Report">
                        <i class="fas fa-file-pdf"></i> Download PDF
                    </a>
                </div>
            </form>
        </div>

        <!-- Sales Summary Stats -->
        <div class="stats-cards">
            <div class="stat-card secondary">
                <div class="stat-card-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-card-title">Total Orders</div>
                <div class="stat-card-value secondary">${salesSummary.totalOrders}</div>
            </div>

            <div class="stat-card success">
                <div class="stat-card-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="stat-card-title">Total Sales</div>
                <div class="stat-card-value success">$<fmt:formatNumber value="${salesSummary.totalSales}" pattern="#,##0.00" /></div>
            </div>

            <div class="stat-card warning">
                <div class="stat-card-icon">
                    <i class="fas fa-box"></i>
                </div>
                <div class="stat-card-title">Total Items</div>
                <div class="stat-card-value warning">${salesSummary.totalItems}</div>
            </div>

            <div class="stat-card primary">
                <div class="stat-card-icon">
                    <i class="fas fa-calculator"></i>
                </div>
                <div class="stat-card-title">Avg. Order Value</div>
                <div class="stat-card-value primary">$<fmt:formatNumber value="${salesSummary.averageOrderValue}" pattern="#,##0.00" /></div>
            </div>
        </div>

        <!-- Sales Chart -->
        <div class="chart-container">
            <div class="chart-header">
                <h2 class="chart-title">Sales Trend</h2>
            </div>
            <canvas id="salesChart" class="chart-canvas"></canvas>
        </div>

        <!-- Sales Data Table -->
        <div class="data-table-container">
            <div class="data-table-header">
                <h2 class="data-table-title">Daily Sales</h2>
            </div>

            <table class="data-table">
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
                </tbody>
            </table>

            <c:if test="${empty salesReports}">
                <div class="empty-state">
                    <i class="fas fa-chart-line"></i>
                    <h3>No Sales Data Available</h3>
                    <p>There is no sales data available for the selected period.</p>
                </div>
            </c:if>
        </div>

        <!-- Popular Items Chart -->
        <div class="chart-container">
            <div class="chart-header">
                <h2 class="chart-title">Popular Items</h2>
            </div>
            <canvas id="popularItemsChart" class="chart-canvas"></canvas>
        </div>

        <!-- Popular Items Table -->
        <div class="data-table-container">
            <div class="data-table-header">
                <h2 class="data-table-title">Top Selling Items</h2>
            </div>

            <table class="data-table">
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
                            <td><strong>${item.menuItemName}</strong></td>
                            <td>${item.restaurantName}</td>
                            <td>${item.categoryName}</td>
                            <td>${item.totalOrders}</td>
                            <td>${item.totalQuantity}</td>
                            <td>$<fmt:formatNumber value="${item.totalSales}" pattern="#,##0.00" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty popularItems}">
                <div class="empty-state">
                    <i class="fas fa-hamburger"></i>
                    <h3>No Popular Items Data</h3>
                    <p>There are no popular items data available for the selected period.</p>
                </div>
            </c:if>
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

    // Chart.js global defaults
    Chart.defaults.font.family = '"Poppins", "Helvetica", "Arial", sans-serif';
    Chart.defaults.font.size = 12;
    Chart.defaults.color = '#666';

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
                borderColor: '#4CAF50',
                backgroundColor: 'rgba(76, 175, 80, 0.1)',
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#4CAF50',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6
            }, {
                label: 'Orders',
                data: [
                    <c:forEach var="report" items="${salesReports}" varStatus="status">
                        ${report.totalOrders}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                borderColor: '#2196F3',
                backgroundColor: 'rgba(33, 150, 243, 0.1)',
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                yAxisID: 'y1',
                pointBackgroundColor: '#2196F3',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            interaction: {
                mode: 'index',
                intersect: false
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        usePointStyle: true,
                        padding: 20,
                        font: {
                            size: 13
                        }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    padding: 10,
                    titleFont: {
                        size: 14
                    },
                    bodyFont: {
                        size: 13
                    },
                    displayColors: true,
                    usePointStyle: true
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        padding: 10
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Sales ($)',
                        font: {
                            size: 13,
                            weight: 'bold'
                        },
                        padding: {top: 0, bottom: 10}
                    },
                    ticks: {
                        padding: 10
                    },
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                y1: {
                    beginAtZero: true,
                    position: 'right',
                    title: {
                        display: true,
                        text: 'Orders',
                        font: {
                            size: 13,
                            weight: 'bold'
                        },
                        padding: {top: 0, bottom: 10}
                    },
                    ticks: {
                        padding: 10
                    },
                    grid: {
                        drawOnChartArea: false,
                        color: 'rgba(0, 0, 0, 0.05)'
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
                borderWidth: 1,
                borderRadius: 4,
                barPercentage: 0.6,
                categoryPercentage: 0.8
            }, {
                label: 'Sales ($)',
                data: [
                    <c:forEach var="item" items="${popularItems}" varStatus="status">
                        ${item.totalSales}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                backgroundColor: 'rgba(33, 150, 243, 0.7)',
                borderColor: 'rgba(33, 150, 243, 1)',
                borderWidth: 1,
                borderRadius: 4,
                barPercentage: 0.6,
                categoryPercentage: 0.8,
                yAxisID: 'y1'
            }]
        },
        options: {
            responsive: true,
            interaction: {
                mode: 'index',
                intersect: false
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        usePointStyle: true,
                        padding: 20,
                        font: {
                            size: 13
                        }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    padding: 10,
                    titleFont: {
                        size: 14
                    },
                    bodyFont: {
                        size: 13
                    },
                    displayColors: true,
                    usePointStyle: true
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        padding: 10,
                        maxRotation: 45,
                        minRotation: 45
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Quantity Sold',
                        font: {
                            size: 13,
                            weight: 'bold'
                        },
                        padding: {top: 0, bottom: 10}
                    },
                    ticks: {
                        padding: 10
                    },
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                y1: {
                    beginAtZero: true,
                    position: 'right',
                    title: {
                        display: true,
                        text: 'Sales ($)',
                        font: {
                            size: 13,
                            weight: 'bold'
                        },
                        padding: {top: 0, bottom: 10}
                    },
                    ticks: {
                        padding: 10
                    },
                    grid: {
                        drawOnChartArea: false,
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                }
            }
        }
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
