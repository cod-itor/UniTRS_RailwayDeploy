<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Verify Reset Code</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
        .otp-input {
            letter-spacing: 12px;
            font-size: 1.8rem;
            font-weight: 700;
            text-align: center;
            font-family: monospace;
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <div class="card-custom">
        <div class="logo"><i class="bi bi-shield-lock-fill"></i> UniTRS</div>
        <div class="subtitle">Step 1 of 2: Verify Your Identity</div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty info}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="bi bi-info-circle-fill me-2"></i>${info}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <p class="text-center text-muted mb-4">
            We sent a 6-digit verification code to: <br>
            <strong class="text-dark">${email}</strong>
        </p>

        <form action="${pageContext.request.contextPath}/auth/verify-reset-otp" method="POST">
            <input type="hidden" name="email" value="${email}">
            
            <div class="mb-4">
                <label for="otpCode" class="form-label fw-semibold text-center w-100">Enter 6-Digit Code</label>
                <input type="text" class="form-control otp-input" id="otpCode" name="otpCode"
                       maxlength="6" placeholder="------" pattern="[0-9]{6}" required autofocus autocomplete="one-time-code">
                <div class="form-text text-center">Code expires in 10 minutes.</div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                <i class="bi bi-arrow-right-circle me-1"></i> Verify & Continue to Password Reset
            </button>
        </form>

        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
            <form action="${pageContext.request.contextPath}/auth/resend-reset-otp" method="POST" class="d-inline">
                <input type="hidden" name="email" value="${email}">
                <button type="submit" class="btn btn-link p-0 text-decoration-none small">
                    <i class="bi bi-arrow-repeat me-1"></i> Resend Code
                </button>
            </form>
            <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none small text-muted">
                Cancel
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
