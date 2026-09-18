package com.unitrs.utils;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailService {

    private static final Logger LOGGER = Logger.getLogger(EmailService.class.getName());
    private static final String RESEND_API_URL = "https://api.resend.com/emails";
    private static final HttpClient HTTP_CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public static boolean sendOtpEmail(String toEmail, String subject, String title, String message, String otpCode) {
        String apiKey = CredentialsLoader.getResendApiKey();
        String from = CredentialsLoader.getMailFrom();

        if (apiKey == null || apiKey.trim().isEmpty() || apiKey.equals("re_your_api_key_here")) {
            LOGGER.info("===============================================================");
            LOGGER.info("[EmailService LOCAL MOCK] No Resend API Key found.");
            LOGGER.info("To: " + toEmail);
            LOGGER.info("Subject: " + subject);
            LOGGER.info("OTP CODE: " + otpCode);
            LOGGER.info("===============================================================");
            return true;
        }

        String htmlContent = buildEmailTemplate(title, message, otpCode);

        String jsonPayload = String.format(
                "{\"from\":\"%s\",\"to\":[\"%s\"],\"subject\":\"%s\",\"html\":\"%s\"}",
                escapeJson(from),
                escapeJson(toEmail),
                escapeJson(subject),
                escapeJson(htmlContent)
        );

        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(RESEND_API_URL))
                    .header("Authorization", "Bearer " + apiKey.trim())
                    .header("Content-Type", "application/json")
                    .timeout(Duration.ofSeconds(15))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                    .build();

            HttpResponse<String> response = HTTP_CLIENT.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() >= 200 && response.statusCode() < 300) {
                LOGGER.info("Email successfully sent to " + toEmail + " via Resend.");
                return true;
            } else {
                LOGGER.severe("Failed to send email via Resend. Status: " + response.statusCode() + ", Body: " + response.body());
                return false;
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception sending email to " + toEmail, e);
            return false;
        }
    }

    public static boolean sendRegistrationOtp(String toEmail, String fullName, String otpCode) {
        String title = "Verify Your UniTRS Account";
        String message = "Hello " + (fullName != null ? fullName : "Student") + ",<br><br>"
                + "Thank you for joining UniTRS University Management System. Please use the verification code below to verify your email address and activate your account:";
        return sendOtpEmail(toEmail, "UniTRS - Verify Your Account", title, message, otpCode);
    }

    public static boolean sendLogin2faOtp(String toEmail, String fullName, String otpCode) {
        String title = "Two-Factor Authentication (2FA)";
        String message = "Hello " + (fullName != null ? fullName : "User") + ",<br><br>"
                + "A sign-in request was initiated for your UniTRS account. Use the one-time verification code below to complete your login:";
        return sendOtpEmail(toEmail, "UniTRS - Your 2FA Login Code", title, message, otpCode);
    }

    public static boolean sendPasswordResetOtp(String toEmail, String fullName, String otpCode) {
        String title = "Password Reset Request";
        String message = "Hello " + (fullName != null ? fullName : "User") + ",<br><br>"
                + "We received a request to reset your UniTRS account password. Use the verification code below to set your new password:";
        return sendOtpEmail(toEmail, "UniTRS - Password Reset Code", title, message, otpCode);
    }

    private static String buildEmailTemplate(String title, String message, String otpCode) {
        return "<!DOCTYPE html>"
                + "<html>"
                + "<head><meta charset='UTF-8'></head>"
                + "<body style='font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Helvetica, Arial, sans-serif; background-color: #0f172a; margin: 0; padding: 30px 15px; color: #f8fafc;'>"
                + "<div style='max-width: 520px; margin: 0 auto; background-color: #1e293b; border: 1px solid #334155; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.5);'>"
                + "  <div style='background: linear-gradient(135deg, #0284c7 0%, #38bdf8 100%); padding: 24px; text-align: center;'>"
                + "    <h1 style='margin: 0; font-size: 24px; color: #ffffff; letter-spacing: 1px; font-weight: 800;'>UniTRS</h1>"
                + "    <p style='margin: 4px 0 0 0; font-size: 13px; color: #e0f2fe;'>University Management System</p>"
                + "  </div>"
                + "  <div style='padding: 30px;'>"
                + "    <h2 style='margin-top: 0; font-size: 19px; color: #f1f5f9;'>" + title + "</h2>"
                + "    <p style='font-size: 14px; line-height: 1.6; color: #cbd5e1;'>" + message + "</p>"
                + "    <div style='margin: 28px 0; text-align: center;'>"
                + "      <div style='display: inline-block; background-color: #0f172a; border: 2px dashed #0284c7; border-radius: 8px; padding: 14px 28px; font-size: 32px; font-weight: 800; letter-spacing: 8px; color: #38bdf8; font-family: monospace;'>"
                +          otpCode
                + "      </div>"
                + "    </div>"
                + "    <p style='font-size: 13px; color: #94a3b8; text-align: center; margin: 0;'>"
                + "      ⏱️ This code will expire in <strong>10 minutes</strong>.<br>If you did not request this, you can safely ignore this email."
                + "    </p>"
                + "  </div>"
                + "  <div style='background-color: #0f172a; padding: 16px; text-align: center; border-top: 1px solid #334155; font-size: 12px; color: #64748b;'>"
                + "    &copy; " + java.time.Year.now().getValue() + " UniTRS. All rights reserved."
                + "  </div>"
                + "</div>"
                + "</body>"
                + "</html>";
    }

    private static String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\b", "\\b")
                    .replace("\f", "\\f")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}
