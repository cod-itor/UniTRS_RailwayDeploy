package com.unitrs.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

import java.io.IOException;
import java.util.List;

import com.unitrs.model.entity.User;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Enrollment;
import com.unitrs.model.entity.Grade;
import com.unitrs.repository.UserRepository;
import com.unitrs.repository.SchoolRepository;
import com.unitrs.repository.EnrollmentRepository;
import com.unitrs.repository.GradeRepository;
import com.unitrs.utils.GradeCalculator;

@WebServlet("/student/*")
public class StudentController extends HttpServlet {

    private UserRepository userRepository;
    private SchoolRepository schoolRepository;
    private EnrollmentRepository enrollmentRepository;
    private GradeRepository gradeRepository;

    @Override
    public void init() throws ServletException {
        this.userRepository = new UserRepository();
        this.schoolRepository = new SchoolRepository();
        this.enrollmentRepository = new EnrollmentRepository();
        this.gradeRepository = new GradeRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole().name())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        if (path == null || path.equals("/") || path.equals("/dashboard")) {

            if (user.getStudentSchoolId() == null) {
                List<School> schools = schoolRepository.findAll();
                request.setAttribute("schools", schools);

            } else {

                School studentSchool = schoolRepository.findById(user.getStudentSchoolId());
                request.setAttribute("studentSchool", studentSchool);

                List<ClassSection> availableClasses = enrollmentRepository
                        .findAvailableClassSections(user.getStudentSchoolId());
                request.setAttribute("availableClasses", availableClasses);

                List<Enrollment> schedule = enrollmentRepository.findStudentSchedule(user.getId());
                request.setAttribute("schedule", schedule);

                List<Grade> grades = gradeRepository.findGradesByStudentId(user.getId());
                request.setAttribute("grades", grades);

                double termGpa = GradeCalculator.calculateTermGpa(grades);
                request.setAttribute("termGpa", termGpa);
            }

            if (request.getParameter("success") != null) {
                request.setAttribute("successMessage", "Operation completed successfully!");
            }
            if (request.getParameter("error") != null) {
                request.setAttribute("errorMessage", request.getParameter("error"));
            }

            request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !"STUDENT".equals(user.getRole().name())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            if ("selectSchool".equals(action)) {
                int schoolId = Integer.parseInt(request.getParameter("schoolId"));
                if (userRepository.assignStudentToSchool(user.getId(), schoolId)) {
                    user.setStudentSchoolId(schoolId);
                    request.getSession().setAttribute("user", user);
                }
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=1");
            } else if ("enroll".equals(action)) {
                int classSectionId = Integer.parseInt(request.getParameter("classSectionId"));

                List<Enrollment> currentSchedule = enrollmentRepository.findStudentSchedule(user.getId());
                boolean alreadyEnrolled = currentSchedule.stream().anyMatch(e -> {

                    return false;
                });

                enrollmentRepository.enrollStudent(user.getId(), classSectionId);
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/student/dashboard?error="
                    + java.net.URLEncoder.encode("Operation failed: " + e.getMessage(), "UTF-8"));
        }
    }
}
