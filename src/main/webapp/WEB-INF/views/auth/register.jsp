<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - Role Selection & Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        :root {
            --dark-bg: #0d1b2a;
            --surface-bg: rgba(18, 30, 49, 0.85);
            --surface-card: rgba(255, 255, 255, 0.05);
            --surface-border: rgba(255, 255, 255, 0.12);
            --surface-hover: rgba(79, 172, 254, 0.12);
            --primary-blue: #4facfe;
            --primary-cyan: #00f2fe;
            --primary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --accent-green: #10b981;
            --accent-amber: #f59e0b;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 1rem;
            background-image: 
                radial-gradient(circle at 15% 20%, rgba(79, 172, 254, 0.18), transparent 35%),
                radial-gradient(circle at 85% 80%, rgba(0, 242, 254, 0.15), transparent 35%),
                radial-gradient(circle at 50% 50%, rgba(13, 27, 42, 0.6), transparent 70%);
            background-attachment: fixed;
        }

        .reg-container {
            max-width: 760px;
            width: 100%;
            margin: 0 auto;
        }

        .glass-panel {
            background: var(--surface-bg);
            border: 1px solid var(--surface-border);
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5), 0 0 0 1px rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .header-brand {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
        }

        .header-brand i {
            font-size: 2rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header-brand span {
            font-size: 1.6rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #ffffff;
        }

        .step-progress-wrapper {
            margin-bottom: 2rem;
        }

        .progress-bar-track {
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
            position: relative;
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .progress-bar-fill {
            height: 100%;
            background: var(--primary-gradient);
            transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 0 12px rgba(0, 242, 254, 0.6);
        }

        .step-badge {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 700;
            color: var(--primary-cyan);
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            background: rgba(0, 242, 254, 0.1);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            border: 1px solid rgba(0, 242, 254, 0.2);
        }

        .view-step {
            display: none;
            animation: fadeIn 0.35s ease-out both;
        }

        .view-step.active {
            display: block;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(12px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .step-title {
            font-size: 1.75rem;
            font-weight: 700;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            text-align: center;
        }

        .step-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
            text-align: center;
            margin-bottom: 2rem;
        }

        .role-cards-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 576px) {
            .role-cards-grid {
                grid-template-columns: 1fr;
            }
            .glass-panel {
                padding: 1.75rem;
            }
        }

        .role-card {
            background: var(--surface-card);
            border: 1.5px solid var(--surface-border);
            border-radius: 18px;
            padding: 2rem 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            user-select: none;
        }

        .role-card:hover {
            border-color: rgba(79, 172, 254, 0.6);
            background: var(--surface-hover);
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3), 0 0 20px rgba(0, 242, 254, 0.15);
        }

        .role-card.selected {
            border-color: var(--primary-cyan);
            background: rgba(0, 242, 254, 0.08);
            box-shadow: 0 0 0 2px rgba(0, 242, 254, 0.3), 0 12px 28px rgba(0, 0, 0, 0.4);
        }

        .role-icon-box {
            width: 72px;
            height: 72px;
            border-radius: 20px;
            margin: 0 auto 1.25rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.25s ease;
        }

        .role-card:hover .role-icon-box {
            transform: scale(1.08);
        }

        .role-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.4rem;
        }

        .role-desc {
            font-size: 0.85rem;
            color: var(--text-muted);
            line-height: 1.4;
        }

        .student-submenu {
            background: rgba(13, 27, 42, 0.6);
            border: 1px dashed rgba(0, 242, 254, 0.35);
            border-radius: 16px;
            padding: 1.25rem;
            margin-top: 1rem;
            display: none;
            animation: fadeIn 0.3s ease-out;
        }

        .student-submenu.open {
            display: block;
        }

        .submenu-title {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--primary-cyan);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.85rem;
            text-align: center;
        }

        .submenu-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.85rem;
        }

        @media (max-width: 576px) {
            .submenu-grid {
                grid-template-columns: 1fr;
            }
        }

        .submenu-option-btn {
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid var(--surface-border);
            border-radius: 12px;
            padding: 1rem;
            text-align: left;
            cursor: pointer;
            transition: all 0.2s ease;
            color: #ffffff;
        }

        .submenu-option-btn:hover {
            background: rgba(79, 172, 254, 0.15);
            border-color: var(--primary-cyan);
            transform: translateY(-2px);
        }

        .submenu-option-title {
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.25rem;
        }

        .submenu-option-desc {
            font-size: 0.78rem;
            color: var(--text-muted);
            margin: 0;
        }

        .search-box {
            position: relative;
            margin-bottom: 1.25rem;
        }

        .search-box i {
            position: absolute;
            left: 1.1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        .search-box input {
            padding-left: 3rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--surface-border);
            color: #ffffff;
            border-radius: 14px;
            height: 52px;
            font-size: 0.95rem;
        }

        .search-box input:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--primary-cyan);
            color: #ffffff;
            box-shadow: 0 0 0 3px rgba(0, 242, 254, 0.18);
        }

        .schools-list-container {
            max-height: 380px;
            overflow-y: auto;
            padding-right: 0.35rem;
            display: flex;
            flex-direction: column;
            gap: 0.65rem;
        }

        .schools-list-container::-webkit-scrollbar {
            width: 6px;
        }

        .schools-list-container::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.18);
            border-radius: 4px;
        }

        .school-item {
            background: var(--surface-card);
            border: 1px solid var(--surface-border);
            border-radius: 14px;
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .school-item:hover {
            background: rgba(79, 172, 254, 0.12);
            border-color: rgba(79, 172, 254, 0.5);
            transform: translateX(4px);
        }

        .school-item-name {
            font-weight: 500;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #ffffff;
        }

        .school-item i.school-icon {
            font-size: 1.25rem;
            color: var(--primary-cyan);
        }

        .school-item i.arrow-icon {
            color: var(--text-muted);
            transition: transform 0.2s;
        }

        .school-item:hover i.arrow-icon {
            color: var(--primary-cyan);
            transform: translateX(3px);
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #cbd5e1;
            margin-bottom: 0.4rem;
        }

        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--surface-border);
            color: #ffffff;
            border-radius: 12px;
            padding: 0.7rem 1rem;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--primary-cyan);
            color: #ffffff;
            box-shadow: 0 0 0 3px rgba(0, 242, 254, 0.18);
        }

        .form-select option {
            background-color: #1b2838;
            color: #ffffff;
        }

        .input-group-text {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--surface-border);
            color: var(--text-muted);
            border-radius: 12px 0 0 12px;
        }

        .input-group .form-control {
            border-radius: 0 12px 12px 0;
        }

        .input-group .btn-outline-secondary {
            border-color: var(--surface-border);
            color: var(--text-muted);
        }

        .input-group .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-color: var(--surface-border);
        }

        .strength-bar-container {
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            margin: 0.5rem 0;
            display: flex;
            overflow: hidden;
        }

        .strength-bar-segment {
            flex: 1;
            height: 100%;
            transition: background-color 0.3s ease;
        }

        .strength-bar-segment:not(:last-child) {
            border-right: 1px solid rgba(13, 27, 42, 0.6);
        }

        .rule-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.25rem;
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .rule-met {
            color: var(--accent-green) !important;
        }

        .validation-message {
            font-size: 0.78rem;
            margin-top: 0.25rem;
        }

        .btn-gradient {
            background: var(--primary-gradient);
            color: #0d1b2a;
            font-weight: 700;
            border: none;
            border-radius: 12px;
            padding: 0.85rem 1.5rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 14px rgba(0, 242, 254, 0.3);
        }

        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 242, 254, 0.45);
            color: #0d1b2a;
        }

        .btn-back {
            background: transparent;
            border: 1px solid var(--surface-border);
            color: var(--text-muted);
            border-radius: 10px;
            padding: 0.4rem 0.9rem;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-back:hover {
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.05);
        }

        .context-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(79, 172, 254, 0.12);
            border: 1px solid rgba(79, 172, 254, 0.25);
            padding: 0.35rem 0.85rem;
            border-radius: 20px;
            font-size: 0.82rem;
            font-weight: 600;
            color: var(--primary-cyan);
            margin-bottom: 1.5rem;
        }

        .success-box {
            text-align: center;
            padding: 2rem 1rem;
            animation: fadeIn 0.4s ease-out;
        }

        .success-icon-badge {
            width: 88px;
            height: 88px;
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.8rem;
        }

        .badge-pending {
            background: rgba(245, 158, 11, 0.15);
            border: 2px solid rgba(245, 158, 11, 0.4);
            color: var(--accent-amber);
            animation: pulseAmber 2.5s infinite;
        }

        .badge-success {
            background: rgba(16, 185, 129, 0.15);
            border: 2px solid rgba(16, 185, 129, 0.4);
            color: var(--accent-green);
        }

        @keyframes pulseAmber {
            0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(245, 158, 11, 0.4); }
            50% { transform: scale(1.04); box-shadow: 0 0 0 12px rgba(245, 158, 11, 0); }
        }

        .info-callout {
            background: rgba(255, 255, 255, 0.04);
            border-left: 4px solid var(--primary-cyan);
            border-radius: 8px;
            padding: 1rem 1.25rem;
            text-align: left;
            margin: 1.5rem 0 2rem;
            font-size: 0.88rem;
            color: #cbd5e1;
        }
    </style>
</head>
<body>

<div class="reg-container">
    <div class="glass-panel">
        <div class="header-brand">
            <i class="bi bi-mortarboard-fill"></i>
            <span>UniTRS</span>
        </div>

        <div class="step-progress-wrapper text-center">
            <div class="progress-bar-track">
                <div class="progress-bar-fill" id="progressFill" style="width: 25%;"></div>
            </div>
            <span class="step-badge" id="stepIndicatorBadge">
                <i class="bi bi-person-gear"></i> Step 1: Role Selection
            </span>
        </div>

        <div class="alert alert-danger d-none" id="globalErrorAlert" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <span id="globalErrorText"></span>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- STEP 1: ROLE SELECTION -->
        <div class="view-step active" id="viewStep1">
            <h2 class="step-title">Welcome! Please select your role to login.</h2>
            <p class="step-subtitle">Choose whether you are joining as an enrolled student or faculty instructor.</p>

            <div class="role-cards-grid">
                <div class="role-card" id="studentCard" onclick="handleStudentCardClick()">
                    <div class="role-icon-box" style="background: rgba(79, 172, 254, 0.12); color: var(--primary-cyan);">
                        <i class="bi bi-mortarboard"></i>
                    </div>
                    <div class="role-title">Student</div>
                    <div class="role-desc">Enrolled university students and prospective new applicants</div>
                </div>

                <div class="role-card" id="professorCard" onclick="handleProfessorCardClick()">
                    <div class="role-icon-box" style="background: rgba(16, 185, 129, 0.12); color: var(--accent-green);">
                        <i class="bi bi-briefcase"></i>
                    </div>
                    <div class="role-title">Professor</div>
                    <div class="role-desc">Academic course instructors, faculty members, and department staff</div>
                </div>
            </div>

            <!-- STEP 2: SUB-MENU -->
            <div class="student-submenu" id="studentSubmenu">
                <div class="submenu-title"><i class="bi bi-arrow-down-short"></i> Select Your Student Status</div>
                <div class="submenu-grid">
                    <div class="submenu-option-btn" id="optionNewApplicantBtn" onclick="selectStudentOption('new')">
                        <div class="submenu-option-title">
                            <i class="bi bi-stars text-warning"></i> Option A: New Applicant
                        </div>
                        <p class="submenu-option-desc">Applying for upcoming admissions or term enrollment</p>
                    </div>

                    <div class="submenu-option-btn" id="optionCurrentStudentBtn" onclick="selectStudentOption('current')">
                        <div class="submenu-option-title">
                            <i class="bi bi-building-check text-info"></i> Option B: Current Student
                        </div>
                        <p class="submenu-option-desc">Enrolled student possessing an assigned 8-digit Student ID</p>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4 pt-2">
                <span class="text-muted">Already have a UniTRS account?</span>
                <a href="${pageContext.request.contextPath}/auth/login" class="text-info text-decoration-none fw-semibold ms-1">Sign In</a>
            </div>
        </div>

        <!-- STEP 3: SCHOOL SELECTION -->
        <div class="view-step" id="viewStep3">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <button type="button" class="btn-back" onclick="navigateToStep(1)">
                    <i class="bi bi-arrow-left"></i> Back to Role
                </button>
                <span class="badge bg-secondary-subtle text-light px-3 py-2" id="step3RoleBadge">Faculty Selection</span>
            </div>

            <h2 class="step-title">Select Your Academic School</h2>
            <p class="step-subtitle">Choose your college or academic department at UniTRS</p>

            <div class="search-box">
                <i class="bi bi-search"></i>
                <input type="text" class="form-control" id="schoolSearchInput" placeholder="Search schools (e.g. Science and Technology, Business...)" autocomplete="off">
            </div>

            <div class="schools-list-container" id="schoolsListContainer">
            </div>
        </div>

        <!-- STEP 4: REGISTRATION FORMS -->
        <div class="view-step" id="viewStep4">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <button type="button" class="btn-back" id="formBackBtn" onclick="handleFormBack()">
                    <i class="bi bi-arrow-left"></i> Back
                </button>
                <div class="context-pill mb-0" id="formContextPill">
                    <i class="bi bi-shield-check"></i> <span id="formContextText">Registration Form</span>
                </div>
            </div>

            <h2 class="step-title mt-3" id="formTitleText">Create Your Account</h2>
            <p class="step-subtitle" id="formSubtitleText">Complete your registration details below.</p>

            <form id="dynamicRegForm" onsubmit="handleFormSubmit(event)" novalidate>
                <input type="hidden" id="payloadRole" name="role" value="student">
                <input type="hidden" id="payloadApplicantType" name="applicantType" value="current">
                <input type="hidden" id="payloadSchoolId" name="schoolId" value="">
                <input type="hidden" id="payloadSchoolName" name="schoolName" value="">
                <input type="hidden" id="payloadFullName" name="fullName" value="">

                <div class="mb-3 d-none" id="idFieldContainer">
                    <label for="identifierInput" class="form-label" id="idFieldLabel">Student ID <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                        <input type="text" class="form-control" id="identifierInput" name="identifier" placeholder="e.g. 60240512" maxlength="20" autocomplete="off">
                    </div>
                    <div id="identifierValidation" class="validation-message text-muted"></div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstNameInput" class="form-label">First Name <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" id="firstNameInput" name="firstName" placeholder="e.g. Sok" required autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastNameInput" class="form-label">Last Name <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                            <input type="text" class="form-control" id="lastNameInput" name="lastName" placeholder="e.g. Dara" required autocomplete="off">
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="emailInput" class="form-label">Email Address <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email" class="form-control" id="emailInput" name="email" placeholder="name@gmail.com or name@unitrs.edu" required autocomplete="off">
                    </div>
                    <div id="emailValidation" class="validation-message text-muted">Must be a valid @gmail.com or university .edu address.</div>
                </div>

                <div class="mb-3 d-none" id="majorFieldContainer">
                    <label for="majorSelect" class="form-label">Select Major <span class="text-danger">*</span></label>
                    <div class="input-group mb-2">
                        <span class="input-group-text"><i class="bi bi-book"></i></span>
                        <select class="form-select" id="majorSelect" name="majorSelect">
                            <option value="">-- Choose your major --</option>
                        </select>
                    </div>
                    <input type="text" class="form-control d-none" id="customMajorInput" name="customMajor" placeholder="Specify your major title">
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="passwordInput" class="form-label">Password <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="passwordInput" name="password" required>
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassVisibility('passwordInput', 'togglePassIcon')">
                                <i class="bi bi-eye" id="togglePassIcon"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="confirmPasswordInput" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                            <input type="password" class="form-control" id="confirmPasswordInput" name="confirmPassword" required>
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassVisibility('confirmPasswordInput', 'toggleConfirmPassIcon')">
                                <i class="bi bi-eye" id="toggleConfirmPassIcon"></i>
                            </button>
                        </div>
                        <div id="confirmValidation" class="validation-message"></div>
                    </div>
                </div>

                <div class="mb-4">
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
                        <li id="rule-spec"><i class="bi bi-circle"></i> Special symbol</li>
                    </ul>
                </div>

                <button type="submit" class="btn-gradient w-100 mb-3" id="submitBtn">
                    <i class="bi bi-person-check me-2"></i>Complete Registration
                </button>
            </form>
        </div>

        <!-- POST-REGISTRATION: NEW APPLICANT SUCCESS -->
        <div class="view-step" id="viewStepSuccessApplicant">
            <div class="success-box">
                <div class="success-icon-badge badge-pending">
                    <i class="bi bi-hourglass-split"></i>
                </div>
                <h2 class="step-title text-warning">Pending Admin Approval</h2>
                <p class="step-subtitle">Your application has been received and submitted for verification.</p>

                <div class="info-callout">
                    <div class="fw-bold mb-1 text-light"><i class="bi bi-info-circle me-1"></i> What happens next?</div>
                    <div>Your student registration is placed in the official university review queue. Once approved by an academic administrator, your default portal will be activated, and you will receive an activation email at <strong class="text-info" id="successApplicantEmail">your email</strong>.</div>
                </div>

                <div class="d-flex gap-3 justify-content-center">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn-gradient text-decoration-none">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Return to Login
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light rounded-3 px-4 py-2 text-decoration-none">
                        Home
                    </a>
                </div>
            </div>
        </div>

        <!-- POST-REGISTRATION: STANDARD SUCCESS -->
        <div class="view-step" id="viewStepSuccessStandard">
            <div class="success-box">
                <div class="success-icon-badge badge-success">
                    <i class="bi bi-check2-circle"></i>
                </div>
                <h2 class="step-title text-success">Registration Successful!</h2>
                <p class="step-subtitle">Your account profile has been created.</p>

                <div class="info-callout">
                    <div class="fw-bold mb-1 text-light"><i class="bi bi-envelope-check me-1"></i> Email Verification Sent</div>
                    <div>A one-time verification passcode has been dispatched to <strong class="text-info" id="successStandardEmail">your email</strong>. Please enter the code to verify your account credentials.</div>
                </div>

                <div class="d-flex gap-3 justify-content-center">
                    <a href="#" id="verifyEmailDirectLink" class="btn-gradient text-decoration-none">
                        <i class="bi bi-shield-check me-1"></i> Verify Email Now
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-light rounded-3 px-4 py-2 text-decoration-none">
                        Sign In
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = '${pageContext.request.contextPath}';

    const SCHOOL_CATALOG = [
        {
            id: 7,
            name: 'College of Science and Technology',
            icon: 'bi-cpu',
            majors: ['Computer Science', 'Information Technology', 'Software Engineering', 'Cybersecurity', 'Data Science']
        },
        {
            id: 12,
            name: 'School of Business',
            icon: 'bi-graph-up-arrow',
            majors: ['Business Administration', 'Accounting', 'Finance', 'Marketing', 'International Business']
        },
        {
            id: 5,
            name: 'College of Law',
            icon: 'bi-bank',
            majors: ['International Law', 'Commercial Law', 'Constitutional Law', 'Legal Studies']
        },
        {
            id: 8,
            name: 'College of Media and Communications',
            icon: 'bi-broadcast',
            majors: ['Journalism', 'Public Relations', 'Digital Media Design', 'Broadcasting']
        },
        {
            id: 3,
            name: 'College of Arts and Humanities',
            icon: 'bi-palette',
            majors: ['English Literature', 'History', 'Philosophy', 'Creative Writing']
        },
        {
            id: 4,
            name: 'College of Education',
            icon: 'bi-mortarboard',
            majors: ['Educational Leadership', 'Curriculum and Instruction', 'Higher Education']
        },
        {
            id: 9,
            name: 'College of Social Sciences',
            icon: 'bi-globe-americas',
            majors: ['Economics', 'International Relations', 'Sociology', 'Political Science']
        },
        {
            id: 10,
            name: 'School of Creative Arts',
            icon: 'bi-brush',
            majors: ['Graphic Design', 'Visual Arts', 'Music Production', 'Animation']
        },
        {
            id: 11,
            name: 'School of Foreign Languages',
            icon: 'bi-translate',
            majors: ['Professional English', 'Applied Linguistics', 'Translation Studies']
        },
        {
            id: 1,
            name: 'School of Undergraduate Studies',
            icon: 'bi-book-half',
            majors: ['General Studies', 'Interdisciplinary Studies']
        },
        {
            id: 2,
            name: 'School of Graduate Studies',
            icon: 'bi-award',
            majors: ['Advanced Computing', 'Executive MBA', 'Applied Policy']
        },
        {
            id: 13,
            name: 'The Techo Sen School of Government and International Relations',
            icon: 'bi-building-columns',
            majors: ['Public Policy', 'Diplomacy', 'Global Affairs']
        }
    ];

    const flowState = {
        step: 1,
        role: null,
        applicantType: null,
        selectedSchoolId: null,
        selectedSchoolName: null
    };

    const viewStep1 = document.getElementById('viewStep1');
    const viewStep3 = document.getElementById('viewStep3');
    const viewStep4 = document.getElementById('viewStep4');
    const viewStepSuccessApplicant = document.getElementById('viewStepSuccessApplicant');
    const viewStepSuccessStandard = document.getElementById('viewStepSuccessStandard');

    const progressFill = document.getElementById('progressFill');
    const stepIndicatorBadge = document.getElementById('stepIndicatorBadge');

    const studentCard = document.getElementById('studentCard');
    const professorCard = document.getElementById('professorCard');
    const studentSubmenu = document.getElementById('studentSubmenu');

    const schoolSearchInput = document.getElementById('schoolSearchInput');
    const schoolsListContainer = document.getElementById('schoolsListContainer');

    const dynamicRegForm = document.getElementById('dynamicRegForm');
    const formTitleText = document.getElementById('formTitleText');
    const formSubtitleText = document.getElementById('formSubtitleText');
    const formContextText = document.getElementById('formContextText');
    const formBackBtn = document.getElementById('formBackBtn');

    const payloadRole = document.getElementById('payloadRole');
    const payloadApplicantType = document.getElementById('payloadApplicantType');
    const payloadSchoolId = document.getElementById('payloadSchoolId');
    const payloadSchoolName = document.getElementById('payloadSchoolName');
    const payloadFullName = document.getElementById('payloadFullName');

    const idFieldContainer = document.getElementById('idFieldContainer');
    const idFieldLabel = document.getElementById('idFieldLabel');
    const identifierInput = document.getElementById('identifierInput');
    const identifierValidation = document.getElementById('identifierValidation');

    const firstNameInput = document.getElementById('firstNameInput');
    const lastNameInput = document.getElementById('lastNameInput');
    const emailInput = document.getElementById('emailInput');
    const emailValidation = document.getElementById('emailValidation');

    const majorFieldContainer = document.getElementById('majorFieldContainer');
    const majorSelect = document.getElementById('majorSelect');
    const customMajorInput = document.getElementById('customMajorInput');

    const passwordInput = document.getElementById('passwordInput');
    const confirmPasswordInput = document.getElementById('confirmPasswordInput');
    const confirmValidation = document.getElementById('confirmValidation');

    const submitBtn = document.getElementById('submitBtn');
    const globalErrorAlert = document.getElementById('globalErrorAlert');
    const globalErrorText = document.getElementById('globalErrorText');

    function handleStudentCardClick() {
        flowState.role = 'student';
        studentCard.classList.add('selected');
        professorCard.classList.remove('selected');
        studentSubmenu.classList.add('open');
    }

    function handleProfessorCardClick() {
        flowState.role = 'professor';
        flowState.applicantType = 'current';
        professorCard.classList.add('selected');
        studentCard.classList.remove('selected');
        studentSubmenu.classList.remove('open');
        navigateToStep(3);
    }

    function selectStudentOption(type) {
        flowState.role = 'student';
        flowState.applicantType = type;

        if (type === 'new') {
            flowState.selectedSchoolId = null;
            flowState.selectedSchoolName = null;
            navigateToStep(4);
        } else {
            navigateToStep(3);
        }
    }

    function navigateToStep(step) {
        flowState.step = step;
        hideGlobalError();

        viewStep1.classList.remove('active');
        viewStep3.classList.remove('active');
        viewStep4.classList.remove('active');
        viewStepSuccessApplicant.classList.remove('active');
        viewStepSuccessStandard.classList.remove('active');

        if (step === 1) {
            viewStep1.classList.add('active');
            progressFill.style.width = '25%';
            stepIndicatorBadge.innerHTML = '<i class="bi bi-person-gear"></i> Step 1: Role Selection';
            studentCard.classList.remove('selected');
            professorCard.classList.remove('selected');
            studentSubmenu.classList.remove('open');
        } else if (step === 3) {
            viewStep3.classList.add('active');
            progressFill.style.width = '55%';
            const roleLabel = flowState.role === 'professor' ? 'Professor' : 'Current Student';
            stepIndicatorBadge.innerHTML = "<i class=\"bi bi-building\"></i> Step 2: Select School (" + roleLabel + ")";
            document.getElementById('step3RoleBadge').textContent = roleLabel + " Track";
            renderSchoolsList();
            schoolSearchInput.value = '';
            schoolSearchInput.focus();
        } else if (step === 4) {
            viewStep4.classList.add('active');
            progressFill.style.width = '85%';
            configureFormFields();
        }
    }

    function renderSchoolsList(filter = '') {
        schoolsListContainer.innerHTML = '';
        const query = filter.trim().toLowerCase();
        const filtered = SCHOOL_CATALOG.filter(s => s.name.toLowerCase().includes(query));

        if (filtered.length === 0) {
            schoolsListContainer.innerHTML = "<div class=\"text-center py-4 text-muted\"><i class=\"bi bi-search me-2\"></i>No schools matching \"" + filter + "\".</div>";
            return;
        }

        filtered.forEach(school => {
            const item = document.createElement('div');
            item.className = 'school-item';
            item.onclick = () => selectSchool(school);
            item.innerHTML = "<div class=\"school-item-name\"><i class=\"bi " + school.icon + " school-icon\"></i><span>" + school.name + "</span></div><i class=\"bi bi-chevron-right arrow-icon\"></i>";
            schoolsListContainer.appendChild(item);
        });
    }

    schoolSearchInput.addEventListener('input', (e) => {
        renderSchoolsList(e.target.value);
    });

    function selectSchool(school) {
        flowState.selectedSchoolId = school.id;
        flowState.selectedSchoolName = school.name;
        navigateToStep(4);
    }

    function configureFormFields() {
        payloadRole.value = flowState.role;
        payloadApplicantType.value = flowState.applicantType;
        payloadSchoolId.value = flowState.selectedSchoolId || '';
        payloadSchoolName.value = flowState.selectedSchoolName || '';

        if (flowState.role === 'student' && flowState.applicantType === 'new') {
            stepIndicatorBadge.innerHTML = '<i class="bi bi-pencil-square"></i> Step 2: New Applicant Registration';
            formTitleText.textContent = 'New Applicant Registration';
            formSubtitleText.textContent = 'Fill in your basic information to begin the application process.';
            formContextText.textContent = 'Student • New Applicant';
            formBackBtn.onclick = () => navigateToStep(1);

            idFieldContainer.classList.add('d-none');
            identifierInput.required = false;
            identifierInput.value = '';

            majorFieldContainer.classList.add('d-none');
            majorSelect.required = false;

        } else if (flowState.role === 'student' && flowState.applicantType === 'current') {
            stepIndicatorBadge.innerHTML = '<i class="bi bi-pencil-square"></i> Step 3: Current Student Registration';
            formTitleText.textContent = 'Current Student Registration';
            formSubtitleText.textContent = 'Enter your 8-digit Student ID, details, and major.';
            formContextText.textContent = "Student • " + flowState.selectedSchoolName;
            formBackBtn.onclick = () => navigateToStep(3);

            idFieldContainer.classList.remove('d-none');
            idFieldLabel.innerHTML = 'Student ID <span class="text-danger">*</span>';
            identifierInput.placeholder = 'e.g. 60240512';
            identifierInput.required = true;
            identifierValidation.textContent = '8-digit Student ID (numbers only, e.g. 60240512).';

            majorFieldContainer.classList.remove('d-none');
            majorSelect.required = true;
            populateMajorsForSchool(flowState.selectedSchoolName);

        } else if (flowState.role === 'professor') {
            stepIndicatorBadge.innerHTML = '<i class="bi bi-pencil-square"></i> Step 3: Faculty Registration';
            formTitleText.textContent = 'Faculty Registration';
            formSubtitleText.textContent = 'Register your faculty account under ' + flowState.selectedSchoolName + '.';
            formContextText.textContent = "Professor • " + flowState.selectedSchoolName;
            formBackBtn.onclick = () => navigateToStep(3);

            idFieldContainer.classList.remove('d-none');
            idFieldLabel.innerHTML = 'Professor ID <span class="text-danger">*</span>';
            identifierInput.placeholder = 'e.g. 80240101';
            identifierInput.required = true;
            identifierValidation.textContent = 'Enter your assigned university Professor/Faculty ID.';

            majorFieldContainer.classList.add('d-none');
            majorSelect.required = false;
        }
    }

    function handleFormBack() {
        if (flowState.applicantType === 'new') {
            navigateToStep(1);
        } else {
            navigateToStep(3);
        }
    }

    function populateMajorsForSchool(schoolName) {
        majorSelect.innerHTML = '<option value="">-- Choose your major --</option>';
        customMajorInput.classList.add('d-none');
        customMajorInput.required = false;

        const school = SCHOOL_CATALOG.find(s => s.name === schoolName);
        const majors = (school && school.majors) ? school.majors : ['General Studies', 'Other'];

        majors.forEach(m => {
            const opt = document.createElement('option');
            opt.value = m;
            opt.textContent = m;
            majorSelect.appendChild(opt);
        });

        if (!majors.includes('Other')) {
            const otherOpt = document.createElement('option');
            otherOpt.value = 'Other';
            otherOpt.textContent = 'Other (Please specify)';
            majorSelect.appendChild(otherOpt);
        }
    }

    majorSelect.addEventListener('change', () => {
        if (majorSelect.value === 'Other') {
            customMajorInput.classList.remove('d-none');
            customMajorInput.required = true;
            customMajorInput.focus();
        } else {
            customMajorInput.classList.add('d-none');
            customMajorInput.required = false;
        }
    });

    function togglePassVisibility(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);
        if (input.type === 'password') {
            input.type = 'text';
            icon.className = 'bi bi-eye-slash';
        } else {
            input.type = 'password';
            icon.className = 'bi bi-eye';
        }
    }

    identifierInput.addEventListener('input', () => {
        const val = identifierInput.value.trim();
        if (flowState.role === 'student' && flowState.applicantType === 'current') {
            if (!val) {
                identifierValidation.className = 'validation-message text-muted';
                identifierValidation.textContent = '8-digit Student ID (numbers only, e.g. 60240512).';
            } else if (!/^\d+$/.test(val)) {
                identifierValidation.className = 'validation-message text-danger';
                identifierValidation.innerHTML = '<i class="bi bi-x-circle"></i> Numbers only! Letters and symbols are not allowed.';
            } else if (val.length < 8) {
                identifierValidation.className = 'validation-message text-warning';
                identifierValidation.innerHTML = "<i class=\"bi bi-info-circle\"></i> Student ID must be 8 digits (" + val.length + "/8)";
            } else {
                identifierValidation.className = 'validation-message text-success';
                identifierValidation.innerHTML = '<i class="bi bi-check-circle"></i> Valid 8-digit Student ID';
            }
        } else if (flowState.role === 'professor') {
            if (!val) {
                identifierValidation.className = 'validation-message text-muted';
                identifierValidation.textContent = '8-digit Faculty ID (numbers only, e.g. 80240101).';
            } else if (!/^\d+$/.test(val)) {
                identifierValidation.className = 'validation-message text-danger';
                identifierValidation.innerHTML = '<i class="bi bi-x-circle"></i> Numbers only! Letters and symbols are not allowed.';
            } else if (val.length < 8) {
                identifierValidation.className = 'validation-message text-warning';
                identifierValidation.innerHTML = "<i class=\"bi bi-info-circle\"></i> Faculty ID must be 8 digits (" + val.length + "/8)";
            } else {
                identifierValidation.className = 'validation-message text-success';
                identifierValidation.innerHTML = '<i class="bi bi-check-circle"></i> Valid 8-digit Faculty ID';
            }
        }
    });

    emailInput.addEventListener('input', () => {
        const val = emailInput.value.trim().toLowerCase();
        if (!val) {
            emailValidation.className = 'validation-message text-muted';
            emailValidation.textContent = 'Must be a valid @gmail.com or university .edu address.';
        } else if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(val)) {
            emailValidation.className = 'validation-message text-warning';
            emailValidation.innerHTML = '<i class="bi bi-info-circle"></i> Invalid email address format';
        } else if (!val.endsWith('@gmail.com') && !val.endsWith('.edu')) {
            emailValidation.className = 'validation-message text-danger';
            emailValidation.innerHTML = '<i class="bi bi-x-circle"></i> Must end in @gmail.com or .edu domain';
        } else {
            emailValidation.className = 'validation-message text-success';
            emailValidation.innerHTML = '<i class="bi bi-check-circle"></i> Valid email address';
        }
    });

    function checkPasswordMatch() {
        const p1 = passwordInput.value;
        const p2 = confirmPasswordInput.value;
        if (!p2) {
            confirmValidation.innerHTML = '';
            return true;
        }
        if (p1 !== p2) {
            confirmValidation.className = 'validation-message text-danger';
            confirmValidation.innerHTML = '<i class="bi bi-x-circle"></i> Passwords do not match';
            return false;
        } else {
            confirmValidation.className = 'validation-message text-success';
            confirmValidation.innerHTML = '<i class="bi bi-check-circle"></i> Passwords match';
            return true;
        }
    }

    passwordInput.addEventListener('input', () => {
        updatePasswordStrength(passwordInput.value);
        checkPasswordMatch();
    });

    confirmPasswordInput.addEventListener('input', checkPasswordMatch);

    function updatePasswordStrength(p) {
        const hasLen = p.length >= 8 && p.length <= 64;
        const hasUpper = /[A-Z]/.test(p);
        const hasLower = /[a-z]/.test(p);
        const hasNum = /[0-9]/.test(p);
        const hasSpec = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~`]/.test(p);

        setRule('rule-len', hasLen);
        setRule('rule-upper', hasUpper);
        setRule('rule-lower', hasLower);
        setRule('rule-num', hasNum);
        setRule('rule-spec', hasSpec);

        let score = [hasLen, hasUpper, hasLower, hasNum, hasSpec].filter(Boolean).length;
        const segs = [document.getElementById('seg1'), document.getElementById('seg2'), document.getElementById('seg3'), document.getElementById('seg4')];
        segs.forEach(s => s.style.backgroundColor = 'transparent');

        if (score === 0) return;
        const color = score <= 2 ? '#ef4444' : score <= 4 ? '#f59e0b' : '#10b981';
        for (let i = 0; i < Math.min(score, 4); i++) {
            segs[i].style.backgroundColor = color;
        }
    }

    function setRule(id, met) {
        const el = document.getElementById(id);
        if (!el) return;
        if (met) {
            el.className = 'rule-met';
            el.querySelector('i').className = 'bi bi-check-circle-fill';
        } else {
            el.className = '';
            el.querySelector('i').className = 'bi bi-circle';
        }
    }

    function showGlobalError(msg) {
        globalErrorText.textContent = msg;
        globalErrorAlert.classList.remove('d-none');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function hideGlobalError() {
        globalErrorAlert.classList.add('d-none');
        globalErrorText.textContent = '';
    }

    async function handleFormSubmit(e) {
        e.preventDefault();
        hideGlobalError();

        const firstName = firstNameInput.value.trim();
        const lastName = lastNameInput.value.trim();
        const email = emailInput.value.trim().toLowerCase();
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        if (!firstName || !lastName) {
            showGlobalError('Please enter both First Name and Last Name.');
            return;
        }
        const fullName = firstName + " " + lastName;
        payloadFullName.value = fullName;

        let identifier = identifierInput.value.trim();
        if (flowState.role === 'student' && flowState.applicantType === 'current') {
            if (!identifier) {
                showGlobalError('Student ID is required for Current Students.');
                return;
            }
            if (!/^\d{8}$/.test(identifier)) {
                showGlobalError('Student ID must be exactly 8 digits (numbers only, e.g. 60240512).');
                return;
            }
        } else if (flowState.role === 'professor') {
            if (!identifier) {
                showGlobalError('Faculty / Professor ID is required.');
                return;
            }
            if (!/^\d{8}$/.test(identifier)) {
                showGlobalError('Faculty / Professor ID must be exactly 8 digits (numbers only, e.g. 80240101).');
                return;
            }
        }

        if (!email || !/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
            showGlobalError('Please provide a valid email format.');
            return;
        }
        if (!email.endsWith('@gmail.com') && !email.endsWith('.edu')) {
            showGlobalError('Email must end with @gmail.com or .edu domain.');
            return;
        }

        if (password !== confirmPassword) {
            showGlobalError('Passwords do not match. Please verify.');
            return;
        }
        if (password.length < 8) {
            showGlobalError('Password must contain at least 8 characters.');
            return;
        }

        let finalMajor = '';
        if (flowState.role === 'student' && flowState.applicantType === 'current') {
            if (majorSelect.value === 'Other') {
                finalMajor = customMajorInput.value.trim();
            } else {
                finalMajor = majorSelect.value;
            }
        }

        const formData = new URLSearchParams();
        formData.append('role', flowState.role);
        formData.append('applicantType', flowState.applicantType);
        formData.append('schoolId', flowState.selectedSchoolId || '');
        formData.append('schoolName', flowState.selectedSchoolName || '');
        formData.append('identifier', identifier);
        formData.append('firstName', firstName);
        formData.append('lastName', lastName);
        formData.append('fullName', fullName);
        formData.append('email', email);
        formData.append('password', password);
        formData.append('confirmPassword', confirmPassword);
        formData.append('major', finalMajor);

        submitBtn.disabled = true;
        const originalBtnText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status"></span>Submitting Registration...';

        try {
            const response = await fetch(contextPath + "/auth/register", {
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
                window.location.href = contextPath + "/auth/verify-registration?email=" + encodeURIComponent(email);
                return;
            } else {
                const errMsg = (data && data.message) ? data.message : 'Registration failed. Please check your inputs and try again.';
                showGlobalError(errMsg);
            }
        } catch (err) {
            console.error('Registration submission error:', err);
            showGlobalError('Network error occurred while submitting. Please check your connection.');
        } finally {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalBtnText;
        }
    }
</script>
</body>
</html>
