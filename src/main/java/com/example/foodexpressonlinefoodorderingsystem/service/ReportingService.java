package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.PopularItem;
import com.example.foodexpressonlinefoodorderingsystem.model.SalesReport;
import com.example.foodexpressonlinefoodorderingsystem.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Service class for generating reports
 */
public class ReportingService {
    
    /**
     * Get daily sales report for a specific date range
     * @param startDate the start date
     * @param endDate the end date
     * @return List of daily sales reports
     */
    public List<SalesReport> getDailySalesReport(Date startDate, Date endDate) {
        String sql = "SELECT DATE(o.order_date) AS report_date, " +
                     "COUNT(o.id) AS total_orders, " +
                     "SUM(o.total_amount) AS total_sales, " +
                     "SUM((SELECT COUNT(*) FROM order_items oi WHERE oi.order_id = o.id)) AS total_items " +
                     "FROM orders o " +
                     "WHERE o.order_date BETWEEN ? AND ? " +
                     "AND o.status != 'CANCELLED' " +
                     "GROUP BY DATE(o.order_date) " +
                     "ORDER BY report_date";
        
        List<SalesReport> reports = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setTimestamp(1, new Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new Timestamp(endDate.getTime()));
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Date reportDate = rs.getDate("report_date");
                int totalOrders = rs.getInt("total_orders");
                BigDecimal totalSales = rs.getBigDecimal("total_sales");
                int totalItems = rs.getInt("total_items");
                
                SalesReport report = new SalesReport(reportDate, totalOrders, totalSales, totalItems);
                reports.add(report);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting daily sales report: " + e.getMessage());
        }
        
        return reports;
    }
    
    /**
     * Get sales report for today
     * @return SalesReport for today
     */
    public SalesReport getTodaySalesReport() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startDate = cal.getTime();
        
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        Date endDate = cal.getTime();
        
        List<SalesReport> reports = getDailySalesReport(startDate, endDate);
        
        if (!reports.isEmpty()) {
            return reports.get(0);
        } else {
            return new SalesReport(new Date(), 0, BigDecimal.ZERO, 0);
        }
    }
    
    /**
     * Get sales report for the current week
     * @return List of daily sales reports for the current week
     */
    public List<SalesReport> getCurrentWeekSalesReport() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startDate = cal.getTime();
        
        cal.add(Calendar.DAY_OF_WEEK, 6);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        Date endDate = cal.getTime();
        
        return getDailySalesReport(startDate, endDate);
    }
    
    /**
     * Get sales report for the current month
     * @return List of daily sales reports for the current month
     */
    public List<SalesReport> getCurrentMonthSalesReport() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startDate = cal.getTime();
        
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        Date endDate = cal.getTime();
        
        return getDailySalesReport(startDate, endDate);
    }
    
    /**
     * Get popular menu items for a specific date range
     * @param startDate the start date
     * @param endDate the end date
     * @param limit the maximum number of items to return
     * @return List of popular menu items
     */
    public List<PopularItem> getPopularItems(Date startDate, Date endDate, int limit) {
        String sql = "SELECT mi.id AS menu_item_id, mi.name AS menu_item_name, " +
                     "r.name AS restaurant_name, c.name AS category_name, " +
                     "COUNT(DISTINCT o.id) AS total_orders, " +
                     "SUM(oi.quantity) AS total_quantity, " +
                     "SUM(oi.price * oi.quantity) AS total_sales " +
                     "FROM order_items oi " +
                     "JOIN orders o ON oi.order_id = o.id " +
                     "JOIN menu_items mi ON oi.menu_item_id = mi.id " +
                     "JOIN restaurants r ON mi.restaurant_id = r.id " +
                     "JOIN categories c ON mi.category_id = c.id " +
                     "WHERE o.order_date BETWEEN ? AND ? " +
                     "AND o.status != 'CANCELLED' " +
                     "GROUP BY mi.id, mi.name, r.name, c.name " +
                     "ORDER BY total_quantity DESC " +
                     "LIMIT ?";
        
        List<PopularItem> popularItems = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setTimestamp(1, new Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new Timestamp(endDate.getTime()));
            stmt.setInt(3, limit);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                int menuItemId = rs.getInt("menu_item_id");
                String menuItemName = rs.getString("menu_item_name");
                String restaurantName = rs.getString("restaurant_name");
                String categoryName = rs.getString("category_name");
                int totalOrders = rs.getInt("total_orders");
                int totalQuantity = rs.getInt("total_quantity");
                BigDecimal totalSales = rs.getBigDecimal("total_sales");
                
                PopularItem item = new PopularItem(menuItemId, menuItemName, restaurantName, categoryName, 
                                                 totalOrders, totalQuantity, totalSales);
                popularItems.add(item);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting popular items: " + e.getMessage());
        }
        
        return popularItems;
    }
    
    /**
     * Get popular menu items for the current week
     * @param limit the maximum number of items to return
     * @return List of popular menu items for the current week
     */
    public List<PopularItem> getCurrentWeekPopularItems(int limit) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startDate = cal.getTime();
        
        cal.add(Calendar.DAY_OF_WEEK, 6);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        Date endDate = cal.getTime();
        
        return getPopularItems(startDate, endDate, limit);
    }
    
    /**
     * Get popular menu items for the current month
     * @param limit the maximum number of items to return
     * @return List of popular menu items for the current month
     */
    public List<PopularItem> getCurrentMonthPopularItems(int limit) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startDate = cal.getTime();
        
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        Date endDate = cal.getTime();
        
        return getPopularItems(startDate, endDate, limit);
    }
    
    /**
     * Get sales summary for a specific date range
     * @param startDate the start date
     * @param endDate the end date
     * @return SalesReport summarizing the date range
     */
    public SalesReport getSalesSummary(Date startDate, Date endDate) {
        String sql = "SELECT COUNT(o.id) AS total_orders, " +
                     "SUM(o.total_amount) AS total_sales, " +
                     "SUM((SELECT COUNT(*) FROM order_items oi WHERE oi.order_id = o.id)) AS total_items " +
                     "FROM orders o " +
                     "WHERE o.order_date BETWEEN ? AND ? " +
                     "AND o.status != 'CANCELLED'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setTimestamp(1, new Timestamp(startDate.getTime()));
            stmt.setTimestamp(2, new Timestamp(endDate.getTime()));
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                int totalOrders = rs.getInt("total_orders");
                BigDecimal totalSales = rs.getBigDecimal("total_sales");
                int totalItems = rs.getInt("total_items");
                
                // Use the midpoint of the date range as the report date
                long midpointTime = (startDate.getTime() + endDate.getTime()) / 2;
                Date midpointDate = new Date(midpointTime);
                
                return new SalesReport(midpointDate, totalOrders, totalSales, totalItems);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting sales summary: " + e.getMessage());
        }
        
        return new SalesReport(new Date(), 0, BigDecimal.ZERO, 0);
    }
    
    /**
     * Format a date as a string
     * @param date the date to format
     * @return formatted date string
     */
    public String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
}
