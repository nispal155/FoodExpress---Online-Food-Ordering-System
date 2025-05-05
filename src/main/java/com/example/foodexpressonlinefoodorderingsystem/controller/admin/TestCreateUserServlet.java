package com.example.foodexpressonlinefoodorderingsystem.controller.admin;

import com.example.foodexpressonlinefoodorderingsystem.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet for testing user creation functionality
 */
@WebServlet(name = "TestCreateUserServlet", urlPatterns = {"/admin/test-create-user"})
public class TestCreateUserServlet extends HttpServlet {
    
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
        
        // Forward to the test page
        request.getRequestDispatcher("/WEB-INF/views/admin/test-create-user.jsp").forward(request, response);
    }
}
