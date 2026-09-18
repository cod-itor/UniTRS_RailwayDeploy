package com.unitrs.service.impl;

import com.unitrs.model.entity.Role;
import com.unitrs.model.entity.User;
import com.unitrs.utils.EmailService;
import com.unitrs.utils.SecurityUtils;
import com.unitrs.exceptions.UnauthorizedException;
import com.unitrs.exceptions.UserNotFoundException;
import com.unitrs.exceptions.ValidationException;
import com.unitrs.repository.UserRepository;
import com.unitrs.service.UserService;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.concurrent.CompletableFuture;

@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public User authenticate(String identifierOrEmail, String password) {
        User user = userRepository.findByEmailOrIdentifier(identifierOrEmail);
        if (user == null) {
            throw new UserNotFoundException("User not found or inactive.");
        }
        if (!SecurityUtils.checkPassword(password, user.getPassword())) {
            throw new UnauthorizedException("Invalid password.");
        }
        return user;
    }

    @Override
    public boolean register(User user) {
        if (user.getPassword() == null || user.getPassword().length() < 6) {
            throw new ValidationException("Password must be at least 6 characters.");
        }
        user.setPassword(SecurityUtils.hashPassword(user.getPassword()));
        return userRepository.register(user);
    }

    @Override
    public User findById(int id) {
        return userRepository.findById(id);
    }

    @Override
    public User findByIdentifier(String identifier) {
        return userRepository.findByIdentifier(identifier);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public boolean isIdentifierAvailable(String identifier) {
        if (identifier == null || identifier.trim().isEmpty())
            return false;
        return userRepository.findByIdentifier(identifier.trim()) == null;
    }

    @Override
    public boolean isEmailAvailable(String email) {
        if (email == null || email.trim().isEmpty())
            return false;
        return userRepository.findByEmail(email.trim()) == null;
    }

    @Override
    public boolean isFullNameAvailable(String fullName) {
        if (fullName == null || fullName.trim().isEmpty())
            return false;
        return userRepository.findByFullName(fullName.trim()) == null;
    }

    @Override
    public List<User> findUnverifiedStudents() {
        return userRepository.findUnverifiedStudents();
    }

    @Override
    public List<User> findUnverifiedUsers() {
        return userRepository.findUnverifiedUsers();
    }

    @Override
    public boolean verifyStudent(int id, boolean isVerified) {
        return userRepository.verifyStudent(id, isVerified);
    }

    @Override
    public boolean updateRole(int id, String role) {
        return userRepository.updateRole(id, role);
    }

    @Override
    public void processUserVerification(int userId, boolean isApproved, String role) {
        userRepository.verifyStudent(userId, isApproved);
        if (isApproved && role != null && !role.trim().isEmpty()) {
            userRepository.updateRole(userId, role);
        }
        if (isApproved) {
            User user = userRepository.findById(userId);
            if (user != null && user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
                String assignedRole = (role != null && !role.trim().isEmpty()) ? role : user.getRole().name();
                CompletableFuture.runAsync(() -> {
                    EmailService.sendAccountVerifiedEmail(user.getEmail().trim(), user.getFullName(), assignedRole);
                });
            }
        }
    }

    @Override
    public void registerNewUser(String identifier, String fullName, String email, String password,
            String confirmPassword, String major) {
        registerNewUser(identifier, fullName, email, password, confirmPassword, major, "STUDENT");
    }

    @Override
    public void registerNewUser(String identifier, String fullName, String email, String password,
            String confirmPassword, String major, String role) {
        if (identifier == null || identifier.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
            throw new ValidationException("Please fill in all required fields.");
        }

        String roleLabel = (role != null && role.trim().equalsIgnoreCase("professor")) ? "Professor" : "Student";

        identifier = identifier.trim();
        if (!identifier.matches("^\\d+$")) {
            throw new ValidationException(roleLabel + " ID must contain numbers only.");
        }
        if (identifier.length() != 8) {
            throw new ValidationException(roleLabel + " ID must be exactly 8 digits (e.g. 60240512).");
        }

        fullName = fullName.trim().replaceAll("\\s+", " ");
        if (fullName.length() < 2 || fullName.length() > 100) {
            throw new ValidationException("Full name must be between 2 and 100 characters.");
        }
        if (fullName.startsWith("-") || fullName.startsWith("'") || fullName.endsWith("-") || fullName.endsWith("'")) {
            throw new ValidationException("Full name cannot start or end with hyphens or apostrophes.");
        }
        if (!fullName.matches("^[a-zA-Z\\s'-]+$")) {
            throw new ValidationException("Full name can only contain letters, spaces, hyphens, and apostrophes.");
        }
        if (!fullName.contains(" ")) {
            throw new ValidationException("Please provide both first and last name.");
        }
        if (!isFullNameAvailable(fullName)) {
            throw new ValidationException("A user with this full name already exists in the system.");
        }

        email = email.trim().toLowerCase();
        if (email.length() > 64) {
            throw new ValidationException("Email address must not exceed 64 characters.");
        }
        if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            throw new ValidationException("Please provide a valid email format.");
        }
        if (!email.endsWith("@gmail.com") && !email.endsWith(".edu")) {
            throw new ValidationException("Email must be a @gmail.com or an .edu domain.");
        }

        if (!password.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match.");
        }
        if (password.length() < 8 || password.length() > 64) {
            throw new ValidationException("Password must be between 8 and 64 characters.");
        }
        if (password.trim().isEmpty()) {
            throw new ValidationException("Password cannot be purely whitespace.");
        }
        if (!password.matches(".*[A-Z].*")) {
            throw new ValidationException("Password must contain at least one uppercase letter.");
        }
        if (!password.matches(".*[a-z].*")) {
            throw new ValidationException("Password must contain at least one lowercase letter.");
        }
        if (!password.matches(".*[0-9].*")) {
            throw new ValidationException("Password must contain at least one number.");
        }
        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?~`].*")) {
            throw new ValidationException("Password must contain at least one special character.");
        }

        if (major != null) {
            major = major.trim();
            if (major.length() > 100) {
                throw new ValidationException("Major must not exceed 100 characters.");
            }
        }

        if (!isIdentifierAvailable(identifier)) {
            throw new ValidationException("A user with this " + roleLabel + " ID already exists.");
        }
        if (!isEmailAvailable(email)) {
            throw new ValidationException("User with this email already exists.");
        }

        User newUser = new User();
        newUser.setUserIdentifier(identifier);
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setMajor(major != null && !major.isEmpty() ? major : null);
        Role userRole = (role != null && role.trim().equalsIgnoreCase("professor")) ? Role.PROFESSOR : Role.STUDENT;
        newUser.setRole(userRole);
        newUser.setVerified(false);
        newUser.setActive(true);

        boolean success = register(newUser);
        if (!success) {
            throw new ValidationException("Failed to register user to the database.");
        }
    }

    @Override
    public List<User> findAllUsers() {
        return userRepository.findAllUsers();
    }

    @Override
    public List<User> findProfessors() {
        return userRepository.findProfessors();
    }

    @Override
    public boolean updateUserStatus(int id, boolean isActive) {
        return userRepository.updateUserStatus(id, isActive);
    }

    @Override
    public boolean createStaffUser(User user) {
        return userRepository.createStaffUser(user);
    }

    @Override
    public void resetPassword(String email, String newPassword, String confirmPassword) {
        if (email == null || email.trim().isEmpty()) {
            throw new ValidationException("Email is required.");
        }
        if (newPassword == null || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            throw new ValidationException("Both password fields are required.");
        }
        if (!newPassword.equals(confirmPassword)) {
            throw new ValidationException("Passwords do not match.");
        }
        if (newPassword.length() < 8) {
            throw new ValidationException("Password must be at least 8 characters long.");
        }
        if (newPassword.length() > 64) {
            throw new ValidationException("Password must not exceed 64 characters.");
        }
        if (!newPassword.matches(".*[A-Z].*")) {
            throw new ValidationException("Password must contain at least one uppercase letter.");
        }
        if (!newPassword.matches(".*[a-z].*")) {
            throw new ValidationException("Password must contain at least one lowercase letter.");
        }
        if (!newPassword.matches(".*[0-9].*")) {
            throw new ValidationException("Password must contain at least one number.");
        }
        if (!newPassword.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?~`].*")) {
            throw new ValidationException("Password must contain at least one special character.");
        }

        User user = userRepository.findByEmail(email.trim());
        if (user == null) {
            throw new ValidationException("No user found with the provided email.");
        }

        String hashedPassword = SecurityUtils.hashPassword(newPassword);
        boolean updated = userRepository.updatePasswordByEmail(email.trim(), hashedPassword);
        if (!updated) {
            throw new ValidationException("Failed to update password. Please try again.");
        }
    }

    @Override
    public void updateTwoFactorEnabled(int userId, boolean enabled) {
        userRepository.updateTwoFactorEnabled(userId, enabled);
    }
}
