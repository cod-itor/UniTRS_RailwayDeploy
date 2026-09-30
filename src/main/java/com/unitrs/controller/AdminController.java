package com.unitrs.controller;

import com.unitrs.model.entity.Role;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.User;
import com.unitrs.repository.ClassSectionRepository;
import com.unitrs.repository.CourseRepository;
import com.unitrs.repository.EnrollmentRepository;
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
    private DeanService deanService;
    private UserRepository userRepository;

    @Override
    public void init() throws ServletException {
        this.userRepository = new UserRepository();
        this.userService = new UserServiceImpl(this.userRepository);
        this.deanService = new DeanServiceImpl(
                new CourseRepository(),
                new TermRepository(),
                this.userRepository,
                new ClassSectionRepository(),
                new RoomRepository(),
                new SchoolRepository(),
                new EnrollmentRepository()
        );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || "/dashboard".equals(path)) {
            showDashboard(request, response);
        } else if ("/users".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?tab=users");
        } else if ("/deans".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?tab=deans");
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

        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.getRole() != Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User refreshedUser = userRepository.findById(user.getId());
        if (refreshedUser != null) {
            user = refreshedUser;
            request.getSession().setAttribute("user", user);
        }

        List<User> allUsers = userService.findAllUsers();
        List<User> unverified = userService.findUnverifiedUsers();

        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("pendingVerifications", unverified.size());

        long studentCount = allUsers.stream()
                .filter(u -> u.getRole() != null && u.getRole() == Role.STUDENT)
                .count();
        long staffCount = allUsers.size() - studentCount;

        request.setAttribute("studentCount", studentCount);
        request.setAttribute("staffCount", staffCount);

        request.setAttribute("users", allUsers);
        request.setAttribute("unverifiedStudents", unverified);

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
        request.setAttribute("reports", new com.unitrs.repository.ReportRepository().findAll());

        String tab = request.getParameter("tab");
        request.setAttribute("currentTab", tab != null ? tab : "overview");

        String success = request.getParameter("success");
        if (success != null) {
            if ("verified".equals(success)) {
                request.setAttribute("successMessage", "User verification successfully processed!");
            } else if ("status".equals(success)) {
                request.setAttribute("successMessage", "User account status successfully updated!");
            } else if ("assigned".equals(success)) {
                request.setAttribute("successMessage", "Dean assignment successfully updated!");
            }
        }

        String error = request.getParameter("error");
        if (error != null && !error.trim().isEmpty()) {
            request.setAttribute("errorMessage", error);
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void handleAssignDean(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int schoolId = Integer.parseInt(request.getParameter("schoolId"));
        String professorIdStr = request.getParameter("professorId");

        List<User> professors = userService.findProfessors();
        for (User prof : professors) {
            if (prof.getDeanSchoolId() != null && prof.getDeanSchoolId() == schoolId) {
                userRepository.assignDeanToSchool(prof.getId(), null);
            }
        }

        if (professorIdStr != null && !professorIdStr.isEmpty()) {
            int professorId = Integer.parseInt(professorIdStr);
            userRepository.assignDeanToSchool(professorId, schoolId);
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard?tab=deans&success=assigned");
    }

    private void handleVerifyStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String action = request.getParameter("action");
        String role = request.getParameter("role");

        boolean isApproved = "approve".equals(action);
        userService.processUserVerification(userId, isApproved, role);

        response.sendRedirect(request.getContextPath() + "/admin/dashboard?tab=users&success=verified");
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String action = request.getParameter("action");

        boolean isActive = "activate".equals(action);
        userService.updateUserStatus(userId, isActive);

        response.sendRedirect(request.getContextPath() + "/admin/dashboard?tab=users&success=status");
    }
}
