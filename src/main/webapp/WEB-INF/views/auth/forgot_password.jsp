<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Forgot Password</title>
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
        <div class="sonner-flash-trigger d-none" data-type="error" data-title="Request Failed" data-message="<c:out value='${error}' />"></div>
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
                        <i class="bi bi-key-fill"></i> Step 1 of 2 &bull; Account Recovery
                    </span>
                </div>
                <div class="auth-subtitle mb-3">Reset Your Password</div>
            </div>

            <div class="auth-info-box">
                <i class="bi bi-info-circle-fill"></i>
                <div>
                    Enter your university email address and we'll send a 6-digit OTP code to verify your identity.
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/auth/forgot-password" method="POST">
                <div class="mb-4">
                    <label for="email" class="form-label-dark">Email Address</label>
                    <div class="input-group-dark">
                        <span class="input-icon-dark"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" class="form-control-dark" id="email" name="email"
                               placeholder="user@unitrs.edu" required autofocus value="${email}">
                    </div>
                </div>

                <button type="submit" class="btn-auth-primary mb-3">
                    <i class="bi bi-send-fill"></i> Send Reset Code
                </button>

                <div class="text-center mt-3 pt-3 border-top border-secondary border-opacity-25">
                    <a href="${pageContext.request.contextPath}/auth/login" class="auth-link small">
                        <i class="bi bi-arrow-left me-1"></i> Back to Sign In
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/sonner.js"></script>
</body>
</html>
