<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Verify Email & Complete Registration</title>
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
            padding: 1.5rem 1rem;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .card-custom {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 1.25rem;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.35);
            max-width: 460px;
            width: 100%;
            padding: 2.25rem;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .logo {
            font-size: 1.85rem;
            font-weight: 700;
            color: #0d6efd;
            text-align: center;
            letter-spacing: -0.5px;
        }
        .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 1.25rem;
            font-size: 0.92rem;
        }
        .otp-input {
            letter-spacing: 14px;
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            color: #0d6efd;
            border: 2px solid #ced4da;
            border-radius: 0.75rem;
            padding: 0.65rem 0.5rem 0.65rem 1rem;
            transition: all 0.2s ease-in-out;
        }
        .otp-input:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.2);
            outline: none;
        }
        .email-display-box {
            background-color: #f8f9fa;
            border: 1px dashed #dee2e6;
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
        }
        .success-icon-wrapper {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.25rem;
            background: rgba(25, 135, 84, 0.12);
            border: 3px solid rgba(25, 135, 84, 0.25);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        @keyframes popIn {
            0% { transform: scale(0.5); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
        .redirect-box {
            background: rgba(13, 110, 253, 0.08);
            border: 1px solid rgba(13, 110, 253, 0.2);
            border-radius: 0.75rem;
            padding: 1rem;
        }
        .progress-bar-redirect {
            height: 6px;
            border-radius: 3px;
            transition: width 2.5s linear;
        }
    </style>
</head>
<body>
    <div class="card-custom">
        <!-- OTP Input Section -->
        <div id="otpInputSection" class="${verifiedSuccess ? 'd-none' : ''}">
            <div class="logo"><i class="bi bi-shield-check"></i> UniTRS</div>
            <div class="subtitle">Account Verification</div>

            <div id="ajaxAlertContainer">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${param.unverified == 'true'}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2"></i>Your account is not verified yet. A verification code has been sent to your email.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty info}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <i class="bi bi-info-circle-fill me-2"></i>${info}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
            </div>

            <div class="email-display-box text-center mb-4">
                <div class="text-muted small mb-1"><i class="bi bi-envelope-at me-1"></i>Verification code sent to:</div>
                <strong class="text-dark fs-6" id="targetEmailText"><c:out value="${email}" /></strong>
            </div>

            <form id="otpForm" action="${pageContext.request.contextPath}/auth/verify-registration" method="POST">
                <input type="hidden" id="emailPayload" name="email" value="${email}">
                
                <div class="mb-3">
                    <label for="otpCode" class="form-label fw-semibold text-center w-100 mb-2">
                        Enter 6-Digit Code
                    </label>
                    <input type="text" class="form-control otp-input" id="otpCode" name="otpCode"
                           maxlength="6" placeholder="------" pattern="[0-9]{6}" required autofocus autocomplete="one-time-code">
                    <div class="form-text text-center mt-2 text-muted small">
                        <i class="bi bi-clock me-1"></i>Code expires in 10 minutes.
                    </div>
                </div>

                <button type="submit" id="verifyBtn" class="btn btn-primary w-100 py-2 fw-semibold mb-3 shadow-sm">
                    <i class="bi bi-check2-circle me-1"></i> Verify & Complete Registration
                </button>
            </form>

            <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                <button type="button" id="resendBtn" class="btn btn-link p-0 text-decoration-none small text-primary">
                    <i class="bi bi-arrow-repeat me-1"></i> <span id="resendBtnText">Resend Code</span>
                </button>
                <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none small text-muted">
                    <i class="bi bi-arrow-left me-1"></i> Back to Sign In
                </a>
            </div>
        </div>

        <!-- Success Section (Shown after valid OTP) -->
        <div id="successSection" class="${verifiedSuccess ? '' : 'd-none'} text-center">
            <div class="success-icon-wrapper">
                <i class="bi bi-check-lg text-success" style="font-size: 2.75rem;"></i>
            </div>
            
            <h4 class="fw-bold text-dark mb-1">Account Created Successfully!</h4>
            <p class="text-muted small mb-3">Your email has been verified successfully.</p>

            <div class="p-3 bg-light rounded-3 text-start mb-3 border">
                <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom">
                    <span class="text-muted small">Email Address</span>
                    <span class="fw-semibold small text-break"><c:out value="${email}" /></span>
                </div>
                <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom">
                    <span class="text-muted small">Email Status</span>
                    <span class="badge bg-success-subtle text-success border border-success px-2 py-1">
                        <i class="bi bi-check2 me-1"></i>Verified
                    </span>
                </div>
                <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom">
                    <span class="text-muted small">Account Status</span>
                    <span class="badge bg-warning text-dark px-2 py-1">
                        <i class="bi bi-hourglass-split me-1"></i>Pending Admin Approval
                    </span>
                </div>
                <div class="text-muted small mt-2">
                    <i class="bi bi-info-circle me-1 text-primary"></i>Your registration has been queued for administrator review. You will receive an email once your requested role has been authorized.
                </div>
            </div>

            <div class="redirect-box mb-3 text-center">
                <div class="d-flex align-items-center justify-content-center gap-2 mb-2">
                    <div class="spinner-border spinner-border-sm text-primary" role="status"></div>
                    <span class="fw-semibold text-primary small">
                        Redirecting to Sign In in <span id="countdown">2</span>s...
                    </span>
                </div>
                <div class="progress" style="height: 6px; background-color: rgba(13, 110, 253, 0.15);">
                    <div id="redirectProgress" class="progress-bar bg-primary progress-bar-striped progress-bar-animated progress-bar-redirect" style="width: 0%;"></div>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-primary w-100 py-2 fw-semibold">
                <i class="bi bi-box-arrow-in-right me-1"></i> Sign In Now
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const isServerVerified = ${verifiedSuccess ? 'true' : 'false'};

        const otpInputSection = document.getElementById('otpInputSection');
        const successSection = document.getElementById('successSection');
        const otpForm = document.getElementById('otpForm');
        const otpCodeInput = document.getElementById('otpCode');
        const emailPayload = document.getElementById('emailPayload');
        const verifyBtn = document.getElementById('verifyBtn');
        const resendBtn = document.getElementById('resendBtn');
        const resendBtnText = document.getElementById('resendBtnText');
        const alertContainer = document.getElementById('ajaxAlertContainer');

        function showAlert(message, type) {
            alertContainer.innerHTML =
                '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                '<i class="bi ' + (type === 'danger' ? 'bi-exclamation-triangle-fill' : 'bi-info-circle-fill') + ' me-2"></i>' +
                message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>';
        }

        function triggerSuccessFlow() {
            if (otpInputSection) otpInputSection.classList.add('d-none');
            if (successSection) successSection.classList.remove('d-none');

            const progressBar = document.getElementById('redirectProgress');
            const countdownEl = document.getElementById('countdown');

            if (progressBar) {
                setTimeout(() => {
                    progressBar.style.width = '100%';
                }, 50);
            }

            let timeLeft = 2;
            const timer = setInterval(() => {
                timeLeft--;
                if (countdownEl && timeLeft >= 0) {
                    countdownEl.textContent = timeLeft;
                }
                if (timeLeft <= 0) {
                    clearInterval(timer);
                }
            }, 1000);

            setTimeout(() => {
                window.location.href = contextPath + "/auth/login";
            }, 2500);
        }

        if (isServerVerified) {
            triggerSuccessFlow();
        }

        otpForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const code = otpCodeInput.value.trim();
            const email = emailPayload.value.trim();

            if (!code || code.length !== 6 || !/^\d{6}$/.test(code)) {
                showAlert('Please enter a valid 6-digit verification code.', 'danger');
                otpCodeInput.focus();
                return;
            }

            verifyBtn.disabled = true;
            const originalBtnText = verifyBtn.innerHTML;
            verifyBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status"></span>Verifying...';

            try {
                const formData = new URLSearchParams();
                formData.append('email', email);
                formData.append('otpCode', code);

                const response = await fetch(contextPath + "/auth/verify-registration", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest',
                        'Accept': 'application/json'
                    },
                    body: formData.toString()
                });

                const data = await response.json().catch(() => null);

                if (response.ok && data && data.status === 'success') {
                    triggerSuccessFlow();
                } else {
                    const errMsg = (data && data.message) ? data.message : 'Invalid or expired verification code. Please check your code or request a new one.';
                    showAlert(errMsg, 'danger');
                    verifyBtn.disabled = false;
                    verifyBtn.innerHTML = originalBtnText;
                    otpCodeInput.select();
                }
            } catch (err) {
                console.error('OTP verification error:', err);
                showAlert('Network error occurred. Please try again.', 'danger');
                verifyBtn.disabled = false;
                verifyBtn.innerHTML = originalBtnText;
            }
        });

        // Auto-submit when user finishes typing the 6th digit
        otpCodeInput.addEventListener('input', () => {
            const val = otpCodeInput.value.trim();
            if (val.length === 6 && /^\d{6}$/.test(val)) {
                otpForm.requestSubmit();
            }
        });

        // Resend OTP with cooldown
        let resendCooldown = 0;
        let cooldownInterval = null;

        resendBtn.addEventListener('click', async () => {
            if (resendCooldown > 0) return;

            const email = emailPayload.value.trim();
            if (!email) {
                showAlert('Email address is missing. Please return to registration.', 'danger');
                return;
            }

            resendBtn.disabled = true;
            resendBtnText.textContent = 'Sending...';

            try {
                const formData = new URLSearchParams();
                formData.append('email', email);

                const response = await fetch(contextPath + "/auth/resend-registration-otp", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest',
                        'Accept': 'application/json'
                    },
                    body: formData.toString()
                });

                const data = await response.json().catch(() => null);

                if (response.ok && data && data.status === 'success') {
                    showAlert('A new verification code has been sent to your email.', 'info');
                } else {
                    showAlert('A new verification code has been sent to your email.', 'info');
                }
            } catch (err) {
                showAlert('A new verification code has been sent to your email.', 'info');
            }

            resendCooldown = 30;
            resendBtnText.textContent = "Resend (" + resendCooldown + "s)";
            cooldownInterval = setInterval(() => {
                resendCooldown--;
                if (resendCooldown > 0) {
                    resendBtnText.textContent = "Resend (" + resendCooldown + "s)";
                } else {
                    clearInterval(cooldownInterval);
                    resendBtn.disabled = false;
                    resendBtnText.textContent = 'Resend Code';
                }
            }, 1000);
        });
    </script>
</body>
</html>
