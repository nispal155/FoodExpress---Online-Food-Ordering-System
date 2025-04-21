package com.example.foodexpressonlinefoodorderingsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet to handle the Terms and Conditions page
 */
@WebServlet("/terms")
public class TermsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the terms.jsp view
        request.getRequestDispatcher("/WEB-INF/views/terms.jsp").forward(request, response);
    }
}
