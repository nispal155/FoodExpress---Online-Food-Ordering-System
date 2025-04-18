package com.example.foodexpressonlinefoodorderingsystem.filter;

import com.example.foodexpressonlinefoodorderingsystem.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Filter for authentication and authorization
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {

    // Public URLs that don't require authentication
    private static final List<String> PUBLIC_URLS = Arrays.asList(
            "/", "/index.jsp", "/login", "/register", "/logout", "/home",
            "/forgot-password", "/reset-password",
            "/css/", "/js/", "/images/", "/assets/", "/favicon.ico",
            "/restaurants", "/restaurant", "/about", "/contact", "/search"
    );

    // URLs that require admin role
    private static final List<String> ADMIN_URLS = Arrays.asList(
            "/admin/", "/admin"
    );

    // URLs that require delivery role
    private static final List<String> DELIVERY_URLS = Arrays.asList(
            "/delivery/", "/delivery"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativePath = requestURI.substring(contextPath.length());

        // Check if the requested URL is public
        if (isPublicURL(relativePath)) {
            chain.doFilter(request, response);
            return;
        }

        // Get the session
        HttpSession session = httpRequest.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            // User is not logged in, redirect to login page
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // User is logged in, get the user object
        User user = (User) session.getAttribute("user");

        // Check if the user is active
        if (!user.isActive()) {
            // User is inactive, invalidate session and redirect to login
            session.invalidate();
            httpResponse.sendRedirect(contextPath + "/login?error=inactive");
            return;
        }

        // Check if the requested URL requires admin role
        if (isAdminURL(relativePath) && !"ADMIN".equals(user.getRole())) {
            // User is not an admin, redirect to dashboard
            httpResponse.sendRedirect(contextPath + "/dashboard");
            return;
        }

        // Check if the requested URL requires delivery role
        if (isDeliveryURL(relativePath) && !"DELIVERY".equals(user.getRole())) {
            // User is not a delivery person, redirect to dashboard
            httpResponse.sendRedirect(contextPath + "/dashboard");
            return;
        }

        // User is authorized, continue the filter chain
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }

    /**
     * Check if the URL is public (doesn't require authentication)
     * @param url the URL to check
     * @return true if the URL is public, false otherwise
     */
    private boolean isPublicURL(String url) {
        return PUBLIC_URLS.stream().anyMatch(url::startsWith);
    }

    /**
     * Check if the URL requires admin role
     * @param url the URL to check
     * @return true if the URL requires admin role, false otherwise
     */
    private boolean isAdminURL(String url) {
        return url.startsWith("/admin");
    }

    /**
     * Check if the URL requires delivery role
     * @param url the URL to check
     * @return true if the URL requires delivery role, false otherwise
     */
    private boolean isDeliveryURL(String url) {
        return url.startsWith("/delivery");
    }
}
