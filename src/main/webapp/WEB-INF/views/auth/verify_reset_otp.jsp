<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Verify Reset Code</title>
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
        <div class="sonner-flash-trigger d-none" data-type="error" data-title="Verification Failed" data-message="<c:out value='${error}' />"></div>
    </c:if>
    <c:if test="${not empty info}">
        <div class="sonner-flash-trigger d-none" data-type="info" data-title="Code Sent" data-message="<c:out value='${info}' />"></div>
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
                        <i class="bi bi-shield-lock-fill"></i> Step 2 of 2 &bull; Verify OTP
                    </span>
                </div>
                <div class="auth-subtitle mb-3">Enter Verification Code</div>
            </div>

            <div class="auth-info-box">
                <i class="bi bi-envelope-check-fill"></i>
                <div>
                    If an account is associated with this email, a verification code has been sent to:<br>
                    <strong class="text-white">${email}</strong>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/auth/verify-reset-otp" method="POST">
                <input type="hidden" name="email" value="${email}">
                
                <div class="mb-4 text-center">
                    <label for="otpCode" class="form-label-dark">6-Digit Code</label>
                    <input type="text" class="form-control otp-input-dark" id="otpCode" name="otpCode"
                           maxlength="6" placeholder="------" pattern="[0-9]{6}" required autofocus autocomplete="one-time-code">
                    <div class="form-text text-secondary mt-2 small">This code will expire in 10 minutes.</div>
                </div>

                <button type="submit" class="btn-auth-primary mb-3">
                    <i class="bi bi-arrow-right-circle"></i> Verify & Continue
                </button>
            </form>

            <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top border-secondary border-opacity-25">
                <form action="${pageContext.request.contextPath}/auth/resend-reset-otp" method="POST" class="d-inline">
                    <input type="hidden" name="email" value="${email}">
                    <button type="submit" class="btn btn-link p-0 auth-link small">
                        <i class="bi bi-arrow-repeat me-1"></i> Resend Code
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/auth/login" class="text-muted text-decoration-none small">
                    Cancel
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/sonner.js"></script>
</body>
</html>
