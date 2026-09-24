package com.unitrs.controller;

import com.unitrs.exceptions.ValidationException;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Course;
import com.unitrs.model.entity.Room;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.Term;
import com.unitrs.model.entity.User;
import com.unitrs.repository.ClassSectionRepository;
import com.unitrs.repository.CourseRepository;
import com.unitrs.repository.RoomRepository;
import com.unitrs.repository.SchoolRepository;
import com.unitrs.repository.TermRepository;
import com.unitrs.repository.UserRepository;
import com.unitrs.service.DeanService;
import com.unitrs.service.impl.DeanServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

@WebServlet("/dean/*")
public class DeanController extends HttpServlet {

    private DeanService deanService;

    @Override
    public void init() throws ServletException {
        this.deanService = new DeanServiceImpl(
            new CourseRepository(),
            new TermRepository(),
            new UserRepository(),
            new ClassSectionRepository(),
            new RoomRepository(),
            new SchoolRepository()
        );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        if (path == null || path.equals("/") || path.equals("/dashboard")) {
            showDashboard(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/dean/dashboard");
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.getDeanSchoolId() == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        int deanSchoolId = user.getDeanSchoolId();
        School deanSchool = deanService.getSchoolById(deanSchoolId);

        List<Course> courses = deanService.getAllCourses(deanSchoolId);
        List<Term> terms = deanService.getAllTerms();
        Map<Term, List<Course>> curriculumMap = deanService.getTermCurriculumMap(deanSchoolId);
        List<User> professors = deanService.getAllProfessors();
        List<User> students = deanService.getStudentsBySchool(deanSchoolId);
        List<ClassSection> sections = deanService.getAllClassSections();
        List<Room> rooms = deanService.getAllRooms();

        Map<Integer, List<User>> sectionStudentsMap = new java.util.HashMap<>();
        UserRepository userRepo = new UserRepository();
        for (ClassSection s : sections) {
            sectionStudentsMap.put(s.getId(), userRepo.findStudentsByClassSection(s.getId()));
        }

        request.setAttribute("deanSchool", deanSchool);
        request.setAttribute("courses", courses);
        request.setAttribute("terms", terms);
        request.setAttribute("curriculumMap", curriculumMap);
        request.setAttribute("professors", professors);
        request.setAttribute("students", students);
        request.setAttribute("sections", sections);
        request.setAttribute("rooms", rooms);
        request.setAttribute("sectionStudentsMap", sectionStudentsMap);

        String successParam = request.getParameter("success");
        if (successParam != null && !successParam.trim().isEmpty()) {
            request.setAttribute("successMessage", successParam.trim());
        }
        String errorParam = request.getParameter("error");
        if (errorParam != null && !errorParam.trim().isEmpty()) {
            request.setAttribute("errorMessage", errorParam.trim());
        }

        String activeTab = request.getParameter("tab");
        if (activeTab == null || activeTab.trim().isEmpty()) {
            activeTab = (String) request.getAttribute("tab");
        }
        if (activeTab == null || activeTab.trim().isEmpty()) {
            activeTab = "courses";
        }
        request.setAttribute("activeTab", activeTab);

        request.getRequestDispatcher("/WEB-INF/views/dean/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String activeTab = "courses";
        String tabFromReq = request.getParameter("tab");
        if (tabFromReq != null && !tabFromReq.trim().isEmpty()) {
            activeTab = tabFromReq.trim();
        }

        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.getDeanSchoolId() == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }
            int deanSchoolId = user.getDeanSchoolId();
            String successMessage = null;

            if ("addCourse".equals(action)) {
                activeTab = "courses";
                String code = request.getParameter("courseCode");
                String title = request.getParameter("courseTitle");
                int credits = Integer.parseInt(request.getParameter("credits"));
                deanService.addCourse(code, title, credits, deanSchoolId);
                successMessage = "Course successfully added.";

            } else if ("updateCourse".equals(action)) {
                activeTab = "courses";
                int id = Integer.parseInt(request.getParameter("courseId"));
                String code = request.getParameter("courseCode");
                String title = request.getParameter("courseTitle");
                int credits = Integer.parseInt(request.getParameter("credits"));
                deanService.updateCourse(id, code, title, credits, deanSchoolId);
                successMessage = "Course successfully updated.";

            } else if ("addTerm".equals(action)) {
                activeTab = "terms";
                int termNumber = Integer.parseInt(request.getParameter("termNumber"));
                String termName = request.getParameter("termName");
                deanService.addTerm(termNumber, termName);
                successMessage = "Term successfully added.";

            } else if ("updateTerm".equals(action)) {
                activeTab = "terms";
                int id = Integer.parseInt(request.getParameter("termId"));
                int termNumber = Integer.parseInt(request.getParameter("termNumber"));
                String termName = request.getParameter("termName");
                deanService.updateTerm(id, termNumber, termName);
                successMessage = "Term successfully updated.";

            } else if ("bundleCourse".equals(action)) {
                activeTab = "bundles";
                int termId = Integer.parseInt(request.getParameter("termId"));
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                deanService.assignCourseToTerm(termId, courseId);
                successMessage = "Course bundled to Term successfully.";

            } else if ("unbundleCourse".equals(action)) {
                activeTab = "bundles";
                int termId = Integer.parseInt(request.getParameter("termId"));
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                deanService.removeCourseFromTerm(termId, courseId);
                successMessage = "Course removed from Term.";

            } else if ("addClassSection".equals(action)) {
                activeTab = "schedules";
                int termId = Integer.parseInt(request.getParameter("termId"));
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                int professorId = Integer.parseInt(request.getParameter("professorId"));
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                String sessionShift = request.getParameter("sessionShift");
                String daysOfWeek = request.getParameter("daysOfWeek");
                String academicYear = request.getParameter("academicYear");

                deanService.addClassSection(termId, courseId, professorId, roomId, sessionShift, daysOfWeek, academicYear);
                successMessage = "Class Section successfully scheduled.";

            } else if ("removeClassSection".equals(action)) {
                activeTab = "schedules";
                int id = Integer.parseInt(request.getParameter("sectionId"));
                deanService.removeClassSection(id);
                successMessage = "Class Section removed.";

            } else if ("unenrollStudent".equals(action)) {
                activeTab = "schedules";
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                int sectionId = Integer.parseInt(request.getParameter("sectionId"));
                deanService.unenrollStudentFromSection(studentId, sectionId);
                successMessage = "Student unenrolled successfully.";

            } else if ("addRoom".equals(action)) {
                activeTab = "facilities";
                String roomNumber = request.getParameter("roomNumber");
                int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
                int capacity = Integer.parseInt(request.getParameter("capacity"));
                deanService.addRoom(roomNumber, floorNumber, capacity);
                successMessage = "Room successfully created.";

            } else if ("addRoomsBatch".equals(action)) {
                activeTab = "facilities";
                int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
                int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
                int capacityPerRoom = Integer.parseInt(request.getParameter("capacityPerRoom"));
                deanService.addRoomsBatch(floorNumber, numberOfRooms, capacityPerRoom);
                successMessage = numberOfRooms + " rooms successfully generated for Floor " + floorNumber + ".";

            } else if ("deleteRoom".equals(action)) {
                activeTab = "facilities";
                int id = Integer.parseInt(request.getParameter("roomId"));
                deanService.deleteRoom(id);
                successMessage = "Room deleted.";
            }

            String tabParam = "&tab=" + URLEncoder.encode(activeTab, StandardCharsets.UTF_8);
            String successParam = (successMessage != null) ? "success=" + URLEncoder.encode(successMessage, StandardCharsets.UTF_8) : "success=1";
            response.sendRedirect(request.getContextPath() + "/dean/dashboard?" + successParam + tabParam);

        } catch (ValidationException | NumberFormatException e) {
            String msg = (e instanceof NumberFormatException) ? "Invalid number format." : e.getMessage();
            String tabParam = "&tab=" + URLEncoder.encode(activeTab, StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/dean/dashboard?error="
                    + URLEncoder.encode(msg, StandardCharsets.UTF_8) + tabParam);
        } catch (Exception e) {
            String msg = (e.getMessage() != null && !e.getMessage().trim().isEmpty()) ? e.getMessage() : "An unexpected error occurred.";
            String tabParam = "&tab=" + URLEncoder.encode(activeTab, StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/dean/dashboard?error="
                    + URLEncoder.encode("An unexpected error occurred: " + msg, StandardCharsets.UTF_8) + tabParam);
        }
    }
}
