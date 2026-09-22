<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Sign In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/sonner.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
</head>
<body class="auth-page">

    <!-- Sonner Flash Notification Triggers -->
    <c:if test="${not empty error}">
        <div class="sonner-flash-trigger d-none" data-type="error" data-title="Sign In Failed" data-message="<c:out value='${error}' />"></div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="sonner-flash-trigger d-none" data-type="success" data-title="Success" data-message="<c:out value='${success}' />"></div>
    </c:if>
    <c:if test="${empty success && param.resetSuccess == 'true'}">
        <div class="sonner-flash-trigger d-none" data-type="success" data-title="Password Reset" data-message="Your password has been successfully reset! Please sign in with your new password."></div>
    </c:if>
    <c:if test="${param.logout == 'true'}">
        <div class="sonner-flash-trigger d-none" data-type="info" data-title="Signed Out" data-message="You have been safely logged out."></div>
    </c:if>

    <div class="auth-container">
        <div class="auth-card">
            <!-- Brand & Header -->
            <div class="text-center mb-4">
                <a href="${pageContext.request.contextPath}/" class="auth-brand">
                    <i class="bi bi-mortarboard-fill"></i>
                    <span>UniTRS</span>
                </a>
                <div class="auth-subtitle">Sign in to your university portal</div>
            </div>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/auth/login" method="POST" id="loginForm">
                <div class="mb-3">
                    <label for="identifier" class="form-label-dark">Email or Student ID</label>
                    <div class="input-group-dark">
                        <span class="input-icon-dark"><i class="bi bi-person-badge"></i></span>
                        <input type="text" class="form-control-dark" id="identifier" name="identifier"
                               placeholder="e.g. 60240512 or user@unitrs.edu" required autofocus value="${identifier}">
                    </div>
                </div>

                <div class="mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label for="password" class="form-label-dark mb-0">Password</label>
                        <a href="${pageContext.request.contextPath}/auth/forgot-password" class="auth-link small">
                            Forgot password?
                        </a>
                    </div>
                    <div class="input-group-dark">
                        <span class="input-icon-dark"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control-dark" id="password" name="password"
                               placeholder="Enter your password" required>
                        <button class="btn-toggle-eye" type="button" id="toggleLoginPassword" aria-label="Toggle password visibility">
                            <i class="bi bi-eye" id="toggleLoginPasswordIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-auth-primary mt-4 mb-3">
                    <i class="bi bi-box-arrow-in-right"></i> Sign In
                </button>

                <div class="auth-footer-text">
                    Don't have an account? 
                    <a href="${pageContext.request.contextPath}/auth/register" class="auth-link ms-1">Register Now</a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/sonner.js"></script>
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            // Check if there was a success message (e.g. successful registration)
            const successTrigger = document.querySelector('.sonner-flash-trigger[data-type="success"]');
            if (successTrigger) {
                // Clear the register form cache
                localStorage.removeItem('reg_identifier');
                localStorage.removeItem('reg_firstName');
                localStorage.removeItem('reg_lastName');
                localStorage.removeItem('reg_fullName');
                localStorage.removeItem('reg_email');
                localStorage.removeItem('reg_majorSelect');
                localStorage.removeItem('reg_majorInput');
            }

            // Restore login identifier only if input is currently empty
            const identifierInput = document.getElementById('identifier');
            if (identifierInput && !identifierInput.value && localStorage.getItem('login_identifier')) {
                identifierInput.value = localStorage.getItem('login_identifier');
            }

            // Save login identifier on change
            if (identifierInput) {
                identifierInput.addEventListener('input', () => {
                    localStorage.setItem('login_identifier', identifierInput.value);
                });
            }

            // Toggle password visibility
            const toggleBtn = document.getElementById('toggleLoginPassword');
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleLoginPasswordIcon');
            if (toggleBtn && passwordInput && toggleIcon) {
                toggleBtn.addEventListener('click', () => {
                    const isPassword = passwordInput.getAttribute('type') === 'password';
                    passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
                    toggleIcon.className = isPassword ? 'bi bi-eye-slash' : 'bi bi-eye';
                });
            }
        });
    </script>
</body>
</html>
