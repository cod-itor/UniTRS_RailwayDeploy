package com.unitrs.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.unitrs.model.entity.TermRegistrationRequest;

public class TermRegistrationRepository extends BaseRepository {

    public boolean createRequest(int studentId, int termId) {
        String query = "INSERT INTO term_registration_requests (student_id, term_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE status = 'PENDING', created_at = CURRENT_TIMESTAMP";
        try (Connection conn = com.unitrs.utils.DatabaseUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, studentId);
            ps.setInt(2, termId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasPendingRequest(int studentId, int termId) {
        String query = "SELECT COUNT(*) FROM term_registration_requests WHERE student_id = ? AND term_id = ? AND status = 'PENDING'";
        try (Connection conn = com.unitrs.utils.DatabaseUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, studentId);
            ps.setInt(2, termId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<TermRegistrationRequest> getPendingRequestsBySchool(int deanSchoolId) {
        List<TermRegistrationRequest> requests = new ArrayList<>();
        String query = "SELECT r.*, u.full_name, u.user_identifier, t.term_name, t.term_number " +
                       "FROM term_registration_requests r " +
                       "JOIN users u ON r.student_id = u.id " +
                       "JOIN terms t ON r.term_id = t.id " +
                       "WHERE u.student_school_id = ? AND r.status = 'PENDING' " +
                       "ORDER BY r.created_at ASC";
        try (Connection conn = com.unitrs.utils.DatabaseUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, deanSchoolId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TermRegistrationRequest req = new TermRegistrationRequest();
                    req.setId(rs.getInt("id"));
                    req.setStudentId(rs.getInt("student_id"));
                    req.setTermId(rs.getInt("term_id"));
                    req.setStatus(rs.getString("status"));
                    req.setCreatedAt(rs.getTimestamp("created_at"));
                    req.setStudentName(rs.getString("full_name"));
                    req.setStudentIdentifier(rs.getString("user_identifier"));
                    req.setTermName(rs.getString("term_name"));
                    req.setTermNumber(rs.getInt("term_number"));
                    requests.add(req);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public boolean updateStatus(int requestId, String status) {
        String query = "UPDATE term_registration_requests SET status = ? WHERE id = ?";
        try (Connection conn = com.unitrs.utils.DatabaseUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public TermRegistrationRequest findById(int id) {
        String query = "SELECT * FROM term_registration_requests WHERE id = ?";
        try (Connection conn = com.unitrs.utils.DatabaseUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TermRegistrationRequest req = new TermRegistrationRequest();
                    req.setId(rs.getInt("id"));
                    req.setStudentId(rs.getInt("student_id"));
                    req.setTermId(rs.getInt("term_id"));
                    req.setStatus(rs.getString("status"));
                    req.setCreatedAt(rs.getTimestamp("created_at"));
                    return req;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public TermRegistrationRequest getLatestRequestByStudent(int studentId) {
        String query = "SELECT r.*, t.term_name, t.term_number FROM term_registration_requests r " +
                       "JOIN terms t ON r.term_id = t.id " +
                       "WHERE r.student_id = ? ORDER BY r.created_at DESC, r.id DESC LIMIT 1";
        try (Connection conn = com.unitrs.utils.DatabaseUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TermRegistrationRequest req = new TermRegistrationRequest();
                    req.setId(rs.getInt("id"));
                    req.setStudentId(rs.getInt("student_id"));
                    req.setTermId(rs.getInt("term_id"));
                    req.setStatus(rs.getString("status"));
                    req.setCreatedAt(rs.getTimestamp("created_at"));
                    req.setTermName(rs.getString("term_name"));
                    req.setTermNumber(rs.getInt("term_number"));
                    return req;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
