package com.unitrs.controller;

import com.unitrs.model.entity.School;
import com.unitrs.model.entity.User;
import com.unitrs.repository.ClassSectionRepository;
import com.unitrs.repository.CourseRepository;
import com.unitrs.repository.RoomRepository;
import com.unitrs.repository.SchoolRepository;
import com.unitrs.repository.TermRepository;
import com.unitrs.repository.UserRepository;
import com.unitrs.service.DeanService;
import com.unitrs.service.UserService;
import com.unitrs.service.impl.DeanServiceImpl;
import com.unitrs.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserServiceImpl(new UserRepository());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || "/dashboard".equals(path)) {
            showDashboard(request, response);
        } else if ("/users".equals(path)) {
            showUsers(request, response);
        } else if ("/deans".equals(path)) {
            showDeans(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if ("/users/verify".equals(path)) {
            handleVerifyStudent(request, response);
        } else if ("/users/status".equals(path)) {
            handleUpdateStatus(request, response);
        } else if ("/deans/assign".equals(path)) {
            handleAssignDean(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> allUsers = userService.findAllUsers();
        List<User> unverified = userService.findUnverifiedUsers();

        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("pendingVerifications", unverified.size());

        long studentCount = allUsers.stream()
                .filter(u -> u.getRole() != null && u.getRole().name().equals("STUDENT"))
                .count();
        long staffCount = allUsers.size() - studentCount;

        request.setAttribute("studentCount", studentCount);
        request.setAttribute("staffCount", staffCount);

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> userList = userService.findAllUsers();
        List<User> unverifiedList = userService.findUnverifiedUsers();

        request.setAttribute("users", userList);
        request.setAttribute("unverifiedStudents", unverifiedList);

        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }

    private void showDeans(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DeanService deanService = new DeanServiceImpl(
                new CourseRepository(),
                new TermRepository(),
                new UserRepository(),
                new ClassSectionRepository(),
                new RoomRepository(),
                new SchoolRepository()
        );

        List<School> schools = deanService.getAllSchools();
        List<User> professors = userService.findProfessors();

        Map<Integer, User> currentDeans = new HashMap<>();
        for (User prof : professors) {
            if (prof.getDeanSchoolId() != null) {
                currentDeans.put(prof.getDeanSchoolId(), prof);
            }
        }

        request.setAttribute("schools", schools);
        request.setAttribute("professors", professors);
        request.setAttribute("currentDeans", currentDeans);

        request.getRequestDispatcher("/WEB-INF/views/admin/deans.jsp").forward(request, response);
    }

    private void handleAssignDean(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int schoolId = Integer.parseInt(request.getParameter("schoolId"));
        String professorIdStr = request.getParameter("professorId");

        UserRepository userRepo = new UserRepository();

        List<User> professors = userService.findProfessors();
        for (User prof : professors) {
            if (prof.getDeanSchoolId() != null && prof.getDeanSchoolId() == schoolId) {
                userRepo.assignDeanToSchool(prof.getId(), null);
            }
        }

        if (professorIdStr != null && !professorIdStr.isEmpty()) {
            int professorId = Integer.parseInt(professorIdStr);
            userRepo.assignDeanToSchool(professorId, schoolId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/deans");
    }

    private void handleVerifyStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String action = request.getParameter("action");
        String role = request.getParameter("role");

        boolean isApproved = "approve".equals(action);
        userService.processUserVerification(userId, isApproved, role);

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String action = request.getParameter("action");

        boolean isActive = "activate".equals(action);
        userService.updateUserStatus(userId, isActive);

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
