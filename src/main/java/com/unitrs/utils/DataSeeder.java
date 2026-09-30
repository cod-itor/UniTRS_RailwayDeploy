package com.unitrs.utils;

import com.unitrs.model.entity.User;
import com.unitrs.repository.UserRepository;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class DataSeeder implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(DataSeeder.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try (java.sql.Connection conn = DatabaseUtils.getConnection();
             java.sql.ResultSet rs = conn.getMetaData().getColumns(null, null, "users", "two_factor_enabled")) {
            if (!rs.next()) {
                try (java.sql.Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate("ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE");
                    LOGGER.info("DataSeeder: Added two_factor_enabled column to users table.");
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "DataSeeder: Column check skipped: " + e.getMessage());
        }

        try (java.sql.Connection conn = DatabaseUtils.getConnection();
             java.sql.Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS professor_availability ("
                    + "professor_id INT NOT NULL, "
                    + "session_shift ENUM('MORNING','AFTERNOON','EVENING','WEEKEND') NOT NULL, "
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                    + "PRIMARY KEY (professor_id, session_shift), "
                    + "FOREIGN KEY (professor_id) REFERENCES users(id) ON DELETE CASCADE)");
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "DataSeeder: professor_availability table check skipped: " + e.getMessage());
        }

        try (java.sql.Connection conn = DatabaseUtils.getConnection();
             java.sql.Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS reports ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "reporter_id INT NOT NULL, "
                    + "reporter_name VARCHAR(100) NOT NULL, "
                    + "reporter_role ENUM('STUDENT','PROFESSOR') NOT NULL, "
                    + "school_id INT DEFAULT NULL, "
                    + "category VARCHAR(60) NOT NULL, "
                    + "issue VARCHAR(100) NOT NULL, "
                    + "details VARCHAR(500) DEFAULT NULL, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "FOREIGN KEY (reporter_id) REFERENCES users(id) ON DELETE CASCADE, "
                    + "FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE SET NULL, "
                    + "INDEX idx_reports_school_id (school_id), INDEX idx_reports_created_at (created_at))");
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "DataSeeder: reports table check skipped: " + e.getMessage());
        }

        try (java.sql.Connection conn = DatabaseUtils.getConnection()) {
            boolean hasDetails;
            try (java.sql.ResultSet rs = conn.getMetaData().getColumns(null, null, "reports", "details")) {
                hasDetails = rs.next();
            }
            if (!hasDetails) {
                try (java.sql.Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate("ALTER TABLE reports ADD COLUMN details VARCHAR(500) DEFAULT NULL AFTER issue");
                    LOGGER.info("DataSeeder: Added details column to reports.");
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "DataSeeder: reports details column check skipped: " + e.getMessage());
        }

        try (java.sql.Connection conn = DatabaseUtils.getConnection()) {
            boolean hasStart;
            try (java.sql.ResultSet rs = conn.getMetaData().getColumns(null, null, "class_sections", "start_date")) {
                hasStart = rs.next();
            }
            if (!hasStart) {
                try (java.sql.Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate("ALTER TABLE class_sections ADD COLUMN start_date DATE DEFAULT NULL, ADD COLUMN end_date DATE DEFAULT NULL");
                    LOGGER.info("DataSeeder: Added start_date/end_date columns to class_sections.");
                }
            }
            int filled = 0;
            try (java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT cs.id, cs.days_of_week, cs.academic_year, t.term_number FROM class_sections cs JOIN terms t ON cs.term_id = t.id WHERE cs.start_date IS NULL");
                 java.sql.PreparedStatement upd = conn.prepareStatement("UPDATE class_sections SET start_date = ?, end_date = ? WHERE id = ?")) {
                while (rs.next()) {
                    try {
                        TermCalendar.Window w = TermCalendar.window(rs.getString("academic_year"), rs.getInt("term_number"));
                        String days = rs.getString("days_of_week");
                        upd.setDate(1, java.sql.Date.valueOf(TermCalendar.firstSession(days, w.getStart())));
                        upd.setDate(2, java.sql.Date.valueOf(TermCalendar.sessionDate(days, w.getStart(), TermCalendar.SESSIONS_PER_TERM)));
                        upd.setInt(3, rs.getInt("id"));
                        upd.executeUpdate();
                        filled++;
                    } catch (IllegalArgumentException e) {
                        LOGGER.log(Level.WARNING, "DataSeeder: could not compute dates for class section " + rs.getInt("id") + ": " + e.getMessage());
                    }
                }
            }
            if (filled > 0) {
                LOGGER.info("DataSeeder: Filled start/end dates for " + filled + " existing class section(s).");
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "DataSeeder: class section dates check skipped: " + e.getMessage());
        }

        LOGGER.info("DataSeeder: Checking seed passwords...");

        UserRepository userRepository = new UserRepository();
        List<User> allUsers = userRepository.findAllUsers();

        int hashedCount = 0;

        for (User user : allUsers) {
            String password = user.getPassword();
            if (password != null && !password.startsWith("$2a$") && !password.startsWith("$2b$")) {
                String hashed = SecurityUtils.hashPassword(password);
                userRepository.updatePassword(user.getId(), hashed);
                hashedCount++;
                LOGGER.info("DataSeeder: Hashed password for user: " + user.getUserIdentifier());
            }
        }

        if (hashedCount > 0) {
            LOGGER.info("DataSeeder: Hashed " + hashedCount + " plain text password(s).");
        } else {
            LOGGER.info("DataSeeder: All passwords are already hashed. No changes needed.");
        }
    }
}
