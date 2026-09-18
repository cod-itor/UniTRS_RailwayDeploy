package com.unitrs.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CredentialsLoader {

    private static final Logger LOGGER = Logger.getLogger(CredentialsLoader.class.getName());
    private static final String FILE_NAME = "db.properties";
    private static final String LOCAL_OVERRIDE_FILE = "db.local.properties";

    public static Properties loadProperties() {
        Properties properties = new Properties();

        try (InputStream cpInput = CredentialsLoader.class.getClassLoader().getResourceAsStream(FILE_NAME)) {
            if (cpInput != null) {
                properties.load(cpInput);
            }
        } catch (IOException e) {
            LOGGER.log(Level.FINE, "Unable to load " + FILE_NAME + " from classpath", e);
        }

        java.io.File localBaseFile = new java.io.File("src/main/resources/" + FILE_NAME);
        if (localBaseFile.exists()) {
            try (InputStream input = new java.io.FileInputStream(localBaseFile)) {
                properties.load(input);
            } catch (IOException e) {
                LOGGER.log(Level.FINE, "Unable to load workspace " + FILE_NAME, e);
            }
        }

        try (InputStream cpLocalInput = CredentialsLoader.class.getClassLoader().getResourceAsStream(LOCAL_OVERRIDE_FILE)) {
            if (cpLocalInput != null) {
                properties.load(cpLocalInput);
            }
        } catch (IOException e) {
            LOGGER.log(Level.FINE, "Unable to load " + LOCAL_OVERRIDE_FILE + " from classpath", e);
        }

        java.io.File devOverrideFile = new java.io.File("src/main/resources/" + LOCAL_OVERRIDE_FILE);
        if (devOverrideFile.exists()) {
            try (InputStream devInput = new java.io.FileInputStream(devOverrideFile)) {
                properties.load(devInput);
            } catch (IOException e) {
                LOGGER.log(Level.FINE, "Unable to load local " + LOCAL_OVERRIDE_FILE, e);
            }
        }

        String dbUrl = System.getenv("DB_URL");
        if (dbUrl == null) {
            dbUrl = System.getenv("MYSQL_URL");
        }
        if (dbUrl == null) {
            dbUrl = System.getenv("MYSQLURL");
        }
        if (dbUrl != null) {
            if (dbUrl.startsWith("mysql://")) {
                dbUrl = "jdbc:" + dbUrl;
            }
            if (!dbUrl.contains("?")) {
                dbUrl += "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            }
            properties.setProperty("db.url", dbUrl);
        } else if (System.getenv("MYSQLHOST") != null) {
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT") != null ? System.getenv("MYSQLPORT") : "3306";
            String database = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "railway";
            String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            properties.setProperty("db.url", url);
        }

        String dbUser = System.getenv("DB_USER");
        if (dbUser == null) {
            dbUser = System.getenv("MYSQLUSER");
        }
        if (dbUser != null) {
            properties.setProperty("db.user", dbUser);
        }

        String dbPassword = System.getenv("DB_PASSWORD");
        if (dbPassword == null) {
            dbPassword = System.getenv("MYSQLPASSWORD");
        }
        if (dbPassword != null) {
            properties.setProperty("db.password", dbPassword);
        }

        String resendApiKey = System.getenv("RESEND_API_KEY");
        if (resendApiKey == null || resendApiKey.trim().isEmpty()) {
            resendApiKey = properties.getProperty("resend.api.key");
        }
        if (resendApiKey != null && !resendApiKey.trim().isEmpty()) {
            properties.setProperty("resend.api.key", resendApiKey.trim());
        }

        String mailFrom = System.getenv("MAIL_FROM");
        if (mailFrom == null || mailFrom.trim().isEmpty()) {
            mailFrom = properties.getProperty("mail.from", "UniTRS <noreply@ditarector.tech>");
        }
        properties.setProperty("mail.from", mailFrom.trim());

        if (!properties.containsKey("db.url")) {
             throw new RuntimeException("No Database Configuration Found. Set DB_URL or provide db.properties");
        }

        return properties;
    }

    public static String getResendApiKey() {
        return loadProperties().getProperty("resend.api.key");
    }

    public static String getMailFrom() {
        return loadProperties().getProperty("mail.from", "UniTRS <noreply@ditarector.tech>");
    }
}
