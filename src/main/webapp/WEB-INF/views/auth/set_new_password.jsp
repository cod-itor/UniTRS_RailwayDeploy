<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Set New Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0d1b2a 0%, #1b2838 50%, #0d6efd 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }
        .card-custom {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 1rem;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.3);
            max-width: 440px;
            width: 100%;
            padding: 2.5rem;
        }
        .logo {
            font-size: 2rem;
            font-weight: 700;
            color: #0d6efd;
            text-align: center;
        }
        .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="card-custom">
        <div class="logo"><i class="bi bi-shield-check"></i> UniTRS</div>
        <div class="subtitle">Step 2 of 2: Create New Password</div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="alert alert-success py-2 text-center mb-4">
            <i class="bi bi-check-circle-fill me-1"></i> Identity verified for <strong>${email}</strong>
        </div>

        <form action="${pageContext.request.contextPath}/auth/set-new-password" method="POST">
            <div class="mb-3">
                <label for="password" class="form-label fw-semibold">New Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Min 8 chars, uppercase, lowercase, digit, symbol" required autofocus>
                    <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword" aria-label="Toggle password visibility">
                        <i class="bi bi-eye" id="toggleNewPasswordIcon"></i>
                    </button>
                </div>
            </div>

            <div class="mb-4">
                <label for="confirmPassword" class="form-label fw-semibold">Confirm New Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-check2-circle"></i></span>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                           placeholder="Re-enter new password" required>
                    <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword" aria-label="Toggle password visibility">
                        <i class="bi bi-eye" id="toggleConfirmPasswordIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                <i class="bi bi-check-lg me-1"></i> Save Password & Sign In
            </button>
        </form>

        <div class="text-center mt-3 pt-3 border-top">
            <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none small text-muted">
                Cancel & Return to Sign In
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function setupToggle(btnId, inputId, iconId) {
            const btn = document.getElementById(btnId);
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            if (btn && input && icon) {
                btn.addEventListener('click', () => {
                    const isPwd = input.getAttribute('type') === 'password';
                    input.setAttribute('type', isPwd ? 'text' : 'password');
                    icon.className = isPwd ? 'bi bi-eye-slash' : 'bi bi-eye';
                });
            }
        }
        setupToggle('toggleNewPassword', 'password', 'toggleNewPasswordIcon');
        setupToggle('toggleConfirmPassword', 'confirmPassword', 'toggleConfirmPasswordIcon');
    </script>
</body>
</html>
