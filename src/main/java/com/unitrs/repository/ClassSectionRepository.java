package com.unitrs.repository;

import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.SessionShift;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ClassSectionRepository extends BaseRepository {

    public List<ClassSection> findAllSections() {
        String sql = "SELECT cs.*, c.course_code, c.course_title, c.credits, c.school_id, u.full_name as professor_name, t.term_name, r.room_number, r.capacity as room_capacity, COUNT(e.id) as enrolled_count " +
                     "FROM class_sections cs " +
                     "JOIN courses c ON cs.course_id = c.id " +
                     "JOIN users u ON cs.professor_id = u.id " +
                     "JOIN terms t ON cs.term_id = t.id " +
                     "JOIN rooms r ON cs.room_id = r.id " +
                     "LEFT JOIN enrollments e ON cs.id = e.class_section_id " +
                     "GROUP BY cs.id " +
                     "ORDER BY t.term_number ASC, c.course_code ASC";
        return executeQuery(sql, this::mapResultSetToClassSection);
    }

    public ClassSection findById(int id) {
        String sql = "SELECT cs.*, c.course_code, c.course_title, c.credits, c.school_id, u.full_name as professor_name, t.term_name, r.room_number, r.capacity as room_capacity, COUNT(e.id) as enrolled_count " +
                     "FROM class_sections cs " +
                     "JOIN courses c ON cs.course_id = c.id " +
                     "JOIN users u ON cs.professor_id = u.id " +
                     "JOIN terms t ON cs.term_id = t.id " +
                     "JOIN rooms r ON cs.room_id = r.id " +
                     "LEFT JOIN enrollments e ON cs.id = e.class_section_id " +
                     "WHERE cs.id = ? " +
                     "GROUP BY cs.id";
        return executeQueryForObject(sql, this::mapResultSetToClassSection, id);
    }

    public List<ClassSection> findByProfessorId(int professorId) {
        String sql = "SELECT cs.*, c.course_code, c.course_title, c.credits, c.school_id, u.full_name as professor_name, t.term_name, r.room_number, r.capacity as room_capacity, COUNT(e.id) as enrolled_count " +
                     "FROM class_sections cs " +
                     "JOIN courses c ON cs.course_id = c.id " +
                     "JOIN users u ON cs.professor_id = u.id " +
                     "JOIN terms t ON cs.term_id = t.id " +
                     "JOIN rooms r ON cs.room_id = r.id " +
                     "LEFT JOIN enrollments e ON cs.id = e.class_section_id " +
                     "WHERE cs.professor_id = ? " +
                     "GROUP BY cs.id " +
                     "ORDER BY t.term_number ASC, c.course_code ASC";
        return executeQuery(sql, this::mapResultSetToClassSection, professorId);
    }

    public boolean save(ClassSection section) {
        String sql = "INSERT INTO class_sections (term_id, course_id, professor_id, room_id, session_shift, days_of_week, academic_year, start_date, end_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(sql,
                section.getTermId(),
                section.getCourseId(),
                section.getProfessorId(),
                section.getRoomId(),
                section.getSessionShift().name(),
                section.getDaysOfWeek(),
                section.getAcademicYear(),
                section.getStartDate(),
                section.getEndDate()) > 0;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM class_sections WHERE id = ?";
        return executeUpdate(sql, id) > 0;
    }

    private ClassSection mapResultSetToClassSection(ResultSet rs) throws SQLException {
        ClassSection section = new ClassSection();
        section.setId(rs.getInt("id"));
        section.setTermId(rs.getInt("term_id"));
        section.setCourseId(rs.getInt("course_id"));
        section.setSchoolId(rs.getInt("school_id"));
        section.setProfessorId(rs.getInt("professor_id"));
        section.setRoomId(rs.getInt("room_id"));
        section.setSessionShift(SessionShift.valueOf(rs.getString("session_shift")));
        section.setDaysOfWeek(rs.getString("days_of_week"));
        section.setAcademicYear(rs.getString("academic_year"));
        section.setStartDate(rs.getDate("start_date"));
        section.setEndDate(rs.getDate("end_date"));

        section.setCourseCode(rs.getString("course_code"));
        section.setCourseTitle(rs.getString("course_title"));
        section.setCredits(rs.getInt("credits"));
        section.setProfessorName(rs.getString("professor_name"));
        section.setTermName(rs.getString("term_name"));
        section.setRoomName(rs.getString("room_number"));
        section.setRoomCapacity(rs.getInt("room_capacity"));
        section.setEnrolledCount(rs.getInt("enrolled_count"));

        return section;
    }
}
