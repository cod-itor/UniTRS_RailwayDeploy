package com.unitrs.repository;

import com.unitrs.model.entity.Role;
import com.unitrs.model.entity.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserRepository extends BaseRepository {

    public User findByEmailOrIdentifier(String identifierOrEmail) {
        String sql = "SELECT * FROM users WHERE (LOWER(user_identifier) = LOWER(?) OR LOWER(email) = LOWER(?)) AND is_active = TRUE";
        return executeQueryForObject(sql, this::mapResultSetToUser, identifierOrEmail, identifierOrEmail);
    }

    public boolean register(User user) {
        String sql = "INSERT INTO users (user_identifier, password, full_name, email, role, major, is_verified, is_active, dean_school_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int id = executeInsertAndReturnKey(sql,
                user.getUserIdentifier(),
                user.getPassword(),
                user.getFullName(),
                user.getEmail(),
                user.getRole() != null ? user.getRole().name() : Role.STUDENT.name(),
                user.getMajor(),
                user.isVerified(),
                user.isActive(),
                user.getDeanSchoolId());

        if (id > 0) {
            user.setId(id);
            return true;
        }
        return false;
    }

    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        return executeQueryForObject(sql, this::mapResultSetToUser, id);
    }

    public User findByIdentifier(String identifier) {
        String sql = "SELECT * FROM users WHERE LOWER(user_identifier) = LOWER(?)";

        return executeQueryForObject(sql, (ResultSet rs) -> {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUserIdentifier(rs.getString("user_identifier"));
            user.setPassword(rs.getString("password"));
            user.setFullName(rs.getString("full_name"));
            user.setEmail(rs.getString("email"));
            user.setRole(Role.fromString(rs.getString("role")));
            user.setMajor(rs.getString("major"));
            user.setVerified(rs.getBoolean("is_verified"));
            user.setActive(rs.getBoolean("is_active"));

            int deanSchoolId = rs.getInt("dean_school_id");
            user.setDeanSchoolId(rs.wasNull() ? null : deanSchoolId);

            int studentSchoolId = rs.getInt("student_school_id");
            user.setStudentSchoolId(rs.wasNull() ? null : studentSchoolId);

            user.setCreatedAt(rs.getTimestamp("created_at"));
            return user;
        }, identifier);
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";
        return executeQueryForObject(sql, this::mapResultSetToUser, email);
    }

    public User findByFullName(String fullName) {
        String sql = "SELECT * FROM users WHERE LOWER(TRIM(full_name)) = LOWER(TRIM(?))";
        return executeQueryForObject(sql, this::mapResultSetToUser, fullName);
    }

    public List<User> findUnverifiedStudents() {
        String sql = "SELECT * FROM users WHERE role = 'STUDENT' AND is_verified = FALSE AND is_active = TRUE ORDER BY created_at DESC";
        return executeQuery(sql, this::mapResultSetToUser);
    }

    public List<User> findUnverifiedUsers() {
        String sql = "SELECT * FROM users WHERE is_verified = FALSE AND is_active = TRUE ORDER BY created_at DESC";
        return executeQuery(sql, this::mapResultSetToUser);
    }

    public boolean verifyStudent(int id, boolean isVerified) {
        String sql = "UPDATE users SET is_verified = ? WHERE id = ?";
        return executeUpdate(sql, isVerified, id) > 0;
    }

    public boolean updateRole(int id, String role) {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        return executeUpdate(sql, role, id) > 0;
    }

    public List<User> findAllUsers() {
        String sql = "SELECT * FROM users ORDER BY id ASC";
        return executeQuery(sql, this::mapResultSetToUser);
    }

    public List<User> findProfessors() {
        String sql = "SELECT * FROM users WHERE role = 'PROFESSOR' AND is_active = TRUE ORDER BY full_name ASC";
        return executeQuery(sql, this::mapResultSetToUser);
    }

    public boolean updateUserStatus(int id, boolean isActive) {
        String sql = "UPDATE users SET is_active = ? WHERE id = ?";
        return executeUpdate(sql, isActive, id) > 0;
    }

    public boolean createStaffUser(User user) {
        user.setVerified(true);
        user.setActive(true);
        return register(user);
    }

    public boolean updatePassword(int id, String hashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        return executeUpdate(sql, hashedPassword, id) > 0;
    }

    public boolean updatePasswordByEmail(String email, String hashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE LOWER(email) = LOWER(?)";
        return executeUpdate(sql, hashedPassword, email) > 0;
    }

    public boolean verifyUserByEmail(String email) {
        String sql = "UPDATE users SET is_verified = TRUE WHERE LOWER(email) = LOWER(?)";
        return executeUpdate(sql, email) > 0;
    }

    public boolean assignDeanToSchool(int userId, Integer schoolId) {
        String sql = "UPDATE users SET dean_school_id = ? WHERE id = ?";
        return executeUpdate(sql, schoolId, userId) > 0;
    }

    public boolean assignStudentToSchool(int userId, Integer schoolId) {
        String sql = "UPDATE users SET student_school_id = ? WHERE id = ?";
        return executeUpdate(sql, schoolId, userId) > 0;
    }

    public List<User> findStudentsBySchool(int schoolId) {
        String sql = "SELECT * FROM users WHERE role = 'STUDENT' AND student_school_id = ? ORDER BY full_name ASC";
        return executeQuery(sql, this::mapResultSetToUser, schoolId);
    }

    public List<User> findStudentsByClassSection(int classSectionId) {
        String sql = "SELECT u.* FROM users u " +
                     "JOIN enrollments e ON u.id = e.student_id " +
                     "WHERE e.class_section_id = ? " +
                     "ORDER BY u.full_name ASC";
        return executeQuery(sql, this::mapResultSetToUser, classSectionId);
    }

    public boolean updateTwoFactorEnabled(int userId, boolean enabled) {
        String sql = "UPDATE users SET two_factor_enabled = ? WHERE id = ?";
        return executeUpdate(sql, enabled, userId) > 0;
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUserIdentifier(rs.getString("user_identifier"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setRole(Role.fromString(rs.getString("role")));
        user.setMajor(rs.getString("major"));
        user.setVerified(rs.getBoolean("is_verified"));
        user.setActive(rs.getBoolean("is_active"));

        int deanSchoolId = rs.getInt("dean_school_id");
        user.setDeanSchoolId(rs.wasNull() ? null : deanSchoolId);

        int studentSchoolId = rs.getInt("student_school_id");
        user.setStudentSchoolId(rs.wasNull() ? null : studentSchoolId);

        try {
            user.setTwoFactorEnabled(rs.getBoolean("two_factor_enabled"));
        } catch (SQLException ignored) {
            user.setTwoFactorEnabled(false);
        }

        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }
}
