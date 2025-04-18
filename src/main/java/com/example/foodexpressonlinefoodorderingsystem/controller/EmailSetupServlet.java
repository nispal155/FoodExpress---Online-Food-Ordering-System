package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet for quick email setup (development use only)
 */
@WebServlet(name = "EmailSetupServlet", urlPatterns = {"/setup-email"})
public class EmailSetupServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Email Setup</title>");
        out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
        out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css\" rel=\"stylesheet\">");
        out.println("<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css\">");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"container py-5\">");
        out.println("<div class=\"row justify-content-center\">");
        out.println("<div class=\"col-md-8\">");
        out.println("<div class=\"card\">");
        out.println("<div class=\"card-header bg-primary text-white\">");
        out.println("<h3 class=\"mb-0\"><i class=\"fas fa-envelope me-2\"></i>Email Configuration</h3>");
        out.println("</div>");
        out.println("<div class=\"card-body\">");
        
        // Check if there's a message or error
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        
        if (message != null && !message.isEmpty()) {
            out.println("<div class=\"alert alert-success\"><i class=\"fas fa-check-circle me-2\"></i>" + message + "</div>");
        }
        
        if (error != null && !error.isEmpty()) {
            out.println("<div class=\"alert alert-danger\"><i class=\"fas fa-exclamation-circle me-2\"></i>" + error + "</div>");
        }
        
        out.println("<form action=\"" + request.getContextPath() + "/setup-email\" method=\"post\">");
        out.println("<div class=\"row mb-3\">");
        out.println("<div class=\"col-md-6\">");
        out.println("<label for=\"username\" class=\"form-label\">Email Username</label>");
        out.println("<input type=\"text\" class=\"form-control\" id=\"username\" name=\"username\" placeholder=\"your-email@gmail.com\" required>");
        out.println("<div class=\"form-text\">Your email address (e.g., example@gmail.com)</div>");
        out.println("</div>");
        out.println("<div class=\"col-md-6\">");
        out.println("<label for=\"password\" class=\"form-label\">Email Password</label>");
        out.println("<input type=\"password\" class=\"form-control\" id=\"password\" name=\"password\" required>");
        out.println("<div class=\"form-text\">For Gmail, use an App Password (not your regular password)</div>");
        out.println("</div>");
        out.println("</div>");
        
        out.println("<div class=\"row mb-3\">");
        out.println("<div class=\"col-md-4\">");
        out.println("<label for=\"host\" class=\"form-label\">SMTP Host</label>");
        out.println("<input type=\"text\" class=\"form-control\" id=\"host\" name=\"host\" value=\"smtp.gmail.com\" required>");
        out.println("</div>");
        out.println("<div class=\"col-md-4\">");
        out.println("<label for=\"port\" class=\"form-label\">SMTP Port</label>");
        out.println("<input type=\"number\" class=\"form-control\" id=\"port\" name=\"port\" value=\"587\" required>");
        out.println("</div>");
        out.println("<div class=\"col-md-4\">");
        out.println("<label for=\"from\" class=\"form-label\">From Name</label>");
        out.println("<input type=\"text\" class=\"form-control\" id=\"from\" name=\"from\" value=\"Food Express\" required>");
        out.println("</div>");
        out.println("</div>");
        
        out.println("<div class=\"form-check form-switch mb-3\">");
        out.println("<input class=\"form-check-input\" type=\"checkbox\" id=\"enabled\" name=\"enabled\" checked>");
        out.println("<label class=\"form-check-label\" for=\"enabled\">Enable Email Sending</label>");
        out.println("</div>");
        
        out.println("<div class=\"alert alert-info\">");
        out.println("<h5><i class=\"fas fa-info-circle me-2\"></i>Gmail Configuration Instructions</h5>");
        out.println("<ol>");
        out.println("<li>Enable 2-Step Verification on your Google Account</li>");
        out.println("<li>Go to your Google Account → Security → App passwords</li>");
        out.println("<li>Select \"Mail\" and \"Other (Custom name)\"</li>");
        out.println("<li>Enter \"Food Express\" and click \"Generate\"</li>");
        out.println("<li>Use the generated 16-character password in the \"Email Password\" field above</li>");
        out.println("</ol>");
        out.println("</div>");
        
        out.println("<div class=\"d-grid gap-2 d-md-flex\">");
        out.println("<button type=\"submit\" name=\"action\" value=\"save\" class=\"btn btn-primary\"><i class=\"fas fa-save me-2\"></i>Save Configuration</button>");
        out.println("<button type=\"submit\" name=\"action\" value=\"test\" class=\"btn btn-secondary\"><i class=\"fas fa-vial me-2\"></i>Test Connection</button>");
        out.println("</div>");
        out.println("</form>");
        
        out.println("</div>"); // card-body
        out.println("</div>"); // card
        out.println("</div>"); // col
        out.println("</div>"); // row
        out.println("</div>"); // container
        
        out.println("<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js\"></script>");
        out.println("</body>");
        out.println("</html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String host = request.getParameter("host");
        String portStr = request.getParameter("port");
        String from = request.getParameter("from");
        String enabled = request.getParameter("enabled");
        String action = request.getParameter("action");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            host == null || host.trim().isEmpty() ||
            portStr == null || portStr.trim().isEmpty() ||
            from == null || from.trim().isEmpty()) {
            
            response.sendRedirect(request.getContextPath() + "/setup-email?error=All+fields+are+required");
            return;
        }
        
        int port;
        try {
            port = Integer.parseInt(portStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/setup-email?error=Port+must+be+a+number");
            return;
        }
        
        boolean isEnabled = enabled != null;
        
        // Format the from address
        String fromAddress = from + " <" + username + ">";
        
        // If test connection action
        if ("test".equals(action)) {
            // Save the configuration temporarily
            EmailUtil.saveConfiguration(username, password, host, port, fromAddress, isEnabled);
            
            // Test the connection
            boolean success = EmailUtil.testConnection();
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/setup-email?message=Connection+test+successful!+Email+configuration+has+been+saved.");
            } else {
                response.sendRedirect(request.getContextPath() + "/setup-email?error=Connection+test+failed.+Please+check+your+settings.");
            }
            return;
        }
        
        // Save the configuration
        boolean success = EmailUtil.saveConfiguration(username, password, host, port, fromAddress, isEnabled);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/setup-email?message=Email+configuration+saved+successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/setup-email?error=Failed+to+save+email+configuration");
        }
    }
}
