package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.PopularItem;
import com.example.foodexpressonlinefoodorderingsystem.model.SalesReport;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.ReportingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Servlet for admin reporting dashboard
 */
@WebServlet(name = "AdminReportingServlet", urlPatterns = {"/admin/reporting"})
public class AdminReportingServlet extends HttpServlet {
    
    private final ReportingService reportingService = new ReportingService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Get report type and date range parameters
        String reportType = request.getParameter("type");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        // Default to current week if no report type specified
        if (reportType == null || reportType.isEmpty()) {
            reportType = "week";
        }
        
        // Get date range based on report type or custom dates
        Date startDate = null;
        Date endDate = null;
        
        if ("custom".equals(reportType) && startDateStr != null && endDateStr != null) {
            // Parse custom date range
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                startDate = sdf.parse(startDateStr);
                endDate = sdf.parse(endDateStr);
                
                // Set time to beginning and end of day
                Calendar cal = Calendar.getInstance();
                
                cal.setTime(startDate);
                cal.set(Calendar.HOUR_OF_DAY, 0);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);
                cal.set(Calendar.MILLISECOND, 0);
                startDate = cal.getTime();
                
                cal.setTime(endDate);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                cal.set(Calendar.MILLISECOND, 999);
                endDate = cal.getTime();
                
            } catch (ParseException e) {
                // Invalid date format, fall back to current week
                reportType = "week";
            }
        }
        
        if (!"custom".equals(reportType) || startDate == null || endDate == null) {
            // Set date range based on report type
            Calendar cal = Calendar.getInstance();
            
            switch (reportType) {
                case "today":
                    cal.set(Calendar.HOUR_OF_DAY, 0);
                    cal.set(Calendar.MINUTE, 0);
                    cal.set(Calendar.SECOND, 0);
                    cal.set(Calendar.MILLISECOND, 0);
                    startDate = cal.getTime();
                    
                    cal.set(Calendar.HOUR_OF_DAY, 23);
                    cal.set(Calendar.MINUTE, 59);
                    cal.set(Calendar.SECOND, 59);
                    cal.set(Calendar.MILLISECOND, 999);
                    endDate = cal.getTime();
                    break;
                    
                case "week":
                    cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
                    cal.set(Calendar.HOUR_OF_DAY, 0);
                    cal.set(Calendar.MINUTE, 0);
                    cal.set(Calendar.SECOND, 0);
                    cal.set(Calendar.MILLISECOND, 0);
                    startDate = cal.getTime();
                    
                    cal.add(Calendar.DAY_OF_WEEK, 6);
                    cal.set(Calendar.HOUR_OF_DAY, 23);
                    cal.set(Calendar.MINUTE, 59);
                    cal.set(Calendar.SECOND, 59);
                    cal.set(Calendar.MILLISECOND, 999);
                    endDate = cal.getTime();
                    break;
                    
                case "month":
                    cal.set(Calendar.DAY_OF_MONTH, 1);
                    cal.set(Calendar.HOUR_OF_DAY, 0);
                    cal.set(Calendar.MINUTE, 0);
                    cal.set(Calendar.SECOND, 0);
                    cal.set(Calendar.MILLISECOND, 0);
                    startDate = cal.getTime();
                    
                    cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                    cal.set(Calendar.HOUR_OF_DAY, 23);
                    cal.set(Calendar.MINUTE, 59);
                    cal.set(Calendar.SECOND, 59);
                    cal.set(Calendar.MILLISECOND, 999);
                    endDate = cal.getTime();
                    break;
                    
                case "year":
                    cal.set(Calendar.DAY_OF_YEAR, 1);
                    cal.set(Calendar.HOUR_OF_DAY, 0);
                    cal.set(Calendar.MINUTE, 0);
                    cal.set(Calendar.SECOND, 0);
                    cal.set(Calendar.MILLISECOND, 0);
                    startDate = cal.getTime();
                    
                    cal.set(Calendar.DAY_OF_YEAR, cal.getActualMaximum(Calendar.DAY_OF_YEAR));
                    cal.set(Calendar.HOUR_OF_DAY, 23);
                    cal.set(Calendar.MINUTE, 59);
                    cal.set(Calendar.SECOND, 59);
                    cal.set(Calendar.MILLISECOND, 999);
                    endDate = cal.getTime();
                    break;
            }
        }
        
        // Get sales reports
        List<SalesReport> salesReports = reportingService.getDailySalesReport(startDate, endDate);
        SalesReport salesSummary = reportingService.getSalesSummary(startDate, endDate);
        
        // Get popular items (top 10)
        List<PopularItem> popularItems = reportingService.getPopularItems(startDate, endDate, 10);
        
        // Format dates for display
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedStartDate = sdf.format(startDate);
        String formattedEndDate = sdf.format(endDate);
        
        // Set attributes for the JSP
        request.setAttribute("reportType", reportType);
        request.setAttribute("startDate", formattedStartDate);
        request.setAttribute("endDate", formattedEndDate);
        request.setAttribute("salesReports", salesReports);
        request.setAttribute("salesSummary", salesSummary);
        request.setAttribute("popularItems", popularItems);
        request.setAttribute("pageTitle", "Sales Reports");
        
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/reporting.jsp").forward(request, response);
    }
}
