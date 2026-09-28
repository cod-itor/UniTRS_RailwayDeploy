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
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;

import com.unitrs.exceptions.ValidationException;
import com.unitrs.model.entity.Role;
import com.unitrs.model.entity.User;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Enrollment;
import com.unitrs.model.entity.Grade;
import com.unitrs.model.entity.AttendanceEntry;
import com.unitrs.model.entity.AttendanceRecord;
import com.unitrs.repository.UserRepository;
import com.unitrs.repository.SchoolRepository;
import com.unitrs.repository.EnrollmentRepository;
import com.unitrs.repository.GradeRepository;
import com.unitrs.repository.AttendanceRepository;
import com.unitrs.repository.ClassSectionRepository;
import com.unitrs.model.entity.TermRegistrationRequest;
import com.unitrs.repository.TermRegistrationRepository;
import com.unitrs.model.entity.Term;
import com.unitrs.repository.TermRepository;
import com.unitrs.utils.GradeCalculator;
import com.unitrs.utils.ScheduleUtils;

@WebServlet("/student/*")
public class StudentController extends HttpServlet {

    private UserRepository userRepository;
    private SchoolRepository schoolRepository;
    private EnrollmentRepository enrollmentRepository;
    private GradeRepository gradeRepository;
    private AttendanceRepository attendanceRepository;
    private ClassSectionRepository classSectionRepository;
    private TermRegistrationRepository termRegistrationRepository;
    private TermRepository termRepository;

    @Override
    public void init() throws ServletException {
        this.userRepository = new UserRepository();
        this.schoolRepository = new SchoolRepository();
        this.enrollmentRepository = new EnrollmentRepository();
        this.gradeRepository = new GradeRepository();
        this.attendanceRepository = new AttendanceRepository();
        this.classSectionRepository = new ClassSectionRepository();
        this.termRegistrationRepository = new TermRegistrationRepository();
        this.termRepository = new TermRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || user.getRole() != Role.STUDENT) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User refreshedUser = userRepository.findById(user.getId());
        if (refreshedUser != null) {
            user = refreshedUser;
            request.getSession().setAttribute("user", user);
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
                Map<Integer, List<AttendanceRecord>> sectionRecordsMap = new HashMap<>();
                for (Enrollment enrollment : schedule) {
                    List<AttendanceEntry> entries = attendanceRepository
                            .findStudentAttendanceByEnrollmentId(enrollment.getClassSectionId(), user.getId());
                    attendanceMap.put(enrollment.getId(), entries);

                    List<AttendanceRecord> records = attendanceRepository
                            .findRecordsByClassSectionId(enrollment.getClassSectionId());
                    sectionRecordsMap.put(enrollment.getId(), records);
                }
                request.setAttribute("attendanceMap", attendanceMap);
                request.setAttribute("sectionRecordsMap", sectionRecordsMap);

                List<Term> allTerms = termRepository.findAll();
                request.setAttribute("allTerms", allTerms);

                Term studentTerm = null;
                if (user.getCurrentTermId() != null) {
                    for (Term t : allTerms) {
                        if (t.getId() == user.getCurrentTermId()) {
                            studentTerm = t;
                            break;
                        }
                    }
                }
                request.setAttribute("studentTerm", studentTerm);

                boolean missingProfileInfo = user.getCurrentTermId() == null || user.getUserIdentifier() == null || user.getUserIdentifier().trim().isEmpty() || user.getUserIdentifier().startsWith("9");
                request.setAttribute("missingProfileInfo", missingProfileInfo);

                boolean hasPendingTermRequest = false;
                List<Term> pendingTerms = new ArrayList<>();
                for (Term t : allTerms) {
                    if (termRegistrationRepository.hasPendingRequest(user.getId(), t.getId())) {
                        hasPendingTermRequest = true;
                        pendingTerms.add(t);
                    }
                }
                request.setAttribute("hasPendingTermRequest", hasPendingTermRequest);
                request.setAttribute("pendingTerms", pendingTerms);

                TermRegistrationRequest latestTermRequest = termRegistrationRepository.getLatestRequestByStudent(user.getId());
                request.setAttribute("latestTermRequest", latestTermRequest);

                List<ClassSection> termCourses = new ArrayList<>();
                Set<String> seenCourseCodes = new HashSet<>();
                int termTotalCredits = 0;
                if (studentTerm != null && availableClasses != null) {
                    for (ClassSection cs : availableClasses) {
                        if (cs.getTermId() == studentTerm.getId()) {
                            if (!seenCourseCodes.contains(cs.getCourseCode())) {
                                seenCourseCodes.add(cs.getCourseCode());
                                termCourses.add(cs);
                                termTotalCredits += cs.getCredits();
                            }
                        }
                    }
                }
                if (studentTerm != null && schedule != null) {
                    for (Enrollment enr : schedule) {
                        if (studentTerm.getTermName() != null && studentTerm.getTermName().equalsIgnoreCase(enr.getTermName())) {
                            if (!seenCourseCodes.contains(enr.getCourseCode())) {
                                seenCourseCodes.add(enr.getCourseCode());
                                ClassSection cs = new ClassSection();
                                cs.setTermId(studentTerm.getId());
                                cs.setCourseCode(enr.getCourseCode());
                                cs.setCourseTitle(enr.getCourseTitle());
                                cs.setCredits(enr.getCredits());
                                cs.setProfessorName(enr.getProfessorName());
                                cs.setRoomName(enr.getRoom());
                                cs.setSessionShift(enr.getSessionShift());
                                cs.setDaysOfWeek(enr.getDaysOfWeek());
                                termCourses.add(cs);
                                termTotalCredits += enr.getCredits();
                            }
                        }
                    }
                }
                request.setAttribute("termCourses", termCourses);
                request.setAttribute("termTotalCredits", termTotalCredits);
                request.setAttribute("termCourseCount", termCourses.size());

                Set<String> enrolledCourseCodes = new HashSet<>();
                boolean isTermEnrolled = false;
                if (schedule != null) {
                    for (Enrollment enr : schedule) {
                        enrolledCourseCodes.add(enr.getCourseCode());
                        if (studentTerm != null && studentTerm.getTermName() != null && studentTerm.getTermName().equalsIgnoreCase(enr.getTermName())) {
                            isTermEnrolled = true;
                        }
                    }
                }
                request.setAttribute("enrolledCourseCodes", enrolledCourseCodes);
                request.setAttribute("isTermEnrolled", isTermEnrolled);

                boolean isTermRegistered = false;
                if (studentTerm != null) {
                    if (hasPendingTermRequest) {
                        isTermRegistered = true;
                    } else if (latestTermRequest != null && latestTermRequest.getTermId() == studentTerm.getId() && "APPROVED".equalsIgnoreCase(latestTermRequest.getStatus())) {
                        isTermRegistered = true;
                    } else if (isTermEnrolled) {
                        isTermRegistered = true;
                    }
                }
                request.setAttribute("isTermRegistered", isTermRegistered);

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
            } else if ("updateProfile".equals(action)) {
                String newStudentId = request.getParameter("studentId");
                if (user.getUserIdentifier() != null && !user.getUserIdentifier().startsWith("9")) {
                    newStudentId = user.getUserIdentifier();
                } else {
                    if (newStudentId == null || !newStudentId.matches("^\\d{8}$")) {
                        throw new ValidationException("Student ID must be exactly 8 digits.");
                    }
                    if (newStudentId.startsWith("9")) {
                        throw new ValidationException("Student ID cannot start with '9' (reserved for temporary applicant IDs). Please enter your official university ID.");
                    }
                }
                Integer termId;
                if (user.getCurrentTermId() != null && user.getCurrentTermId() > 0) {
                    termId = user.getCurrentTermId();
                } else {
                    String termIdParam = request.getParameter("currentTermId");
                    if (termIdParam == null || termIdParam.trim().isEmpty()) {
                        throw new ValidationException("Current Term is required.");
                    }
                    termId = Integer.parseInt(termIdParam);
                }
                
                if (!newStudentId.equals(user.getUserIdentifier())) {
                    User existing = userRepository.findByIdentifier(newStudentId);
                    if (existing != null && existing.getId() != user.getId()) {
                        throw new ValidationException("This Student ID is already registered to another account.");
                    }
                }

                if (userRepository.updateStudentProfile(user.getId(), newStudentId, termId)) {
                    user.setUserIdentifier(newStudentId);
                    user.setCurrentTermId(termId);
                    request.getSession().setAttribute("user", user);
                }
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=profile_updated");
            } else if ("enroll".equals(action)) {
                int classSectionId = Integer.parseInt(request.getParameter("classSectionId"));
                ClassSection targetSection = classSectionRepository.findById(classSectionId);
                if (targetSection == null) {
                    throw new ValidationException("Selected class section does not exist.");
                }

                if (targetSection.getEnrolledCount() >= targetSection.getRoomCapacity()) {
                    throw new ValidationException("Cannot enroll: This class section is full ("
                            + targetSection.getEnrolledCount() + "/" + targetSection.getRoomCapacity() + " seats occupied).");
                }

                List<Enrollment> currentSchedule = enrollmentRepository.findStudentSchedule(user.getId());

                for (Enrollment enrolled : currentSchedule) {
                    if (enrolled.getClassSectionId() == classSectionId) {
                        throw new ValidationException("You are already enrolled in this class section.");
                    }
                }

                for (Enrollment enrolled : currentSchedule) {
                    if (enrolled.getCourseCode() != null && enrolled.getCourseCode().equalsIgnoreCase(targetSection.getCourseCode())
                            && enrolled.getTermName() != null && enrolled.getTermName().equalsIgnoreCase(targetSection.getTermName())) {
                        throw new ValidationException("You are already enrolled in another section of course "
                                + targetSection.getCourseCode() + " for " + targetSection.getTermName() + ".");
                    }
                }

                for (Enrollment enrolled : currentSchedule) {
                    boolean sameYear = (enrolled.getAcademicYear() != null && enrolled.getAcademicYear().equals(targetSection.getAcademicYear()));
                    boolean sameShift = (enrolled.getSessionShift() != null && enrolled.getSessionShift() == targetSection.getSessionShift());
                    if (sameYear && sameShift) {
                        if (ScheduleUtils.daysOverlap(enrolled.getDaysOfWeek(), targetSection.getDaysOfWeek())) {
                            throw new ValidationException("Schedule conflict: You are already enrolled in "
                                    + enrolled.getCourseCode() + " during " + enrolled.getSessionShift()
                                    + " on overlapping days (" + enrolled.getDaysOfWeek() + ").");
                        }
                    }
                }

                boolean enrolled = enrollmentRepository.enrollStudent(user.getId(), classSectionId);
                if (!enrolled) {
                    throw new ValidationException("Failed to enroll in the course. Please try again.");
                }

                String tab = request.getParameter("tab");
                String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : "&tab=courses";
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=enrolled" + tabParam);
            } else if ("unenroll".equals(action) || "drop".equals(action)) {
                String sectionIdStr = request.getParameter("classSectionId");
                if (sectionIdStr == null || sectionIdStr.trim().isEmpty()) {
                    throw new ValidationException("Class section ID is required to drop course.");
                }
                int classSectionId = Integer.parseInt(sectionIdStr.trim());
                boolean dropped = enrollmentRepository.unenrollStudent(user.getId(), classSectionId);
                if (!dropped) {
                    throw new ValidationException("Failed to drop course. You might not be enrolled in this section.");
                }
                String tab = request.getParameter("tab");
                String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : "&tab=schedule";
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=dropped" + tabParam);
            } else if ("batch_term_register".equals(action)) {
                int termId = Integer.parseInt(request.getParameter("termId"));
                Term term = termRepository.findById(termId);
                if (term == null) {
                    throw new ValidationException("Invalid term selected.");
                }
                if (termRegistrationRepository.hasPendingRequest(user.getId(), termId)) {
                    throw new ValidationException("You already have a pending registration request for " + term.getTermName() + ".");
                }
                
                boolean created = termRegistrationRepository.createRequest(user.getId(), termId);
                if (!created) {
                    throw new ValidationException("Failed to submit term registration request.");
                }
                response.sendRedirect(request.getContextPath() + "/student/dashboard?success=batch_requested&tab=registration");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
            }
        } catch (ValidationException e) {
            String tab = request.getParameter("tab");
            String defaultTab = ("enroll".equals(action) || "unenroll".equals(action) || "drop".equals(action) || "batch_term_register".equals(action)) ? "&tab=registration" : "";
            String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : defaultTab;
            response.sendRedirect(request.getContextPath() + "/student/dashboard?error="
                    + java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + tabParam);
        } catch (Exception e) {
            e.printStackTrace();
            String tab = request.getParameter("tab");
            String defaultTab = ("enroll".equals(action) || "unenroll".equals(action) || "drop".equals(action)) ? "&tab=courses" : "";
            String tabParam = (tab != null && !tab.trim().isEmpty()) ? "&tab=" + java.net.URLEncoder.encode(tab.trim(), "UTF-8") : defaultTab;
            String msg = (e.getMessage() != null && !e.getMessage().trim().isEmpty()) ? e.getMessage() : "An unexpected error occurred.";
            response.sendRedirect(request.getContextPath() + "/student/dashboard?error="
                    + java.net.URLEncoder.encode(msg, "UTF-8") + tabParam);
        }
    }
}
