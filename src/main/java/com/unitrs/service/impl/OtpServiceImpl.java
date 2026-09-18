package com.unitrs.service.impl;

import com.unitrs.model.entity.OtpVerification;
import com.unitrs.model.entity.User;
import com.unitrs.repository.OtpRepository;
import com.unitrs.repository.UserRepository;
import com.unitrs.service.OtpService;
import com.unitrs.utils.EmailService;

import java.security.SecureRandom;
import java.util.logging.Logger;

public class OtpServiceImpl implements OtpService {

    private static final Logger LOGGER = Logger.getLogger(OtpServiceImpl.class.getName());
    private static final SecureRandom RANDOM = new SecureRandom();
    private final OtpRepository otpRepository;
    private final UserRepository userRepository;

    public OtpServiceImpl() {
        this.otpRepository = new OtpRepository();
        this.userRepository = new UserRepository();
    }

    public OtpServiceImpl(OtpRepository otpRepository, UserRepository userRepository) {
        this.otpRepository = otpRepository;
        this.userRepository = userRepository;
    }

    private String generateSixDigitCode() {
        int code = RANDOM.nextInt(900000) + 100000;
        return String.valueOf(code);
    }

    @Override
    public void sendRegistrationOtp(String email, String fullName) {
        if (email == null || email.trim().isEmpty())
            return;
        String code = generateSixDigitCode();
        otpRepository.createOtp(email.trim(), code, "REGISTRATION", 10);
        EmailService.sendRegistrationOtp(email.trim(), fullName, code);
        LOGGER.info("Registration OTP sent to " + email);
    }

    @Override
    public void sendLogin2faOtp(User user) {
        if (user == null || user.getEmail() == null)
            return;
        String code = generateSixDigitCode();
        otpRepository.createOtp(user.getEmail().trim(), code, "LOGIN_2FA", 5);
        EmailService.sendLogin2faOtp(user.getEmail().trim(), user.getFullName(), code);
        LOGGER.info("Login 2FA OTP sent to " + user.getEmail());
    }

    @Override
    public void sendPasswordResetOtp(String email) {
        if (email == null || email.trim().isEmpty())
            return;
        User user = userRepository.findByEmail(email.trim());
        if (user == null) {
            LOGGER.warning("Password reset requested for non-existing email: " + email);
            return;
        }
        String code = generateSixDigitCode();
        otpRepository.createOtp(email.trim(), code, "PASSWORD_RESET", 10);
        EmailService.sendPasswordResetOtp(email.trim(), user.getFullName(), code);
        LOGGER.info("Password reset OTP sent to " + email);
    }

    @Override
    public boolean verifyRegistrationOtp(String email, String otpCode) {
        if (email == null || otpCode == null)
            return false;
        OtpVerification otp = otpRepository.findValidOtp(email.trim(), otpCode.trim(), "REGISTRATION");
        if (otp != null) {
            otpRepository.markOtpUsed(otp.getId());
            LOGGER.info("Registration OTP verified for " + email);
            return true;
        }
        return false;
    }

    @Override
    public boolean verifyLogin2faOtp(String email, String otpCode) {
        if (email == null || otpCode == null)
            return false;
        OtpVerification otp = otpRepository.findValidOtp(email.trim(), otpCode.trim(), "LOGIN_2FA");
        if (otp != null) {
            otpRepository.markOtpUsed(otp.getId());
            LOGGER.info("2FA Login OTP verified for " + email);
            return true;
        }
        return false;
    }

    @Override
    public boolean verifyPasswordResetOtp(String email, String otpCode) {
        if (email == null || otpCode == null)
            return false;
        OtpVerification otp = otpRepository.findValidOtp(email.trim(), otpCode.trim(), "PASSWORD_RESET");
        if (otp != null) {
            otpRepository.markOtpUsed(otp.getId());
            LOGGER.info("Password reset OTP verified for " + email);
            return true;
        }
        return false;
    }
}
