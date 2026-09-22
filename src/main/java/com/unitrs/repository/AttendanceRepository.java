package com.unitrs.repository;

import com.unitrs.model.entity.AttendanceEntry;
import com.unitrs.model.entity.AttendanceRecord;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.sql.Date;

public class AttendanceRepository extends BaseRepository {

    public List<AttendanceRecord> findRecordsByClassSectionId(int classSectionId) {
        String sql = "SELECT ar.*, " +
                     "SUM(CASE WHEN ae.status = 'PRESENT' THEN 1 ELSE 0 END) AS present_count, " +
                     "SUM(CASE WHEN ae.status = 'ABSENT' THEN 1 ELSE 0 END) AS absent_count, " +
                     "SUM(CASE WHEN ae.status = 'LATE' THEN 1 ELSE 0 END) AS late_count, " +
                     "SUM(CASE WHEN ae.status = 'EXCUSED' THEN 1 ELSE 0 END) AS excused_count " +
                     "FROM attendance_records ar " +
                     "LEFT JOIN attendance_entries ae ON ar.id = ae.attendance_record_id " +
                     "WHERE ar.class_section_id = ? " +
                     "GROUP BY ar.id " +
                     "ORDER BY ar.session_date DESC";
        
        return executeQuery(sql, this::mapResultSetToAttendanceRecord, classSectionId);
    }

    public AttendanceRecord findRecordBySectionAndDate(int classSectionId, Date sessionDate) {
        String sql = "SELECT ar.*, " +
                     "SUM(CASE WHEN ae.status = 'PRESENT' THEN 1 ELSE 0 END) AS present_count, " +
                     "SUM(CASE WHEN ae.status = 'ABSENT' THEN 1 ELSE 0 END) AS absent_count, " +
                     "SUM(CASE WHEN ae.status = 'LATE' THEN 1 ELSE 0 END) AS late_count, " +
                     "SUM(CASE WHEN ae.status = 'EXCUSED' THEN 1 ELSE 0 END) AS excused_count " +
                     "FROM attendance_records ar " +
                     "LEFT JOIN attendance_entries ae ON ar.id = ae.attendance_record_id " +
                     "WHERE ar.class_section_id = ? AND ar.session_date = ? " +
                     "GROUP BY ar.id";
                     
        return executeQueryForObject(sql, this::mapResultSetToAttendanceRecord, classSectionId, sessionDate);
    }

    public List<AttendanceEntry> findEntriesByRecordId(int recordId) {
        String sql = "SELECT ae.*, u.full_name as student_name, u.user_identifier as student_identifier " +
                     "FROM attendance_entries ae " +
                     "JOIN users u ON ae.student_id = u.id " +
                     "WHERE ae.attendance_record_id = ? " +
                     "ORDER BY u.full_name ASC";
        return executeQuery(sql, this::mapResultSetToAttendanceEntry, recordId);
    }

    public List<AttendanceEntry> findStudentAttendanceByEnrollmentId(int classSectionId, int studentId) {
        String sql = "SELECT ae.id, ae.attendance_record_id, ae.student_id, ae.status, " +
                     "ar.session_date, " +
                     "u.full_name as student_name, u.user_identifier as student_identifier " +
                     "FROM attendance_entries ae " +
                     "JOIN attendance_records ar ON ae.attendance_record_id = ar.id " +
                     "JOIN users u ON ae.student_id = u.id " +
                     "WHERE ar.class_section_id = ? AND ae.student_id = ? " +
                     "ORDER BY ar.session_date ASC";
        return executeQuery(sql, rs -> {
            AttendanceEntry entry = mapResultSetToAttendanceEntry(rs);
            entry.setSessionDate(rs.getDate("session_date"));
            return entry;
        }, classSectionId, studentId);
    }

    public int createRecord(int classSectionId, Date sessionDate) {
        String sql = "INSERT INTO attendance_records (class_section_id, session_date) VALUES (?, ?)";
        return executeInsertAndReturnKey(sql, classSectionId, sessionDate);
    }

    public boolean saveEntry(int recordId, int studentId, String status) {
        String sql = "INSERT INTO attendance_entries (attendance_record_id, student_id, status) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE status = ?";
        return executeUpdate(sql, recordId, studentId, status, status) > 0;
    }

    private AttendanceRecord mapResultSetToAttendanceRecord(ResultSet rs) throws SQLException {
        AttendanceRecord record = new AttendanceRecord();
        record.setId(rs.getInt("id"));
        record.setClassSectionId(rs.getInt("class_section_id"));
        record.setSessionDate(rs.getDate("session_date"));
        record.setCreatedAt(rs.getTimestamp("created_at"));
        
        record.setPresentCount(rs.getInt("present_count"));
        record.setAbsentCount(rs.getInt("absent_count"));
        record.setLateCount(rs.getInt("late_count"));
        record.setExcusedCount(rs.getInt("excused_count"));
        return record;
    }

    private AttendanceEntry mapResultSetToAttendanceEntry(ResultSet rs) throws SQLException {
        AttendanceEntry entry = new AttendanceEntry();
        entry.setId(rs.getInt("id"));
        entry.setAttendanceRecordId(rs.getInt("attendance_record_id"));
        entry.setStudentId(rs.getInt("student_id"));
        entry.setStatus(rs.getString("status"));
        
        entry.setStudentName(rs.getString("student_name"));
        entry.setStudentIdentifier(rs.getString("student_identifier"));
        return entry;
    }
}
