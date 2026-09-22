package com.unitrs.repository;

import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.Enrollment;
import com.unitrs.model.entity.SessionShift;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class EnrollmentRepository extends BaseRepository {

    public List<ClassSection> findAvailableClassSections(int schoolId) {
        String sql = "SELECT cs.*, c.course_code, c.course_title, c.credits, " +
                     "t.term_name, r.room_number, r.capacity, u.full_name AS professor_name, " +
                     "(SELECT COUNT(*) FROM enrollments e WHERE e.class_section_id = cs.id) AS enrolled_count " +
                     "FROM class_sections cs " +
                     "JOIN courses c ON cs.course_id = c.id " +
                     "JOIN terms t ON cs.term_id = t.id " +
                     "JOIN rooms r ON cs.room_id = r.id " +
                     "JOIN users u ON cs.professor_id = u.id " +
                     "WHERE c.school_id = ? " +
                     "ORDER BY t.id DESC, c.course_code ASC";

        return executeQuery(sql, this::mapResultSetToClassSection, schoolId);
    }

    public List<Enrollment> findStudentSchedule(int studentId) {
        String sql = "SELECT * FROM student_schedule_view WHERE student_id = ? ORDER BY term_name DESC, course_code ASC";
        return executeQuery(sql, this::mapResultSetToEnrollment, studentId);
    }

    public boolean enrollStudent(int studentId, int classSectionId) {

        String sql = "INSERT INTO enrollments (student_id, class_section_id) VALUES (?, ?)";
        return executeUpdate(sql, studentId, classSectionId) > 0;
    }

    public boolean unenrollStudent(int studentId, int classSectionId) {
        String sql = "DELETE FROM enrollments WHERE student_id = ? AND class_section_id = ?";
        return executeUpdate(sql, studentId, classSectionId) > 0;
    }

    private ClassSection mapResultSetToClassSection(ResultSet rs) throws SQLException {
        ClassSection section = new ClassSection();
        section.setId(rs.getInt("id"));
        section.setTermId(rs.getInt("term_id"));
        section.setCourseId(rs.getInt("course_id"));
        section.setProfessorId(rs.getInt("professor_id"));
        section.setRoomId(rs.getInt("room_id"));
        section.setSessionShift(SessionShift.valueOf(rs.getString("session_shift")));
        section.setDaysOfWeek(rs.getString("days_of_week"));
        section.setAcademicYear(rs.getString("academic_year"));

        section.setCourseCode(rs.getString("course_code"));
        section.setCourseTitle(rs.getString("course_title"));
        section.setCredits(rs.getInt("credits"));
        section.setTermName(rs.getString("term_name"));
        section.setRoomName(rs.getString("room_number"));
        section.setRoomCapacity(rs.getInt("capacity"));
        section.setProfessorName(rs.getString("professor_name"));
        section.setEnrolledCount(rs.getInt("enrolled_count"));
        return section;
    }

    private Enrollment mapResultSetToEnrollment(ResultSet rs) throws SQLException {
        Enrollment e = new Enrollment();
        e.setId(rs.getInt("enrollment_id"));
        e.setStudentId(rs.getInt("student_id"));
        e.setClassSectionId(rs.getInt("class_section_id"));
        e.setCourseCode(rs.getString("course_code"));
        e.setCourseTitle(rs.getString("course_title"));
        e.setCredits(rs.getInt("credits"));
        e.setTermName(rs.getString("term_name"));
        e.setSessionShift(SessionShift.valueOf(rs.getString("session_shift")));
        e.setDaysOfWeek(rs.getString("days_of_week"));
        e.setAcademicYear(rs.getString("academic_year"));
        e.setRoom(rs.getString("room_number"));
        e.setProfessorName(rs.getString("professor_name"));
        return e;
    }
}
