<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Verify Email &amp; Complete Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/sonner.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        .success-icon-wrapper {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.25rem;
            background: rgba(16, 185, 129, 0.15);
            border: 2px solid rgba(16, 185, 129, 0.35);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 25px rgba(16, 185, 129, 0.3);
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        @keyframes popIn {
            0% { transform: scale(0.5); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
        .redirect-box {
            background: rgba(79, 172, 254, 0.08);
            border: 1px solid rgba(79, 172, 254, 0.2);
            border-radius: 14px;
            padding: 1rem;
        }
        .progress-bar-redirect {
            height: 6px;
            border-radius: 3px;
            transition: width 2.5s linear;
        }
    </style>
</head>
<body class="auth-page">

    <!-- Sonner Flash Alerts -->
    <c:if test="${not empty error}">
        <div class="sonner-flash-trigger d-none" data-type="error" data-title="Verification Failed" data-message="<c:out value='${error}' />"></div>
    </c:if>
    <c:if test="${param.unverified == 'true'}">
        <div class="sonner-flash-trigger d-none" data-type="warning" data-title="Account Pending" data-message="Your account is not verified yet. A verification code has been sent to your email."></div>
    </c:if>
    <c:if test="${not empty info}">
        <div class="sonner-flash-trigger d-none" data-type="info" data-title="Code Sent" data-message="<c:out value='${info}' />"></div>
    </c:if>

    <div class="auth-container">
        <div class="auth-card">
            <!-- OTP Input Section -->
            <div id="otpInputSection" class="${verifiedSuccess ? 'd-none' : ''}">
                <div class="text-center mb-3">
                    <a href="${pageContext.request.contextPath}/" class="auth-brand">
                        <i class="bi bi-mortarboard-fill"></i>
                        <span>UniTRS</span>
                    </a>
                    <div class="d-flex justify-content-center">
                        <span class="step-badge">
                            <i class="bi bi-shield-check"></i> Account Verification
                        </span>
                    </div>
                    <div class="auth-subtitle mb-3">Verify Your Email Address</div>
                </div>

                <div id="ajaxAlertContainer"></div>

                <div class="auth-info-box">
                    <i class="bi bi-envelope-at"></i>
                    <div>
                        Verification code sent to:<br>
                        <strong class="text-white" id="targetEmailText"><c:out value="${email}" /></strong>
                    </div>
                </div>

                <form id="otpForm" action="${pageContext.request.contextPath}/auth/verify-registration" method="POST">
                    <input type="hidden" id="emailPayload" name="email" value="${email}">
                    
                    <div class="mb-4 text-center">
                        <label for="otpCode" class="form-label-dark">Enter 6-Digit Code</label>
                        <input type="text" class="form-control otp-input-dark" id="otpCode" name="otpCode"
                               maxlength="6" placeholder="------" pattern="[0-9]{6}" required autofocus autocomplete="one-time-code">
                        <div class="form-text text-secondary mt-2 small">
                            <i class="bi bi-clock me-1"></i>Code expires in 10 minutes.
                        </div>
                    </div>

                    <button type="submit" id="verifyBtn" class="btn-auth-primary mb-3">
                        <i class="bi bi-check2-circle"></i> Verify &amp; Complete Registration
                    </button>
                </form>

                <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top border-secondary border-opacity-25">
                    <button type="button" id="resendBtn" class="btn btn-link p-0 auth-link small">
                        <i class="bi bi-arrow-repeat me-1"></i> <span id="resendBtnText">Resend Code</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-muted text-decoration-none small">
                        <i class="bi bi-arrow-left me-1"></i> Back to Sign In
                    </a>
                </div>
            </div>

            <!-- Success Section (Shown after valid OTP) -->
            <div id="successSection" class="${verifiedSuccess ? '' : 'd-none'} text-center">
                <div class="success-icon-wrapper">
                    <i class="bi bi-check-lg text-success" style="font-size: 2.75rem;"></i>
                </div>
                
                <h4 class="fw-bold text-white mb-1">Account Created Successfully!</h4>
                <p class="text-muted small mb-4">Your university email has been verified.</p>

                <div class="p-3 rounded-4 text-start mb-4" style="background: rgba(255, 255, 255, 0.05); border: 1px solid var(--surface-border);">
                    <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom border-secondary border-opacity-25">
                        <span class="text-muted small">Email Address</span>
                        <span class="fw-semibold text-white small text-break"><c:out value="${email}" /></span>
                    </div>
                    <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom border-secondary border-opacity-25">
                        <span class="text-muted small">Email Status</span>
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                            <i class="bi bi-check2 me-1"></i>Verified
                        </span>
                    </div>
                    <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom border-secondary border-opacity-25">
                        <span class="text-muted small">Account Status</span>
                        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-2 py-1">
                            <i class="bi bi-hourglass-split me-1"></i>Pending Admin Approval
                        </span>
                    </div>
                    <div class="text-muted small mt-2">
                        <i class="bi bi-info-circle me-1 text-info"></i>Your registration has been queued for administrator review. You will receive an email once approved.
                    </div>
                </div>

                <div class="redirect-box mb-4 text-center">
                    <div class="d-flex align-items-center justify-content-center gap-2 mb-2">
                        <div class="spinner-border spinner-border-sm text-info" role="status"></div>
                        <span class="fw-semibold text-info small">
                            Redirecting to Sign In in <span id="countdown">2</span>s...
                        </span>
                    </div>
                    <div class="progress" style="height: 6px; background-color: rgba(255, 255, 255, 0.1);">
                        <div id="redirectProgress" class="progress-bar bg-info progress-bar-striped progress-bar-animated progress-bar-redirect" style="width: 0%;"></div>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/auth/login" class="btn-auth-primary">
                    <i class="bi bi-box-arrow-in-right"></i> Sign In Now
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/sonner.js"></script>
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

        function showAlert(message, type) {
            if (window.Sonner) {
                if (type === 'danger' || type === 'error') {
                    Sonner.error(message);
                } else if (type === 'success') {
                    Sonner.success(message);
                } else {
                    Sonner.info(message);
                }
            }
        }

        function triggerSuccessFlow() {
            if (otpInputSection) otpInputSection.classList.add('d-none');
            if (successSection) successSection.classList.remove('d-none');

            if (window.Sonner) {
                Sonner.success('Email verified successfully! Your account is pending administrator approval.', 'Verified');
            }

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
