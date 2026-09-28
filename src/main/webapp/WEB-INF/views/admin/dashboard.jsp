<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Portal - UniTRS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

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

        body.modal-open {
            padding-right: 0 !important;
            overflow-y: hidden !important;
        }

        .desktop-layout {
            display: flex;
            min-height: 100vh;
            padding: 20px;
            gap: 24px;
        }

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

        .desktop-main {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

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
            background: #eff6ff;
            color: #2563eb;
            overflow: hidden;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 0.85rem;
            border: 1px solid #dbeafe;
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

        .admin-hero-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #2563eb 100%);
            border-radius: 24px;
            padding: 24px 28px;
            color: #fff;
            box-shadow: 0 12px 32px rgba(37, 99, 235, 0.18);
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .admin-hero-banner::after {
            content: '';
            position: absolute;
            top: -30%;
            right: -10%;
            width: 320px;
            height: 320px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.12) 0%, transparent 70%);
            pointer-events: none;
        }

        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-bottom: 18px;
        }

        @media (max-width: 1200px) {
            .metrics-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        .metric-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 14px 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
            border: 1px solid var(--card-border);
            position: relative;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
            cursor: pointer;
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

        .mc-title { font-size: 0.75rem; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; }
        .mc-value { font-size: 1.6rem; font-weight: 800; color: var(--brand-dark); line-height: 1; margin-bottom: 2px; }
        .mc-subtitle { font-size: 0.72rem; color: #94a3b8; }

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

        .btn-filter-pill {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            color: #64748b;
            padding: 6px 16px;
            border-radius: 99px;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.15s;
        }

        .btn-filter-pill:hover {
            background: #f8fafc;
            color: var(--brand-dark);
        }

        .btn-filter-pill.active {
            background: var(--brand-dark);
            border-color: var(--brand-dark);
            color: #ffffff;
        }

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

        @media (max-width: 767.98px) {
            body {
                background: #f8fafc;
                padding-bottom: 0 !important;
                -webkit-font-smoothing: antialiased;
                -webkit-tap-highlight-color: transparent;
            }

            .desktop-layout {
                display: none !important;
            }

            .mobile-app-container {
                display: block !important;
                width: 100% !important;
                max-width: 540px !important;
                margin: 0 auto !important;
                padding: 0 16px calc(84px + env(safe-area-inset-bottom, 16px)) !important;
                background: #f8fafc;
                min-height: 100vh;
                box-sizing: border-box !important;
            }

            .admin-mobile-topbar {
                position: sticky;
                top: 0;
                z-index: 1020;
                background: rgba(248, 250, 252, 0.92);
                backdrop-filter: blur(18px);
                -webkit-backdrop-filter: blur(18px);
                padding: calc(12px + env(safe-area-inset-top, 0px)) 16px 12px;
                margin-left: -16px;
                margin-right: -16px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid rgba(226, 232, 240, 0.8);
                margin-bottom: 16px;
            }

            .admin-top-avatar {
                width: 44px;
                height: 44px;
                border-radius: 14px;
                background: #eff6ff;
                color: #2563eb;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 800;
                font-size: 0.92rem;
                border: 2px solid #ffffff;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
                flex-shrink: 0;
            }

            .mobile-sub-view {
                display: none;
                padding: 0 0 16px;
                width: 100%;
                box-sizing: border-box;
            }

            .mobile-sub-view.active {
                display: block;
                animation: mobileFadeIn 0.22s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes mobileFadeIn {
                from { opacity: 0; transform: translateY(6px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .admin-mobile-kpi-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
                margin-bottom: 16px;
            }

            .admin-mobile-kpi-card {
                background: #ffffff;
                border-radius: 18px;
                padding: 14px;
                border: 1px solid rgba(226, 232, 240, 0.8);
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
                cursor: pointer;
            }

            .mobile-card-item {
                background: #ffffff;
                border-radius: 20px;
                padding: 16px;
                border: 1px solid rgba(226, 232, 240, 0.75);
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.02);
                margin-bottom: 12px;
            }

            .mobile-dock, .mobile-bottom-dock {
                position: fixed;
                bottom: calc(12px + env(safe-area-inset-bottom, 8px));
                left: 50%;
                transform: translateX(-50%);
                width: calc(100% - 24px);
                max-width: 480px;
                background: rgba(255, 255, 255, 0.92);
                backdrop-filter: blur(24px) saturate(180%);
                -webkit-backdrop-filter: blur(24px) saturate(180%);
                border: 1px solid rgba(255, 255, 255, 0.8);
                border-radius: 28px;
                display: flex;
                align-items: center;
                justify-content: space-around;
                padding: 6px 8px;
                z-index: 1040;
                box-shadow: 0 12px 32px -4px rgba(15, 23, 42, 0.12), 0 2px 8px rgba(0, 0, 0, 0.04);
            }

            .dock-tab-btn {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                background: transparent;
                border: none;
                color: #64748b;
                font-size: 0.68rem;
                font-weight: 600;
                letter-spacing: -0.01em;
                flex: 1;
                max-width: 84px;
                min-height: 46px;
                padding: 5px 4px;
                border-radius: 18px;
                cursor: pointer;
                transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                text-decoration: none;
                position: relative;
                user-select: none;
                -webkit-tap-highlight-color: transparent;
            }

            .dock-tab-btn:active {
                transform: scale(0.92);
            }

            .dock-tab-btn.active {
                color: #2563eb;
                background: rgba(37, 99, 235, 0.09);
                font-weight: 700;
            }

            .dock-tab-btn i {
                font-size: 1.25rem;
                margin-bottom: 2px;
                transition: transform 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            }

            .dock-tab-btn.active i {
                transform: scale(1.08);
            }
        }
    </style>
</head>
<body>

    <c:if test="${not empty successMessage}">
        <div class="position-fixed top-0 start-50 translate-middle-x p-3" style="z-index: 99999;">
            <div class="alert alert-success alert-dismissible fade show shadow-lg rounded-4 d-flex align-items-center gap-2 mb-0 py-2.5 px-4" role="alert" style="border: 1px solid #86efac; background: #f0fdf4; color: #166534;">
                <i class="bi bi-check-circle-fill text-success fs-5"></i>
                <div class="fw-bold small">${successMessage}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 1rem;"></button>
            </div>
        </div>
    </c:if>

    <div class="desktop-layout">
        <aside class="desktop-sidebar" role="complementary" aria-label="Admin Navigation">
            <div class="sidebar-logo">
                <i class="bi bi-shield-lock-fill"></i>
                <span>UniTRS</span>
                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill ms-auto" style="font-size:0.65rem; padding: 4px 8px;">Admin</span>
            </div>

            <div class="sidebar-search">
                <i class="bi bi-search"></i>
                <input type="text" id="adminSearchInput" placeholder="Search directory..." aria-label="Search records" onkeyup="filterActiveAdminTable(this.value)">
            </div>

            <nav class="sidebar-nav" role="tablist" aria-label="Administration sections">
                <button role="tab" id="tab-overview" aria-selected="${empty currentTab || currentTab == 'overview' ? 'true' : 'false'}" class="${empty currentTab || currentTab == 'overview' ? 'active' : ''}" onclick="switchDesktopTab('overview', this)">
                    <i class="bi bi-grid-fill"></i> Overview
                </button>
                <button role="tab" id="tab-users" aria-selected="${currentTab == 'users' ? 'true' : 'false'}" class="${currentTab == 'users' ? 'active' : ''}" onclick="switchDesktopTab('users', this)">
                    <i class="bi bi-people-fill"></i> Users &amp; Access
                    <c:if test="${pendingVerifications > 0}">
                        <span class="nav-badge bg-warning text-dark">${pendingVerifications}</span>
                    </c:if>
                </button>
                <button role="tab" id="tab-deans" aria-selected="${currentTab == 'deans' ? 'true' : 'false'}" class="${currentTab == 'deans' ? 'active' : ''}" onclick="switchDesktopTab('deans', this)">
                    <i class="bi bi-building-fill"></i> Dean Leadership
                    <span class="nav-badge">${schools.size()}</span>
                </button>
                <button role="tab" id="tab-holidays" aria-selected="${currentTab == 'holidays' ? 'true' : 'false'}" class="${currentTab == 'holidays' ? 'active' : ''}" onclick="switchDesktopTab('holidays', this)">
                    <i class="bi bi-calendar-heart"></i> School Holidays
                </button>
                <button role="tab" id="tab-profile" aria-selected="${currentTab == 'profile' ? 'true' : 'false'}" class="${currentTab == 'profile' ? 'active' : ''}" onclick="switchDesktopTab('profile', this)">
                    <i class="bi bi-shield-check"></i> Security &amp; Profile
                </button>
            </nav>

            <div class="sidebar-promo">
                <div class="star-icon">
                    <i class="bi bi-cpu-fill"></i>
                </div>
                <h4>Platform Status</h4>
                <p>Central identity management, faculty leadership &amp; campus controls.</p>
                <div class="mt-2">
                    <span class="badge bg-white text-dark rounded-pill px-3 py-1.5 small fw-bold shadow-sm">
                        <i class="bi bi-check-circle-fill text-success me-1"></i>Healthy 99.98%
                    </span>
                </div>
            </div>
        </aside>

        <main class="desktop-main" role="main">
            <header class="desktop-header">
                <div>
                    <h1 class="header-title mb-0">Administrative Center</h1>
                    <div class="text-muted small mt-1 fw-medium">
                        <i class="bi bi-shield-check text-primary me-1"></i>
                        University Central Governance &bull; Master Operations
                    </div>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn btn-outline-light text-dark border bg-white rounded-pill px-3 py-1.5 fw-semibold d-inline-flex align-items-center gap-2 shadow-xs" onclick="switchDesktopTab('holidays', document.getElementById('tab-holidays'))" title="View School Holidays">
                        <i class="bi bi-calendar-heart text-danger"></i>
                        <span class="small">Holidays</span>
                    </button>

                    <div class="dropdown">
                        <button class="user-profile dropdown-toggle border-0 text-start" type="button" id="adminProfileDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                            <div class="user-avatar">
                                <c:choose>
                                    <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                                        <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="user-info-text pe-2">
                                <span class="user-name">${sessionScope.user.fullName}</span>
                                <span class="user-role">System Central <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill ms-1 px-2 py-0" style="font-size: 0.65rem; font-weight: 700;">ADMIN</span> <i class="bi bi-chevron-down ms-1" style="font-size:0.65rem;"></i></span>
                            </div>
                        </button>

                        <div class="dropdown-menu dropdown-menu-end shadow-lg rounded-4 p-0 border-0 mt-2 overflow-hidden user-dropdown-menu" aria-labelledby="adminProfileDropdown" style="width: 310px; z-index: 1060;" onclick="event.stopPropagation();">
                            <div class="p-3 border-bottom" style="background: linear-gradient(135deg, #f8fafc 0%, #edf2f7 100%);">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="user-avatar" style="width: 44px; height: 44px; border-radius: 14px; border: 2px solid #ffffff; box-shadow: 0 4px 10px rgba(0,0,0,0.06);">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                                                <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="overflow-hidden">
                                        <div class="text-muted small text-uppercase fw-semibold" style="font-size: 0.68rem; letter-spacing: 0.5px;">Master Administrator</div>
                                        <div class="fw-semibold text-dark text-truncate" style="font-size: 0.85rem;">${sessionScope.user.email}</div>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill mt-1" style="font-size: 0.68rem; font-weight: 700;">
                                            <i class="bi bi-shield-lock-fill me-1"></i>SYSTEM ADMIN
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="p-3">
                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom" style="font-size: 0.82rem;">
                                    <span class="text-muted d-flex align-items-center gap-2">
                                        <i class="bi bi-person-badge text-primary"></i> Admin ID
                                    </span>
                                    <span class="fw-bold text-dark font-monospace text-end text-truncate ms-2">
                                        ${sessionScope.user.formattedIdentifier}
                                    </span>
                                </div>

                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom" style="font-size: 0.82rem;">
                                    <span class="text-muted d-flex align-items-center gap-2">
                                        <i class="bi bi-key text-primary"></i> Authorization
                                    </span>
                                    <span class="fw-semibold text-dark text-end text-truncate ms-2">
                                        Central Superuser
                                    </span>
                                </div>

                                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="pt-2">
                                    <input type="hidden" name="redirect" value="/admin/dashboard?tab=profile">
                                    <div class="d-flex justify-content-between align-items-center" style="font-size: 0.82rem;">
                                        <span class="text-muted d-flex align-items-center gap-2">
                                            <i class="bi bi-shield-lock text-primary"></i> 2FA Security
                                        </span>
                                        <select name="twoFactorEnabled" class="form-select form-select-sm py-0 border-0 bg-light fw-bold" style="font-size: 0.8rem; width: auto;" onchange="this.form.submit()">
                                            <option value="false" ${!sessionScope.user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                                            <option value="true" ${sessionScope.user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                                        </select>
                                    </div>
                                </form>
                            </div>

                            <div class="p-3 bg-light border-top">
                                <button type="button" onclick="document.getElementById('logoutConfirmModal').style.display='flex'" class="btn btn-outline-danger w-100 rounded-pill py-2 fw-bold d-flex align-items-center justify-content-center gap-2" style="font-size: 0.85rem;">
                                    <i class="bi bi-box-arrow-right"></i> Logout
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <section id="admin-tab-overview" class="tab-section ${empty currentTab || currentTab == 'overview' ? 'active' : ''}">
                <div class="admin-hero-banner">
                    <div class="d-flex flex-column flex-lg-row align-items-start align-items-lg-center justify-content-between gap-3">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <span class="badge bg-white bg-opacity-20 text-white rounded-pill px-3 py-1 font-monospace" style="font-size:0.75rem; font-weight:700;">
                                    <i class="bi bi-shield-check me-1 text-warning"></i>UniTRS Master Control
                                </span>
                                <span class="badge bg-success text-white rounded-pill px-2.5 py-1" style="font-size:0.72rem; font-weight:700;">
                                    <i class="bi bi-activity me-1"></i>Live Server
                                </span>
                            </div>
                            <h2 class="fw-extrabold text-white mb-1" style="font-size:1.55rem; letter-spacing:-0.02em;">University Administration Dashboard</h2>
                            <p class="text-white text-opacity-80 small mb-0">Total system governance: manage users, verify prospective students & professors, and designate school deans.</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-light rounded-pill px-3.5 py-2 fw-bold small text-dark d-inline-flex align-items-center gap-2 shadow-xs" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                                <i class="bi bi-person-check-fill text-primary"></i> Review Users
                            </button>
                            <button type="button" class="btn btn-outline-light rounded-pill px-3.5 py-2 fw-bold small d-inline-flex align-items-center gap-2" onclick="switchDesktopTab('deans', document.getElementById('tab-deans'))">
                                <i class="bi bi-building"></i> Deans
                            </button>
                        </div>
                    </div>
                </div>

                <div class="metrics-grid">
                    <div class="metric-card" role="button" tabindex="0" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon blue"><i class="bi bi-people-fill"></i></div>
                            <div class="mc-title">TOTAL USERS</div>
                        </div>
                        <div class="mc-value">${totalUsers}</div>
                        <div class="mc-subtitle">Registered accounts</div>
                    </div>
                    <div class="metric-card" role="button" tabindex="0" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon amber"><i class="bi bi-hourglass-split"></i></div>
                            <div class="mc-title">PENDING VERIFICATION</div>
                        </div>
                        <div class="mc-value text-warning">${pendingVerifications}</div>
                        <div class="mc-subtitle">Awaiting confirmation</div>
                    </div>
                    <div class="metric-card" role="button" tabindex="0" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon green"><i class="bi bi-mortarboard-fill"></i></div>
                            <div class="mc-title">STUDENTS</div>
                        </div>
                        <div class="mc-value text-success">${studentCount}</div>
                        <div class="mc-subtitle">Active student body</div>
                    </div>
                    <div class="metric-card" role="button" tabindex="0" onclick="switchDesktopTab('deans', document.getElementById('tab-deans'))">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon purple"><i class="bi bi-building-fill"></i></div>
                            <div class="mc-title">FACULTY &amp; STAFF</div>
                        </div>
                        <div class="mc-value text-purple">${staffCount}</div>
                        <div class="mc-subtitle">Professors &amp; Deans</div>
                    </div>
                </div>

                <c:if test="${not empty unverifiedStudents}">
                    <div class="table-card border-warning mb-4">
                        <div class="tc-header">
                            <div>
                                <h3 class="d-flex align-items-center gap-2">
                                    <i class="bi bi-exclamation-triangle-fill text-warning"></i>
                                    Pending Registrations Awaiting Verification (${unverifiedStudents.size()})
                                </h3>
                                <div class="text-muted small mt-1">Review new registrations and confirm authorizations</div>
                            </div>
                            <button type="button" class="btn btn-sm btn-dark rounded-pill px-3 py-1.5 fw-bold" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                                Open All in Users Tab <i class="bi bi-arrow-right ms-1"></i>
                            </button>
                        </div>
                        <div class="tc-table-wrap">
                            <table class="tc-table">
                                <thead>
                                    <tr>
                                        <th>Identifier</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Requested Role</th>
                                        <th>Department / Major</th>
                                        <th class="text-end">Verification Decision</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${unverifiedStudents}" begin="0" end="4">
                                        <tr>
                                            <td><span class="badge bg-light text-dark border font-monospace px-2 py-1">${u.formattedIdentifier}</span></td>
                                            <td><div class="fw-bold text-dark">${u.fullName}</div></td>
                                            <td><span class="text-muted">${u.email}</span></td>
                                            <td>
                                                <span class="badge ${u.role == 'PROFESSOR' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-primary-subtle text-primary border border-primary-subtle'} rounded-pill px-2.5 py-1">
                                                    ${u.role}
                                                </span>
                                            </td>
                                            <td><span class="text-secondary">${not empty u.major ? u.major : 'General'}</span></td>
                                            <td class="text-end">
                                                <form action="${pageContext.request.contextPath}/admin/users/verify" method="POST" class="d-inline-flex align-items-center gap-1.5">
                                                    <input type="hidden" name="userId" value="${u.id}">
                                                    <select name="role" class="form-select form-select-sm rounded-pill py-1 px-2 border" style="width: auto; font-size: 0.78rem;">
                                                        <option value="STUDENT" ${u.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                                        <option value="PROFESSOR" ${u.role == 'PROFESSOR' ? 'selected' : ''}>Professor</option>
                                                        <option value="DEAN" ${u.role == 'DEAN' ? 'selected' : ''}>Dean</option>
                                                        <option value="ADMIN" ${u.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                    </select>
                                                    <button type="submit" name="action" value="approve" class="btn btn-sm btn-success rounded-pill px-2.5 py-1 fw-bold" style="font-size:0.75rem;">
                                                        <i class="bi bi-check2"></i> Approve
                                                    </button>
                                                    <button type="submit" name="action" value="reject" class="btn btn-sm btn-outline-danger rounded-pill px-2 py-1 fw-semibold" style="font-size:0.75rem;">
                                                        <i class="bi bi-x"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>

                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="table-card h-100">
                            <div class="tc-header">
                                <h3 class="d-flex align-items-center gap-2">
                                    <i class="bi bi-pie-chart-fill text-primary"></i> User Role Distribution
                                </h3>
                                <span class="badge bg-light text-muted border">${totalUsers} Total Accounts</span>
                            </div>
                            <div class="pt-2">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small fw-bold text-dark">Students</span>
                                    <span class="small text-muted">${studentCount} (${totalUsers > 0 ? Math.round((studentCount * 100.0) / totalUsers) : 0}%)</span>
                                </div>
                                <div class="progress mb-4" style="height: 8px; border-radius: 99px;">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: ${totalUsers > 0 ? (studentCount * 100.0) / totalUsers : 0}%;"></div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small fw-bold text-dark">Faculty &amp; Staff</span>
                                    <span class="small text-muted">${staffCount} (${totalUsers > 0 ? Math.round((staffCount * 100.0) / totalUsers) : 0}%)</span>
                                </div>
                                <div class="progress mb-4" style="height: 8px; border-radius: 99px;">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: ${totalUsers > 0 ? (staffCount * 100.0) / totalUsers : 0}%;"></div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small fw-bold text-dark">Pending Verifications</span>
                                    <span class="small text-muted">${pendingVerifications} (${totalUsers > 0 ? Math.round((pendingVerifications * 100.0) / totalUsers) : 0}%)</span>
                                </div>
                                <div class="progress" style="height: 8px; border-radius: 99px;">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: ${totalUsers > 0 ? (pendingVerifications * 100.0) / totalUsers : 0}%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="table-card h-100">
                            <div class="tc-header">
                                <h3 class="d-flex align-items-center gap-2">
                                    <i class="bi bi-lightning-charge-fill text-warning"></i> Quick Management Hub
                                </h3>
                            </div>
                            <div class="d-flex flex-column gap-2.5 pt-2">
                                <a href="javascript:void(0)" onclick="switchDesktopTab('users', document.getElementById('tab-users'))" class="p-3 bg-light rounded-3 text-decoration-none d-flex align-items-center justify-content-between hover-primary">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="p-2.5 bg-primary bg-opacity-10 text-primary rounded-3"><i class="bi bi-person-lines-fill fs-5"></i></div>
                                        <div>
                                            <div class="fw-bold text-dark small">Manage All Users</div>
                                            <div class="text-muted" style="font-size:0.75rem;">View accounts, activate, or deactivate users</div>
                                        </div>
                                    </div>
                                    <i class="bi bi-chevron-right text-muted"></i>
                                </a>

                                <a href="javascript:void(0)" onclick="switchDesktopTab('deans', document.getElementById('tab-deans'))" class="p-3 bg-light rounded-3 text-decoration-none d-flex align-items-center justify-content-between hover-primary">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="p-2.5 bg-success bg-opacity-10 text-success rounded-3"><i class="bi bi-building-check fs-5"></i></div>
                                        <div>
                                            <div class="fw-bold text-dark small">Assign School Deans</div>
                                            <div class="text-muted" style="font-size:0.75rem;">Delegate faculty leadership to university schools</div>
                                        </div>
                                    </div>
                                    <i class="bi bi-chevron-right text-muted"></i>
                                </a>

                                <a href="javascript:void(0)" onclick="switchDesktopTab('holidays', document.getElementById('tab-holidays'))" class="p-3 bg-light rounded-3 text-decoration-none d-flex align-items-center justify-content-between hover-primary">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="p-2.5 bg-danger bg-opacity-10 text-danger rounded-3"><i class="bi bi-calendar-heart fs-5"></i></div>
                                        <div>
                                            <div class="fw-bold text-dark small">University Holidays Calendar</div>
                                            <div class="text-muted" style="font-size:0.75rem;">View national and institutional holidays for 2026</div>
                                        </div>
                                    </div>
                                    <i class="bi bi-chevron-right text-muted"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section id="admin-tab-users" class="tab-section ${currentTab == 'users' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">User Management &amp; Access Control</h4>
                        <div class="text-muted small">Verify incoming registrations and manage user statuses across all roles</div>
                    </div>
                    <span class="badge bg-primary text-white rounded-pill px-3 py-1.5 fw-bold font-monospace">${users.size()} Accounts</span>
                </div>

                <c:if test="${not empty unverifiedStudents}">
                    <div class="table-card border-warning mb-4">
                        <div class="tc-header">
                            <div>
                                <h3 class="d-flex align-items-center gap-2">
                                    <i class="bi bi-shield-exclamation text-warning"></i>
                                    Pending Authorizations (${unverifiedStudents.size()})
                                </h3>
                                <div class="text-muted small mt-1">Select the authorized university role and confirm or decline the account</div>
                            </div>
                        </div>
                        <div class="tc-table-wrap">
                            <table class="tc-table">
                                <thead>
                                    <tr>
                                        <th>Identifier</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Requested Role</th>
                                        <th>Major / Dept</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="student" items="${unverifiedStudents}">
                                        <tr>
                                            <td><span class="badge bg-light text-dark border font-monospace px-2 py-1">${student.formattedIdentifier}</span></td>
                                            <td><div class="fw-bold text-dark">${student.fullName}</div></td>
                                            <td><span class="text-muted">${student.email}</span></td>
                                            <td>
                                                <span class="badge ${student.role == 'PROFESSOR' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-primary-subtle text-primary border border-primary-subtle'} rounded-pill px-2.5 py-1">
                                                    ${student.role}
                                                </span>
                                            </td>
                                            <td><span class="text-secondary">${not empty student.major ? student.major : '—'}</span></td>
                                            <td class="text-end">
                                                <form action="${pageContext.request.contextPath}/admin/users/verify" method="POST" class="d-inline-flex align-items-center gap-1.5">
                                                    <input type="hidden" name="userId" value="${student.id}">
                                                    <select name="role" class="form-select form-select-sm rounded-pill py-1 px-2 border" style="width: auto; font-size: 0.78rem;">
                                                        <option value="STUDENT" ${student.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                                        <option value="PROFESSOR" ${student.role == 'PROFESSOR' ? 'selected' : ''}>Professor</option>
                                                        <option value="DEAN" ${student.role == 'DEAN' ? 'selected' : ''}>Dean</option>
                                                        <option value="ADMIN" ${student.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                    </select>
                                                    <button type="submit" name="action" value="approve" class="btn btn-sm btn-success rounded-pill px-3 py-1 fw-bold" style="font-size:0.75rem;">
                                                        <i class="bi bi-check2"></i> Approve
                                                    </button>
                                                    <button type="submit" name="action" value="reject" class="btn btn-sm btn-outline-danger rounded-pill px-2 py-1 fw-semibold" style="font-size:0.75rem;">
                                                        <i class="bi bi-x"></i> Reject
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>

                <div class="table-card">
                    <div class="tc-header flex-wrap gap-2">
                        <div class="d-flex align-items-center gap-2 flex-wrap" id="desktopRoleFilterContainer">
                            <button type="button" class="btn-filter-pill active" onclick="filterDesktopRole('all', this)">All (${users.size()})</button>
                            <button type="button" class="btn-filter-pill" onclick="filterDesktopRole('STUDENT', this)">Students (${studentCount})</button>
                            <button type="button" class="btn-filter-pill" onclick="filterDesktopRole('PROFESSOR', this)">Professors</button>
                            <button type="button" class="btn-filter-pill" onclick="filterDesktopRole('DEAN', this)">Deans</button>
                            <button type="button" class="btn-filter-pill" onclick="filterDesktopRole('ADMIN', this)">Admins</button>
                        </div>
                        <div style="width: 260px;">
                            <input type="text" class="form-control form-control-sm rounded-pill border" id="desktopUserFilterInput" placeholder="Filter by name or email..." oninput="filterDesktopUsersTable(this.value)">
                        </div>
                    </div>
                    <div class="tc-table-wrap">
                        <table class="tc-table" id="desktopUsersTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Identifier</th>
                                    <th>User Profile</th>
                                    <th>Email Address</th>
                                    <th>Role</th>
                                    <th>Verified</th>
                                    <th>Account Status</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${users}">
                                    <tr class="desktop-user-row" data-role="${u.role}" data-name="${u.fullName.toLowerCase()}" data-email="${u.email.toLowerCase()}" data-id="${u.formattedIdentifier}">
                                        <td><span class="text-muted small">#${u.id}</span></td>
                                        <td><span class="badge bg-light text-dark border font-monospace px-2 py-1">${u.formattedIdentifier}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="rounded-circle bg-light d-flex align-items-center justify-content-center fw-bold text-secondary" style="width: 32px; height: 32px; font-size: 0.75rem;">
                                                    ${u.fullName.substring(0, 1)}
                                                </div>
                                                <div class="fw-bold text-dark">${u.fullName}</div>
                                            </div>
                                        </td>
                                        <td><span class="text-muted small">${u.email}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.role == 'ADMIN'}"><span class="badge bg-danger text-white rounded-pill px-2.5 py-1">ADMIN</span></c:when>
                                                <c:when test="${u.role == 'DEAN'}"><span class="badge bg-purple text-white rounded-pill px-2.5 py-1" style="background:#7c3aed;">DEAN</span></c:when>
                                                <c:when test="${u.role == 'PROFESSOR'}"><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2.5 py-1">PROFESSOR</span></c:when>
                                                <c:otherwise><span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-2.5 py-1">STUDENT</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.verified}"><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2 py-0.5"><i class="bi bi-check-circle-fill me-1"></i>Verified</span></c:when>
                                                <c:otherwise><span class="badge bg-warning-subtle text-warning border border-warning-subtle rounded-pill px-2 py-0.5"><i class="bi bi-clock-fill me-1"></i>Pending</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.active}"><span class="badge bg-success rounded-pill px-2.5 py-1">Active</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary rounded-pill px-2.5 py-1">Inactive</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <c:if test="${u.id != sessionScope.user.id}">
                                                <form action="${pageContext.request.contextPath}/admin/users/status" method="POST" class="d-inline">
                                                    <input type="hidden" name="userId" value="${u.id}">
                                                    <c:choose>
                                                        <c:when test="${u.active}">
                                                            <input type="hidden" name="action" value="deactivate">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2.5 py-1 fw-semibold" style="font-size:0.75rem;">
                                                                <i class="bi bi-person-slash me-1"></i>Deactivate
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="hidden" name="action" value="activate">
                                                            <button type="submit" class="btn btn-sm btn-outline-success rounded-pill px-2.5 py-1 fw-semibold" style="font-size:0.75rem;">
                                                                <i class="bi bi-person-check me-1"></i>Activate
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <section id="admin-tab-deans" class="tab-section ${currentTab == 'deans' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">Faculty &amp; School Dean Leadership</h4>
                        <div class="text-muted small">Designate professors as academic deans to supervise faculties and courses</div>
                    </div>
                    <span class="badge bg-primary text-white rounded-pill px-3 py-1.5 fw-bold font-monospace">${schools.size()} Schools</span>
                </div>

                <div class="table-card">
                    <div class="tc-header">
                        <h3 class="d-flex align-items-center gap-2">
                            <i class="bi bi-building-fill text-primary"></i> University Schools &amp; Designated Deans
                        </h3>
                    </div>
                    <div class="tc-table-wrap">
                        <table class="tc-table">
                            <thead>
                                <tr>
                                    <th>School ID</th>
                                    <th>School Name</th>
                                    <th>Current Dean Status</th>
                                    <th>Assign / Reassign Dean</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="school" items="${schools}">
                                    <c:set var="currentDean" value="${currentDeans[school.id]}" />
                                    <tr>
                                        <td><span class="badge bg-light text-dark border font-monospace px-2 py-1">SCH-${school.id}</span></td>
                                        <td>
                                            <div class="fw-bold text-dark">${school.schoolName}</div>
                                            <div class="text-muted" style="font-size:0.75rem;">Main Campus Academic Division</div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty currentDean}">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                            <i class="bi bi-person-badge-fill"></i>
                                                        </div>
                                                        <div>
                                                            <div class="fw-bold text-dark small">${currentDean.fullName}</div>
                                                            <div class="text-muted" style="font-size:0.72rem;">${currentDean.email}</div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 rounded-pill px-2.5 py-1">
                                                        <i class="bi bi-exclamation-circle me-1"></i>Unassigned
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/deans/assign" method="post" class="d-flex align-items-center gap-2 m-0">
                                                <input type="hidden" name="schoolId" value="${school.id}">
                                                <select name="professorId" class="form-select form-select-sm rounded-pill border" style="max-width: 280px; font-size: 0.8rem;">
                                                    <option value="">-- Unassign Dean --</option>
                                                    <c:forEach var="prof" items="${professors}">
                                                        <option value="${prof.id}" ${not empty currentDean && currentDean.id == prof.id ? 'selected' : ''}>
                                                            ${prof.fullName} (${prof.email})
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" class="btn btn-sm btn-primary rounded-pill px-3 py-1 fw-bold shadow-xs" style="font-size: 0.78rem;">
                                                    <i class="bi bi-save me-1"></i>Save
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <section id="admin-tab-holidays" class="tab-section ${currentTab == 'holidays' ? 'active' : ''}">
                <jsp:include page="/WEB-INF/views/common/school_holidays_view.jsp" />
            </section>

            <section id="admin-tab-profile" class="tab-section ${currentTab == 'profile' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">Administrative Profile &amp; Platform Security</h4>
                        <div class="text-muted small">Manage account authentication, multi-factor verification, and system telemetry</div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-5">
                        <div class="table-card text-center p-4">
                            <div class="mx-auto mb-3" style="width: 84px; height: 84px; border-radius: 28px; background: #eff6ff; color: #2563eb; display: flex; align-items: center; justify-content: center; font-size: 2.2rem; font-weight: 800; border: 3px solid #dbeafe; box-shadow: 0 8px 24px rgba(37, 99, 235, 0.15);">
                                <c:choose>
                                    <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                                        <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:25px;">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:25px;">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h5 class="fw-bold text-dark mb-1">${sessionScope.user.fullName}</h5>
                            <div class="text-muted small mb-2">${sessionScope.user.email}</div>
                            <div class="d-flex justify-content-center gap-2 mb-3">
                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3 py-1 font-monospace fw-bold">ADMINISTRATOR</span>
                                <span class="badge bg-light text-dark border font-monospace px-2.5 py-1">${sessionScope.user.formattedIdentifier}</span>
                            </div>
                            <div class="p-3 bg-light rounded-3 text-start small">
                                <div class="d-flex justify-content-between mb-1.5">
                                    <span class="text-muted">Account Status:</span>
                                    <span class="fw-bold text-success"><i class="bi bi-shield-check me-1"></i>Active</span>
                                </div>
                                <div class="d-flex justify-content-between mb-1.5">
                                    <span class="text-muted">System Level:</span>
                                    <span class="fw-bold text-dark">Central Master</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Authority:</span>
                                    <span class="fw-bold text-primary">Unrestricted</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-7">
                        <div class="table-card p-4 mb-4">
                            <h3 class="mb-3 d-flex align-items-center gap-2">
                                <i class="bi bi-shield-lock-fill text-primary"></i> Two-Factor Authentication (2FA)
                            </h3>
                            <p class="text-muted small mb-3">
                                Multi-factor verification strengthens administrator portal security by sending a one-time OTP to your verified email upon login.
                            </p>
                            <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST">
                                <input type="hidden" name="redirect" value="/admin/dashboard?tab=profile">
                                <div class="d-flex align-items-center justify-content-between p-3 bg-light rounded-3 border mb-3">
                                    <div>
                                        <div class="fw-bold text-dark small">Login OTP Verification</div>
                                        <div class="text-muted" style="font-size:0.75rem;">Require verification code on every web portal sign-in</div>
                                    </div>
                                    <div class="form-check form-switch m-0 fs-5">
                                        <input class="form-check-input" type="checkbox" name="twoFactorEnabled" value="true" ${sessionScope.user.twoFactorEnabled ? 'checked' : ''} onchange="this.form.submit()">
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="table-card p-4">
                            <h3 class="mb-3 d-flex align-items-center gap-2">
                                <i class="bi bi-hdd-network-fill text-success"></i> Central Telemetry &amp; System Health
                            </h3>
                            <div class="row g-3">
                                <div class="col-6">
                                    <div class="p-3 bg-light rounded-3 border text-center">
                                        <div class="text-muted small" style="font-size:0.75rem;">Database Connectivity</div>
                                        <div class="fw-bold text-success fs-6 mt-1"><i class="bi bi-check-circle-fill me-1"></i>Connected</div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="p-3 bg-light rounded-3 border text-center">
                                        <div class="text-muted small" style="font-size:0.75rem;">Email Dispatch Gateway</div>
                                        <div class="fw-bold text-primary fs-6 mt-1"><i class="bi bi-send-check-fill me-1"></i>Online</div>
                                    </div>
                                </div>
                            </div>
                            <div class="pt-3 mt-3 border-top">
                                <button type="button" class="btn btn-outline-danger rounded-pill px-4 py-2 fw-bold w-100 shadow-xs" onclick="document.getElementById('logoutConfirmModal').style.display='flex'">
                                    <i class="bi bi-box-arrow-right me-1.5"></i> Sign Out of Admin Account
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <div class="mobile-app-container d-block d-md-none">
        <header class="admin-mobile-topbar" role="banner">
            <div class="d-flex align-items-center justify-content-between w-100">
                <div class="d-flex align-items-center gap-3">
                    <div class="admin-top-avatar">
                        <c:choose>
                            <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                                <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:12px;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:12px;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="fw-extrabold text-dark" style="font-size: 1.05rem; letter-spacing: -0.02em;">Admin Portal</span>
                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2 py-0" style="font-size:0.65rem; font-weight:700;">ADMIN</span>
                        </div>
                        <div class="text-muted small fw-medium text-truncate" style="max-width: 170px; font-size: 0.75rem;">${sessionScope.user.fullName}</div>
                    </div>
                </div>

                <div class="d-flex align-items-center gap-2">
                    <button type="button" class="btn btn-light rounded-circle p-0 d-flex align-items-center justify-content-center shadow-xs" style="width: 38px; height: 38px; border: 1px solid rgba(226,232,240,0.8);" data-bs-toggle="modal" data-bs-target="#schoolHolidaysModal" aria-label="School Holidays">
                        <i class="bi bi-calendar-heart text-danger" style="font-size: 1rem;"></i>
                    </button>
                    <button type="button" class="btn btn-light rounded-circle p-0 d-flex align-items-center justify-content-center shadow-xs" style="width: 38px; height: 38px; border: 1px solid rgba(226,232,240,0.8);" onclick="document.getElementById('logoutConfirmModal').style.display='flex'" aria-label="Sign out">
                        <i class="bi bi-box-arrow-right text-danger" style="font-size: 1rem;"></i>
                    </button>
                </div>
            </div>
        </header>

        <section id="mobile-view-home" class="mobile-sub-view active" role="tabpanel" aria-labelledby="dock-tab-home">
            <div class="admin-hero-banner py-3 px-3 mb-3">
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span class="badge bg-white bg-opacity-20 text-white rounded-pill px-2.5 py-0.5 font-monospace" style="font-size:0.7rem;">
                        <i class="bi bi-shield-lock-fill me-1 text-warning"></i>UniTRS Core
                    </span>
                    <span class="badge bg-success text-white rounded-pill px-2 py-0.5" style="font-size:0.68rem;">Live</span>
                </div>
                <h4 class="fw-extrabold text-white mb-1" style="font-size:1.15rem;">Admin Overview</h4>
                <p class="text-white text-opacity-80 small mb-0" style="font-size:0.78rem;">System accounts, verifications &amp; deans</p>
            </div>

            <c:if test="${pendingVerifications > 0}">
                <div class="alert alert-warning d-flex align-items-center justify-content-between p-3 mb-3 rounded-4 border-warning shadow-xs" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-exclamation-triangle-fill text-warning fs-5"></i>
                        <div>
                            <div class="fw-bold small text-dark">${pendingVerifications} Pending Verifications</div>
                            <div class="text-muted" style="font-size:0.72rem;">Tap to review and approve users</div>
                        </div>
                    </div>
                    <span class="badge bg-warning text-dark rounded-pill px-2.5 py-1" style="font-size:0.7rem;">Review</span>
                </div>
            </c:if>

            <div class="admin-mobile-kpi-grid">
                <div class="admin-mobile-kpi-card" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="mc-icon blue mb-2"><i class="bi bi-people-fill"></i></div>
                    <div class="fw-extrabold fs-4 text-dark mb-0">${totalUsers}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Total Accounts</div>
                </div>
                <div class="admin-mobile-kpi-card" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="mc-icon amber mb-2"><i class="bi bi-hourglass-split"></i></div>
                    <div class="fw-extrabold fs-4 text-warning mb-0">${pendingVerifications}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Pending Review</div>
                </div>
                <div class="admin-mobile-kpi-card" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="mc-icon green mb-2"><i class="bi bi-mortarboard-fill"></i></div>
                    <div class="fw-extrabold fs-4 text-success mb-0">${studentCount}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Students</div>
                </div>
                <div class="admin-mobile-kpi-card" onclick="switchAdminMobileTab('deans')" role="button" tabindex="0">
                    <div class="mc-icon purple mb-2"><i class="bi bi-building-fill"></i></div>
                    <div class="fw-extrabold fs-4 text-purple mb-0">${schools.size()}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Schools</div>
                </div>
            </div>

            <div class="mobile-card-item p-3 mb-3 border-danger-subtle bg-danger-subtle bg-opacity-10" onclick="switchAdminMobileTab('holidays')" role="button" tabindex="0" style="cursor:pointer;">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-2">
                        <div class="p-2 rounded-3 bg-danger bg-opacity-10 text-danger"><i class="bi bi-calendar-heart fs-5"></i></div>
                        <div>
                            <div class="fw-bold text-dark small">School Holidays 2026</div>
                            <div class="text-muted" style="font-size:0.72rem;">View upcoming Cambodian national holidays</div>
                        </div>
                    </div>
                    <i class="bi bi-chevron-right text-muted"></i>
                </div>
            </div>
        </section>

        <section id="mobile-view-users" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-users">
            <div class="d-flex justify-content-between align-items-center mb-2.5">
                <h6 class="fw-bold text-dark mb-0">User Directory &amp; Verification</h6>
                <span class="badge bg-primary text-white rounded-pill px-2.5 py-1 font-monospace">${users.size()}</span>
            </div>

            <c:if test="${not empty unverifiedStudents}">
                <div class="mb-3">
                    <div class="small fw-bold text-warning text-uppercase mb-2" style="font-size:0.72rem; letter-spacing:0.04em;">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i>Action Required (${unverifiedStudents.size()})
                    </div>
                    <c:forEach var="student" items="${unverifiedStudents}">
                        <div class="mobile-card-item p-3 border-warning mb-2.5">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <div class="fw-bold text-dark">${student.fullName}</div>
                                    <div class="text-muted small" style="font-size:0.75rem;">${student.email}</div>
                                </div>
                                <span class="badge bg-warning text-dark font-monospace">${student.formattedIdentifier}</span>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/users/verify" method="POST" class="pt-2 border-top">
                                <input type="hidden" name="userId" value="${student.id}">
                                <div class="mb-2">
                                    <label class="form-label text-muted small mb-1" style="font-size:0.72rem;">Assign System Role</label>
                                    <select name="role" class="form-select form-select-sm rounded-pill" required>
                                        <option value="STUDENT" ${student.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                        <option value="PROFESSOR" ${student.role == 'PROFESSOR' ? 'selected' : ''}>Professor</option>
                                        <option value="DEAN" ${student.role == 'DEAN' ? 'selected' : ''}>Dean</option>
                                        <option value="ADMIN" ${student.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                    </select>
                                </div>
                                <div class="d-flex gap-2">
                                    <button type="submit" name="action" value="approve" class="btn btn-sm btn-success rounded-pill w-50 fw-bold">Approve</button>
                                    <button type="submit" name="action" value="reject" class="btn btn-sm btn-outline-danger rounded-pill w-50 fw-semibold">Reject</button>
                                </div>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <div class="mb-3">
                <input type="text" class="form-control form-control-sm rounded-pill border mb-2" id="mobileUserFilterInput" placeholder="Search users..." oninput="filterMobileUsersList(this.value)">
                <div class="d-flex gap-1.5 overflow-x-auto pb-1" style="scrollbar-width:none;" id="mobileRoleFilterContainer">
                    <button type="button" class="btn-filter-pill active" onclick="filterMobileRole('all', this)">All</button>
                    <button type="button" class="btn-filter-pill" onclick="filterMobileRole('STUDENT', this)">Students</button>
                    <button type="button" class="btn-filter-pill" onclick="filterMobileRole('PROFESSOR', this)">Professors</button>
                    <button type="button" class="btn-filter-pill" onclick="filterMobileRole('DEAN', this)">Deans</button>
                    <button type="button" class="btn-filter-pill" onclick="filterMobileRole('ADMIN', this)">Admins</button>
                </div>
            </div>

            <div id="mobileUsersListContainer">
                <c:forEach var="u" items="${users}">
                    <div class="mobile-card-item p-3 mobile-user-card" data-role="${u.role}" data-name="${u.fullName.toLowerCase()}" data-email="${u.email.toLowerCase()}" data-id="${u.formattedIdentifier}">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div class="d-flex align-items-center gap-2">
                                <div class="rounded-circle bg-light d-flex align-items-center justify-content-center fw-bold text-secondary" style="width: 32px; height: 32px; font-size: 0.75rem;">
                                    ${u.fullName.substring(0, 1)}
                                </div>
                                <div>
                                    <div class="fw-bold text-dark small">${u.fullName}</div>
                                    <div class="text-muted" style="font-size:0.72rem;">${u.email}</div>
                                </div>
                            </div>
                            <span class="badge ${u.active ? 'bg-success' : 'bg-secondary'} rounded-pill" style="font-size:0.65rem;">
                                ${u.active ? 'Active' : 'Inactive'}
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                            <div class="d-flex align-items-center gap-1.5">
                                <span class="badge bg-light text-dark border font-monospace" style="font-size:0.68rem;">${u.formattedIdentifier}</span>
                                <span class="badge bg-secondary-subtle text-secondary" style="font-size:0.68rem;">${u.role}</span>
                            </div>
                            <c:if test="${u.id != sessionScope.user.id}">
                                <form action="${pageContext.request.contextPath}/admin/users/status" method="POST" class="m-0">
                                    <input type="hidden" name="userId" value="${u.id}">
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <input type="hidden" name="action" value="deactivate">
                                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2.5 py-0" style="font-size:0.72rem; min-height:26px;">Deactivate</button>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="activate">
                                            <button type="submit" class="btn btn-sm btn-outline-success rounded-pill px-2.5 py-0" style="font-size:0.72rem; min-height:26px;">Activate</button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section id="mobile-view-deans" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-deans">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6 class="fw-bold text-dark mb-0">Dean Leadership Assignments</h6>
                <span class="badge bg-primary text-white rounded-pill px-2.5 py-1 font-monospace">${schools.size()} Schools</span>
            </div>

            <c:forEach var="school" items="${schools}">
                <c:set var="currentDean" value="${currentDeans[school.id]}" />
                <div class="mobile-card-item p-3 mb-3">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                            <div class="fw-bold text-dark">${school.schoolName}</div>
                            <div class="text-muted small" style="font-size:0.72rem;">Division Code: SCH-${school.id}</div>
                        </div>
                        <c:choose>
                            <c:when test="${not empty currentDean}">
                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill" style="font-size:0.68rem;">Dean Assigned</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning-subtle text-warning border border-warning-subtle rounded-pill" style="font-size:0.68rem;">Unassigned</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${not empty currentDean}">
                        <div class="p-2.5 bg-light rounded-3 d-flex align-items-center gap-2 mb-3">
                            <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                <i class="bi bi-person-badge-fill"></i>
                            </div>
                            <div>
                                <div class="fw-bold text-dark small">${currentDean.fullName}</div>
                                <div class="text-muted" style="font-size:0.7rem;">${currentDean.email}</div>
                            </div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/deans/assign" method="post" class="pt-2 border-top">
                        <input type="hidden" name="schoolId" value="${school.id}">
                        <label class="form-label text-muted small mb-1" style="font-size:0.72rem;">Designate Dean</label>
                        <div class="d-flex gap-2">
                            <select name="professorId" class="form-select form-select-sm rounded-pill" style="font-size:0.78rem;">
                                <option value="">-- Unassign Dean --</option>
                                <c:forEach var="prof" items="${professors}">
                                    <option value="${prof.id}" ${not empty currentDean && currentDean.id == prof.id ? 'selected' : ''}>
                                        ${prof.fullName}
                                    </option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="btn btn-sm btn-primary rounded-pill px-3 fw-bold">Save</button>
                        </div>
                    </form>
                </div>
            </c:forEach>
        </section>

        <section id="mobile-view-holidays" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-holidays">
            <jsp:include page="/WEB-INF/views/common/school_holidays_view.jsp" />
        </section>

        <section id="mobile-view-profile" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-profile">
            <div class="mobile-card-item p-4 text-center mb-3">
                <div class="mx-auto mb-3" style="width: 72px; height: 72px; border-radius: 24px; background: #eff6ff; color: #2563eb; display: flex; align-items: center; justify-content: center; font-size: 1.8rem; font-weight: 800; border: 2px solid #dbeafe;">
                    <c:choose>
                        <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                            <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:22px;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:22px;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <h5 class="fw-bold text-dark mb-1">${sessionScope.user.fullName}</h5>
                <div class="text-muted small mb-2">${sessionScope.user.email}</div>
                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3 py-1 font-monospace fw-bold">ADMINISTRATOR</span>
            </div>

            <div class="mobile-card-item p-3 mb-3">
                <h6 class="fw-bold text-dark mb-2">Two-Factor Authentication</h6>
                <p class="text-muted small mb-3" style="font-size:0.75rem;">Protect your administrator account with OTP verification.</p>
                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST">
                    <input type="hidden" name="redirect" value="/admin/dashboard?tab=profile">
                    <button type="submit" class="btn btn-sm ${sessionScope.user.twoFactorEnabled ? 'btn-outline-danger' : 'btn-primary'} w-100 rounded-pill py-2 fw-bold" style="min-height:44px;">
                        <i class="bi ${sessionScope.user.twoFactorEnabled ? 'bi-shield-slash' : 'bi-shield-check'} me-1"></i>
                        ${sessionScope.user.twoFactorEnabled ? 'Disable 2-Step Verification' : 'Enable 2-Step Verification'}
                    </button>
                </form>
            </div>

            <div class="pt-2 mb-4">
                <button type="button" onclick="document.getElementById('logoutConfirmModal').style.display='flex'" class="btn btn-danger w-100 rounded-pill py-3 fw-bold shadow-sm" style="min-height:48px; display:flex; align-items:center; justify-content:center; gap:8px;">
                    <i class="bi bi-box-arrow-right"></i> Sign Out of Admin Account
                </button>
            </div>
        </section>

        <nav class="mobile-bottom-dock mobile-dock" role="navigation" aria-label="Admin Mobile Navigation">
            <button type="button" class="dock-tab-btn active" id="dock-tab-home" data-tab="home" onclick="switchAdminMobileTab('home')" role="tab" aria-selected="true" aria-controls="mobile-view-home" aria-label="Home Overview">
                <i class="bi bi-house-door-fill"></i>
                <span>Home</span>
            </button>
            <button type="button" class="dock-tab-btn position-relative" id="dock-tab-users" data-tab="users" onclick="switchAdminMobileTab('users')" role="tab" aria-selected="false" aria-controls="mobile-view-users" aria-label="Users & Verification">
                <i class="bi bi-people"></i>
                <span>Users</span>
                <c:if test="${pendingVerifications > 0}">
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.58rem; transform: translate(-75%, 20%) !important;">
                        ${pendingVerifications}
                    </span>
                </c:if>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-deans" data-tab="deans" onclick="switchAdminMobileTab('deans')" role="tab" aria-selected="false" aria-controls="mobile-view-deans" aria-label="Dean Leadership">
                <i class="bi bi-building"></i>
                <span>Deans</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-holidays" data-tab="holidays" onclick="switchAdminMobileTab('holidays')" role="tab" aria-selected="false" aria-controls="mobile-view-holidays" aria-label="School Holidays">
                <i class="bi bi-calendar-heart"></i>
                <span>Holidays</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-profile" data-tab="profile" onclick="switchAdminMobileTab('profile')" role="tab" aria-selected="false" aria-controls="mobile-view-profile" aria-label="Profile Settings">
                <i class="bi bi-shield"></i>
                <span>Profile</span>
            </button>
        </nav>
    </div>

    <jsp:include page="/WEB-INF/views/common/school_holidays_modal.jsp" />

    <div id="logoutConfirmModal" style="display:none; position:fixed; inset:0; z-index:9999; align-items:center; justify-content:center; background:rgba(15,23,42,0.55); backdrop-filter:blur(4px);" aria-modal="true" role="dialog" aria-labelledby="logoutModalTitle">
        <div style="background:#fff; border-radius:24px; padding:2.5rem 3rem; max-width:480px; width:90%; box-shadow:0 24px 64px -12px rgba(0,0,0,0.35); text-align:center; animation:slideUpModal 0.25s cubic-bezier(.34,1.56,.64,1);">
            <div style="width:64px;height:64px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;margin:0 auto 1.25rem;">
                <i class="bi bi-box-arrow-right" style="font-size:1.75rem;color:#dc2626;"></i>
            </div>
            <h4 id="logoutModalTitle" style="font-weight:800;color:#0f172a;margin-bottom:0.75rem;">Sign Out?</h4>
            <p style="color:#64748b;font-size:1rem;margin-bottom:2rem;line-height:1.5;">Are you sure you want to log out of your account? Any unsaved changes will be lost.</p>
            <div style="display:flex;gap:1rem;justify-content:center;">
                <button type="button" onclick="document.getElementById('logoutConfirmModal').style.display='none'" style="flex:1;padding:0.75rem 1.5rem;border-radius:50px;border:2px solid #e2e8f0;background:#fff;color:#475569;font-weight:700;font-size:1rem;cursor:pointer;transition:all 0.2s;" onmouseover="this.style.background='#f1f5f9'" onmouseout="this.style.background='#fff'">Cancel</button>
                <a href="${pageContext.request.contextPath}/auth/logout" style="flex:1;padding:0.75rem 1.5rem;border-radius:50px;border:none;background:#b91c1c;color:#fff;font-weight:700;font-size:1rem;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;gap:0.5rem;box-shadow:0 4px 14px rgba(185,28,28,0.35);transition:all 0.2s;" onmouseover="this.style.opacity='0.9'" onmouseout="this.style.opacity='1'"><i class="bi bi-box-arrow-right"></i> Yes, Sign Out</a>
            </div>
        </div>
    </div>

    <style>
    @keyframes slideUpModal {
        from { opacity:0; transform:translateY(30px) scale(0.95); }
        to   { opacity:1; transform:translateY(0) scale(1); }
    }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        var currentActiveRoleFilter = 'all';

        function switchDesktopTab(tabId, btn) {
            var tabs = document.querySelectorAll('.desktop-sidebar .sidebar-nav button');
            tabs.forEach(function(b) {
                b.classList.remove('active');
                b.setAttribute('aria-selected', 'false');
            });
            if (btn) {
                btn.classList.add('active');
                btn.setAttribute('aria-selected', 'true');
            } else {
                var autoBtn = document.getElementById('tab-' + tabId);
                if (autoBtn) {
                    autoBtn.classList.add('active');
                    autoBtn.setAttribute('aria-selected', 'true');
                }
            }

            var sections = document.querySelectorAll('.desktop-main .tab-section');
            sections.forEach(function(sec) {
                sec.classList.remove('active');
            });

            var targetSection = document.getElementById('admin-tab-' + tabId);
            if (targetSection) {
                targetSection.classList.add('active');
            }

            try {
                var url = new URL(window.location);
                url.searchParams.set('tab', tabId);
                window.history.replaceState({}, '', url);
            } catch (e) {}

            var searchInput = document.getElementById('adminSearchInput');
            if (searchInput && searchInput.value) {
                filterActiveAdminTable(searchInput.value);
            }
        }

        function switchAdminMobileTab(tabId) {
            var views = document.querySelectorAll('.mobile-app-container .mobile-sub-view');
            views.forEach(function(v) {
                v.classList.remove('active');
            });

            var targetView = document.getElementById('mobile-view-' + tabId);
            if (targetView) {
                targetView.classList.add('active');
            }

            var dockBtns = document.querySelectorAll('.mobile-bottom-dock .dock-tab-btn');
            dockBtns.forEach(function(btn) {
                btn.classList.remove('active');
                btn.setAttribute('aria-selected', 'false');
                var icon = btn.querySelector('i');
                var tab = btn.getAttribute('data-tab');
                if (tab === tabId) {
                    btn.classList.add('active');
                    btn.setAttribute('aria-selected', 'true');
                    if (icon) {
                        if (tab === 'home') icon.className = 'bi bi-house-door-fill';
                        else if (tab === 'users') icon.className = 'bi bi-people-fill';
                        else if (tab === 'deans') icon.className = 'bi bi-building-fill';
                        else if (tab === 'holidays') icon.className = 'bi bi-calendar-heart-fill';
                        else if (tab === 'profile') icon.className = 'bi bi-shield-fill';
                    }
                } else {
                    if (icon) {
                        if (tab === 'home') icon.className = 'bi bi-house-door';
                        else if (tab === 'users') icon.className = 'bi bi-people';
                        else if (tab === 'deans') icon.className = 'bi bi-building';
                        else if (tab === 'holidays') icon.className = 'bi bi-calendar-heart';
                        else if (tab === 'profile') icon.className = 'bi bi-shield';
                    }
                }
            });

            try {
                var url = new URL(window.location);
                url.searchParams.set('tab', tabId);
                window.history.replaceState({}, '', url);
            } catch (e) {}

            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function filterDesktopRole(role, btn) {
            currentActiveRoleFilter = role;
            var pills = document.querySelectorAll('#desktopRoleFilterContainer .btn-filter-pill');
            pills.forEach(function(p) { p.classList.remove('active'); });
            if (btn) btn.classList.add('active');
            applyDesktopUserFilters();
        }

        function filterDesktopUsersTable(query) {
            applyDesktopUserFilters();
        }

        function applyDesktopUserFilters() {
            var searchInput = document.getElementById('desktopUserFilterInput');
            var q = (searchInput ? searchInput.value : '').toLowerCase().trim();
            var rows = document.querySelectorAll('#desktopUsersTable tbody tr.desktop-user-row');

            rows.forEach(function(r) {
                var role = r.getAttribute('data-role');
                var name = r.getAttribute('data-name') || '';
                var email = r.getAttribute('data-email') || '';
                var id = r.getAttribute('data-id') || '';

                var matchesRole = (currentActiveRoleFilter === 'all' || role === currentActiveRoleFilter);
                var matchesQuery = !q || name.indexOf(q) !== -1 || email.indexOf(q) !== -1 || id.indexOf(q) !== -1;

                if (matchesRole && matchesQuery) {
                    r.style.display = '';
                } else {
                    r.style.display = 'none';
                }
            });
        }

        function filterMobileRole(role, btn) {
            currentActiveRoleFilter = role;
            var pills = document.querySelectorAll('#mobileRoleFilterContainer .btn-filter-pill');
            pills.forEach(function(p) { p.classList.remove('active'); });
            if (btn) btn.classList.add('active');
            applyMobileUserFilters();
        }

        function filterMobileUsersList(val) {
            applyMobileUserFilters();
        }

        function applyMobileUserFilters() {
            var searchInput = document.getElementById('mobileUserFilterInput');
            var q = (searchInput ? searchInput.value : '').toLowerCase().trim();
            var cards = document.querySelectorAll('#mobileUsersListContainer .mobile-user-card');

            cards.forEach(function(c) {
                var role = c.getAttribute('data-role');
                var name = c.getAttribute('data-name') || '';
                var email = c.getAttribute('data-email') || '';
                var id = c.getAttribute('data-id') || '';

                var matchesRole = (currentActiveRoleFilter === 'all' || role === currentActiveRoleFilter);
                var matchesQuery = !q || name.indexOf(q) !== -1 || email.indexOf(q) !== -1 || id.indexOf(q) !== -1;

                if (matchesRole && matchesQuery) {
                    c.style.display = '';
                } else {
                    c.style.display = 'none';
                }
            });
        }

        function filterActiveAdminTable(query) {
            query = (query || '').toLowerCase().trim();
            var activeTab = document.querySelector('.tab-section.active');
            if (!activeTab) return;

            if (activeTab.id === 'admin-tab-overview') {
                if (query.length > 0) {
                    switchDesktopTab('users', document.getElementById('tab-users'));
                    var dtInput = document.getElementById('desktopUserFilterInput');
                    if (dtInput) {
                        dtInput.value = query;
                        applyDesktopUserFilters();
                    }
                }
                return;
            }

            var rows = activeTab.querySelectorAll('.tc-table tbody tr');
            rows.forEach(function(row) {
                var text = (row.textContent || '').toLowerCase();
                if (!query || text.indexOf(query) !== -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            var params = new URLSearchParams(window.location.search);
            var initialTab = params.get('tab');
            if (initialTab) {
                var dtBtn = document.getElementById('tab-' + initialTab);
                if (dtBtn) switchDesktopTab(initialTab, dtBtn);
                switchAdminMobileTab(initialTab);
            }
        });

        document.getElementById('logoutConfirmModal').addEventListener('click', function(e) {
            if (e.target === this) this.style.display = 'none';
        });
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') document.getElementById('logoutConfirmModal').style.display = 'none';
        });
    </script>
</body>
</html>
