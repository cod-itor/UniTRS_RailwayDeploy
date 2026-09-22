package com.unitrs.service;

import com.unitrs.model.entity.User;
import java.util.List;

public interface UserService {
    User authenticate(String identifierOrEmail, String password);
    boolean register(User user);
    User findById(int id);
    User findByIdentifier(String identifier);
    User findByEmail(String email);
    boolean isIdentifierAvailable(String identifier);
    boolean isEmailAvailable(String email);
    boolean isFullNameAvailable(String fullName);
    List<User> findUnverifiedStudents();
    List<User> findUnverifiedUsers();
    boolean verifyStudent(int id, boolean isVerified);
    void processUserVerification(int userId, boolean isApproved, String role);
    boolean updateRole(int id, String role);
    void registerNewUser(String identifier, String fullName, String email, String password, String confirmPassword, String major, String gender);
    void registerNewUser(String identifier, String fullName, String email, String password, String confirmPassword, String major, String role, String gender);
    List<User> findAllUsers();
    List<User> findProfessors();
    boolean updateUserStatus(int id, boolean isActive);
    boolean createStaffUser(User user);
    void resetPassword(String email, String newPassword, String confirmPassword);
    void updateTwoFactorEnabled(int userId, boolean enabled);
}
