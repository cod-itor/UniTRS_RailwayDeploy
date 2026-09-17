package com.unitrs.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CredentialsLoader {

    private static final Logger LOGGER = Logger.getLogger(CredentialsLoader.class.getName());
    private static final String FILE_NAME = "db.properties";

    public static Properties loadProperties() {
        Properties properties = new Properties();

        try (InputStream input = CredentialsLoader.class.getClassLoader().getResourceAsStream(FILE_NAME)) {
            if (input == null) {
                LOGGER.warning("Unable to find " + FILE_NAME + " in the classpath. Relying on Environment Variables.");
            } else {
                properties.load(input);
            }
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Unable to load properties file", e);
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

        if (!properties.containsKey("db.url")) {
             throw new RuntimeException("No Database Configuration Found. Set DB_URL or provide db.properties");
        }

        return properties;
    }
}
