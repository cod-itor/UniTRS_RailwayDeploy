<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0d1b2a 0%, #1b2838 50%, #0d6efd 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 1rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            max-width: 420px;
            width: 100%;
            padding: 2.5rem;
        }
        .login-card .logo {
            font-size: 2rem;
            font-weight: 700;
            color: #0d6efd;
            text-align: center;
            margin-bottom: 0.25rem;
        }
        .login-card .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 2rem;
            font-size: 0.9rem;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.15);
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 0.65rem;
            font-weight: 600;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="logo"><i class="bi bi-mortarboard-fill"></i> UniTRS</div>
        <div class="subtitle">University Management System</div>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Success message (e.g., after registration) -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Logout message -->
        <c:if test="${param.logout == 'true'}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="bi bi-box-arrow-right me-2"></i>You have been logged out successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/login" method="POST">
            <div class="mb-3">
                <label for="identifier" class="form-label fw-semibold">Email or Student ID</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                    <input type="text" class="form-control" id="identifier" name="identifier"
                           placeholder="e.g. 60240512 or admin@unitrs.edu" required value="${identifier}">
                </div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter your password" required>
                    <button class="btn btn-outline-secondary" type="button" id="toggleLoginPassword" aria-label="Toggle password visibility">
                        <i class="bi bi-eye" id="toggleLoginPasswordIcon"></i>
                    </button>
                </div>
            </div>
            <div class="d-flex justify-content-end mb-3">
                <a href="${pageContext.request.contextPath}/auth/forgot-password" class="text-decoration-none small">
                    Forgot password?
                </a>
            </div>
            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
            </button>
            <div class="text-center">
                <span class="text-muted">Don't have an account?</span>
                <a href="${pageContext.request.contextPath}/auth/register" class="text-decoration-none fw-semibold ms-1">Register Now</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            // Check if there's a success alert (meaning registration was successful)
            const successAlert = document.querySelector('.alert-success');
            if (successAlert) {
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
            if (!identifierInput.value && localStorage.getItem('login_identifier')) {
                identifierInput.value = localStorage.getItem('login_identifier');
            }

            // Save login identifier on change
            identifierInput.addEventListener('input', () => {
                localStorage.setItem('login_identifier', identifierInput.value);
            });

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
