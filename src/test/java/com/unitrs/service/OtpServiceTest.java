package com.unitrs.service;

import com.unitrs.model.entity.OtpVerification;
import com.unitrs.model.entity.User;
import com.unitrs.repository.OtpRepository;
import com.unitrs.repository.UserRepository;
import com.unitrs.service.impl.OtpServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.temporal.ChronoUnit;

import static org.junit.jupiter.api.Assertions.*;

public class OtpServiceTest {

    private OtpRepository fakeOtpRepository;
    private UserRepository fakeUserRepository;
    private OtpService otpService;

    private OtpVerification storedOtp;
    private boolean userVerifiedCalled;

    @BeforeEach
    void setUp() {
        storedOtp = null;
        userVerifiedCalled = false;

        fakeOtpRepository = new OtpRepository() {
            @Override
            public void createOtp(String email, String otpCode, String otpType, int expiryMinutes) {
                storedOtp = new OtpVerification();
                storedOtp.setId(1);
                storedOtp.setEmail(email);
                storedOtp.setOtpCode(otpCode);
                storedOtp.setOtpType(otpType);
                storedOtp.setExpiresAt(Timestamp.from(Instant.now().plus(expiryMinutes, ChronoUnit.MINUTES)));
                storedOtp.setUsed(false);
            }

            @Override
            public OtpVerification findValidOtp(String email, String otpCode, String otpType) {
                if (storedOtp != null && storedOtp.getEmail().equalsIgnoreCase(email)
                        && storedOtp.getOtpCode().equals(otpCode)
                        && storedOtp.getOtpType().equals(otpType)
                        && !storedOtp.isUsed()
                        && storedOtp.getExpiresAt().after(new Timestamp(System.currentTimeMillis()))) {
                    return storedOtp;
                }
                return null;
            }

            @Override
            public void markOtpUsed(int id) {
                if (storedOtp != null && storedOtp.getId() == id) {
                    storedOtp.setUsed(true);
                }
            }

            @Override
            public void invalidatePendingOtps(String email, String otpType) {
                if (storedOtp != null && storedOtp.getEmail().equalsIgnoreCase(email)) {
                    storedOtp.setUsed(true);
                }
            }
        };

        fakeUserRepository = new UserRepository() {
            @Override
            public boolean verifyUserByEmail(String email) {
                userVerifiedCalled = true;
                return true;
            }

            @Override
            public User findByEmail(String email) {
                User u = new User();
                u.setEmail(email);
                u.setFullName("Test User");
                return u;
            }
        };

        otpService = new OtpServiceImpl(fakeOtpRepository, fakeUserRepository);
    }

    @Test
    void testRegistrationOtpLifecycle() {
        String email = "student@unitrs.edu";
        otpService.sendRegistrationOtp(email, "Alice Smith");

        assertNotNull(storedOtp);
        assertEquals("REGISTRATION", storedOtp.getOtpType());
        assertEquals(email, storedOtp.getEmail());
        assertEquals(6, storedOtp.getOtpCode().length());
        assertFalse(storedOtp.isUsed());

        boolean failVerify = otpService.verifyRegistrationOtp(email, "000000");
        assertFalse(failVerify);
        assertFalse(userVerifiedCalled);
        assertFalse(storedOtp.isUsed());

        boolean successVerify = otpService.verifyRegistrationOtp(email, storedOtp.getOtpCode());
        assertTrue(successVerify);
        assertFalse(userVerifiedCalled);
        assertTrue(storedOtp.isUsed());

        boolean reuseVerify = otpService.verifyRegistrationOtp(email, storedOtp.getOtpCode());
        assertFalse(reuseVerify);
    }

    @Test
    void testLogin2faOtpLifecycle() {
        User user = new User();
        user.setEmail("prof@unitrs.edu");
        user.setFullName("Dr. Alan Turing");

        otpService.sendLogin2faOtp(user);
        assertNotNull(storedOtp);
        assertEquals("LOGIN_2FA", storedOtp.getOtpType());

        assertTrue(otpService.verifyLogin2faOtp("prof@unitrs.edu", storedOtp.getOtpCode()));
        assertTrue(storedOtp.isUsed());
    }

    @Test
    void testExpiredOtpFails() {
        String email = "user@unitrs.edu";
        otpService.sendRegistrationOtp(email, "Bob");

        storedOtp.setExpiresAt(Timestamp.from(Instant.now().minus(1, ChronoUnit.HOURS)));

        boolean result = otpService.verifyRegistrationOtp(email, storedOtp.getOtpCode());
        assertFalse(result, "Expired OTP should not be valid");
    }
}
