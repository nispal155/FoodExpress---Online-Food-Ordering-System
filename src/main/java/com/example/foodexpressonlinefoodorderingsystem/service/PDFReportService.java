package com.example.foodexpressonlinefoodorderingsystem.service;

import com.example.foodexpressonlinefoodorderingsystem.model.PopularItem;
import com.example.foodexpressonlinefoodorderingsystem.model.SalesReport;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Service class for generating PDF reports
 */
public class PDFReportService {

    // Define colors
    private static final BaseColor PRIMARY_COLOR = new BaseColor(255, 87, 34); // #FF5722
    private static final BaseColor SECONDARY_COLOR = new BaseColor(51, 51, 51); // #333333
    private static final BaseColor BORDER_COLOR = new BaseColor(221, 221, 221); // #DDDDDD

    // Define fonts
    private static Font TITLE_FONT;
    private static Font SUBTITLE_FONT;
    private static Font HEADER_FONT;
    private static Font NORMAL_FONT;
    private static Font BOLD_FONT;
    private static Font SMALL_FONT;

    static {
        try {
            TITLE_FONT = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, PRIMARY_COLOR);
            SUBTITLE_FONT = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, SECONDARY_COLOR);
            HEADER_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
            NORMAL_FONT = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);
            BOLD_FONT = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLACK);
            SMALL_FONT = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL, BaseColor.GRAY);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Generate a sales report PDF
     * @param salesReports List of daily sales reports
     * @param salesSummary Summary of sales for the period
     * @param popularItems List of popular items
     * @param startDate Start date of the report period
     * @param endDate End date of the report period
     * @return PDF as byte array
     */
    public byte[] generateSalesReportPDF(List<SalesReport> salesReports, SalesReport salesSummary,
                                        List<PopularItem> popularItems, Date startDate, Date endDate) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try {
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, baos);

            // Add metadata
            document.addTitle("Sales Report");
            document.addSubject("Food Express Sales Report");
            document.addKeywords("Food Express, Sales, Report");
            document.addCreator("Food Express System");
            document.addAuthor("Food Express Admin");

            document.open();

            // Add header with logo and title
            addReportHeader(document, startDate, endDate);

            // Add summary section
            addSummarySection(document, salesSummary);

            // Add daily sales table
            addDailySalesTable(document, salesReports);

            // Add popular items table
            if (popularItems != null && !popularItems.isEmpty()) {
                addPopularItemsTable(document, popularItems);
            }

            // Add footer
            addFooter(document);

            document.close();

        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return baos.toByteArray();
    }

    /**
     * Add the report header with logo and title
     */
    private void addReportHeader(Document document, Date startDate, Date endDate) throws DocumentException {
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd, yyyy");
        String dateRange = sdf.format(startDate) + " - " + sdf.format(endDate);

        Paragraph title = new Paragraph();
        title.add(new Chunk("Food Express Sales Report", TITLE_FONT));
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        Paragraph dateRangePara = new Paragraph();
        dateRangePara.add(new Chunk(dateRange, SUBTITLE_FONT));
        dateRangePara.setAlignment(Element.ALIGN_CENTER);
        dateRangePara.setSpacingAfter(20);
        document.add(dateRangePara);

        // Add current date and time
        SimpleDateFormat currentDateFormat = new SimpleDateFormat("MMMM dd, yyyy HH:mm:ss");
        Paragraph currentDate = new Paragraph();
        currentDate.add(new Chunk("Generated on: " + currentDateFormat.format(new Date()), SMALL_FONT));
        currentDate.setAlignment(Element.ALIGN_RIGHT);
        currentDate.setSpacingAfter(20);
        document.add(currentDate);

        // Add horizontal line
        LineSeparator line = new LineSeparator();
        line.setLineColor(PRIMARY_COLOR);
        line.setLineWidth(1);
        document.add(new Chunk(line));

        // Add spacing
        document.add(new Paragraph(" "));
    }

    /**
     * Add the summary section
     */
    private void addSummarySection(Document document, SalesReport summary) throws DocumentException {
        Paragraph summaryTitle = new Paragraph();
        summaryTitle.add(new Chunk("Sales Summary", SUBTITLE_FONT));
        summaryTitle.setSpacingBefore(10);
        summaryTitle.setSpacingAfter(10);
        document.add(summaryTitle);

        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(20f);

        // Set column widths
        float[] columnWidths = {1f, 1f, 1f, 1f};
        table.setWidths(columnWidths);

        // Create summary cards
        addSummaryCard(table, "Total Orders", String.valueOf(summary.getTotalOrders()), "orders");
        addSummaryCard(table, "Total Sales", "$" + formatCurrency(summary.getTotalSales()), "revenue");
        addSummaryCard(table, "Total Items", String.valueOf(summary.getTotalItems()), "items");
        addSummaryCard(table, "Avg. Order Value", "$" + formatCurrency(summary.getAverageOrderValue()), "average");

        document.add(table);
    }

    /**
     * Add a summary card to the table
     */
    private void addSummaryCard(PdfPTable table, String title, String value, String type) {
        PdfPCell cell = new PdfPCell();
        cell.setPadding(10);
        cell.setBorderColor(BORDER_COLOR);

        Paragraph content = new Paragraph();
        content.add(new Chunk(title + "\n", NORMAL_FONT));

        Font valueFont = new Font(BOLD_FONT);
        if (type.equals("revenue")) {
            valueFont.setColor(new BaseColor(76, 175, 80)); // Green
        } else if (type.equals("orders")) {
            valueFont.setColor(new BaseColor(33, 150, 243)); // Blue
        } else if (type.equals("items")) {
            valueFont.setColor(new BaseColor(255, 152, 0)); // Orange
        } else {
            valueFont.setColor(new BaseColor(156, 39, 176)); // Purple
        }

        content.add(new Chunk(value, valueFont));
        cell.addElement(content);

        table.addCell(cell);
    }

    /**
     * Add the daily sales table
     */
    private void addDailySalesTable(Document document, List<SalesReport> salesReports) throws DocumentException {
        Paragraph tableTitle = new Paragraph();
        tableTitle.add(new Chunk("Daily Sales", SUBTITLE_FONT));
        tableTitle.setSpacingBefore(10);
        tableTitle.setSpacingAfter(10);
        document.add(tableTitle);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(20f);

        // Set column widths
        float[] columnWidths = {1.5f, 1f, 1f, 1.5f, 1.5f};
        table.setWidths(columnWidths);

        // Add table headers
        addTableHeader(table, new String[]{"Date", "Orders", "Items", "Sales", "Avg. Order"});

        // Add table rows
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (SalesReport report : salesReports) {
            PdfPCell dateCell = new PdfPCell(new Phrase(sdf.format(report.getDate()), NORMAL_FONT));
            styleCell(dateCell, false);
            table.addCell(dateCell);

            PdfPCell ordersCell = new PdfPCell(new Phrase(String.valueOf(report.getTotalOrders()), NORMAL_FONT));
            styleCell(ordersCell, false);
            table.addCell(ordersCell);

            PdfPCell itemsCell = new PdfPCell(new Phrase(String.valueOf(report.getTotalItems()), NORMAL_FONT));
            styleCell(itemsCell, false);
            table.addCell(itemsCell);

            PdfPCell salesCell = new PdfPCell(new Phrase("$" + formatCurrency(report.getTotalSales()), NORMAL_FONT));
            styleCell(salesCell, false);
            table.addCell(salesCell);

            PdfPCell avgCell = new PdfPCell(new Phrase("$" + formatCurrency(report.getAverageOrderValue()), NORMAL_FONT));
            styleCell(avgCell, false);
            table.addCell(avgCell);
        }

        document.add(table);
    }

    /**
     * Add the popular items table
     */
    private void addPopularItemsTable(Document document, List<PopularItem> popularItems) throws DocumentException {
        Paragraph tableTitle = new Paragraph();
        tableTitle.add(new Chunk("Popular Items", SUBTITLE_FONT));
        tableTitle.setSpacingBefore(10);
        tableTitle.setSpacingAfter(10);
        document.add(tableTitle);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(20f);

        // Set column widths
        float[] columnWidths = {3f, 2f, 1f, 1f, 1.5f};
        table.setWidths(columnWidths);

        // Add table headers
        addTableHeader(table, new String[]{"Item", "Restaurant", "Orders", "Quantity", "Sales"});

        // Add table rows
        for (PopularItem item : popularItems) {
            PdfPCell nameCell = new PdfPCell(new Phrase(item.getMenuItemName(), NORMAL_FONT));
            styleCell(nameCell, false);
            table.addCell(nameCell);

            PdfPCell restaurantCell = new PdfPCell(new Phrase(item.getRestaurantName(), NORMAL_FONT));
            styleCell(restaurantCell, false);
            table.addCell(restaurantCell);

            PdfPCell ordersCell = new PdfPCell(new Phrase(String.valueOf(item.getTotalOrders()), NORMAL_FONT));
            styleCell(ordersCell, false);
            table.addCell(ordersCell);

            PdfPCell quantityCell = new PdfPCell(new Phrase(String.valueOf(item.getTotalQuantity()), NORMAL_FONT));
            styleCell(quantityCell, false);
            table.addCell(quantityCell);

            PdfPCell salesCell = new PdfPCell(new Phrase("$" + formatCurrency(item.getTotalSales()), NORMAL_FONT));
            styleCell(salesCell, false);
            table.addCell(salesCell);
        }

        document.add(table);
    }

    /**
     * Add table headers
     */
    private void addTableHeader(PdfPTable table, String[] headers) {
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, HEADER_FONT));
            cell.setBackgroundColor(PRIMARY_COLOR);
            styleCell(cell, true);
            table.addCell(cell);
        }
    }

    /**
     * Style a table cell
     */
    private void styleCell(PdfPCell cell, boolean isHeader) {
        cell.setPadding(8);
        cell.setBorderColor(BORDER_COLOR);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);

        if (!isHeader) {
            cell.setBackgroundColor(BaseColor.WHITE);
        }
    }

    /**
     * Add the footer
     */
    private void addFooter(Document document) throws DocumentException {
        // Add horizontal line
        LineSeparator line = new LineSeparator();
        line.setLineColor(BORDER_COLOR);
        line.setLineWidth(0.5f);
        document.add(new Chunk(line));

        // Add footer text
        Paragraph footer = new Paragraph();
        footer.add(new Chunk("Food Express Online Food Ordering System - Confidential", SMALL_FONT));
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(10);
        document.add(footer);
    }

    /**
     * Format a currency value
     */
    private String formatCurrency(BigDecimal value) {
        return value.setScale(2, RoundingMode.HALF_UP).toString();
    }
}
