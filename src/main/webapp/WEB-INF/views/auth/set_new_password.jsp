<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Set New Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/sonner.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
</head>
<body class="auth-page">

    <!-- Sonner Flash Alerts -->
    <c:if test="${not empty error}">
        <div class="sonner-flash-trigger d-none" data-type="error" data-title="Password Reset Failed" data-message="<c:out value='${error}' />"></div>
    </c:if>

    <div class="auth-container">
        <div class="auth-card">
            <!-- Brand & Header -->
            <div class="text-center mb-3">
                <a href="${pageContext.request.contextPath}/" class="auth-brand">
                    <i class="bi bi-mortarboard-fill"></i>
                    <span>UniTRS</span>
                </a>
                <div class="d-flex justify-content-center">
                    <span class="step-badge">
                        <i class="bi bi-shield-check"></i> Final Step &bull; Set New Password
                    </span>
                </div>
                <div class="auth-subtitle mb-3">Create Your New Password</div>
            </div>

            <div class="auth-info-box">
                <i class="bi bi-check-circle-fill text-success"></i>
                <div>
                    Identity verified for:<br>
                    <strong class="text-white">${email}</strong>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/auth/set-new-password" method="POST">
                <div class="mb-3">
                    <label for="password" class="form-label-dark">New Password</label>
                    <div class="input-group-dark">
                        <span class="input-icon-dark"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control-dark" id="password" name="password"
                               placeholder="Min 8 chars, uppercase, lowercase, number, symbol" required autofocus>
                        <button class="btn-toggle-eye" type="button" id="toggleNewPassword" aria-label="Toggle password visibility">
                            <i class="bi bi-eye" id="toggleNewPasswordIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="confirmPassword" class="form-label-dark">Confirm New Password</label>
                    <div class="input-group-dark">
                        <span class="input-icon-dark"><i class="bi bi-check2-circle"></i></span>
                        <input type="password" class="form-control-dark" id="confirmPassword" name="confirmPassword"
                               placeholder="Re-enter new password" required>
                        <button class="btn-toggle-eye" type="button" id="toggleConfirmPassword" aria-label="Toggle password visibility">
                            <i class="bi bi-eye" id="toggleConfirmPasswordIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-auth-primary mb-3">
                    <i class="bi bi-check-lg"></i> Save Password &amp; Sign In
                </button>

                <div class="text-center mt-3 pt-3 border-top border-secondary border-opacity-25">
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-muted text-decoration-none small">
                        Cancel &amp; Return to Sign In
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/sonner.js"></script>
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
