<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Forgot Password</title>
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
        <div class="logo"><i class="bi bi-key-fill"></i> UniTRS</div>
        <div class="subtitle">Reset Your Password</div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <p class="text-muted text-center mb-4">
            Enter the email address associated with your UniTRS account and we will send you a 6-digit OTP code to reset your password.
        </p>

        <form action="${pageContext.request.contextPath}/auth/forgot-password" method="POST">
            <div class="mb-4">
                <label for="email" class="form-label fw-semibold">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                    <input type="email" class="form-control" id="email" name="email"
                           placeholder="student@unitrs.edu" required autofocus value="${email}">
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                <i class="bi bi-send-fill me-1"></i> Send Password Reset Code
            </button>
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none small text-muted">
                    <i class="bi bi-arrow-left me-1"></i> Back to Sign In
                </a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
