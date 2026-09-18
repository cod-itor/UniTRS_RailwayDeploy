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
