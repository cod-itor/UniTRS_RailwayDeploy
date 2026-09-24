package com.unitrs.repository;

import com.unitrs.model.entity.Course;
import com.unitrs.model.entity.Term;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class TermRepository extends BaseRepository {

    public List<Term> findAll() {
        String sql = "SELECT * FROM terms ORDER BY term_number ASC";
        return executeQuery(sql, this::mapResultSetToTerm);
    }

    public Term findById(int id) {
        String sql = "SELECT * FROM terms WHERE id = ?";
        return executeQueryForObject(sql, this::mapResultSetToTerm, id);
    }

    public Term findByNumber(int termNumber) {
        String sql = "SELECT * FROM terms WHERE term_number = ?";
        return executeQueryForObject(sql, this::mapResultSetToTerm, termNumber);
    }

    public boolean save(Term term) {
        String sql = "INSERT INTO terms (term_number, term_name) VALUES (?, ?)";
        return executeUpdate(sql, term.getTermNumber(), term.getTermName()) > 0;
    }

    public boolean update(Term term) {
        String sql = "UPDATE terms SET term_number = ?, term_name = ? WHERE id = ?";
        return executeUpdate(sql, term.getTermNumber(), term.getTermName(), term.getId()) > 0;
    }

    public boolean assignCourseToTerm(int termId, int courseId) {
        String sql = "INSERT IGNORE INTO term_courses (term_id, course_id) VALUES (?, ?)";
        return executeUpdate(sql, termId, courseId) > 0;
    }

    public boolean removeCourseFromTerm(int termId, int courseId) {
        String sql = "DELETE FROM term_courses WHERE term_id = ? AND course_id = ?";
        return executeUpdate(sql, termId, courseId) > 0;
    }

    public List<Course> findCoursesByTerm(int termId) {
        String sql = "SELECT c.* FROM courses c " +
                     "JOIN term_courses tc ON c.id = tc.course_id " +
                     "WHERE tc.term_id = ? ORDER BY c.course_code";
        return executeQuery(sql, rs -> {
            Course course = new Course();
            course.setId(rs.getInt("id"));
            course.setCourseCode(rs.getString("course_code"));
            course.setCourseTitle(rs.getString("course_title"));
            course.setCredits(rs.getInt("credits"));
            course.setSchoolId(rs.getInt("school_id"));
            return course;
        }, termId);
    }

    public List<Course> findCoursesByTerm(int termId, int schoolId) {
        String sql = "SELECT c.* FROM courses c " +
                     "JOIN term_courses tc ON c.id = tc.course_id " +
                     "WHERE tc.term_id = ? AND c.school_id = ? ORDER BY c.course_code";
        return executeQuery(sql, rs -> {
            Course course = new Course();
            course.setId(rs.getInt("id"));
            course.setCourseCode(rs.getString("course_code"));
            course.setCourseTitle(rs.getString("course_title"));
            course.setCredits(rs.getInt("credits"));
            course.setSchoolId(rs.getInt("school_id"));
            return course;
        }, termId, schoolId);
    }

    private Term mapResultSetToTerm(ResultSet rs) throws SQLException {
        Term term = new Term();
        term.setId(rs.getInt("id"));
        term.setTermNumber(rs.getInt("term_number"));
        term.setTermName(rs.getString("term_name"));
        return term;
    }
}
