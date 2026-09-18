package com.unitrs.controller;

import com.unitrs.repository.UserRepository;
import com.unitrs.service.UserService;
import com.unitrs.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@WebServlet("/api/validate/*")
public class ValidationController extends HttpServlet {

    private UserService userService;
    private final Map<String, long[]> rateLimiter = new ConcurrentHashMap<>();
    private static final int MAX_REQUESTS = 60;
    private static final long TIME_WINDOW_MS = 60000;

    @Override
    public void init() throws ServletException {
        this.userService = new UserServiceImpl(new UserRepository());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String clientIp = request.getRemoteAddr();
        if (isRateLimited(clientIp)) {
            response.setStatus(429);
            response.getWriter().write("{\"error\": \"Rate limit exceeded. Please try again later.\"}");
            return;
        }

        String path = request.getPathInfo();

        if ("/identifier".equals(path)) {
            String identifier = request.getParameter("identifier");
            if (identifier == null || identifier.trim().isEmpty()) {
                response.getWriter().write("{\"available\": false}");
                return;
            }
            boolean available = userService.isIdentifierAvailable(identifier.trim());
            response.getWriter().write("{\"available\": " + available + "}");

        } else if ("/email".equals(path)) {
            String email = request.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                response.getWriter().write("{\"available\": false}");
                return;
            }
            boolean available = userService.isEmailAvailable(email.trim());
            response.getWriter().write("{\"available\": " + available + "}");

        } else if ("/fullname".equals(path)) {
            String fullName = request.getParameter("fullName");
            if (fullName == null || fullName.trim().isEmpty()) {
                response.getWriter().write("{\"available\": false}");
                return;
            }
            boolean available = userService.isFullNameAvailable(fullName.trim());
            response.getWriter().write("{\"available\": " + available + "}");

        } else {
            response.setStatus(404);
            response.getWriter().write("{\"error\": \"Not found\"}");
        }
    }

    private boolean isRateLimited(String ip) {
        long currentTime = System.currentTimeMillis();
        long[] data = rateLimiter.computeIfAbsent(ip, k -> new long[] { currentTime, 0 });

        synchronized (data) {
            if (currentTime - data[0] > TIME_WINDOW_MS) {

                data[0] = currentTime;
                data[1] = 1;
                return false;
            }
            data[1]++;
            return data[1] > MAX_REQUESTS;
        }
    }
}
