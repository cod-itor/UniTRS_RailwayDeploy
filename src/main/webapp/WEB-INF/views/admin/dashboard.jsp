<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
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
            --surface-bg: #f8fafc;
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
            padding: 18px 16px;
            text-align: center;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
            border: 1px solid #bfdbfe;
        }

        .sidebar-promo .star-icon {
            width: 40px;
            height: 40px;
            background: #2563eb;
            color: white;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            margin-bottom: 10px;
            box-shadow: 0 8px 16px rgba(37, 99, 235, 0.25);
        }

        .sidebar-promo h4 {
            font-size: 0.88rem;
            font-weight: 800;
            color: var(--brand-dark);
            margin-bottom: 4px;
        }

        .sidebar-promo p {
            font-size: 0.72rem;
            color: #475569;
            margin-bottom: 10px;
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

        .user-profile:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
            transform: translateY(-1px);
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 0.88rem;
            flex-shrink: 0;
            border: 2px solid #ffffff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
        }

        .tab-panel {
            display: none;
        }

        .tab-panel.active {
            display: block;
            animation: adminFadeIn 0.22s ease-in-out;
        }

        @keyframes adminFadeIn {
            from { opacity: 0; transform: translateY(4px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .admin-hero-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 55%, #2563eb 100%);
            border-radius: 24px;
            padding: 26px 30px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
            box-shadow: 0 16px 36px rgba(15, 23, 42, 0.16);
            margin-bottom: 24px;
        }

        .admin-hero-banner::before {
            content: '';
            position: absolute;
            top: -60px;
            right: -60px;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.12) 0%, rgba(255, 255, 255, 0) 70%);
            pointer-events: none;
        }

        .kpi-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 24px;
        }

        .admin-kpi-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 20px;
            border: 1px solid var(--card-border);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.02);
            transition: all 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        .admin-kpi-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.04);
        }

        .kpi-icon-box {
            width: 44px;
            height: 44px;
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            margin-bottom: 14px;
        }

        .kpi-icon-box.blue { background: #eff6ff; color: #2563eb; }
        .kpi-icon-box.amber { background: #fffbeb; color: #d97706; }
        .kpi-icon-box.emerald { background: #f0fdf4; color: #16a34a; }
        .kpi-icon-box.purple { background: #faf5ff; color: #9333ea; }

        .kpi-val {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--brand-dark);
            line-height: 1.1;
            margin-bottom: 4px;
        }

        .kpi-label {
            font-size: 0.8rem;
            font-weight: 600;
            color: #64748b;
        }

        .table-card {
            background: #ffffff;
            border-radius: 24px;
            border: 1px solid var(--card-border);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.02);
            overflow: hidden;
            margin-bottom: 24px;
        }

        .table-card-header {
            padding: 20px 24px;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
            flex-wrap: wrap;
            gap: 14px;
        }

        .admin-filter-pill {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            color: #64748b;
            padding: 6px 14px;
            border-radius: 99px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.15s;
        }

        .admin-filter-pill:hover {
            background: #f1f5f9;
            color: var(--brand-dark);
        }

        .admin-filter-pill.active {
            background: var(--brand-dark);
            border-color: var(--brand-dark);
            color: #ffffff;
        }

        .custom-data-table {
            width: 100%;
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .custom-data-table th {
            background: #f8fafc;
            color: #475569;
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 20px;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        .custom-data-table td {
            padding: 14px 20px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.88rem;
            color: #334155;
        }

        .custom-data-table tbody tr:hover td {
            background-color: #f8fafc;
        }

        .admin-id-card {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 60%, #312e81 100%);
            border-radius: 24px;
            padding: 24px;
            color: #ffffff;
            box-shadow: 0 16px 36px rgba(15, 23, 42, 0.22);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.12);
        }

        .admin-id-card::after {
            content: '';
            position: absolute;
            bottom: -50px;
            right: -50px;
            width: 180px;
            height: 180px;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.25) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        @media (max-width: 767.98px) {
            body {
                background: #f8fafc;
                padding-bottom: 0 !important;
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
                box-sizing: border-box !important;
            }

            .admin-mobile-topbar {
                position: sticky;
                top: 0;
                z-index: 1020;
                background: rgba(248, 250, 252, 0.94);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border-bottom: 1px solid rgba(226, 232, 240, 0.8);
                padding: calc(12px + env(safe-area-inset-top, 0px)) 16px 12px;
                margin-left: -16px;
                margin-right: -16px;
                margin-bottom: 16px;
            }

            .admin-top-avatar {
                width: 42px;
                height: 42px;
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
                animation: adminMobileFadeIn 0.22s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes adminMobileFadeIn {
                from { opacity: 0; transform: translateY(6px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .mobile-kpi-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
                margin-bottom: 16px;
            }

            .mobile-card-item {
                background: #ffffff;
                border-radius: 20px;
                padding: 16px;
                border: 1px solid rgba(226, 232, 240, 0.75);
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.02);
                margin-bottom: 12px;
            }

            .mobile-bottom-dock {
                position: fixed;
                bottom: 16px;
                left: 16px;
                right: 16px;
                max-width: 508px;
                margin: 0 auto;
                background: rgba(15, 23, 42, 0.94);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border-radius: 99px;
                padding: 8px 12px;
                display: flex;
                justify-content: space-around;
                align-items: center;
                z-index: 1040;
                box-shadow: 0 16px 40px rgba(15, 23, 42, 0.35);
                border: 1px solid rgba(255, 255, 255, 0.15);
            }

            .dock-tab-btn {
                background: transparent;
                border: none;
                color: #94a3b8;
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 3px;
                font-size: 0.68rem;
                font-weight: 700;
                padding: 6px 14px;
                border-radius: 99px;
                transition: all 0.2s;
                position: relative;
                cursor: pointer;
            }

            .dock-tab-btn i {
                font-size: 1.15rem;
            }

            .dock-tab-btn.active {
                color: #ffffff;
                background: rgba(255, 255, 255, 0.15);
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

    <div class="desktop-layout d-none d-md-flex">
        <aside class="desktop-sidebar">
            <div class="sidebar-logo">
                <i class="bi bi-shield-lock-fill"></i>
                <span>UniTRS</span>
                <span class="badge bg-danger-subtle text-danger border border-danger-subtle ms-auto" style="font-size:0.65rem; font-weight:800; letter-spacing:0.04em;">ADMIN</span>
            </div>

            <div class="sidebar-search">
                <i class="bi bi-search"></i>
                <input type="text" id="desktopAdminSearch" placeholder="Search directory..." oninput="handleDesktopQuickSearch(this.value)">
            </div>

            <nav class="sidebar-nav">
                <button type="button" class="nav-item ${empty currentTab || currentTab == 'overview' ? 'active' : ''}" id="tab-overview" onclick="switchDesktopTab('overview', this)">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Overview</span>
                </button>
                <button type="button" class="nav-item ${currentTab == 'users' ? 'active' : ''}" id="tab-users" onclick="switchDesktopTab('users', this)">
                    <i class="bi bi-people-fill"></i>
                    <span>Users & Access</span>
                    <c:if test="${pendingVerifications > 0}">
                        <span class="nav-badge bg-warning text-dark font-monospace">${pendingVerifications}</span>
                    </c:if>
                </button>
                <button type="button" class="nav-item ${currentTab == 'deans' ? 'active' : ''}" id="tab-deans" onclick="switchDesktopTab('deans', this)">
                    <i class="bi bi-building-fill"></i>
                    <span>Dean Leadership</span>
                    <span class="nav-badge">${schools.size()}</span>
                </button>
                <button type="button" class="nav-item" onclick="new bootstrap.Modal(document.getElementById('schoolHolidaysModal')).show()">
                    <i class="bi bi-calendar-heart text-danger"></i>
                    <span>School Holidays</span>
                </button>
                <button type="button" class="nav-item ${currentTab == 'profile' ? 'active' : ''}" id="tab-profile" onclick="switchDesktopTab('profile', this)">
                    <i class="bi bi-shield-check"></i>
                    <span>Security & Profile</span>
                </button>
            </nav>

            <div class="sidebar-promo">
                <div class="star-icon">
                    <i class="bi bi-cpu-fill"></i>
                </div>
                <h4>Platform Status</h4>
                <p>UniTRS Enterprise Server is running nominal with active session security.</p>
                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2.5 py-1 fw-bold" style="font-size:0.72rem;">
                    <i class="bi bi-check-circle-fill me-1"></i>Healthy 99.98%
                </span>
            </div>

            <div class="mt-3 pt-3 border-top d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center gap-2">
                    <div class="user-avatar">
                        AD
                    </div>
                    <div>
                        <div class="fw-bold small text-dark text-truncate" style="max-width: 140px;">${sessionScope.user.fullName}</div>
                        <div class="text-muted" style="font-size: 0.72rem;">Administrator</div>
                    </div>
                </div>
                <button type="button" class="btn btn-sm btn-outline-danger rounded-circle p-0 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;" onclick="document.getElementById('logoutConfirmModal').style.display='flex'" title="Sign Out">
                    <i class="bi bi-box-arrow-right"></i>
                </button>
            </div>
        </aside>

        <main class="desktop-main">
            <header class="desktop-header">
                <div>
                    <h1 class="header-title mb-1">Administrative Center</h1>
                    <div class="text-muted small fw-medium">Welcome back, ${sessionScope.user.fullName} &bull; University Central Management System</div>
                </div>
                <div class="header-actions">
                    <button type="button" class="btn btn-light rounded-pill px-3 py-2 border shadow-xs d-flex align-items-center gap-2 fw-semibold text-dark small" data-bs-toggle="modal" data-bs-target="#schoolHolidaysModal">
                        <i class="bi bi-calendar-heart text-danger"></i>
                        <span>School Holidays</span>
                    </button>
                    <div class="user-profile dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="user-avatar">AD</div>
                        <div class="d-flex flex-column text-start">
                            <span class="fw-bold text-dark small">${sessionScope.user.fullName}</span>
                            <span class="text-muted" style="font-size:0.7rem;">System Admin</span>
                        </div>
                        <i class="bi bi-chevron-down text-muted small ms-1"></i>
                    </div>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg rounded-4 p-2 border-0">
                        <li><a class="dropdown-item rounded-3 small py-2 fw-semibold" href="javascript:void(0)" onclick="switchDesktopTab('profile', document.getElementById('tab-profile'))"><i class="bi bi-person-gear me-2 text-primary"></i>Security & Profile</a></li>
                        <li><hr class="dropdown-divider my-1"></li>
                        <li><a class="dropdown-item rounded-3 small py-2 fw-bold text-danger" href="javascript:void(0)" onclick="document.getElementById('logoutConfirmModal').style.display='flex'"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a></li>
                    </ul>
                </div>
            </header>

            <div id="dt-overview" class="tab-panel ${empty currentTab || currentTab == 'overview' ? 'active' : ''}">
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
                            <button type="button" class="btn btn-light rounded-pill px-3 py-2 fw-bold small text-dark d-inline-flex align-items-center gap-2 shadow-xs" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                                <i class="bi bi-person-check-fill text-primary"></i> Review Users
                            </button>
                            <button type="button" class="btn btn-outline-light rounded-pill px-3 py-2 fw-bold small d-inline-flex align-items-center gap-2" onclick="switchDesktopTab('deans', document.getElementById('tab-deans'))">
                                <i class="bi bi-building"></i> Deans
                            </button>
                        </div>
                    </div>
                </div>

                <div class="kpi-row">
                    <div class="admin-kpi-card" role="button" tabindex="0" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                        <div class="kpi-icon-box blue"><i class="bi bi-people-fill"></i></div>
                        <div class="kpi-val">${totalUsers}</div>
                        <div class="kpi-label">Total Accounts</div>
                    </div>
                    <div class="admin-kpi-card" role="button" tabindex="0" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                        <div class="kpi-icon-box amber"><i class="bi bi-hourglass-split"></i></div>
                        <div class="kpi-val text-warning">${pendingVerifications}</div>
                        <div class="kpi-label">Pending Verification</div>
                    </div>
                    <div class="admin-kpi-card" role="button" tabindex="0" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                        <div class="kpi-icon-box emerald"><i class="bi bi-mortarboard-fill"></i></div>
                        <div class="kpi-val text-success">${studentCount}</div>
                        <div class="kpi-label">Enrolled Students</div>
                    </div>
                    <div class="admin-kpi-card" role="button" tabindex="0" onclick="switchDesktopTab('deans', document.getElementById('tab-deans'))">
                        <div class="kpi-icon-box purple"><i class="bi bi-building-fill"></i></div>
                        <div class="kpi-val text-purple">${staffCount}</div>
                        <div class="kpi-label">Faculty & Staff</div>
                    </div>
                </div>

                <c:if test="${not empty unverifiedStudents}">
                    <div class="table-card border-warning mb-4">
                        <div class="table-card-header bg-warning bg-opacity-10">
                            <div class="d-flex align-items-center gap-2">
                                <div class="p-2 rounded-3 bg-warning text-dark"><i class="bi bi-exclamation-triangle-fill"></i></div>
                                <div>
                                    <h6 class="fw-bold text-dark mb-0">Pending User Verifications (${unverifiedStudents.size()})</h6>
                                    <div class="text-muted small">New student and faculty registrations awaiting administrative confirmation</div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-sm btn-dark rounded-pill px-3 py-1.5 fw-bold" onclick="switchDesktopTab('users', document.getElementById('tab-users'))">
                                Open All in Users Tab <i class="bi bi-arrow-right ms-1"></i>
                            </button>
                        </div>
                        <div class="table-responsive">
                            <table class="custom-data-table">
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
                            <div class="table-card-header">
                                <h6 class="fw-bold text-dark mb-0 d-flex align-items-center gap-2">
                                    <i class="bi bi-pie-chart-fill text-primary"></i> User Role Distribution
                                </h6>
                                <span class="badge bg-light text-muted border">${totalUsers} Total Accounts</span>
                            </div>
                            <div class="p-4">
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
                            <div class="table-card-header">
                                <h6 class="fw-bold text-dark mb-0 d-flex align-items-center gap-2">
                                    <i class="bi bi-lightning-charge-fill text-warning"></i> Quick Management Hub
                                </h6>
                            </div>
                            <div class="p-4 d-flex flex-column gap-2.5">
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

                                <a href="javascript:void(0)" onclick="new bootstrap.Modal(document.getElementById('schoolHolidaysModal')).show()" class="p-3 bg-light rounded-3 text-decoration-none d-flex align-items-center justify-content-between hover-primary">
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
            </div>

            <div id="dt-users" class="tab-panel ${currentTab == 'users' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">User Management &amp; Access Control</h4>
                        <div class="text-muted small">Verify incoming registrations and manage user statuses across all roles</div>
                    </div>
                    <span class="badge bg-primary text-white rounded-pill px-3 py-1.5 fw-bold font-monospace">${users.size()} Accounts</span>
                </div>

                <c:if test="${not empty unverifiedStudents}">
                    <div class="table-card border-warning mb-4">
                        <div class="table-card-header bg-warning bg-opacity-10">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-shield-exclamation text-warning fs-5"></i>
                                <div>
                                    <h6 class="fw-bold text-dark mb-0">Pending Authorizations (${unverifiedStudents.size()})</h6>
                                    <div class="text-muted small">Select the authorized university role and confirm or decline the account</div>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="custom-data-table">
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
                    <div class="table-card-header">
                        <div class="d-flex align-items-center gap-2 flex-wrap">
                            <button type="button" class="admin-filter-pill active" onclick="filterDesktopRole('all', this)">All (${users.size()})</button>
                            <button type="button" class="admin-filter-pill" onclick="filterDesktopRole('STUDENT', this)">Students (${studentCount})</button>
                            <button type="button" class="admin-filter-pill" onclick="filterDesktopRole('PROFESSOR', this)">Professors</button>
                            <button type="button" class="admin-filter-pill" onclick="filterDesktopRole('DEAN', this)">Deans</button>
                            <button type="button" class="admin-filter-pill" onclick="filterDesktopRole('ADMIN', this)">Admins</button>
                        </div>
                        <div style="width: 260px;">
                            <input type="text" class="form-control form-control-sm rounded-pill border" id="desktopUserFilterInput" placeholder="Filter by name or email..." oninput="filterDesktopUsersTable(this.value)">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="custom-data-table" id="desktopUsersTable">
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
            </div>

            <div id="dt-deans" class="tab-panel ${currentTab == 'deans' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">Faculty &amp; School Dean Leadership</h4>
                        <div class="text-muted small">Designate professors as academic deans to supervise faculties and courses</div>
                    </div>
                    <span class="badge bg-primary text-white rounded-pill px-3 py-1.5 fw-bold font-monospace">${schools.size()} Schools</span>
                </div>

                <div class="table-card">
                    <div class="table-card-header">
                        <h6 class="fw-bold text-dark mb-0 d-flex align-items-center gap-2">
                            <i class="bi bi-building-fill text-primary"></i> University Schools &amp; Designated Deans
                        </h6>
                    </div>
                    <div class="table-responsive">
                        <table class="custom-data-table">
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
            </div>

            <div id="dt-profile" class="tab-panel ${currentTab == 'profile' ? 'active' : ''}">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">Administrator Profile &amp; Security</h4>
                        <div class="text-muted small">Manage account authentication, two-factor verification, and system telemetry</div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="admin-id-card mb-4">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div>
                                    <div class="badge bg-white bg-opacity-20 text-white rounded-pill px-3 py-1 mb-1 font-monospace" style="font-size:0.75rem;">
                                        <i class="bi bi-mortarboard-fill me-1 text-warning"></i>UniTRS Executive
                                    </div>
                                    <h4 class="fw-bold text-white mb-0">System Administrator</h4>
                                </div>
                                <div class="p-2 rounded-circle bg-white bg-opacity-15 text-white">
                                    <i class="bi bi-shield-lock-fill fs-4"></i>
                                </div>
                            </div>
                            <div class="d-flex align-items-center gap-3 my-4">
                                <div class="rounded-circle bg-white text-dark d-flex align-items-center justify-content-center fw-extrabold" style="width: 58px; height: 58px; font-size: 1.35rem; box-shadow: 0 4px 12px rgba(0,0,0,0.2);">
                                    AD
                                </div>
                                <div>
                                    <div class="fw-bold fs-5 text-white">${sessionScope.user.fullName}</div>
                                    <div class="text-white-50 small">${sessionScope.user.email}</div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-end pt-3 border-top border-white border-opacity-20">
                                <div>
                                    <div class="text-white-50 text-uppercase small" style="font-size:0.68rem; letter-spacing:0.04em;">Identifier</div>
                                    <div class="fw-bold font-monospace text-white">${sessionScope.user.formattedIdentifier}</div>
                                </div>
                                <div>
                                    <span class="badge bg-success text-white rounded-pill px-3 py-1 fw-bold">ROOT ACCESS</span>
                                </div>
                            </div>
                        </div>

                        <div class="table-card p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <h6 class="fw-bold text-dark mb-1 d-flex align-items-center gap-2">
                                        <i class="bi bi-shield-check text-primary"></i> Two-Factor Authentication
                                    </h6>
                                    <div class="text-muted small">Require email verification code on sign in for enhanced administrative security</div>
                                </div>
                                <span class="badge ${sessionScope.user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill px-3 py-1">
                                    ${sessionScope.user.twoFactorEnabled ? 'Enabled' : 'Disabled'}
                                </span>
                            </div>
                            <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="m-0 pt-2 border-top d-flex justify-content-between align-items-center">
                                <input type="hidden" name="redirect" value="/admin/dashboard?tab=profile">
                                <input type="hidden" name="twoFactorEnabled" value="${!sessionScope.user.twoFactorEnabled}">
                                <span class="small text-muted">Status: <strong>${sessionScope.user.twoFactorEnabled ? 'Active Protection' : 'Inactive'}</strong></span>
                                <c:choose>
                                    <c:when test="${sessionScope.user.twoFactorEnabled}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-1.5 fw-bold">Disable 2FA</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn btn-sm btn-success rounded-pill px-3 py-1.5 fw-bold">Enable 2FA</button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="table-card p-4 mb-4">
                            <h6 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2">
                                <i class="bi bi-hdd-network text-info"></i> System &amp; Environment Telemetry
                            </h6>
                            <ul class="list-group list-group-flush small">
                                <li class="list-group-item d-flex justify-content-between px-0 py-2.5">
                                    <span class="text-muted">Application Version</span>
                                    <span class="fw-bold text-dark font-monospace">UniTRS v1.0.0</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between px-0 py-2.5">
                                    <span class="text-muted">Runtime Environment</span>
                                    <span class="fw-bold text-dark font-monospace">JDK 17 LTS / Jakarta EE 10</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between px-0 py-2.5">
                                    <span class="text-muted">Web Container</span>
                                    <span class="fw-bold text-dark font-monospace">Apache Tomcat 10.1</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between px-0 py-2.5">
                                    <span class="text-muted">Database Engine</span>
                                    <span class="fw-bold text-success font-monospace"><i class="bi bi-circle-fill me-1" style="font-size:0.5rem;"></i>PostgreSQL Active</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between px-0 py-2.5">
                                    <span class="text-muted">Session ID</span>
                                    <span class="fw-bold text-muted font-monospace">${pageContext.session.id.substring(0, 10)}...</span>
                                </li>
                            </ul>
                        </div>

                        <div class="table-card p-4">
                            <h6 class="fw-bold text-dark mb-2 d-flex align-items-center gap-2">
                                <i class="bi bi-box-arrow-right text-danger"></i> Sign Out
                            </h6>
                            <p class="text-muted small mb-3">Terminate your administrative session securely.</p>
                            <button type="button" class="btn btn-danger rounded-pill px-4 py-2 fw-bold w-100 shadow-xs" onclick="document.getElementById('logoutConfirmModal').style.display='flex'">
                                <i class="bi bi-box-arrow-right me-1.5"></i> Sign Out of Admin Account
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <div class="mobile-app-container d-block d-md-none">
        <header class="admin-mobile-topbar" role="banner">
            <div class="d-flex align-items-center justify-content-between w-100">
                <div class="d-flex align-items-center gap-2.5">
                    <div class="admin-top-avatar">AD</div>
                    <div>
                        <div class="d-flex align-items-center gap-1.5">
                            <span class="fw-extrabold text-dark small">Admin Portal</span>
                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2 py-0" style="font-size:0.65rem; font-weight:700;">ADMIN</span>
                        </div>
                        <div class="text-muted text-truncate" style="max-width: 160px; font-size: 0.72rem;">${sessionScope.user.fullName}</div>
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

            <div class="mobile-kpi-grid">
                <div class="mobile-card-item p-3 mb-0" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="kpi-icon-box blue mb-2"><i class="bi bi-people-fill"></i></div>
                    <div class="fw-extrabold fs-4 text-dark mb-0">${totalUsers}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Total Accounts</div>
                </div>
                <div class="mobile-card-item p-3 mb-0" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="kpi-icon-box amber mb-2"><i class="bi bi-hourglass-split"></i></div>
                    <div class="fw-extrabold fs-4 text-warning mb-0">${pendingVerifications}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Pending Review</div>
                </div>
                <div class="mobile-card-item p-3 mb-0" onclick="switchAdminMobileTab('users')" role="button" tabindex="0">
                    <div class="kpi-icon-box emerald mb-2"><i class="bi bi-mortarboard-fill"></i></div>
                    <div class="fw-extrabold fs-4 text-success mb-0">${studentCount}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Students</div>
                </div>
                <div class="mobile-card-item p-3 mb-0" onclick="switchAdminMobileTab('deans')" role="button" tabindex="0">
                    <div class="kpi-icon-box purple mb-2"><i class="bi bi-building-fill"></i></div>
                    <div class="fw-extrabold fs-4 text-purple mb-0">${schools.size()}</div>
                    <div class="text-muted small" style="font-size:0.72rem;">Schools</div>
                </div>
            </div>

            <div class="mobile-card-item p-3 mb-3 border-danger-subtle bg-danger-subtle bg-opacity-10" onclick="new bootstrap.Modal(document.getElementById('schoolHolidaysModal')).show()" role="button" tabindex="0" style="cursor:pointer;">
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
                <div class="d-flex gap-1.5 overflow-x-auto pb-1" style="scrollbar-width:none;">
                    <button type="button" class="admin-filter-pill active" onclick="filterMobileRole('all', this)">All</button>
                    <button type="button" class="admin-filter-pill" onclick="filterMobileRole('STUDENT', this)">Students</button>
                    <button type="button" class="admin-filter-pill" onclick="filterMobileRole('PROFESSOR', this)">Professors</button>
                    <button type="button" class="admin-filter-pill" onclick="filterMobileRole('DEAN', this)">Deans</button>
                    <button type="button" class="admin-filter-pill" onclick="filterMobileRole('ADMIN', this)">Admins</button>
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
                            <div class="text-muted small" style="font-size:0.72rem;">Academic Division</div>
                        </div>
                        <span class="badge bg-light text-dark border font-monospace">SCH-${school.id}</span>
                    </div>

                    <div class="p-2.5 rounded-3 bg-light mb-3">
                        <div class="text-muted small mb-1" style="font-size:0.7rem; text-transform:uppercase; letter-spacing:0.04em;">Assigned Dean</div>
                        <c:choose>
                            <c:when test="${not empty currentDean}">
                                <div class="fw-bold text-dark small"><i class="bi bi-person-badge text-primary me-1"></i>${currentDean.fullName}</div>
                                <div class="text-muted" style="font-size:0.72rem;">${currentDean.email}</div>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary-subtle text-secondary rounded-pill">Unassigned</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/deans/assign" method="post" class="m-0 pt-2 border-top">
                        <input type="hidden" name="schoolId" value="${school.id}">
                        <div class="mb-2">
                            <select name="professorId" class="form-select form-select-sm rounded-pill">
                                <option value="">-- Unassign Dean --</option>
                                <c:forEach var="prof" items="${professors}">
                                    <option value="${prof.id}" ${not empty currentDean && currentDean.id == prof.id ? 'selected' : ''}>
                                        ${prof.fullName} (${prof.email})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-sm btn-primary rounded-pill w-100 fw-bold">Update Dean</button>
                    </form>
                </div>
            </c:forEach>
        </section>

        <section id="mobile-view-profile" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-profile">
            <h6 class="fw-bold text-dark mb-3">Administrator Account</h6>

            <div class="admin-id-card mb-3 p-3">
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span class="badge bg-white bg-opacity-20 text-white rounded-pill px-2.5 py-0.5 font-monospace" style="font-size:0.7rem;">UniTRS Executive</span>
                    <span class="badge bg-success text-white rounded-pill" style="font-size:0.65rem;">ADMIN</span>
                </div>
                <div class="fw-bold fs-5 text-white mb-0">${sessionScope.user.fullName}</div>
                <div class="text-white-50 small mb-3" style="font-size:0.78rem;">${sessionScope.user.email}</div>
                <div class="d-flex justify-content-between align-items-center pt-2 border-top border-white border-opacity-20">
                    <span class="text-white-50 small font-monospace">${sessionScope.user.formattedIdentifier}</span>
                    <span class="badge bg-white text-dark rounded-pill px-2 py-0.5 fw-bold" style="font-size:0.68rem;">Verified</span>
                </div>
            </div>

            <div class="mobile-card-item p-3 mb-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <div>
                        <div class="fw-bold small text-dark"><i class="bi bi-shield-lock me-1 text-primary"></i>Two-Factor Authentication</div>
                        <div class="text-muted" style="font-size:0.72rem;">Email OTP security verification</div>
                    </div>
                    <span class="badge ${sessionScope.user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">
                        ${sessionScope.user.twoFactorEnabled ? 'Active' : 'Off'}
                    </span>
                </div>
                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="pt-2 border-top m-0">
                    <input type="hidden" name="redirect" value="/admin/dashboard?tab=profile">
                    <input type="hidden" name="twoFactorEnabled" value="${!sessionScope.user.twoFactorEnabled}">
                    <c:choose>
                        <c:when test="${sessionScope.user.twoFactorEnabled}">
                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill w-100 fw-bold">Disable 2FA</button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-sm btn-success rounded-pill w-100 fw-bold">Enable 2FA</button>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>

            <div class="pt-2 mb-4">
                <button type="button" onclick="document.getElementById('logoutConfirmModal').style.display='flex'" class="btn btn-danger w-100 rounded-pill py-3 fw-bold shadow-sm d-flex align-items-center justify-content-center gap-2">
                    <i class="bi bi-box-arrow-right"></i> Sign Out of Admin Account
                </button>
            </div>
        </section>

        <nav class="mobile-bottom-dock" role="navigation" aria-label="Admin Navigation Dock">
            <button type="button" class="dock-tab-btn active" id="dock-tab-home" data-tab="home" onclick="switchAdminMobileTab('home')" role="tab" aria-selected="true" aria-controls="mobile-view-home">
                <i class="bi bi-house-door-fill"></i>
                <span>Home</span>
            </button>
            <button type="button" class="dock-tab-btn position-relative" id="dock-tab-users" data-tab="users" onclick="switchAdminMobileTab('users')" role="tab" aria-selected="false" aria-controls="mobile-view-users">
                <i class="bi bi-people"></i>
                <span>Users</span>
                <c:if test="${pendingVerifications > 0}">
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.58rem; transform: translate(-75%, 20%) !important;">
                        ${pendingVerifications}
                    </span>
                </c:if>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-deans" data-tab="deans" onclick="switchAdminMobileTab('deans')" role="tab" aria-selected="false" aria-controls="mobile-view-deans">
                <i class="bi bi-building"></i>
                <span>Deans</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-profile" data-tab="profile" onclick="switchAdminMobileTab('profile')" role="tab" aria-selected="false" aria-controls="mobile-view-profile">
                <i class="bi bi-person"></i>
                <span>Profile</span>
            </button>
        </nav>
    </div>

    <jsp:include page="/WEB-INF/views/common/school_holidays_modal.jsp" />

    <div id="logoutConfirmModal" style="display:none; position:fixed; inset:0; z-index:99999; align-items:center; justify-content:center; background:rgba(15,23,42,0.55); backdrop-filter:blur(4px);" aria-modal="true" role="dialog" aria-labelledby="logoutModalTitle">
        <div style="background:#fff; border-radius:24px; padding:2rem 2.25rem; max-width:400px; width:90%; box-shadow:0 24px 64px -12px rgba(0,0,0,0.35); text-align:center;">
            <div style="width:60px;height:60px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;margin:0 auto 1.25rem;color:#dc2626;font-size:1.75rem;">
                <i class="bi bi-box-arrow-right"></i>
            </div>
            <h5 id="logoutModalTitle" style="font-weight:800;color:#0f172a;margin-bottom:0.5rem;">Sign Out?</h5>
            <p style="color:#64748b;font-size:0.92rem;margin-bottom:1.5rem;">Are you sure you want to log out of the UniTRS Administrator portal?</p>
            <div style="display:flex;gap:0.75rem;justify-content:center;">
                <button type="button" onclick="document.getElementById('logoutConfirmModal').style.display='none'" style="flex:1;padding:0.65rem 1.25rem;border-radius:50px;border:2px solid #e2e8f0;background:#fff;color:#475569;font-weight:700;font-size:0.9rem;cursor:pointer;">Cancel</button>
                <a href="${pageContext.request.contextPath}/auth/logout" style="flex:1;padding:0.65rem 1.25rem;border-radius:50px;border:none;background:#dc2626;color:#fff;font-weight:700;font-size:0.9rem;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;gap:0.5rem;">Sign Out</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        var currentActiveRoleFilter = 'all';

        function switchDesktopTab(tabId, btn) {
            var panels = document.querySelectorAll('.desktop-layout .tab-panel');
            for (var i = 0; i < panels.length; i++) {
                panels[i].classList.remove('active');
            }
            var target = document.getElementById('dt-' + tabId);
            if (target) target.classList.add('active');

            var navBtns = document.querySelectorAll('.sidebar-nav button.nav-item');
            for (var j = 0; j < navBtns.length; j++) {
                navBtns[j].classList.remove('active');
            }
            if (btn) {
                btn.classList.add('active');
            } else {
                var autoBtn = document.getElementById('tab-' + tabId);
                if (autoBtn) autoBtn.classList.add('active');
            }

            try {
                var url = new URL(window.location);
                url.searchParams.set('tab', tabId);
                window.history.replaceState({}, '', url);
            } catch (e) {}
        }

        function switchAdminMobileTab(tabName) {
            var views = document.querySelectorAll('.mobile-sub-view');
            for (var i = 0; i < views.length; i++) {
                views[i].classList.remove('active');
            }
            var target = document.getElementById('mobile-view-' + tabName);
            if (target) target.classList.add('active');

            var btns = document.querySelectorAll('.dock-tab-btn');
            var iconMap = {
                home: ['bi-house-door-fill', 'bi-house-door'],
                users: ['bi-people-fill', 'bi-people'],
                deans: ['bi-building-fill', 'bi-building'],
                profile: ['bi-person-fill', 'bi-person']
            };

            for (var j = 0; j < btns.length; j++) {
                var b = btns[j];
                var bTab = b.getAttribute('data-tab');
                var ic = b.querySelector('i');
                if (bTab === tabName) {
                    b.classList.add('active');
                    b.setAttribute('aria-selected', 'true');
                    if (ic && iconMap[bTab]) ic.className = 'bi ' + iconMap[bTab][0];
                } else {
                    b.classList.remove('active');
                    b.setAttribute('aria-selected', 'false');
                    if (ic && iconMap[bTab]) ic.className = 'bi ' + iconMap[bTab][1];
                }
            }

            try {
                var url = new URL(window.location);
                url.searchParams.set('tab', tabName);
                window.history.replaceState({}, '', url);
            } catch (e) {}
        }

        function filterDesktopRole(role, btn) {
            currentActiveRoleFilter = role;
            var pills = document.querySelectorAll('.admin-filter-pill');
            for (var i = 0; i < pills.length; i++) pills[i].classList.remove('active');
            if (btn) btn.classList.add('active');
            applyDesktopUserFilters();
        }

        function filterDesktopUsersTable(query) {
            applyDesktopUserFilters();
        }

        function applyDesktopUserFilters() {
            var queryInput = document.getElementById('desktopUserFilterInput');
            var q = queryInput ? queryInput.value.toLowerCase().trim() : '';
            var rows = document.querySelectorAll('.desktop-user-row');

            for (var i = 0; i < rows.length; i++) {
                var r = rows[i];
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
            }
        }

        function filterMobileRole(role, btn) {
            currentActiveRoleFilter = role;
            var pills = document.querySelectorAll('#mobile-view-users .admin-filter-pill');
            for (var i = 0; i < pills.length; i++) pills[i].classList.remove('active');
            if (btn) btn.classList.add('active');
            applyMobileUserFilters();
        }

        function filterMobileUsersList(query) {
            applyMobileUserFilters();
        }

        function applyMobileUserFilters() {
            var queryInput = document.getElementById('mobileUserFilterInput');
            var q = queryInput ? queryInput.value.toLowerCase().trim() : '';
            var cards = document.querySelectorAll('.mobile-user-card');

            for (var i = 0; i < cards.length; i++) {
                var c = cards[i];
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
            }
        }

        function handleDesktopQuickSearch(val) {
            if (!val) return;
            switchDesktopTab('users', document.getElementById('tab-users'));
            var input = document.getElementById('desktopUserFilterInput');
            if (input) {
                input.value = val;
                applyDesktopUserFilters();
            }
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
