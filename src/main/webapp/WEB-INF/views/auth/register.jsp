<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Register</title>
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
            padding: 2rem 0;
        }
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 1rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            max-width: 550px;
            width: 100%;
            padding: 2.5rem;
        }
        .register-card .logo {
            font-size: 2rem;
            font-weight: 700;
            color: #0d6efd;
            text-align: center;
            margin-bottom: 0.25rem;
        }
        .register-card .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 2rem;
            font-size: 0.9rem;
        }
        .form-control:focus, .form-select:focus {
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
        
        /* Validation Styles */
        .validation-message {
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        .text-success-custom { color: #198754; }
        .text-danger-custom { color: #dc3545; }
        .text-warning-custom { color: #ffc107; }
        
        /* Password Strength Meter */
        .password-strength-container {
            margin-top: 0.5rem;
            font-size: 0.8rem;
        }
        .strength-bar-container {
            height: 4px;
            background-color: #e9ecef;
            border-radius: 2px;
            margin-bottom: 0.5rem;
            overflow: hidden;
            display: flex;
        }
        .strength-bar-segment {
            height: 100%;
            flex: 1;
            transition: background-color 0.3s ease;
        }
        .strength-bar-segment:not(:last-child) {
            border-right: 1px solid white;
        }
        .rule-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.25rem;
        }
        .rule-list li {
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        .rule-list li i { font-size: 0.9rem; }
        .rule-met { color: #198754 !important; }
        .rule-unmet { color: #dc3545 !important; }
    </style>
</head>
<body>
    <div class="register-card">
        <div class="logo"><i class="bi bi-mortarboard-fill"></i> Create Student Account</div>
        <div class="subtitle">Join University Management System</div>

        <!-- Error message (e.g. duplicate full name or duplicate student ID from database) -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="POST" id="registerForm">
            <!-- Student ID -->
            <div class="mb-3">
                <label for="identifier" class="form-label fw-semibold">Student ID <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                    <input type="text" class="form-control" id="identifier" name="identifier"
                           placeholder="e.g. 60240512" maxlength="8" required autocomplete="off" value="${identifier}">
                </div>
                <div id="identifierValidation" class="validation-message text-muted">
                    Must be an 8-digit Student ID (numbers only, e.g. 60240512).
                </div>
            </div>
            
            <!-- Separate First Name and Last Name -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="firstName" class="form-label fw-semibold">First Name <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" id="firstName" name="firstName"
                               placeholder="e.g. Sok" required autocomplete="off" value="${firstName}">
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="lastName" class="form-label fw-semibold">Last Name <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                        <input type="text" class="form-control" id="lastName" name="lastName"
                               placeholder="e.g. Dara" required autocomplete="off" value="${lastName}">
                    </div>
                </div>
            </div>
            <input type="hidden" id="fullName" name="fullName" value="${fullName}">
            
            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" class="form-control" id="email" name="email"
                           placeholder="name@gmail.com or name@unitrs.edu" required autocomplete="off" value="${email}">
                </div>
                <div id="emailValidation" class="validation-message text-muted">
                    Make sure the email can receive messages because you need to verify it.
                </div>
            </div>
            
            <!-- Major -->
            <div class="mb-3">
                <label for="majorSelect" class="form-label fw-semibold">Major (Optional)</label>
                <div class="input-group mb-2">
                    <span class="input-group-text"><i class="bi bi-book"></i></span>
                    <select class="form-select" id="majorSelect" name="majorSelect">
                        <option value="">-- Select Major --</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Information Technology">Information Technology</option>
                        <option value="Software Engineering">Software Engineering</option>
                        <option value="Business Administration">Business Administration</option>
                        <option value="Accounting">Accounting</option>
                        <option value="Other">Other (Please specify)</option>
                    </select>
                </div>
                <input type="text" class="form-control d-none" id="majorInput" name="majorInput" placeholder="Enter your major">
            </div>
            
            <!-- Password with Show/Hide Toggle -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="password" class="form-label fw-semibold">Password <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePasswordBtn" aria-label="Toggle password visibility">
                            <i class="bi bi-eye" id="togglePasswordIcon"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="confirmPassword" class="form-label fw-semibold">Confirm <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        <button class="btn btn-outline-secondary" type="button" id="toggleConfirmBtn" aria-label="Toggle password visibility">
                            <i class="bi bi-eye" id="toggleConfirmIcon"></i>
                        </button>
                    </div>
                    <div id="confirmValidation" class="validation-message"></div>
                </div>
            </div>
            
            <!-- Password Strength -->
            <div class="password-strength-container mb-4">
                <div class="strength-bar-container">
                    <div class="strength-bar-segment" id="seg1"></div>
                    <div class="strength-bar-segment" id="seg2"></div>
                    <div class="strength-bar-segment" id="seg3"></div>
                    <div class="strength-bar-segment" id="seg4"></div>
                </div>
                <ul class="rule-list">
                    <li id="rule-len"><i class="bi bi-circle"></i> 8-64 characters</li>
                    <li id="rule-upper"><i class="bi bi-circle"></i> Uppercase letter</li>
                    <li id="rule-lower"><i class="bi bi-circle"></i> Lowercase letter</li>
                    <li id="rule-num"><i class="bi bi-circle"></i> Number</li>
                    <li id="rule-spec"><i class="bi bi-circle"></i> Special character</li>
                </ul>
            </div>
            
            <button type="submit" class="btn btn-primary w-100 mb-3" id="submitBtn">
                <i class="bi bi-person-plus me-2"></i>Register
            </button>
            <div class="text-center">
                <span class="text-muted">Already have an account?</span>
                <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none fw-semibold ms-1">Sign In</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        
        // Form Elements
        const identifierInput = document.getElementById('identifier');
        const identifierVal = document.getElementById('identifierValidation');
        
        const firstNameInput = document.getElementById('firstName');
        const lastNameInput = document.getElementById('lastName');
        const fullNameInput = document.getElementById('fullName');
        
        const emailInput = document.getElementById('email');
        const emailVal = document.getElementById('emailValidation');
        
        const majorSelect = document.getElementById('majorSelect');
        const majorInput = document.getElementById('majorInput');
        
        const passwordInput = document.getElementById('password');
        const confirmInput = document.getElementById('confirmPassword');
        const confirmVal = document.getElementById('confirmValidation');
        
        const submitBtn = document.getElementById('submitBtn');
        const registerForm = document.getElementById('registerForm');
        
        // Handle server-side major restoration
        const serverMajor = '${major}';
        if (serverMajor) {
            const options = Array.from(majorSelect.options).map(opt => opt.value);
            if (options.includes(serverMajor)) {
                majorSelect.value = serverMajor;
            } else {
                majorSelect.value = 'Other';
                majorInput.value = serverMajor;
                majorInput.classList.remove('d-none');
                majorInput.required = true;
            }
        }

        // --- Helper ---
        function setValidationMsg(el, msg, colorClass, iconClass) {
            el.className = 'validation-message ' + colorClass;
            el.innerHTML = iconClass ? `<i class="bi ${iconClass}"></i> ${msg}` : msg;
        }

        // --- Student ID Real-Time Input Filter (Numbers only warning) ---
        identifierInput.addEventListener('input', () => {
            const rawVal = identifierInput.value.trim();
            if (!rawVal) {
                setValidationMsg(identifierVal, 'Must be an 8-digit Student ID (numbers only, e.g. 60240512).', 'text-muted', '');
                return;
            }
            if (!/^\d+$/.test(rawVal)) {
                setValidationMsg(identifierVal, 'Numbers only! Letters and special characters are not allowed.', 'text-danger-custom', 'bi-x-circle');
            } else if (rawVal.length < 8) {
                setValidationMsg(identifierVal, 'Student ID must be 8 digits (current: ' + rawVal.length + '/8)', 'text-warning-custom', 'bi-info-circle');
            } else {
                setValidationMsg(identifierVal, '8-digit Student ID format valid', 'text-success-custom', 'bi-check-circle');
            }
        });

        // --- Email Input Formatting Helper ---
        emailInput.addEventListener('input', () => {
            const val = emailInput.value.trim().toLowerCase();
            if (!val) {
                setValidationMsg(emailVal, 'Make sure the email can receive messages because you need to verify it.', 'text-muted', '');
                return;
            }
            if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(val)) {
                setValidationMsg(emailVal, 'Please enter a valid email format', 'text-warning-custom', 'bi-info-circle');
            } else if (!val.endsWith('@gmail.com') && !val.endsWith('.edu')) {
                setValidationMsg(emailVal, 'Must be a @gmail.com or .edu address', 'text-danger-custom', 'bi-x-circle');
            } else {
                setValidationMsg(emailVal, 'Valid email format', 'text-success-custom', 'bi-check-circle');
            }
        });

        // --- Major Handling ---
        majorSelect.addEventListener('change', () => {
            if (majorSelect.value === 'Other') {
                majorInput.classList.remove('d-none');
                majorInput.required = true;
            } else {
                majorInput.classList.add('d-none');
                majorInput.required = false;
                majorInput.value = '';
            }
        });

        // --- Show / Hide Password Toggles ---
        function setupPasswordToggle(btnId, inputId, iconId) {
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
        setupPasswordToggle('togglePasswordBtn', 'password', 'togglePasswordIcon');
        setupPasswordToggle('toggleConfirmBtn', 'confirmPassword', 'toggleConfirmIcon');

        // --- Password Strength ---
        function checkPasswordRules(val) {
            return {
                len: val.length >= 8 && val.length <= 64,
                upper: /[A-Z]/.test(val),
                lower: /[a-z]/.test(val),
                num: /[0-9]/.test(val),
                spec: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?~`]/.test(val)
            };
        }

        function isPasswordValid(val) {
            if (!val || val.trim() === '') return false;
            const r = checkPasswordRules(val);
            return r.len && r.upper && r.lower && r.num && r.spec;
        }

        passwordInput.addEventListener('input', () => {
            const val = passwordInput.value;
            const checks = checkPasswordRules(val);

            let score = 0;
            for (let key in checks) {
                const el = document.getElementById('rule-' + key);
                const icon = el.querySelector('i');
                if (checks[key]) {
                    el.classList.add('rule-met');
                    el.classList.remove('rule-unmet');
                    icon.className = 'bi bi-check-circle-fill';
                    score++;
                } else {
                    el.classList.remove('rule-met');
                    if (val.length > 0) el.classList.add('rule-unmet');
                    icon.className = val.length > 0 ? 'bi bi-x-circle-fill' : 'bi bi-circle';
                }
            }
            
            if (val.trim() === '') score = 0;

            const segments = ['seg1', 'seg2', 'seg3', 'seg4'];
            const colors = ['#dc3545', '#ffc107', '#0dcaf0', '#198754'];
            
            segments.forEach((seg, i) => {
                const el = document.getElementById(seg);
                if (i < score - 1 || (score === 5 && i === 3)) {
                    el.style.backgroundColor = colors[Math.max(0, score - 2)];
                } else {
                    el.style.backgroundColor = 'transparent';
                }
            });
            
            validateConfirm();
        });

        // --- Confirm Password ---
        confirmInput.addEventListener('input', validateConfirm);

        function validateConfirm() {
            const val = confirmInput.value;
            const target = passwordInput.value;
            if (!val) {
                confirmVal.innerHTML = '';
            } else if (val === target) {
                setValidationMsg(confirmVal, 'Passwords match', 'text-success-custom', 'bi-check-circle');
            } else {
                setValidationMsg(confirmVal, 'Passwords do not match', 'text-danger-custom', 'bi-x-circle');
            }
        }

        // --- Form Submit Check: Validate & Submit to Database ---
        registerForm.addEventListener('submit', (e) => {
            const rawId = identifierInput.value.trim();
            if (!rawId || !/^\d{8}$/.test(rawId)) {
                e.preventDefault();
                alert("Please provide a valid 8-digit Student ID (numbers only, e.g. 60240512).");
                identifierInput.focus();
                return;
            }

            const first = firstNameInput.value.trim();
            const last = lastNameInput.value.trim();
            if (!first || !last) {
                e.preventDefault();
                alert("Please provide both First Name and Last Name.");
                if (!first) firstNameInput.focus();
                else lastNameInput.focus();
                return;
            }

            if (!/^[a-zA-Z\s'-]+$/.test(first) || !/^[a-zA-Z\s'-]+$/.test(last)) {
                e.preventDefault();
                alert("First and Last Name can only contain letters, spaces, hyphens, and apostrophes.");
                return;
            }

            const emailVal = emailInput.value.trim().toLowerCase();
            if (!emailVal || !/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(emailVal) || (!emailVal.endsWith('@gmail.com') && !emailVal.endsWith('.edu'))) {
                e.preventDefault();
                alert("Please provide a valid @gmail.com or .edu email address.");
                emailInput.focus();
                return;
            }

            if (!isPasswordValid(passwordInput.value)) {
                e.preventDefault();
                alert("Please satisfy all password complexity requirements (8-64 characters, uppercase, lowercase, number, and special character).");
                passwordInput.focus();
                return;
            }

            if (passwordInput.value !== confirmInput.value) {
                e.preventDefault();
                alert("Passwords do not match.");
                confirmInput.focus();
                return;
            }

            if (majorSelect.value === 'Other' && !majorInput.value.trim()) {
                e.preventDefault();
                alert("Please specify your major.");
                majorInput.focus();
                return;
            }

            // Sync fullName before submitting to server
            fullNameInput.value = (first + ' ' + last).replace(/\s+/g, ' ').trim();

            // Map major safely without creating duplicate hidden inputs
            let finalMajor = document.getElementById('finalMajorInput');
            if (!finalMajor) {
                finalMajor = document.createElement('input');
                finalMajor.type = 'hidden';
                finalMajor.name = 'major';
                finalMajor.id = 'finalMajorInput';
                registerForm.appendChild(finalMajor);
            }
            finalMajor.value = majorSelect.value === 'Other' ? majorInput.value.trim() : majorSelect.value;
        });

        // --- Local Storage & Autofill Management ---
        window.addEventListener('DOMContentLoaded', () => {
            if (!identifierInput.value && localStorage.getItem('reg_identifier')) {
                identifierInput.value = localStorage.getItem('reg_identifier');
            }
            if (!firstNameInput.value && localStorage.getItem('reg_firstName')) {
                firstNameInput.value = localStorage.getItem('reg_firstName');
            }
            if (!lastNameInput.value && localStorage.getItem('reg_lastName')) {
                lastNameInput.value = localStorage.getItem('reg_lastName');
            }
            if (!emailInput.value && localStorage.getItem('reg_email')) {
                emailInput.value = localStorage.getItem('reg_email');
            }
            if (!majorSelect.value && localStorage.getItem('reg_majorSelect')) {
                majorSelect.value = localStorage.getItem('reg_majorSelect');
                majorSelect.dispatchEvent(new Event('change'));
            }
            if (!majorInput.value && localStorage.getItem('reg_majorInput')) {
                majorInput.value = localStorage.getItem('reg_majorInput');
            }
        });

        // Save values on change
        identifierInput.addEventListener('input', () => localStorage.setItem('reg_identifier', identifierInput.value));
        firstNameInput.addEventListener('input', () => localStorage.setItem('reg_firstName', firstNameInput.value));
        lastNameInput.addEventListener('input', () => localStorage.setItem('reg_lastName', lastNameInput.value));
        emailInput.addEventListener('input', () => localStorage.setItem('reg_email', emailInput.value));
        majorSelect.addEventListener('change', () => localStorage.setItem('reg_majorSelect', majorSelect.value));
        majorInput.addEventListener('input', () => localStorage.setItem('reg_majorInput', majorInput.value));
    </script>
</body>
</html>
