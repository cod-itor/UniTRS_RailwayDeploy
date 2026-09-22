package com.unitrs.service.impl;

import com.unitrs.exceptions.ValidationException;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Course;
import com.unitrs.model.entity.Room;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.SessionShift;
import com.unitrs.model.entity.Term;
import com.unitrs.model.entity.User;
import com.unitrs.repository.*;
import com.unitrs.service.DeanService;
import com.unitrs.utils.ScheduleUtils;
import lombok.RequiredArgsConstructor;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
@RequiredArgsConstructor

public class DeanServiceImpl implements DeanService {

    private final CourseRepository courseRepository;
    private final TermRepository termRepository;
    private final UserRepository userRepository;
    private final ClassSectionRepository classSectionRepository;
    private final RoomRepository roomRepository;
    private final SchoolRepository schoolRepository;


    @Override
    public List<Course> getAllCourses(int schoolId) {
        return courseRepository.findBySchoolId(schoolId);
    }

    @Override
    public Course getCourseById(int id) {
        return courseRepository.findById(id);
    }

    @Override
    public List<School> getAllSchools() {
        return schoolRepository.findAll();
    }

    @Override
    public School getSchoolById(int id) {
        return schoolRepository.findById(id);
    }

    @Override
    public void addCourse(String courseCode, String courseTitle, int credits, int schoolId) {
        if (courseCode == null || courseCode.trim().isEmpty()) {
            throw new ValidationException("Course Code cannot be empty.");
        }
        if (courseTitle == null || courseTitle.trim().isEmpty()) {
            throw new ValidationException("Course Title cannot be empty.");
        }
        if (credits <= 0) {
            throw new ValidationException("Credits must be a positive number.");
        }
        if (schoolId <= 0) {
            throw new ValidationException("School must be selected.");
        }

        Course existing = courseRepository.findByCode(courseCode.trim());
        if (existing != null) {
            throw new ValidationException("A course with code " + courseCode + " already exists.");
        }

        Course course = new Course();
        course.setCourseCode(courseCode.trim().toUpperCase());
        course.setCourseTitle(courseTitle.trim());
        course.setCredits(credits);
        course.setSchoolId(schoolId);

        if (!courseRepository.save(course)) {
            throw new RuntimeException("Failed to save course.");
        }
    }

    @Override
    public void updateCourse(int id, String courseCode, String courseTitle, int credits, int schoolId) {
        Course course = courseRepository.findById(id);
        if (course == null) {
            throw new ValidationException("Course not found.");
        }
        if (schoolId <= 0) {
            throw new ValidationException("School must be selected.");
        }

        Course existing = courseRepository.findByCode(courseCode.trim());
        if (existing != null && existing.getId() != id) {
            throw new ValidationException("Another course with code " + courseCode + " already exists.");
        }

        course.setCourseCode(courseCode.trim().toUpperCase());
        course.setCourseTitle(courseTitle.trim());
        course.setCredits(credits);
        course.setSchoolId(schoolId);

        if (!courseRepository.update(course)) {
            throw new RuntimeException("Failed to update course.");
        }
    }

    @Override
    public List<Term> getAllTerms() {
        return termRepository.findAll();
    }

    @Override
    public Term getTermById(int id) {
        return termRepository.findById(id);
    }

    @Override
    public void addTerm(int termNumber, String termName) {
        if (termNumber <= 0) {
            throw new ValidationException("Term Number must be positive.");
        }
        if (termName == null || termName.trim().isEmpty()) {
            throw new ValidationException("Term Name cannot be empty.");
        }

        Term existing = termRepository.findByNumber(termNumber);
        if (existing != null) {
            throw new ValidationException("Term Number " + termNumber + " already exists.");
        }

        Term term = new Term();
        term.setTermNumber(termNumber);
        term.setTermName(termName.trim());

        if (!termRepository.save(term)) {
            throw new RuntimeException("Failed to save term.");
        }
    }

    @Override
    public void updateTerm(int id, int termNumber, String termName) {
        Term term = termRepository.findById(id);
        if (term == null) {
            throw new ValidationException("Term not found.");
        }

        Term existing = termRepository.findByNumber(termNumber);
        if (existing != null && existing.getId() != id) {
            throw new ValidationException("Another term with number " + termNumber + " already exists.");
        }

        term.setTermNumber(termNumber);
        term.setTermName(termName.trim());

        if (!termRepository.update(term)) {
            throw new RuntimeException("Failed to update term.");
        }
    }

    @Override
    public void assignCourseToTerm(int termId, int courseId) {
        List<Course> currentCourses = termRepository.findCoursesByTerm(termId);
        if (currentCourses.size() >= 5) {
            throw new ValidationException("A term can only have a maximum of 5 courses bundled.");
        }

        termRepository.assignCourseToTerm(termId, courseId);
    }

    @Override
    public void removeCourseFromTerm(int termId, int courseId) {
        List<ClassSection> sections = classSectionRepository.findAllSections();
        boolean hasActiveSection = sections.stream()
                .anyMatch(s -> s.getTermId() == termId && s.getCourseId() == courseId);
        if (hasActiveSection) {
            throw new ValidationException("Cannot remove course from this term: An active class section is already scheduled for this course in this term. Please remove the scheduled class section first.");
        }
        termRepository.removeCourseFromTerm(termId, courseId);
    }

    @Override
    public Map<Term, List<Course>> getTermCurriculumMap(int schoolId) {
        List<Term> terms = termRepository.findAll();
        Map<Term, List<Course>> map = new LinkedHashMap<>();

        for (Term term : terms) {
            List<Course> courses = termRepository.findCoursesByTerm(term.getId());

            courses.removeIf(c -> c.getSchoolId() != schoolId);
            map.put(term, courses);
        }

        return map;
    }

    @Override
    public List<User> getAllProfessors() {
        return userRepository.findProfessors();
    }

    @Override
    public List<User> getStudentsBySchool(int schoolId) {
        return userRepository.findStudentsBySchool(schoolId);
    }

    @Override
    public List<ClassSection> getAllClassSections() {
        return classSectionRepository.findAllSections();
    }

    @Override
    public void addClassSection(int termId, int courseId, int professorId, int roomId, String sessionShift, String daysOfWeek, String academicYear) {
        if (daysOfWeek == null || daysOfWeek.trim().isEmpty()) {
            throw new ValidationException("Days of week cannot be empty.");
        }
        if (academicYear == null || academicYear.trim().isEmpty()) {
            throw new ValidationException("Academic Year cannot be empty.");
        }

        List<Course> coursesInTerm = termRepository.findCoursesByTerm(termId);
        boolean courseAssigned = coursesInTerm.stream().anyMatch(c -> c.getId() == courseId);
        if (!courseAssigned) {
            throw new ValidationException("Cannot schedule: This course is not bundled into the selected term.");
        }

        String exactDays = daysOfWeek.trim();
        List<ClassSection> allSections = classSectionRepository.findAllSections();

        if ("Mon-Fri".equalsIgnoreCase(exactDays)) {
            int totalCourses = coursesInTerm.size();

            long scheduledCount = allSections.stream()
                .filter(s -> s.getTermId() == termId
                          && s.getSessionShift().name().equals(sessionShift)
                          && s.getAcademicYear().equals(academicYear.trim()))
                .count();

            int slotIndex = (int) scheduledCount;
            exactDays = calculateMonFriDays(totalCourses, slotIndex);
        }

        for (ClassSection existing : allSections) {
            if (existing.getProfessorId() == professorId &&
                existing.getAcademicYear().equals(academicYear.trim()) &&
                existing.getTermId() == termId &&
                existing.getSessionShift().name().equals(sessionShift)) {

                if (daysOverlap(existing.getDaysOfWeek(), exactDays)) {
                    throw new ValidationException("Professor is already booked for this time slot on overlapping days (" + existing.getDaysOfWeek() + ").");
                }
            }
        }

        for (ClassSection existing : allSections) {
            if (existing.getRoomId() == roomId &&
                existing.getAcademicYear().equals(academicYear.trim()) &&
                existing.getTermId() == termId &&
                existing.getSessionShift().name().equals(sessionShift)) {

                if (daysOverlap(existing.getDaysOfWeek(), exactDays)) {
                    throw new ValidationException("Room is already booked for this time slot on overlapping days (" + existing.getDaysOfWeek() + ").");
                }
            }
        }

        ClassSection section = new ClassSection();
        section.setTermId(termId);
        section.setCourseId(courseId);
        section.setProfessorId(professorId);
        section.setRoomId(roomId);
        section.setSessionShift(SessionShift.valueOf(sessionShift));
        section.setDaysOfWeek(exactDays);
        section.setAcademicYear(academicYear.trim());

        if (!classSectionRepository.save(section)) {
            throw new RuntimeException("Failed to save class section.");
        }
    }

    private boolean daysOverlap(String days1, String days2) {
        return ScheduleUtils.daysOverlap(days1, days2);
    }

    private String calculateMonFriDays(int totalCourses, int slotIndex) {
        if (totalCourses <= 0) return "Mon-Fri";
        if (slotIndex >= totalCourses) slotIndex = totalCourses - 1;

        if (totalCourses >= 5) {
            String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri"};
            return slotIndex < 5 ? days[slotIndex] : "Fri";
        } else if (totalCourses == 4) {
            String[] days = {"Mon, Tue", "Wed", "Thu", "Fri"};
            return days[slotIndex];
        } else if (totalCourses == 3) {
            String[] days = {"Mon, Tue", "Wed, Thu", "Fri"};
            return days[slotIndex];
        } else if (totalCourses == 2) {
            String[] days = {"Mon, Tue, Wed", "Thu, Fri"};
            return days[slotIndex];
        } else {
            return "Mon-Fri";
        }
    }

    @Override
    public void removeClassSection(int id) {
        ClassSection section = classSectionRepository.findById(id);
        if (section == null) {
            throw new ValidationException("Class section not found.");
        }
        if (section.getEnrolledCount() > 0) {
            throw new ValidationException("Cannot remove class section: " + section.getEnrolledCount()
                    + " student(s) are actively enrolled. Please drop all student enrollments before deleting this section.");
        }
        if (!classSectionRepository.delete(id)) {
            throw new RuntimeException("Failed to delete class section.");
        }
    }

    @Override
    public List<Room> getAllRooms() {
        return roomRepository.findAllRooms();
    }

    @Override
    public void addRoom(String roomNumber, int floorNumber, int capacity) {
        if (roomNumber == null || roomNumber.trim().isEmpty()) {
            throw new ValidationException("Room Number cannot be empty.");
        }
        if (capacity <= 0) {
            throw new ValidationException("Capacity must be greater than 0.");
        }

        Room existing = roomRepository.findByNumber(roomNumber.trim());
        if (existing != null) {
            throw new ValidationException("Room " + roomNumber + " already exists.");
        }

        Room room = new Room();
        room.setRoomNumber(roomNumber.trim());
        room.setFloorNumber(floorNumber);
        room.setCapacity(capacity);

        if (!roomRepository.save(room)) {
            throw new RuntimeException("Failed to save room.");
        }
    }

    @Override
    public void addRoomsBatch(int floorNumber, int numberOfRooms, int capacityPerRoom) {
        if (numberOfRooms <= 0) {
            throw new ValidationException("Number of rooms must be positive.");
        }
        if (capacityPerRoom <= 0) {
            throw new ValidationException("Capacity must be positive.");
        }

        int baseRoomNumber = floorNumber * 100;
        int roomsCreated = 0;
        int i = 1;

        while (roomsCreated < numberOfRooms) {
            String roomNumStr = "Room " + (baseRoomNumber + i);
            Room existing = roomRepository.findByNumber(roomNumStr);
            if (existing == null) {
                Room room = new Room();
                room.setRoomNumber(roomNumStr);
                room.setFloorNumber(floorNumber);
                room.setCapacity(capacityPerRoom);
                roomRepository.save(room);
                roomsCreated++;
            }
            i++;
            if (i > 1000) break;
        }
    }

    @Override
    public void deleteRoom(int id) {
        if (!roomRepository.delete(id)) {
            throw new ValidationException("Failed to delete room. It might be assigned to an active class section.");
        }
    }
}
