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
        out.println("<style>");
        out.println("  * { box-sizing: border-box; margin: 0; padding: 0; }");
        out.println("  body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; background-color: #f5f5f5; }");
        out.println("  .container { max-width: 800px; margin: 0 auto; padding: 20px; }");
        out.println("  .card { background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; overflow: hidden; }");
        out.println("  .card-header { background: #4a6da7; color: white; padding: 15px 20px; }");
        out.println("  .card-header h3 { margin: 0; font-size: 1.5rem; }");
        out.println("  .card-body { padding: 20px; }");
        out.println("  .alert { padding: 15px; border-radius: 4px; margin-bottom: 20px; }");
        out.println("  .alert-success { background-color: #d4edda; border: 1px solid #c3e6cb; color: #155724; }");
        out.println("  .alert-danger { background-color: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }");
        out.println("  .alert-info { background-color: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; }");
        out.println("  .form-group { margin-bottom: 15px; }");
        out.println("  .form-row { display: flex; flex-wrap: wrap; margin: 0 -10px; }");
        out.println("  .form-col { flex: 1; padding: 0 10px; min-width: 200px; }");
        out.println("  label { display: block; margin-bottom: 5px; font-weight: bold; }");
        out.println("  input[type=\"text\"], input[type=\"password\"], input[type=\"number\"] { ");
        out.println("    width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; }");
        out.println("  .form-text { font-size: 0.875rem; color: #6c757d; margin-top: 5px; }");
        out.println("  .form-check { display: flex; align-items: center; margin-bottom: 15px; }");
        out.println("  .form-check input { margin-right: 10px; }");
        out.println("  .btn { display: inline-block; font-weight: 400; text-align: center; ");
        out.println("    white-space: nowrap; vertical-align: middle; user-select: none; border: 1px solid transparent; ");
        out.println("    padding: 0.375rem 0.75rem; font-size: 1rem; line-height: 1.5; border-radius: 0.25rem; ");
        out.println("    cursor: pointer; transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out; }");
        out.println("  .btn-primary { color: #fff; background-color: #4a6da7; border-color: #4a6da7; }");
        out.println("  .btn-primary:hover { background-color: #3c5a8a; border-color: #3c5a8a; }");
        out.println("  .btn-secondary { color: #fff; background-color: #6c757d; border-color: #6c757d; }");
        out.println("  .btn-secondary:hover { background-color: #5a6268; border-color: #5a6268; }");
        out.println("  .btn-group { display: flex; gap: 10px; }");
        out.println("  ol { padding-left: 20px; }");
        out.println("  li { margin-bottom: 5px; }");
        out.println("  @media (max-width: 768px) { ");
        out.println("    .form-col { min-width: 100%; margin-bottom: 15px; } ");
        out.println("    .btn-group { flex-direction: column; }");
        out.println("  }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"container\">");
        out.println("<div class=\"card\">");
        out.println("<div class=\"card-header\">");
        out.println("<h3>Email Configuration</h3>");
        out.println("</div>");
        out.println("<div class=\"card-body\">");

        // Check if there's a message or error
        String message = request.getParameter("message");
        String error = request.getParameter("error");

        if (message != null && !message.isEmpty()) {
            out.println("<div class=\"alert alert-success\">✓ " + message + "</div>");
        }

        if (error != null && !error.isEmpty()) {
            out.println("<div class=\"alert alert-danger\">⚠ " + error + "</div>");
        }

        out.println("<form action=\"" + request.getContextPath() + "/setup-email\" method=\"post\">");

        out.println("<div class=\"form-row\">");
        out.println("<div class=\"form-col\">");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"username\">Email Username</label>");
        out.println("<input type=\"text\" id=\"username\" name=\"username\" placeholder=\"your-email@gmail.com\" required>");
        out.println("<div class=\"form-text\">Your email address (e.g., example@gmail.com)</div>");
        out.println("</div>");
        out.println("</div>");

        out.println("<div class=\"form-col\">");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"password\">Email Password</label>");
        out.println("<input type=\"password\" id=\"password\" name=\"password\" required>");
        out.println("<div class=\"form-text\">For Gmail, use an App Password (not your regular password)</div>");
        out.println("</div>");
        out.println("</div>");
        out.println("</div>");

        out.println("<div class=\"form-row\">");
        out.println("<div class=\"form-col\">");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"host\">SMTP Host</label>");
        out.println("<input type=\"text\" id=\"host\" name=\"host\" value=\"smtp.gmail.com\" required>");
        out.println("</div>");
        out.println("</div>");

        out.println("<div class=\"form-col\">");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"port\">SMTP Port</label>");
        out.println("<input type=\"number\" id=\"port\" name=\"port\" value=\"587\" required>");
        out.println("</div>");
        out.println("</div>");

        out.println("<div class=\"form-col\">");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"from\">From Name</label>");
        out.println("<input type=\"text\" id=\"from\" name=\"from\" value=\"Food Express\" required>");
        out.println("</div>");
        out.println("</div>");
        out.println("</div>");

        out.println("<div class=\"form-check\">");
        out.println("<input type=\"checkbox\" id=\"enabled\" name=\"enabled\" checked>");
        out.println("<label for=\"enabled\">Enable Email Sending</label>");
        out.println("</div>");

        out.println("<div class=\"alert alert-info\">");
        out.println("<h5>ℹ️ Gmail Configuration Instructions</h5>");
        out.println("<ol>");
        out.println("<li>Enable 2-Step Verification on your Google Account</li>");
        out.println("<li>Go to your Google Account → Security → App passwords</li>");
        out.println("<li>Select \"Mail\" and \"Other (Custom name)\"</li>");
        out.println("<li>Enter \"Food Express\" and click \"Generate\"</li>");
        out.println("<li>Use the generated 16-character password in the \"Email Password\" field above</li>");
        out.println("</ol>");
        out.println("</div>");

        out.println("<div class=\"btn-group\">");
        out.println("<button type=\"submit\" name=\"action\" value=\"save\" class=\"btn btn-primary\">Save Configuration</button>");
        out.println("<button type=\"submit\" name=\"action\" value=\"test\" class=\"btn btn-secondary\">Test Connection</button>");
        out.println("</div>");
        out.println("</form>");

        out.println("</div>"); // card-body
        out.println("</div>"); // card
        out.println("</div>"); // container

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
