package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.PopularItem;
import com.example.foodexpressonlinefoodorderingsystem.model.SalesReport;
import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.PDFReportService;
import com.example.foodexpressonlinefoodorderingsystem.service.ReportingService;
import com.example.foodexpressonlinefoodorderingsystem.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Servlet for generating PDF reports
 */
@WebServlet(name = "AdminReportPDFServlet", urlPatterns = {"/admin/reporting/pdf"})
public class AdminReportPDFServlet extends HttpServlet {

    private final ReportingService reportingService = new ReportingService();
    private final PDFReportService pdfReportService = new PDFReportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in and is an admin
        User user = SessionUtil.getUser(request);

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
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

        try {
            if ("custom".equals(reportType) && startDateStr != null && endDateStr != null) {
                // Parse custom date range
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                startDate = sdf.parse(startDateStr);
                endDate = sdf.parse(endDateStr);

                // Set end date to end of day
                Calendar cal = Calendar.getInstance();
                cal.setTime(endDate);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                endDate = cal.getTime();
            } else {
                // Calculate date range based on report type
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                endDate = cal.getTime();

                cal.set(Calendar.HOUR_OF_DAY, 0);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);

                if ("day".equals(reportType)) {
                    startDate = cal.getTime();
                } else if ("week".equals(reportType)) {
                    cal.add(Calendar.DAY_OF_MONTH, -6);
                    startDate = cal.getTime();
                } else if ("month".equals(reportType)) {
                    cal.add(Calendar.MONTH, -1);
                    startDate = cal.getTime();
                } else if ("year".equals(reportType)) {
                    cal.add(Calendar.YEAR, -1);
                    startDate = cal.getTime();
                } else {
                    // Default to week
                    cal.add(Calendar.DAY_OF_MONTH, -6);
                    startDate = cal.getTime();
                }
            }
        } catch (ParseException e) {
            // Handle date parsing error
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        // Get sales reports
        List<SalesReport> salesReports = reportingService.getDailySalesReport(startDate, endDate);
        SalesReport salesSummary = reportingService.getSalesSummary(startDate, endDate);

        // Get popular items (top 10)
        List<PopularItem> popularItems = reportingService.getPopularItems(startDate, endDate, 10);

        // Generate PDF
        byte[] pdfBytes = pdfReportService.generateSalesReportPDF(salesReports, salesSummary, popularItems, startDate, endDate);

        // Set response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=sales_report.pdf");
        response.setContentLength(pdfBytes.length);

        // Write PDF to response
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
    }
}
