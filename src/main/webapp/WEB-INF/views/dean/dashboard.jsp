<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dean Dashboard - UniTRS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <script>
        // Automatic Mobile Redirect: Dual-role / mobile devices are routed to professor portal (full mobile UI)
        if (window.innerWidth < 768 && !window.location.search.includes('force=desktop')) {
            window.location.replace('${pageContext.request.contextPath}/professor/dashboard');
        }
    </script>

    <style>
        :root {
            --brand-primary: #2563eb;
            --brand-dark: #0f172a;
            --surface-bg: #f3f5f8;
            --card-border: rgba(226, 232, 240, 0.7);
        }

        body {
            background-color: var(--surface-bg);
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #1e293b;
            min-height: 100vh;
        }

        /* Prevent scrollbar twitch/shift when modals open */
        body.modal-open {
            padding-right: 0 !important;
            overflow-y: hidden !important;
        }

        /* DESKTOP WRAPPER */
        .desktop-layout {
            display: flex;
            min-height: 100vh;
            padding: 20px;
            gap: 24px;
        }

        /* SIDEBAR */
        .desktop-sidebar {
            width: 280px;
            background: #ffffff;
            border-radius: 28px;
            padding: 28px 20px;
            display: flex;
            flex-direction: column;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.03);
            flex-shrink: 0;
            position: sticky;
            top: 20px;
            height: calc(100vh - 40px);
            overflow-y: auto;
        }

        .desktop-sidebar::-webkit-scrollbar {
            display: none;
        }

        .sidebar-logo {
            font-size: 1.45rem;
            font-weight: 800;
            color: var(--brand-dark);
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding: 0 8px;
        }

        .sidebar-logo i {
            color: var(--brand-primary);
            font-size: 1.75rem;
        }

        .sidebar-search {
            position: relative;
            margin-bottom: 22px;
        }

        .sidebar-search input {
            width: 100%;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 99px;
            padding: 11px 16px 11px 40px;
            font-size: 0.85rem;
            color: #334155;
            transition: all 0.2s;
        }

        .sidebar-search input:focus {
            outline: none;
            background: #fff;
            border-color: #94a3b8;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
        }

        .sidebar-search i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 0.95rem;
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: auto;
        }

        .sidebar-nav button {
            background: transparent;
            border: none;
            text-align: left;
            padding: 12px 16px;
            border-radius: 16px;
            font-size: 0.92rem;
            font-weight: 600;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            width: 100%;
        }

        .sidebar-nav button i {
            font-size: 1.2rem;
            color: #94a3b8;
            transition: all 0.2s;
        }

        .sidebar-nav button .nav-badge {
            margin-left: auto;
            background: #f1f5f9;
            color: #64748b;
            font-size: 0.72rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 10px;
        }

        .sidebar-nav button:hover {
            color: var(--brand-dark);
            background: #f8fafc;
        }

        .sidebar-nav button:hover i {
            color: var(--brand-dark);
        }

        .sidebar-nav button.active {
            background: var(--brand-dark);
            color: #ffffff;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.2);
        }

        .sidebar-nav button.active i {
            color: #ffffff;
        }

        .sidebar-nav button.active .nav-badge {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }

        /* SIDEBAR PROMO / DUAL-ROLE CARD */
        .sidebar-promo {
            background: linear-gradient(145deg, #eff6ff, #dbeafe);
            border-radius: 22px;
            padding: 20px 16px;
            text-align: center;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
            border: 1px solid #bfdbfe;
        }

        .sidebar-promo .star-icon {
            width: 44px;
            height: 44px;
            background: #2563eb;
            color: white;
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 12px;
            box-shadow: 0 8px 16px rgba(37, 99, 235, 0.25);
            transform: rotate(-6deg);
        }

        .sidebar-promo h4 {
            font-size: 0.92rem;
            font-weight: 800;
            color: var(--brand-dark);
            margin-bottom: 4px;
        }

        .sidebar-promo p {
            font-size: 0.72rem;
            color: #475569;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .sidebar-promo a.btn {
            background: var(--brand-dark);
            color: white;
            border: none;
            width: 100%;
            padding: 9px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 700;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .sidebar-promo a.btn:hover {
            background: #1e293b;
            color: #fff;
        }

        /* MAIN CONTENT */
        .desktop-main {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        /* HEADER */
        .desktop-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding: 6px 0;
        }

        .header-title {
            font-size: 1.55rem;
            font-weight: 800;
            color: var(--brand-dark);
            letter-spacing: -0.02em;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .action-btn {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #64748b;
            font-size: 1.1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
            transition: all 0.2s;
            position: relative;
            cursor: pointer;
        }

        .action-btn:hover {
            color: var(--brand-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #ffffff;
            padding: 5px 16px 5px 5px;
            border-radius: 99px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            color: inherit;
            border: 1px solid #e2e8f0;
        }

        .user-profile:hover, .user-profile:focus {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
            transform: translateY(-1px);
        }

        .user-profile.dropdown-toggle::after {
            display: none !important;
        }

        .user-dropdown-menu {
            border: 1px solid #e2e8f0 !important;
            box-shadow: 0 16px 36px rgba(0, 0, 0, 0.08) !important;
            border-radius: 20px !important;
            animation: dropdownFadeIn 0.16s cubic-bezier(0.16, 1, 0.3, 1);
            transform-origin: top right;
        }

        @keyframes dropdownFadeIn {
            from {
                opacity: 0;
                transform: scale(0.96) translateY(-6px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #f1f5f9;
            overflow: hidden;
            flex-shrink: 0;
        }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-info-text {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--brand-dark);
            line-height: 1.2;
        }

        .user-role {
            font-size: 0.7rem;
            color: #64748b;
        }

        /* METRIC CARDS */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        @media (max-width: 1200px) {
            .metrics-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .metric-card {
            background: #ffffff;
            border-radius: 22px;
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            border: 1px solid var(--card-border);
            position: relative;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .metric-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.04);
        }

        .mc-icon-wrap {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .mc-icon {
            width: 36px;
            height: 36px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
        }

        .mc-icon.blue { background: #dbeafe; color: #1d4ed8; }
        .mc-icon.green { background: #dcfce7; color: #15803d; }
        .mc-icon.amber { background: #fef3c7; color: #b45309; }
        .mc-icon.purple { background: #f3e8ff; color: #7e22ce; }
        .mc-icon.cyan { background: #cffafe; color: #0e7490; }

        .mc-title { font-size: 0.8rem; font-weight: 700; color: #64748b; }
        .mc-value { font-size: 2rem; font-weight: 800; color: var(--brand-dark); line-height: 1; margin-bottom: 4px; }
        .mc-subtitle { font-size: 0.72rem; color: #94a3b8; }

        /* TABLE CARD */
        .table-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 26px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            border: 1px solid var(--card-border);
            margin-bottom: 24px;
        }

        .tc-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .tc-header h3 {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--brand-dark);
            margin: 0;
        }

        .tc-table-wrap {
            overflow-x: auto;
        }

        .tc-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 8px;
        }

        .tc-table th {
            font-size: 0.75rem;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0 16px 12px;
            text-align: left;
            border-bottom: 1px solid #f1f5f9;
        }

        .tc-table td {
            background: #ffffff;
            padding: 14px 16px;
            font-size: 0.85rem;
            color: #334155;
            font-weight: 600;
            border-top: 1px solid #f1f5f9;
            border-bottom: 1px solid #f1f5f9;
            transition: all 0.2s;
            vertical-align: middle;
        }

        .tc-table tbody tr td:first-child {
            border-left: 1px solid #f1f5f9;
            border-top-left-radius: 14px;
            border-bottom-left-radius: 14px;
        }

        .tc-table tbody tr td:last-child {
            border-right: 1px solid #f1f5f9;
            border-top-right-radius: 14px;
            border-bottom-right-radius: 14px;
        }

        .tc-table tbody tr:hover td {
            background: #f8fafc;
            border-color: #e2e8f0;
        }

        /* TAB PANES - Smooth Opacity without Stacking/Transform Glitches */
        .tab-section {
            display: none;
        }

        .tab-section.active {
            display: block;
            animation: tabFadeIn 0.2s ease-in-out;
        }

        @keyframes tabFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* MODAL GLITCH-FREE POLISH */
        .modal {
            --bs-modal-zindex: 1065;
            padding-right: 0 !important;
        }

        .modal-backdrop {
            --bs-backdrop-zindex: 1060;
            background-color: #0f172a;
        }

        .modal-backdrop.show {
            opacity: 0.6;
        }

        .modal-dialog {
            margin: 1.75rem auto;
            max-width: 520px;
        }

        .modal-dialog.modal-lg {
            max-width: 760px;
        }

        .modal-content {
            border-radius: 22px !important;
            border: 1px solid rgba(226, 232, 240, 0.9) !important;
            box-shadow: 0 25px 50px -12px rgba(15, 23, 42, 0.25) !important;
            background-color: #ffffff;
            overflow: hidden;
        }

        .modal.fade .modal-dialog {
            transition: transform 0.22s cubic-bezier(0.16, 1, 0.3, 1), opacity 0.22s ease-out;
            transform: scale(0.96) translateY(-8px);
            opacity: 0;
        }

        .modal.show .modal-dialog {
            transform: scale(1) translateY(0);
            opacity: 1;
        }

        .modal-header {
            border-bottom: 1px solid #f1f5f9;
            padding: 18px 24px;
        }

        .modal-body {
            padding: 24px;
        }

        .modal-footer {
            border-top: 1px solid #f1f5f9;
            padding: 16px 24px;
            background-color: #f8fafc;
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 10px 14px;
            border-color: #e2e8f0;
            font-size: 0.9rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--brand-primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }

        /* BUNDLE TERM CARDS */
        .bundle-card {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid var(--card-border);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.02);
            height: 100%;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .bundle-card .card-header {
            background: #ffffff;
            border-bottom: 1px solid #f1f5f9;
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .bundle-card .list-group-item {
            border-color: #f1f5f9;
            padding: 14px 20px;
        }
    </style>
</head>
<body>

    <!-- Force Desktop Mobile Warning Banner -->
    <c:if test="${param.force == 'desktop'}">
        <div class="alert alert-dark d-flex align-items-center justify-content-between py-2 px-4 m-0 rounded-0 border-0" style="font-size: 0.85rem; background: #0f172a; color: #fff; z-index: 1050;">
            <div>
                <i class="bi bi-display me-2 text-info"></i>
                You are currently viewing the <strong>Dean Administration Portal</strong> in desktop mode.
            </div>
            <a href="${pageContext.request.contextPath}/professor/dashboard" class="btn btn-sm btn-info rounded-pill px-3 py-1 fw-bold text-dark text-nowrap ms-2">
                <i class="bi bi-phone me-1"></i> Switch to Mobile View
            </a>
        </div>
    </c:if>

    <div class="desktop-layout">

        <%-- DESKTOP SIDEBAR --%>
        <aside class="desktop-sidebar" role="complementary" aria-label="Dean Navigation">
            <div class="sidebar-logo">
                <i class="bi bi-mortarboard-fill"></i>
                <span>UniTRS</span>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill ms-auto" style="font-size:0.65rem; padding: 4px 8px;">Dean Admin</span>
            </div>

            <div class="sidebar-search">
                <i class="bi bi-search"></i>
                <input type="text" id="deanSearchInput" placeholder="Search tables..." aria-label="Search records" onkeyup="filterActiveDeanTable(this.value)">
            </div>

            <nav class="sidebar-nav" role="tablist" aria-label="Dean Administration sections">
                <button role="tab" id="tab-courses" aria-selected="${activeTab == 'courses' ? 'true' : 'false'}" class="${activeTab == 'courses' ? 'active' : ''}" onclick="switchDeanTab('courses', this)">
                    <i class="bi bi-book-fill"></i> Master Courses
                    <span class="nav-badge">${courses.size()}</span>
                </button>
                <button role="tab" id="tab-terms" aria-selected="${activeTab == 'terms' ? 'true' : 'false'}" class="${activeTab == 'terms' ? 'active' : ''}" onclick="switchDeanTab('terms', this)">
                    <i class="bi bi-calendar3"></i> Academic Terms
                    <span class="nav-badge">${terms.size()}</span>
                </button>
                <button role="tab" id="tab-students" aria-selected="${activeTab == 'students' ? 'true' : 'false'}" class="${activeTab == 'students' ? 'active' : ''}" onclick="switchDeanTab('students', this)">
                    <i class="bi bi-people-fill"></i> Students
                    <span class="nav-badge">${students.size()}</span>
                </button>
                <button role="tab" id="tab-bundles" aria-selected="${activeTab == 'bundles' ? 'true' : 'false'}" class="${activeTab == 'bundles' ? 'active' : ''}" onclick="switchDeanTab('bundles', this)">
                    <i class="bi bi-collection-fill"></i> Curriculum Bundles
                    <span class="nav-badge">${curriculumMap.size()}</span>
                </button>
                <button role="tab" id="tab-schedules" aria-selected="${activeTab == 'schedules' ? 'true' : 'false'}" class="${activeTab == 'schedules' ? 'active' : ''}" onclick="switchDeanTab('schedules', this)">
                    <i class="bi bi-clock-history"></i> Class Schedules
                    <span class="nav-badge">${sections.size()}</span>
                </button>
                <button role="tab" id="tab-facilities" aria-selected="${activeTab == 'facilities' ? 'true' : 'false'}" class="${activeTab == 'facilities' ? 'active' : ''}" onclick="switchDeanTab('facilities', this)">
                    <i class="bi bi-building-fill"></i> Facilities
                    <span class="nav-badge">${rooms.size()}</span>
                </button>
            </nav>

            <%-- Faculty / Professor Portal Switcher Widget --%>
            <div class="sidebar-promo">
                <div class="star-icon"><i class="bi bi-person-workspace"></i></div>
                <h4>Professor Portal</h4>
                <p>Switch view to check your teaching classes, record attendance, and submit student grades.</p>
                <a href="${pageContext.request.contextPath}/professor/dashboard" class="btn">
                    <i class="bi bi-arrow-left-right me-1"></i> Switch to Professor View
                </a>
            </div>
        </aside>

        <%-- DESKTOP MAIN CONTENT --%>
        <main class="desktop-main" role="main">

            <%-- HEADER --%>
            <header class="desktop-header">
                <div>
                    <h1 class="header-title mb-0">Dean Administration</h1>
                    <div class="text-muted small mt-1 fw-medium">
                        <i class="bi bi-shield-check text-primary me-1"></i>
                        ${deanSchool.schoolName} &bull; Academic Leadership & Curriculum Control
                    </div>
                </div>

                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/professor/dashboard" class="btn btn-outline-dark rounded-pill px-3 py-2 fw-bold d-flex align-items-center gap-2" style="font-size: 0.85rem;">
                        <i class="bi bi-person-workspace text-primary"></i> Switch to Professor View
                    </a>

                    <button type="button" class="action-btn" aria-label="Notifications">
                        <i class="bi bi-bell"></i>
                    </button>

                    <div class="dropdown">
                        <button class="user-profile dropdown-toggle border-0 text-start" type="button" id="deanProfileDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                            <div class="user-avatar">
                                <c:choose>
                                    <c:when test="${user.gender == 'FEMALE'}">
                                        <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="user-info-text pe-2">
                                <span class="user-name">${user.fullName}</span>
                                <span class="user-role">${deanSchool.schoolName} <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill ms-1 px-2 py-0" style="font-size: 0.65rem; font-weight: 700;">DEAN</span> <i class="bi bi-chevron-down ms-1" style="font-size:0.65rem;"></i></span>
                            </div>
                        </button>

                        <div class="dropdown-menu dropdown-menu-end shadow-lg rounded-4 p-0 border-0 mt-2 overflow-hidden user-dropdown-menu" aria-labelledby="deanProfileDropdown" style="width: 310px; z-index: 1060;" onclick="event.stopPropagation();">
                            <!-- Header Banner -->
                            <div class="p-3 border-bottom" style="background: linear-gradient(135deg, #f8fafc 0%, #edf2f7 100%);">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="user-avatar" style="width: 44px; height: 44px; border-radius: 14px; border: 2px solid #ffffff; box-shadow: 0 4px 10px rgba(0,0,0,0.06);">
                                        <c:choose>
                                            <c:when test="${user.gender == 'FEMALE'}">
                                                <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="overflow-hidden">
                                        <div class="text-muted small text-uppercase fw-semibold" style="font-size: 0.68rem; letter-spacing: 0.5px;">Dean Account</div>
                                        <div class="fw-semibold text-dark text-truncate" style="font-size: 0.85rem;">${user.email}</div>
                                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill mt-1" style="font-size: 0.68rem; font-weight: 700;">
                                            <i class="bi bi-mortarboard-fill me-1"></i>DEAN & FACULTY
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <!-- Details Rows -->
                            <div class="p-3">
                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom" style="font-size: 0.82rem;">
                                    <span class="text-muted d-flex align-items-center gap-2">
                                        <i class="bi bi-person-badge text-primary"></i> Faculty ID
                                    </span>
                                    <span class="fw-bold text-dark font-monospace text-end text-truncate ms-2">
                                        ${user.formattedIdentifier}
                                    </span>
                                </div>

                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom" style="font-size: 0.82rem;">
                                    <span class="text-muted d-flex align-items-center gap-2">
                                        <i class="bi bi-building text-primary"></i> College / School
                                    </span>
                                    <span class="fw-semibold text-dark text-end text-truncate ms-2" style="max-width: 170px;">
                                        ${deanSchool.schoolName}
                                    </span>
                                </div>

                                <!-- 2FA Toggle -->
                                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="pt-2">
                                    <input type="hidden" name="redirect" value="/dean/dashboard?tab=${activeTab}">
                                    <div class="d-flex justify-content-between align-items-center" style="font-size: 0.82rem;">
                                        <span class="text-muted d-flex align-items-center gap-2">
                                            <i class="bi bi-shield-lock text-primary"></i> 2FA Security
                                        </span>
                                        <select name="twoFactorEnabled" class="form-select form-select-sm py-0 border-0 bg-light fw-bold" style="font-size: 0.8rem; width: auto;" onchange="this.form.submit()">
                                            <option value="false" ${!user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                                            <option value="true" ${user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                                        </select>
                                    </div>
                                </form>
                            </div>

                            <!-- Switch to Professor Portal Button -->
                            <div class="px-3 pb-2">
                                <a href="${pageContext.request.contextPath}/professor/dashboard" class="btn btn-dark w-100 rounded-pill py-2 fw-bold d-flex align-items-center justify-content-center gap-2 text-white text-decoration-none" style="font-size: 0.85rem;">
                                    <i class="bi bi-person-workspace text-info"></i> Switch to Professor View
                                </a>
                            </div>

                            <!-- Logout Button -->
                            <div class="p-3 bg-light border-top">
                                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger w-100 rounded-pill py-2 fw-bold d-flex align-items-center justify-content-center gap-2" style="font-size: 0.85rem;">
                                    <i class="bi bi-box-arrow-right"></i> Logout
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <%-- ALERTS --%>
            <div aria-live="polite">
                <c:if test="${param.twoFactorUpdated == 'true'}">
                    <div class="alert alert-success alert-dismissible fade show rounded-4" role="alert">
                        <i class="bi bi-shield-check me-2"></i>Two-Factor Authentication (2FA) is now <strong>enabled</strong> for your account.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${param.twoFactorUpdated == 'false'}">
                    <div class="alert alert-info alert-dismissible fade show rounded-4" role="alert">
                        <i class="bi bi-shield-slash me-2"></i>Two-Factor Authentication (2FA) has been <strong>disabled</strong> for your account.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show rounded-4" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
            </div>

            <%-- TOP METRIC STATS CARDS --%>
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="mc-icon-wrap">
                        <div class="mc-icon blue"><i class="bi bi-book-half"></i></div>
                        <span class="mc-title">Master Courses</span>
                    </div>
                    <div class="mc-value">${courses.size()}</div>
                    <div class="mc-subtitle">Offered in ${deanSchool.schoolName}</div>
                </div>

                <div class="metric-card">
                    <div class="mc-icon-wrap">
                        <div class="mc-icon green"><i class="bi bi-people-fill"></i></div>
                        <span class="mc-title">Active Students</span>
                    </div>
                    <div class="mc-value">${students.size()}</div>
                    <div class="mc-subtitle">Registered in department</div>
                </div>

                <div class="metric-card">
                    <div class="mc-icon-wrap">
                        <div class="mc-icon amber"><i class="bi bi-calendar3"></i></div>
                        <span class="mc-title">Academic Terms</span>
                    </div>
                    <div class="mc-value">${terms.size()}</div>
                    <div class="mc-subtitle">Active academic periods</div>
                </div>

                <div class="metric-card">
                    <div class="mc-icon-wrap">
                        <div class="mc-icon purple"><i class="bi bi-clock-history"></i></div>
                        <span class="mc-title">Class Sections</span>
                    </div>
                    <div class="mc-value">${sections.size()}</div>
                    <div class="mc-subtitle">Scheduled classes</div>
                </div>

                <div class="metric-card">
                    <div class="mc-icon-wrap">
                        <div class="mc-icon cyan"><i class="bi bi-building"></i></div>
                        <span class="mc-title">Campus Facilities</span>
                    </div>
                    <div class="mc-value">${rooms.size()}</div>
                    <div class="mc-subtitle">Active rooms & labs</div>
                </div>
            </div>

            <%-- ========================================================= --%>
            <%-- TAB 1: MASTER COURSES                                     --%>
            <%-- ========================================================= --%>
            <section id="dt-courses" class="tab-section ${activeTab == 'courses' ? 'active' : ''}">
                <div class="table-card">
                    <div class="tc-header">
                        <div>
                            <h3>Course Catalog & Master Curriculum</h3>
                            <p class="text-muted small mb-0 mt-1">Official master courses approved for ${deanSchool.schoolName}.</p>
                        </div>
                        <button class="btn btn-primary rounded-pill px-3 py-2 fw-semibold d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#addCourseModal">
                            <i class="bi bi-plus-lg"></i> Add New Course
                        </button>
                    </div>

                    <div class="tc-table-wrap">
                        <table class="tc-table" id="coursesTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Course Code</th>
                                    <th>Course Title</th>
                                    <th>School / Department</th>
                                    <th>Credits</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="course" items="${courses}">
                                    <tr class="searchable-row">
                                        <td><span class="badge bg-light text-muted border">#${course.id}</span></td>
                                        <td><span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 rounded-pill">${course.courseCode}</span></td>
                                        <td class="fw-bold text-dark">${course.courseTitle}</td>
                                        <td><small class="text-muted"><i class="bi bi-building me-1"></i>${course.schoolName}</small></td>
                                        <td><span class="badge bg-secondary-subtle text-secondary border px-2 py-1 rounded-pill">${course.credits} Credits</span></td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#editCourseModal${course.id}">
                                                <i class="bi bi-pencil me-1"></i> Edit
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty courses}">
                                    <tr><td colspan="6" class="text-center text-muted py-4">No master courses available for this school.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <%-- ========================================================= --%>
            <%-- TAB 2: ACADEMIC TERMS                                     --%>
            <%-- ========================================================= --%>
            <section id="dt-terms" class="tab-section ${activeTab == 'terms' ? 'active' : ''}">
                <div class="table-card">
                    <div class="tc-header">
                        <div>
                            <h3>Academic Terms Management</h3>
                            <p class="text-muted small mb-0 mt-1">Configure academic terms, semesters, and curriculum progression periods.</p>
                        </div>
                        <button class="btn btn-primary rounded-pill px-3 py-2 fw-semibold d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#addTermModal">
                            <i class="bi bi-plus-lg"></i> Add New Term
                        </button>
                    </div>

                    <div class="tc-table-wrap">
                        <table class="tc-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Term Sequence</th>
                                    <th>Term Name</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="term" items="${terms}">
                                    <tr class="searchable-row">
                                        <td><span class="badge bg-light text-muted border">#${term.id}</span></td>
                                        <td><span class="badge bg-info-subtle text-info-emphasis border px-2 py-1 rounded-pill">Term ${term.termNumber}</span></td>
                                        <td class="fw-bold text-dark">${term.termName}</td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#editTermModal${term.id}">
                                                <i class="bi bi-pencil me-1"></i> Edit
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty terms}">
                                    <tr><td colspan="4" class="text-center text-muted py-4">No terms defined yet.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <%-- ========================================================= --%>
            <%-- TAB 3: STUDENTS IN SCHOOL                                 --%>
            <%-- ========================================================= --%>
            <section id="dt-students" class="tab-section ${activeTab == 'students' ? 'active' : ''}">
                <div class="table-card">
                    <div class="tc-header">
                        <div>
                            <h3>Registered Students &bull; ${deanSchool.schoolName}</h3>
                            <p class="text-muted small mb-0 mt-1">Official list of all students registered under your school.</p>
                        </div>
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill fw-semibold">
                            Total Students: ${students.size()}
                        </span>
                    </div>

                    <div class="tc-table-wrap">
                        <table class="tc-table">
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Student Name</th>
                                    <th>Email Address</th>
                                    <th>Major / Specialization</th>
                                    <th>Verification</th>
                                    <th>Account Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr class="searchable-row">
                                        <td><span class="badge bg-light text-dark border px-2 py-1 rounded-pill font-monospace">${student.formattedIdentifier}</span></td>
                                        <td class="fw-bold text-dark">${student.fullName}</td>
                                        <td><span class="text-muted">${student.email}</span></td>
                                        <td><span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 rounded-pill">${student.major}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${student.verified}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill"><i class="bi bi-check-circle me-1"></i> Verified</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-2 py-1 rounded-pill"><i class="bi bi-hourglass me-1"></i> Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${student.active}">
                                                    <span class="badge bg-success px-2 py-1 rounded-pill">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger px-2 py-1 rounded-pill">Disabled</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty students}">
                                    <tr><td colspan="6" class="text-center text-muted py-4">No students currently enrolled in this school.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <%-- ========================================================= --%>
            <%-- TAB 4: CURRICULUM BUNDLING                                --%>
            <%-- ========================================================= --%>
            <section id="dt-bundles" class="tab-section ${activeTab == 'bundles' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h3 class="h5 fw-bold text-dark mb-0">Term Curriculum Bundles</h3>
                        <p class="text-muted small mb-0">Assign and bundle courses offered in each academic term.</p>
                    </div>
                </div>

                <div class="row g-4">
                    <c:forEach var="entry" items="${curriculumMap}">
                        <c:set var="term" value="${entry.key}" />
                        <c:set var="termCourses" value="${entry.value}" />

                        <div class="col-md-6 col-lg-4">
                            <div class="bundle-card">
                                <div class="card-header">
                                    <div>
                                        <h5 class="mb-0 fw-bold text-dark">${term.termName}</h5>
                                        <small class="text-muted">${termCourses.size()} courses bundled</small>
                                    </div>
                                    <button class="btn btn-sm btn-primary rounded-pill px-3 fw-semibold" data-bs-toggle="modal" data-bs-target="#bundleModal${term.id}">
                                        <i class="bi bi-plus-lg me-1"></i> Add Course
                                    </button>
                                </div>
                                <div class="card-body p-0">
                                    <ul class="list-group list-group-flush">
                                        <c:forEach var="course" items="${termCourses}">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                <div>
                                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-0 rounded-pill" style="font-size: 0.7rem;">${course.courseCode}</span>
                                                    <div class="fw-semibold text-dark mt-1" style="font-size: 0.85rem;">${course.courseTitle}</div>
                                                    <small class="text-muted">${course.credits} Credits</small>
                                                </div>
                                                <!-- Unbundle form -->
                                                <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="m-0 p-0">
                                                    <input type="hidden" name="action" value="unbundleCourse">
                                                    <input type="hidden" name="termId" value="${term.id}">
                                                    <input type="hidden" name="courseId" value="${course.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger border-0 rounded-circle" title="Remove from term" onclick="return confirm('Remove ${course.courseCode} from ${term.termName}?')">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${empty termCourses}">
                                            <li class="list-group-item text-center text-muted py-4 small">No courses assigned to this term yet.</li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty curriculumMap}">
                        <div class="col-12 text-center text-muted py-5">No academic terms created yet. Create a term first to configure curriculum bundles.</div>
                    </c:if>
                </div>
            </section>

            <%-- ========================================================= --%>
            <%-- TAB 5: CLASS SCHEDULES                                    --%>
            <%-- ========================================================= --%>
            <section id="dt-schedules" class="tab-section ${activeTab == 'schedules' ? 'active' : ''}">
                <div class="table-card">
                    <div class="tc-header">
                        <div>
                            <h3>Class Schedules & Faculty Assignment</h3>
                            <p class="text-muted small mb-0 mt-1">Schedule courses into physical rooms and assign academic faculty.</p>
                        </div>
                        <button class="btn btn-primary rounded-pill px-3 py-2 fw-semibold d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#scheduleClassModal">
                            <i class="bi bi-plus-lg"></i> Schedule Class
                        </button>
                    </div>

                    <div class="tc-table-wrap">
                        <table class="tc-table">
                            <thead>
                                <tr>
                                    <th>Term & Academic Year</th>
                                    <th>Course</th>
                                    <th>Assigned Professor</th>
                                    <th>Schedule Shift</th>
                                    <th>Room & Enrollment</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="section" items="${sections}">
                                    <tr class="searchable-row">
                                        <td>
                                            <span class="badge bg-info-subtle text-info-emphasis border px-2 py-1 rounded-pill">${section.termName}</span>
                                            <div class="small text-muted mt-1 font-monospace">${section.academicYear}</div>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-0 rounded-pill mb-1" style="font-size:0.7rem;">${section.courseCode}</span>
                                            <div class="fw-bold text-dark">${section.courseTitle}</div>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="mc-icon blue" style="width:28px; height:28px; font-size:0.85rem; border-radius:8px;"><i class="bi bi-person-badge"></i></div>
                                                <span class="fw-semibold text-dark">${section.professorName}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark border px-2 py-1 rounded-pill">${section.sessionShift}</span>
                                            <div class="small text-muted mt-1"><i class="bi bi-calendar-event me-1"></i>${section.daysOfWeek}</div>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center gap-1 fw-semibold text-dark">
                                                <i class="bi bi-door-open text-primary me-1"></i>${section.roomName}
                                            </div>
                                            <div class="small text-muted mt-1">
                                                Seats: <strong>${section.enrolledCount} / ${section.roomCapacity}</strong>
                                            </div>
                                            <div class="progress mt-1" style="height: 6px; width: 120px; border-radius: 99px;">
                                                <div class="progress-bar ${section.enrolledCount >= section.roomCapacity ? 'bg-danger' : 'bg-success'}" role="progressbar" style="width: ${section.roomCapacity > 0 ? (section.enrolledCount * 100 / section.roomCapacity) : 0}%"></div>
                                            </div>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="removeClassSection">
                                                <input type="hidden" name="sectionId" value="${section.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Are you sure you want to delete this scheduled class section?');">
                                                    <i class="bi bi-trash me-1"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty sections}">
                                    <tr><td colspan="6" class="text-center text-muted py-4">No class sections scheduled yet. Click "+ Schedule Class" to create one.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <%-- ========================================================= --%>
            <%-- TAB 6: FACILITY MANAGEMENT                                --%>
            <%-- ========================================================= --%>
            <section id="dt-facilities" class="tab-section ${activeTab == 'facilities' ? 'active' : ''}">
                <div class="table-card">
                    <div class="tc-header">
                        <div>
                            <h3>Physical Campus Facilities</h3>
                            <p class="text-muted small mb-0 mt-1">Manage physical classrooms, computer labs, and seating capacities.</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-secondary rounded-pill px-3 py-2 fw-semibold d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#batchRoomModal">
                                <i class="bi bi-layers"></i> Batch Generate Rooms
                            </button>
                            <button class="btn btn-primary rounded-pill px-3 py-2 fw-semibold d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                                <i class="bi bi-plus-lg"></i> Add Single Room
                            </button>
                        </div>
                    </div>

                    <div class="tc-table-wrap">
                        <table class="tc-table">
                            <thead>
                                <tr>
                                    <th>Floor Level</th>
                                    <th>Room Identifier</th>
                                    <th>Seating Capacity</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${rooms}">
                                    <tr class="searchable-row">
                                        <td><span class="badge bg-light text-muted border px-2 py-1 rounded-pill">Floor ${room.floorNumber}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="mc-icon cyan" style="width:28px; height:28px; font-size:0.85rem; border-radius:8px;"><i class="bi bi-door-open"></i></div>
                                                <span class="fw-bold text-dark">${room.roomNumber}</span>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-secondary-subtle text-secondary border px-2 py-1 rounded-pill">${room.capacity} Seats</span></td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="deleteRoom">
                                                <input type="hidden" name="roomId" value="${room.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Delete room ${room.roomNumber}?');">
                                                    <i class="bi bi-trash me-1"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty rooms}">
                                    <tr><td colspan="4" class="text-center text-muted py-4">No rooms created yet. Generate a floor batch to begin.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

        </main>
    </div>

    <%-- ============================================================= --%>
    <%-- ALL MODALS (AT ROOT LEVEL TO PREVENT GLITCHES & CLIPPING)     --%>
    <%-- ============================================================= --%>

    <!-- 1. Add Course Modal -->
    <div class="modal fade" id="addCourseModal" tabindex="-1" aria-labelledby="addCourseModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addCourse">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold text-dark" id="addCourseModalLabel">Create New Master Course</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Course Code</label>
                        <input type="text" class="form-control" name="courseCode" placeholder="e.g. CS 301" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Course Title</label>
                        <input type="text" class="form-control" name="courseTitle" placeholder="e.g. Distributed Systems" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Credits</label>
                        <input type="number" class="form-control" name="credits" value="3" required min="1" max="10">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Create Course</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 2. Edit Course Modals (Root Level) -->
    <c:forEach var="course" items="${courses}">
        <div class="modal fade" id="editCourseModal${course.id}" tabindex="-1" aria-labelledby="editCourseModalLabel${course.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                    <input type="hidden" name="action" value="updateCourse">
                    <input type="hidden" name="courseId" value="${course.id}">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold text-dark" id="editCourseModalLabel${course.id}">Edit Course - ${course.courseCode}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Course Code</label>
                            <input type="text" class="form-control" name="courseCode" value="${course.courseCode}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Course Title</label>
                            <input type="text" class="form-control" name="courseTitle" value="${course.courseTitle}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Credits</label>
                            <input type="number" class="form-control" name="credits" value="${course.credits}" required min="1" max="10">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>

    <!-- 3. Add Term Modal -->
    <div class="modal fade" id="addTermModal" tabindex="-1" aria-labelledby="addTermModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addTerm">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold text-dark" id="addTermModalLabel">Create New Academic Term</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Term Sequence Number</label>
                        <input type="number" class="form-control" name="termNumber" placeholder="e.g. 5" required min="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Term Name</label>
                        <input type="text" class="form-control" name="termName" placeholder="e.g. Term 5 (Fall 2026)" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Create Term</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 4. Edit Term Modals (Root Level) -->
    <c:forEach var="term" items="${terms}">
        <div class="modal fade" id="editTermModal${term.id}" tabindex="-1" aria-labelledby="editTermModalLabel${term.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                    <input type="hidden" name="action" value="updateTerm">
                    <input type="hidden" name="termId" value="${term.id}">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold text-dark" id="editTermModalLabel${term.id}">Edit Academic Term</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Term Number (e.g. 1, 2, 3)</label>
                            <input type="number" class="form-control" name="termNumber" value="${term.termNumber}" required min="1">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Term Name</label>
                            <input type="text" class="form-control" name="termName" value="${term.termName}" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>

    <!-- 5. Bundle Course Modals (Root Level) -->
    <c:forEach var="entry" items="${curriculumMap}">
        <c:set var="term" value="${entry.key}" />
        <c:set var="termCourses" value="${entry.value}" />
        <div class="modal fade" id="bundleModal${term.id}" tabindex="-1" aria-labelledby="bundleModalLabel${term.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                    <input type="hidden" name="action" value="bundleCourse">
                    <input type="hidden" name="termId" value="${term.id}">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold text-dark" id="bundleModalLabel${term.id}">Assign Course to ${term.termName}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Select Course from Master Catalog</label>
                            <select name="courseId" class="form-select" required>
                                <option value="">-- Choose a Course --</option>
                                <c:forEach var="c" items="${courses}">
                                    <c:set var="isAssigned" value="false" />
                                    <c:forEach var="tc" items="${termCourses}">
                                        <c:if test="${tc.id == c.id}">
                                            <c:set var="isAssigned" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <option value="${c.id}" ${isAssigned ? 'disabled' : ''}>
                                        ${c.courseCode} - ${c.courseTitle} (${c.credits} cr) ${isAssigned ? '[Assigned]' : ''}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4">Assign Course</button>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>

    <!-- 6. Schedule Class Modal -->
    <div class="modal fade" id="scheduleClassModal" tabindex="-1" aria-labelledby="scheduleClassModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addClassSection">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold text-dark" id="scheduleClassModalLabel">Schedule New Class Section</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Term</label>
                            <select name="termId" class="form-select" id="termSelect" required>
                                <option value="">-- Choose Term --</option>
                                <c:forEach var="entry" items="${curriculumMap}">
                                    <c:if test="${not empty entry.value}">
                                        <option value="${entry.key.id}">${entry.key.termName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Course (Assigned to Term)</label>
                            <select name="courseId" class="form-select" id="courseSelect" required>
                                <option value="">-- First choose a term above --</option>
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-semibold">Assign Professor</label>
                            <select name="professorId" class="form-select" required>
                                <option value="">-- Choose Professor --</option>
                                <c:forEach var="prof" items="${professors}">
                                    <option value="${prof.id}">${prof.fullName} (${prof.email})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Shift</label>
                            <select name="sessionShift" class="form-select" required>
                                <option value="MORNING">Morning (08:00 - 11:30)</option>
                                <option value="AFTERNOON">Afternoon (13:30 - 17:00)</option>
                                <option value="EVENING">Evening (17:30 - 20:30)</option>
                                <option value="WEEKEND">Weekend (Saturday/Sunday)</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Physical Room</label>
                            <select name="roomId" class="form-select" required>
                                <option value="">-- Choose Room --</option>
                                <c:forEach var="room" items="${rooms}">
                                    <option value="${room.id}">${room.roomNumber} (Cap: ${room.capacity})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Days of Week</label>
                            <select name="daysOfWeek" class="form-select" required>
                                <option value="Mon-Fri">Mon-Fri (Weekday)</option>
                                <option value="Sat-Sun">Sat-Sun (Weekend)</option>
                            </select>
                            <small class="text-muted d-block mt-1" style="font-size: 0.75rem;">Exact timetable will calculate automatically</small>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-semibold">Academic Year</label>
                            <input type="text" class="form-control" name="academicYear" placeholder="e.g. 2026-2027" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Schedule Class</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 7. Add Single Room Modal -->
    <div class="modal fade" id="addRoomModal" tabindex="-1" aria-labelledby="addRoomModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addRoom">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold text-dark" id="addRoomModalLabel">Add Campus Classroom</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Room Number</label>
                        <input type="text" class="form-control" name="roomNumber" placeholder="e.g. Room 402" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Floor Number</label>
                        <input type="number" class="form-control" name="floorNumber" min="1" max="15" placeholder="e.g. 4" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Maximum Seating Capacity</label>
                        <input type="number" class="form-control" name="capacity" min="1" placeholder="e.g. 45" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Create Room</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 8. Batch Generate Rooms Modal -->
    <div class="modal fade" id="batchRoomModal" tabindex="-1" aria-labelledby="batchRoomModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addRoomsBatch">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold text-dark" id="batchRoomModalLabel">Batch Generate Classrooms</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info py-2 rounded-3 small">
                        <i class="bi bi-info-circle me-1"></i> Quickly generate multiple identical rooms for a specific floor.
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Floor Number</label>
                        <input type="number" class="form-control" name="floorNumber" min="1" max="15" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Number of Rooms to Generate</label>
                        <input type="number" class="form-control" name="numberOfRooms" min="1" max="50" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Seating Capacity (Per Room)</label>
                        <input type="number" class="form-control" name="capacityPerRoom" min="1" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Generate Batch</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tab switching function
        function switchDeanTab(tabName, btn) {
            // Hide all tab sections
            document.querySelectorAll('.tab-section').forEach(sec => sec.classList.remove('active'));
            // Remove active class from all sidebar buttons
            document.querySelectorAll('.sidebar-nav button').forEach(b => {
                b.classList.remove('active');
                b.setAttribute('aria-selected', 'false');
            });

            // Activate targeted tab section
            const targetSec = document.getElementById('dt-' + tabName);
            if (targetSec) {
                targetSec.classList.add('active');
            }

            // Activate button
            if (btn) {
                btn.classList.add('active');
                btn.setAttribute('aria-selected', 'true');
            } else {
                const navBtn = document.getElementById('tab-' + tabName);
                if (navBtn) {
                    navBtn.classList.add('active');
                    navBtn.setAttribute('aria-selected', 'true');
                }
            }

            // Update URL without page reload
            window.history.replaceState(null, null, '?tab=' + tabName);
        }

        // Search filtering across active tab's table
        function filterActiveDeanTable(query) {
            const activeSection = document.querySelector('.tab-section.active');
            if (!activeSection) return;

            const rows = activeSection.querySelectorAll('tbody tr.searchable-row');
            const q = query.trim().toLowerCase();

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(q) ? '' : 'none';
            });
        }

        // Dynamic Course Dropdown based on Term Selection
        const termCoursesMap = {};
        <c:forEach var="entry" items="${curriculumMap}">
            termCoursesMap[${entry.key.id}] = [
                <c:forEach var="course" items="${entry.value}">
                    { id: ${course.id}, code: "${course.courseCode}", title: "${course.courseTitle}" },
                </c:forEach>
            ];
        </c:forEach>

        const termSelect = document.getElementById('termSelect');
        const courseSelect = document.getElementById('courseSelect');

        function updateCourseOptions() {
            if (!termSelect || !courseSelect) return;
            const termId = termSelect.value;
            courseSelect.innerHTML = '';

            if (!termId) {
                courseSelect.innerHTML = '<option value="">-- First choose a term above --</option>';
                return;
            }

            const courses = termCoursesMap[termId];
            if (courses && courses.length > 0) {
                courseSelect.innerHTML = '<option value="">-- Choose Course --</option>';
                courses.forEach(course => {
                    const option = document.createElement('option');
                    option.value = course.id;
                    option.textContent = course.code + ' - ' + course.title;
                    courseSelect.appendChild(option);
                });
            } else {
                courseSelect.innerHTML = '<option value="" disabled>-- No courses bundled in this term yet --</option>';
            }
        }

        if (termSelect) {
            termSelect.addEventListener('change', updateCourseOptions);
        }

        const scheduleModal = document.getElementById('scheduleClassModal');
        if (scheduleModal) {
            scheduleModal.addEventListener('shown.bs.modal', function () {
                updateCourseOptions();
            });
        }
    </script>
</body>
</html>
