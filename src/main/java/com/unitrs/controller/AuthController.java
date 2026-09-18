package com.unitrs.controller;

import com.unitrs.exceptions.UnauthorizedException;
import com.unitrs.exceptions.UserNotFoundException;
import com.unitrs.exceptions.ValidationException;
import com.unitrs.model.entity.Role;
import com.unitrs.model.entity.User;
import com.unitrs.repository.OtpRepository;
import com.unitrs.repository.SchoolRepository;
import com.unitrs.repository.UserRepository;
import com.unitrs.service.OtpService;
import com.unitrs.service.UserService;
import com.unitrs.service.impl.OtpServiceImpl;
import com.unitrs.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/auth/*")
public class AuthController extends HttpServlet {

    private UserService userService;
    private OtpService otpService;
    private SchoolRepository schoolRepository;

    @Override
    public void init() throws ServletException {
        UserRepository userRepository = new UserRepository();
        this.userService = new UserServiceImpl(userRepository);
        this.otpService = new OtpServiceImpl(new OtpRepository(), userRepository);
        this.schoolRepository = new SchoolRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();
        if (path == null) {
            path = "/login";
        }

        switch (path) {
            case "/logout":
                handleLogout(request, response);
                break;
            case "/register":
                request.setAttribute("schools", schoolRepository.findAll());
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                break;
            case "/verify-registration":
                request.setAttribute("email", request.getParameter("email"));
                request.getRequestDispatcher("/WEB-INF/views/auth/verify_registration.jsp").forward(request, response);
                break;
            case "/verify-2fa":
                handleGet2fa(request, response);
                break;
            case "/forgot-password":
                request.getRequestDispatcher("/WEB-INF/views/auth/forgot_password.jsp").forward(request, response);
                break;
            case "/verify-reset-otp":
                request.setAttribute("email", request.getParameter("email"));
                request.getRequestDispatcher("/WEB-INF/views/auth/verify_reset_otp.jsp").forward(request, response);
                break;
            case "/set-new-password":
                handleGetSetNewPassword(request, response);
                break;
            default:
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();
        if (path == null) {
            path = "/login";
        }

        switch (path) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            case "/verify-registration":
                handleVerifyRegistration(request, response);
                break;
            case "/resend-registration-otp":
                handleResendRegistrationOtp(request, response);
                break;
            case "/verify-2fa":
                handleVerify2fa(request, response);
                break;
            case "/resend-2fa-otp":
                handleResend2faOtp(request, response);
                break;
            case "/forgot-password":
                handleForgotPassword(request, response);
                break;
            case "/verify-reset-otp":
                handleVerifyResetOtp(request, response);
                break;
            case "/resend-reset-otp":
                handleResendResetOtp(request, response);
                break;
            case "/set-new-password":
                handleSetNewPassword(request, response);
                break;
            case "/update-2fa":
                handleUpdate2fa(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/auth/login");
                break;
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String identifierOrEmail = request.getParameter("identifier");
        String password = request.getParameter("password");

        if (identifierOrEmail == null || identifierOrEmail.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both Email/Student ID and password.");
            request.setAttribute("identifier", identifierOrEmail);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userService.authenticate(identifierOrEmail.trim(), password);

            if (user.getRole() == Role.ADMIN) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());
                session.setMaxInactiveInterval(30 * 60);
                redirectToUserDashboard(user, request, response);
                return;
            }

            if (!user.isVerified()) {
                request.setAttribute("error", "Your account is pending administrator verification. You will receive an email once your account has been approved.");
                request.setAttribute("identifier", identifierOrEmail);
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            if (user.isTwoFactorEnabled()) {
                otpService.sendLogin2faOtp(user);

                HttpSession session = request.getSession(true);
                session.setAttribute("pending_2fa_user", user);

                response.sendRedirect(request.getContextPath() + "/auth/verify-2fa");
            } else {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());
                session.setMaxInactiveInterval(30 * 60);

                redirectToUserDashboard(user, request, response);
            }

        } catch (UserNotFoundException e) {
            request.setAttribute("error", "User not found or account is inactive.");
            request.setAttribute("identifier", identifierOrEmail);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        } catch (UnauthorizedException e) {
            request.setAttribute("error", "Invalid password. Please try again.");
            request.setAttribute("identifier", identifierOrEmail);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    private void handleUpdate2fa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.getRole() == Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        String twoFactorEnabledParam = request.getParameter("twoFactorEnabled");
        boolean enabled = "true".equalsIgnoreCase(twoFactorEnabledParam) || "enabled".equalsIgnoreCase(twoFactorEnabledParam);

        userService.updateTwoFactorEnabled(user.getId(), enabled);
        user.setTwoFactorEnabled(enabled);
        session.setAttribute("user", user);

        String redirect = request.getParameter("redirect");
        if (redirect == null || redirect.trim().isEmpty() || !redirect.startsWith("/")) {
            if (user.getRole() == Role.DEAN || user.getDeanSchoolId() != null) {
                redirect = "/dean/dashboard";
            } else if (user.getRole() == Role.PROFESSOR) {
                redirect = "/professor/dashboard";
            } else {
                redirect = "/student/dashboard";
            }
        }

        String separator = redirect.contains("?") ? "&" : "?";
        response.sendRedirect(request.getContextPath() + redirect + separator + "twoFactorUpdated=" + enabled);
    }

    private void handleGet2fa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pending_2fa_user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("pending_2fa_user");
        request.setAttribute("email", user.getEmail());
        request.getRequestDispatcher("/WEB-INF/views/auth/verify_2fa.jsp").forward(request, response);
    }

    private void handleVerify2fa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pending_2fa_user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("pending_2fa_user");
        String otpCode = request.getParameter("otpCode");

        if (otpService.verifyLogin2faOtp(user.getEmail(), otpCode)) {
            session.removeAttribute("pending_2fa_user");
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60);

            redirectToUserDashboard(user, request, response);
        } else {
            request.setAttribute("email", user.getEmail());
            request.setAttribute("error", "Invalid or expired 2FA code. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify_2fa.jsp").forward(request, response);
        }
    }

    private void handleResend2faOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pending_2fa_user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("pending_2fa_user");
        otpService.sendLogin2faOtp(user);

        request.setAttribute("email", user.getEmail());
        request.setAttribute("info", "A new 2FA code has been sent to your email.");
        request.getRequestDispatcher("/WEB-INF/views/auth/verify_2fa.jsp").forward(request, response);
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
                || (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));

        String identifier = request.getParameter("identifier");
        String roleStr = request.getParameter("role");
        String applicantType = request.getParameter("applicantType");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String fullName = request.getParameter("fullName");
        if ((fullName == null || fullName.trim().isEmpty()) && firstName != null && lastName != null) {
            fullName = (firstName.trim() + " " + lastName.trim()).trim();
        }
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String major = request.getParameter("major");

        if ((identifier == null || identifier.trim().isEmpty()) && "new".equalsIgnoreCase(applicantType)) {
            identifier = "9" + (int) (1000000 + (Math.random() * 9000000));
        }

        try {
            userService.registerNewUser(identifier, fullName, email, password, confirmPassword, major, roleStr);

            otpService.sendRegistrationOtp(email, fullName);

            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_OK);
                String safeApplicantType = applicantType != null ? applicantType : "";
                String safeRole = roleStr != null ? roleStr : "student";
                response.getWriter().write("{\"status\":\"success\",\"applicantType\":\"" + safeApplicantType
                        + "\",\"role\":\"" + safeRole + "\",\"email\":\"" + email + "\"}");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/auth/verify-registration?email="
                    + URLEncoder.encode(email, StandardCharsets.UTF_8));

        } catch (ValidationException e) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                String msg = e.getMessage() != null ? e.getMessage().replace("\"", "\\\"") : "Validation failed";
                response.getWriter().write("{\"status\":\"error\",\"message\":\"" + msg + "\"}");
                return;
            }

            request.setAttribute("error", e.getMessage());
            request.setAttribute("identifier", identifier);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("major", major);
            request.setAttribute("schools", schoolRepository.findAll());
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }

    private void handleVerifyRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
                || (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));

        String email = request.getParameter("email");
        String otpCode = request.getParameter("otpCode");

        if (otpService.verifyRegistrationOtp(email, otpCode)) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Email verified successfully! Your account is now pending administrator approval.\"}");
                return;
            }
            request.setAttribute("email", email);
            request.setAttribute("verifiedSuccess", true);
            request.getRequestDispatcher("/WEB-INF/views/auth/verify_registration.jsp").forward(request, response);
        } else {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid or expired verification code. Please check your code or request a new one.\"}");
                return;
            }
            request.setAttribute("email", email);
            request.setAttribute("error", "Invalid or expired verification code. Please check your code or request a new one.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify_registration.jsp").forward(request, response);
        }
    }

    private void handleResendRegistrationOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
                || (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));

        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            User user = userService.findByEmail(email.trim());
            String fullName = user != null ? user.getFullName() : null;
            otpService.sendRegistrationOtp(email.trim(), fullName);
        }

        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"status\":\"success\",\"message\":\"A new verification code has been sent to your email.\"}");
            return;
        }

        request.setAttribute("email", email);
        request.setAttribute("info", "A new verification code has been sent to your email.");
        request.getRequestDispatcher("/WEB-INF/views/auth/verify_registration.jsp").forward(request, response);
    }

    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Please enter your email address.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot_password.jsp").forward(request, response);
            return;
        }

        User user = userService.findByEmail(email.trim());
        if (user == null) {
            request.setAttribute("error", "No account found with this email address.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot_password.jsp").forward(request, response);
            return;
        }

        otpService.sendPasswordResetOtp(email.trim());

        response.sendRedirect(request.getContextPath() + "/auth/verify-reset-otp?email="
                + URLEncoder.encode(email.trim(), StandardCharsets.UTF_8));
    }

    private void handleVerifyResetOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String otpCode = request.getParameter("otpCode");

        if (otpService.verifyPasswordResetOtp(email, otpCode)) {

            HttpSession session = request.getSession(true);
            session.setAttribute("verified_reset_email", email.trim());

            response.sendRedirect(request.getContextPath() + "/auth/set-new-password");
        } else {
            request.setAttribute("email", email);
            request.setAttribute("error", "Invalid or expired code. Please enter the 6-digit code sent to your email.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify_reset_otp.jsp").forward(request, response);
        }
    }

    private void handleResendResetOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            otpService.sendPasswordResetOtp(email.trim());
        }

        request.setAttribute("email", email);
        request.setAttribute("info", "A new verification code has been sent to your email.");
        request.getRequestDispatcher("/WEB-INF/views/auth/verify_reset_otp.jsp").forward(request, response);
    }

    private void handleGetSetNewPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("verified_reset_email") == null) {

            response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
            return;
        }

        request.setAttribute("email", session.getAttribute("verified_reset_email"));
        request.getRequestDispatcher("/WEB-INF/views/auth/set_new_password.jsp").forward(request, response);
    }

    private void handleSetNewPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("verified_reset_email") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
            return;
        }

        String email = (String) session.getAttribute("verified_reset_email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            userService.resetPassword(email, password, confirmPassword);

            session.removeAttribute("verified_reset_email");

            request.setAttribute("success", "Your password has been successfully reset! Please sign in with your new password.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);

        } catch (ValidationException e) {
            request.setAttribute("email", email);
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/set_new_password.jsp").forward(request, response);
        }
    }

    private void redirectToUserDashboard(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String contextPath = request.getContextPath();

        if (user.getDeanSchoolId() != null) {
            response.sendRedirect(contextPath + "/dean/dashboard");
            return;
        }

        switch (user.getRole()) {
            case ADMIN:
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case DEAN:
                response.sendRedirect(contextPath + "/dean/dashboard");
                break;
            case PROFESSOR:
                response.sendRedirect(contextPath + "/professor/dashboard");
                break;
            case STUDENT:
                response.sendRedirect(contextPath + "/student/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/auth/login");
                break;
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/auth/login?logout=true");
    }
}
