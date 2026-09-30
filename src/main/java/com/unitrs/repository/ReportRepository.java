package com.unitrs.repository;

import com.unitrs.exceptions.ValidationException;
import com.unitrs.model.entity.Report;
import com.unitrs.model.entity.User;
import com.unitrs.utils.ReportCatalog;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ReportRepository extends BaseRepository {

    private static final String SELECT_BASE =
            "SELECT r.id, r.reporter_id, r.reporter_name, r.reporter_role, r.school_id, r.category, r.issue, r.details, r.created_at, "
            + "u.user_identifier AS reporter_identifier, u.email AS reporter_email "
            + "FROM reports r JOIN users u ON r.reporter_id = u.id ";

    public boolean save(Report report) {
        String sql = "INSERT INTO reports (reporter_id, reporter_name, reporter_role, school_id, category, issue, details) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(sql, report.getReporterId(), report.getReporterName(), report.getReporterRole(),
                report.getSchoolId(), report.getCategory(), report.getIssue(), report.getDetails()) > 0;
    }

    /** Validates the submitted form values against the catalog and stores the report. */
    public void submit(User reporter, String reporterRole, Integer schoolId, String name, String issueValue, String details) {
        String cleanName = name == null ? "" : name.trim();
        if (cleanName.isEmpty()) {
            throw new ValidationException("Please enter your name.");
        }
        if (cleanName.length() > 100) {
            throw new ValidationException("Name must not exceed 100 characters.");
        }
        String[] resolved = ReportCatalog.resolve(issueValue);
        if (resolved == null) {
            throw new ValidationException("Please choose what you want to report.");
        }
        String cleanDetails = details == null ? "" : details.trim();
        if (cleanDetails.length() > 500) {
            throw new ValidationException("Details must not exceed 500 characters.");
        }
        Report report = new Report();
        report.setReporterId(reporter.getId());
        report.setReporterName(cleanName);
        report.setReporterRole(reporterRole);
        report.setSchoolId(schoolId);
        report.setCategory(resolved[0]);
        report.setIssue(resolved[1]);
        report.setDetails(cleanDetails.isEmpty() ? null : cleanDetails);
        if (!save(report)) {
            throw new ValidationException("Could not submit your report. Please try again.");
        }
    }

    public List<Report> findAll() {
        return executeQuery(SELECT_BASE + "ORDER BY r.created_at DESC, r.id DESC", this::mapRow);
    }

    /** Reports from the given school, plus reports with no school (e.g. professors not tied to a school). */
    public List<Report> findBySchool(int schoolId) {
        return executeQuery(SELECT_BASE + "WHERE r.school_id = ? OR r.school_id IS NULL ORDER BY r.created_at DESC, r.id DESC",
                this::mapRow, schoolId);
    }

    private Report mapRow(ResultSet rs) throws SQLException {
        Report r = new Report();
        r.setId(rs.getInt("id"));
        r.setReporterId(rs.getInt("reporter_id"));
        r.setReporterName(rs.getString("reporter_name"));
        r.setReporterRole(rs.getString("reporter_role"));
        int schoolId = rs.getInt("school_id");
        r.setSchoolId(rs.wasNull() ? null : schoolId);
        r.setCategory(rs.getString("category"));
        r.setIssue(rs.getString("issue"));
        r.setDetails(rs.getString("details"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setReporterIdentifier(rs.getString("reporter_identifier"));
        r.setReporterEmail(rs.getString("reporter_email"));
        return r;
    }
}
