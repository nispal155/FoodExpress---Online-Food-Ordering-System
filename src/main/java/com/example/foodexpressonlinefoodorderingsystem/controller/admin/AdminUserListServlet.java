package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import com.example.foodexpressonlinefoodorderingsystem.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling the admin users list page
 */
@WebServlet(name = "AdminUserListServlet", urlPatterns = {"/admin/users"})
public class AdminUserListServlet extends HttpServlet {

    private final UserService userService = new UserService();

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

        // Get filter parameters
        String roleFilter = request.getParameter("role");
        String searchQuery = request.getParameter("search");

        // Get pagination parameters
        int page = 1;
        int pageSize = 10; // Number of users per page

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            }
        } catch (NumberFormatException e) {
            // If page parameter is invalid, default to page 1
            page = 1;
        }

        // Get total count and users based on filters
        List<User> users;
        int totalUsers;

        if (roleFilter != null && !roleFilter.isEmpty()) {
            users = userService.getUsersByRolePaginated(roleFilter, page, pageSize);
            totalUsers = userService.countUsersByRole(roleFilter);
            request.setAttribute("roleFilter", roleFilter);
        } else if (searchQuery != null && !searchQuery.isEmpty()) {
            users = userService.searchUsersPaginated(searchQuery, page, pageSize);
            totalUsers = userService.countSearchUsers(searchQuery);
            request.setAttribute("searchQuery", searchQuery);
        } else {
            users = userService.getAllUsersPaginated(page, pageSize);
            totalUsers = userService.countAllUsers();
        }

        // Calculate total pages
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        if (totalPages < 1) {
            totalPages = 1;
        }

        // Set pagination attributes
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);

        // Set attributes for the JSP
        request.setAttribute("users", users);
        request.setAttribute("pageTitle", "User Management");

        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
}
