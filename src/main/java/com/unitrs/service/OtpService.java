package com.unitrs.service;

import com.unitrs.model.entity.User;

public interface OtpService {

    void sendRegistrationOtp(String email, String fullName);

    void sendLogin2faOtp(User user);

    void sendPasswordResetOtp(String email);

    boolean verifyRegistrationOtp(String email, String otpCode);

    boolean verifyLogin2faOtp(String email, String otpCode);

    boolean verifyPasswordResetOtp(String email, String otpCode);
}
