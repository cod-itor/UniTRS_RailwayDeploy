package com.unitrs.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.unitrs.model.entity.User;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Enrollment;
import com.unitrs.model.entity.Grade;
import com.unitrs.model.entity.AttendanceEntry;
import com.unitrs.repository.UserRepository;
import com.unitrs.repository.SchoolRepository;
import com.unitrs.repository.EnrollmentRepository;
import com.unitrs.repository.GradeRepository;
import com.unitrs.repository.AttendanceRepository;
import com.unitrs.utils.GradeCalculator;

@WebServlet("/student/*")
public class StudentController extends HttpServlet {

    private UserRepository userRepository;
    private SchoolRepository schoolRepository;
    private EnrollmentRepository enrollmentRepository;
    private GradeRepository gradeRepository;
    private AttendanceRepository attendanceRepository;

    @Override
    public void init() throws ServletException {
        this.userRepository = new UserRepository();
        this.schoolRepository = new SchoolRepository();
        this.enrollmentRepository = new EnrollmentRepository();
        this.gradeRepository = new GradeRepository();
        this.attendanceRepository = new AttendanceRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        User user = (User) request.getSession().getAttribute("user");

        if (false) {
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

                Map<Integer, List<AttendanceEntry>> attendanceMap = new HashMap<>();
                for (Enrollment enrollment : schedule) {
                    List<AttendanceEntry> entries = attendanceRepository
                            .findStudentAttendanceByEnrollmentId(enrollment.getClassSectionId(), user.getId());
                    attendanceMap.put(enrollment.getId(), entries);
                }
                request.setAttribute("attendanceMap", attendanceMap);

                Map<Integer, Grade> gradeMap = new HashMap<>();
                for (Grade grade : grades) {
                    gradeMap.put(grade.getEnrollmentId(), grade);
                }
                request.setAttribute("gradeMap", gradeMap);
            }

            String success = request.getParameter("success");
            if ("enrolled".equals(success)) {
                request.setAttribute("successMessage", "Enrolled in course successfully!");
            } else if ("dropped".equals(success)) {
                request.setAttribute("successMessage", "Course dropped successfully.");
            } else if (success != null) {
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
                enrollmentRepository.enrollStudent(user.getId(), classSectionId);
                String tab = request.getParameter("tab");
                String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : "&tab=courses";
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=enrolled" + tabParam);
            } else if ("unenroll".equals(action) || "drop".equals(action)) {
                int classSectionId = Integer.parseInt(request.getParameter("classSectionId"));
                enrollmentRepository.unenrollStudent(user.getId(), classSectionId);
                String tab = request.getParameter("tab");
                String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : "&tab=courses";
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=dropped" + tabParam);
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String tab = request.getParameter("tab");
            String defaultTab = ("enroll".equals(action) || "unenroll".equals(action) || "drop".equals(action)) ? "&tab=courses" : "";
            String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : defaultTab;
            response.sendRedirect(request.getContextPath() + "/student/dashboard?error="
                    + java.net.URLEncoder.encode("Operation failed: " + e.getMessage(), "UTF-8") + tabParam);
        }
    }
}
