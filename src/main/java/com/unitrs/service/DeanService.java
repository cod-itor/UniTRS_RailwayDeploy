package com.unitrs.service;

import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Course;
import com.unitrs.model.entity.Room;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.Term;
import com.unitrs.model.entity.User;

import java.util.List;
import java.util.Map;

public interface DeanService {

    List<Course> getAllCourses(int schoolId);

    Course getCourseById(int id);

    void addCourse(String courseCode, String courseTitle, int credits, int schoolId);

    void updateCourse(int id, String courseCode, String courseTitle, int credits, int schoolId, int deanSchoolId);

    List<School> getAllSchools();

    School getSchoolById(int id);

    List<Term> getAllTerms();

    Term getTermById(int id);

    void addTerm(int termNumber, String termName);

    void updateTerm(int id, int termNumber, String termName);

    void assignCourseToTerm(int termId, int courseId, int deanSchoolId);

    void removeCourseFromTerm(int termId, int courseId, int deanSchoolId);

    Map<Term, List<Course>> getTermCurriculumMap(int schoolId);

    List<User> getAllProfessors();

    List<User> getStudentsBySchool(int schoolId);

    List<ClassSection> getAllClassSections();

    void addClassSection(int termId, int courseId, int professorId, int roomId, String sessionShift, String daysOfWeek,
            String academicYear, int deanSchoolId);

    void removeClassSection(int id, int deanSchoolId);

    void unenrollStudentFromSection(int studentId, int classSectionId, int deanSchoolId);

    List<Room> getAllRooms();

    void addRoom(String roomNumber, int floorNumber, int capacity);

    void addRoomsBatch(int floorNumber, int numberOfRooms, int capacityPerRoom);

    void deleteRoom(int id);
}
