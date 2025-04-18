package com.example.foodexpressonlinefoodorderingsystem.controller;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import com.example.foodexpressonlinefoodorderingsystem.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for handling user login
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User is already logged in, redirect based on role
            User user = (User) session.getAttribute("user");
            redirectBasedOnRole(user, request, response);
            return;
        }

        // Check for remember-me cookie
        User user = SessionUtil.getUserFromRememberMeCookie(request);
        if (user != null) {
            // Create a new session for the user
            session = SessionUtil.createSession(request, user, true);
            redirectBasedOnRole(user, request, response);
            return;
        }

        // Check for success message (e.g., from password reset)
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
            request.setAttribute("message", message);
        }

        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = userService.authenticateUser(username, password);

        if (user != null) {
            // Create session
            boolean remember = "on".equals(rememberMe);
            HttpSession session = SessionUtil.createSession(request, user, remember);

            // Create remember-me cookie if requested
            if (remember) {
                SessionUtil.createRememberMeCookie(response, user);
            }

            // Redirect based on role
            redirectBasedOnRole(user, request, response);
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    /**
     * Redirect the user based on their role
     * @param user the user
     * @param request the HTTP request
     * @param response the HTTP response
     * @throws IOException if an I/O error occurs
     */
    private void redirectBasedOnRole(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String contextPath = request.getContextPath();

        switch (user.getRole()) {
            case "ADMIN":
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case "DELIVERY":
                response.sendRedirect(contextPath + "/delivery/dashboard");
                break;
            default: // CUSTOMER
                response.sendRedirect(contextPath + "/dashboard");
                break;
        }
    }
}
