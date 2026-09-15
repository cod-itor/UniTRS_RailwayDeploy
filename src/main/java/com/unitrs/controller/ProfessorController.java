package com.unitrs.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.unitrs.model.entity.User;
import com.unitrs.model.entity.Role;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.AttendanceRecord;
import com.unitrs.model.entity.Grade;
import com.unitrs.repository.ClassSectionRepository;
import com.unitrs.repository.UserRepository;
import com.unitrs.repository.AttendanceRepository;
import com.unitrs.repository.GradeRepository;
import com.unitrs.utils.GradeCalculator;
import com.unitrs.exceptions.ValidationException;

@WebServlet("/professor/*")
public class ProfessorController extends HttpServlet {

    private static final Set<String> VALID_STATUSES = Set.of("PRESENT", "ABSENT", "LATE", "EXCUSED");

    private ClassSectionRepository classSectionRepository;
    private UserRepository userRepository;
    private AttendanceRepository attendanceRepository;
    private GradeRepository gradeRepository;

    @Override
    public void init() throws ServletException {
        this.classSectionRepository = new ClassSectionRepository();
        this.userRepository = new UserRepository();
        this.attendanceRepository = new AttendanceRepository();
        this.gradeRepository = new GradeRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || (user.getRole() != Role.PROFESSOR && user.getDeanSchoolId() == null)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        if (path == null || path.equals("/") || path.equals("/dashboard")) {
            List<ClassSection> sections = classSectionRepository.findByProfessorId(user.getId());

            Map<ClassSection, List<User>> sectionStudentsMap = new LinkedHashMap<>();
            Map<Integer, List<AttendanceRecord>> sectionAttendanceMap = new LinkedHashMap<>();
            Map<Integer, List<Grade>> sectionGradesMap = new LinkedHashMap<>();

            for (ClassSection section : sections) {
                List<User> students = userRepository.findStudentsByClassSection(section.getId());
                sectionStudentsMap.put(section, students);

                List<AttendanceRecord> records = attendanceRepository.findRecordsByClassSectionId(section.getId());
                for (AttendanceRecord record : records) {
                    record.setEntries(attendanceRepository.findEntriesByRecordId(record.getId()));
                }
                sectionAttendanceMap.put(section.getId(), records);

                List<Grade> grades = gradeRepository.findGradesByClassSectionId(section.getId());
                sectionGradesMap.put(section.getId(), grades);
            }

            request.setAttribute("sectionStudentsMap", sectionStudentsMap);
            request.setAttribute("sectionAttendanceMap", sectionAttendanceMap);
            request.setAttribute("sectionGradesMap", sectionGradesMap);

            String success = request.getParameter("success");
            if (success != null) {
                if ("attendance".equals(success)) {
                    request.setAttribute("successMessage", "Attendance successfully recorded!");
                } else if ("grades".equals(success)) {
                    request.setAttribute("successMessage", "Grades successfully saved!");
                } else {
                    request.setAttribute("successMessage", "Operation completed successfully!");
                }
            }
            if (request.getParameter("error") != null) {
                request.setAttribute("errorMessage", request.getParameter("error"));
            }

            request.getRequestDispatcher("/WEB-INF/views/professor/dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/professor/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || (user.getRole() != Role.PROFESSOR && user.getDeanSchoolId() == null)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        if (path != null && path.equals("/attendance/save")) {
            try {
                String sectionIdStr = request.getParameter("classSectionId");
                if (sectionIdStr == null || sectionIdStr.trim().isEmpty()) {
                    throw new ValidationException("Class section ID is required.");
                }
                int classSectionId = Integer.parseInt(sectionIdStr.trim());

                ClassSection section = classSectionRepository.findById(classSectionId);
                if (section == null) {
                    throw new ValidationException("Class section not found.");
                }
                if (section.getProfessorId() != user.getId() && user.getDeanSchoolId() == null) {
                    throw new ValidationException("You are not authorized to manage attendance for this section.");
                }

                String sessionDateStr = request.getParameter("sessionDate");
                if (sessionDateStr == null || sessionDateStr.trim().isEmpty()) {
                    throw new ValidationException("Please select a valid session date.");
                }

                java.sql.Date sessionDate;
                try {
                    sessionDate = java.sql.Date.valueOf(sessionDateStr.trim());
                } catch (IllegalArgumentException e) {
                    throw new ValidationException("Invalid session date format.");
                }

                AttendanceRecord record = attendanceRepository.findRecordBySectionAndDate(classSectionId, sessionDate);
                int recordId;
                if (record == null) {
                    recordId = attendanceRepository.createRecord(classSectionId, sessionDate);
                } else {
                    recordId = record.getId();
                }

                List<User> students = userRepository.findStudentsByClassSection(classSectionId);
                for (User student : students) {
                    String status = request.getParameter("status_" + student.getId());
                    if (status != null && VALID_STATUSES.contains(status.trim().toUpperCase())) {
                        attendanceRepository.saveEntry(recordId, student.getId(), status.trim().toUpperCase());
                    }
                }

                response.sendRedirect(request.getContextPath() + "/professor/dashboard?success=attendance");
            } catch (Exception e) {
                e.printStackTrace();
                String msg = (e.getMessage() != null && !e.getMessage().trim().isEmpty()) ? e.getMessage() : "Failed to save attendance.";
                response.sendRedirect(request.getContextPath() + "/professor/dashboard?error=" + URLEncoder.encode(msg, StandardCharsets.UTF_8));
            }
        } else if (path != null && path.equals("/grades/save")) {
            try {
                String sectionIdStr = request.getParameter("classSectionId");
                if (sectionIdStr == null || sectionIdStr.trim().isEmpty()) {
                    throw new ValidationException("Class section ID is required.");
                }
                int classSectionId = Integer.parseInt(sectionIdStr.trim());

                ClassSection section = classSectionRepository.findById(classSectionId);
                if (section == null) {
                    throw new ValidationException("Class section not found.");
                }
                if (section.getProfessorId() != user.getId() && user.getDeanSchoolId() == null) {
                    throw new ValidationException("You are not authorized to manage grades for this section.");
                }

                List<Grade> existingGrades = gradeRepository.findGradesByClassSectionId(classSectionId);

                for (Grade grade : existingGrades) {
                    int eid = grade.getEnrollmentId();
                    String attStr = request.getParameter("attendance_" + eid);
                    String assStr = request.getParameter("assignment_" + eid);
                    String midStr = request.getParameter("midterm_" + eid);
                    String finStr = request.getParameter("final_" + eid);

                    double att = parseScore(attStr, grade.getAttendanceScore(), "Attendance", grade.getStudentName());
                    double ass = parseScore(assStr, grade.getAssignmentScore(), "Assignment", grade.getStudentName());
                    double mid = parseScore(midStr, grade.getMidtermScore(), "Midterm", grade.getStudentName());
                    double fin = parseScore(finStr, grade.getFinalScore(), "Final", grade.getStudentName());

                    if (!GradeCalculator.isValidAttendance(att)) {
                        throw new ValidationException("Attendance score for " + grade.getStudentName() + " must be between 0 and 15.");
                    }
                    if (!GradeCalculator.isValidAssignment(ass)) {
                        throw new ValidationException("Assignment score for " + grade.getStudentName() + " must be between 0 and 25.");
                    }
                    if (!GradeCalculator.isValidMidterm(mid)) {
                        throw new ValidationException("Midterm score for " + grade.getStudentName() + " must be between 0 and 30.");
                    }
                    if (!GradeCalculator.isValidFinal(fin)) {
                        throw new ValidationException("Final score for " + grade.getStudentName() + " must be between 0 and 30.");
                    }

                    double total = GradeCalculator.calculateTotal(att, ass, mid, fin);
                    String letter = GradeCalculator.calculateLetterGrade(total);
                    double gpa = GradeCalculator.calculateGpaPoint(letter);

                    gradeRepository.saveGrade(eid, att, ass, mid, fin, total, letter, gpa);
                }
                response.sendRedirect(request.getContextPath() + "/professor/dashboard?success=grades");
            } catch (Exception e) {
                e.printStackTrace();
                String msg = (e.getMessage() != null && !e.getMessage().trim().isEmpty()) ? e.getMessage() : "Failed to save grades.";
                response.sendRedirect(request.getContextPath() + "/professor/dashboard?error=" + URLEncoder.encode(msg, StandardCharsets.UTF_8));
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/professor/dashboard");
        }
    }

    private double parseScore(String value, double fallback, String fieldName, String studentName) throws ValidationException {
        if (value == null || value.trim().isEmpty()) {
            return fallback;
        }
        try {
            return Double.parseDouble(value.trim());
        } catch (NumberFormatException e) {
            throw new ValidationException("Invalid number format for " + fieldName + " of " + studentName + ".");
        }
    }
}
