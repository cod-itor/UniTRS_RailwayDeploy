package com.unitrs.repository;

import com.unitrs.model.entity.OtpVerification;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class OtpRepository extends BaseRepository {

    public void createOtp(String email, String otpCode, String otpType, int expiryMinutes) {

        invalidatePendingOtps(email, otpType);

        String sql = "INSERT INTO otp_verifications (email, otp_code, otp_type, expires_at) "
                   + "VALUES (?, ?, ?, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL ? MINUTE))";
        executeUpdate(sql, email, otpCode, otpType, expiryMinutes);
    }

    public OtpVerification findValidOtp(String email, String otpCode, String otpType) {
        String sql = "SELECT * FROM otp_verifications "
                   + "WHERE LOWER(email) = LOWER(?) AND otp_code = ? AND otp_type = ? "
                   + "AND is_used = FALSE AND expires_at > CURRENT_TIMESTAMP "
                   + "ORDER BY created_at DESC LIMIT 1";
        return executeQueryForObject(sql, this::mapResultSetToOtp, email, otpCode, otpType);
    }

    public OtpVerification findLatestActiveOtp(String email, String otpType) {
        String sql = "SELECT * FROM otp_verifications "
                   + "WHERE LOWER(email) = LOWER(?) AND otp_type = ? "
                   + "AND is_used = FALSE AND expires_at > CURRENT_TIMESTAMP "
                   + "ORDER BY created_at DESC LIMIT 1";
        return executeQueryForObject(sql, this::mapResultSetToOtp, email, otpType);
    }

    public void incrementAttempts(int id) {
        String sql = "UPDATE otp_verifications SET attempts = COALESCE(attempts, 0) + 1, "
                   + "is_used = CASE WHEN attempts >= 5 THEN TRUE ELSE is_used END "
                   + "WHERE id = ?";
        executeUpdate(sql, id);
    }

    public int getSecondsUntilNextOtp(String email, String otpType) {
        String sql = "SELECT TIMESTAMPDIFF(SECOND, created_at, CURRENT_TIMESTAMP) "
                   + "FROM otp_verifications "
                   + "WHERE LOWER(email) = LOWER(?) AND otp_type = ? "
                   + "ORDER BY created_at DESC LIMIT 1";
        Integer diff = executeQueryForObject(sql, rs -> rs.getInt(1), email, otpType);
        if (diff != null && diff < 60 && diff >= 0) {
            return 60 - diff;
        }
        return 0;
    }

    public void markOtpUsed(int id) {
        String sql = "UPDATE otp_verifications SET is_used = TRUE WHERE id = ?";
        executeUpdate(sql, id);
    }

    public void invalidatePendingOtps(String email, String otpType) {
        String sql = "UPDATE otp_verifications SET is_used = TRUE WHERE LOWER(email) = LOWER(?) AND otp_type = ? AND is_used = FALSE";
        executeUpdate(sql, email, otpType);
    }

    private OtpVerification mapResultSetToOtp(ResultSet rs) throws SQLException {
        OtpVerification otp = new OtpVerification();
        otp.setId(rs.getInt("id"));
        otp.setEmail(rs.getString("email"));
        otp.setOtpCode(rs.getString("otp_code"));
        otp.setOtpType(rs.getString("otp_type"));
        otp.setExpiresAt(rs.getTimestamp("expires_at"));
        otp.setUsed(rs.getBoolean("is_used"));
        try {
            otp.setAttempts(rs.getInt("attempts"));
        } catch (SQLException ignored) {
            otp.setAttempts(0);
        }
        otp.setCreatedAt(rs.getTimestamp("created_at"));
        return otp;
    }
}
