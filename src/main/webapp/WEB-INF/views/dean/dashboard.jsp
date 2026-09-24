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
            gap: 12px;
            margin-bottom: 18px;
        }

        @media (max-width: 1200px) {
            .metrics-grid {
                grid-template-columns: repeat(3, 1fr);
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
        .mc-value { font-size: 1.6rem; font-weight: 800; color: var(--brand-dark); line-height: 1; margin-bottom: 2px; }
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

        /* ========================================================
           MOBILE UNIFIED DESIGN SYSTEM FOR DEAN
           ======================================================== */
        @media (max-width: 767.98px) {
            body {
                display: block !important;
                font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
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

            /* Sticky Safe-Area Aware Top Bar */
            .dean-mobile-topbar {
                position: sticky;
                top: 0;
                z-index: 1020;
                background: rgba(248, 250, 252, 0.92);
                backdrop-filter: blur(20px) saturate(180%);
                -webkit-backdrop-filter: blur(20px) saturate(180%);
                border-bottom: 1px solid rgba(226, 232, 240, 0.8);
                padding: calc(12px + env(safe-area-inset-top, 0px)) 16px 12px;
                margin-left: -16px;
                margin-right: -16px;
                margin-bottom: 16px;
            }

            .dean-top-avatar {
                width: 42px;
                height: 42px;
                border-radius: 14px;
                overflow: hidden;
                background: #eff6ff;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 2px solid #ffffff;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
                flex-shrink: 0;
            }

            .dean-prof-switch-pill {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 6px 12px;
                border-radius: 99px;
                background: #eff6ff;
                border: 1px solid #bfdbfe;
                font-size: 0.75rem;
                font-weight: 700;
                color: #1d4ed8;
                text-decoration: none;
                transition: all 0.2s ease;
                min-height: 36px;
            }

            .dean-prof-switch-pill:active {
                background: #dbeafe;
                transform: scale(0.97);
            }

            /* Sub Views Animation */
            .mobile-sub-view {
                display: none;
                padding: 0 0 16px;
                width: 100%;
                box-sizing: border-box;
            }

            .mobile-sub-view.active {
                display: block;
                animation: deanMobileFadeIn 0.26s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes deanMobileFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(6px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Hero Banner */
            .dean-hero-banner {
                background: linear-gradient(135deg, #091e3a 0%, #1e3a8a 60%, #2563eb 100%);
                border-radius: 24px;
                padding: 20px;
                color: #ffffff;
                position: relative;
                overflow: hidden;
                box-shadow: 0 14px 34px rgba(15, 23, 42, 0.14);
                margin-bottom: 16px;
                width: 100%;
                box-sizing: border-box;
            }

            .dean-hero-banner::before {
                content: '';
                position: absolute;
                top: -50px;
                right: -50px;
                width: 160px;
                height: 160px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, rgba(255, 255, 255, 0) 70%);
                pointer-events: none;
            }

            /* KPI 2x2 Grid */
            .dean-kpi-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
                margin-bottom: 16px;
                width: 100%;
                box-sizing: border-box;
            }

            .dean-kpi-card {
                background: #ffffff;
                border-radius: 20px;
                padding: 14px 16px;
                border: 1px solid rgba(226, 232, 240, 0.75);
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.02);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                min-height: 94px;
                transition: transform 0.15s ease;
            }

            .dean-kpi-card:active {
                transform: scale(0.98);
            }

            .kpi-icon-box {
                width: 34px;
                height: 34px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
                margin-bottom: 8px;
            }

            .kpi-icon-box.blue { background: #eff6ff; color: #2563eb; }
            .kpi-icon-box.purple { background: #f5f3ff; color: #7c3aed; }
            .kpi-icon-box.indigo { background: #e0e7ff; color: #4338ca; }
            .kpi-icon-box.emerald { background: #ecfdf5; color: #059669; }

            .dean-kpi-val {
                font-size: 1.5rem;
                font-weight: 800;
                color: #0f172a;
                line-height: 1.1;
                letter-spacing: -0.02em;
            }

            .dean-kpi-label {
                font-size: 0.75rem;
                font-weight: 600;
                color: #64748b;
                margin-top: 2px;
            }

            /* Action Strip */
            .dean-action-strip {
                display: flex;
                gap: 8px;
                overflow-x: auto;
                padding-bottom: 8px;
                margin-bottom: 16px;
                -webkit-overflow-scrolling: touch;
                scrollbar-width: none;
                width: 100%;
                box-sizing: border-box;
            }

            .dean-action-strip::-webkit-scrollbar {
                display: none;
            }

            .dean-action-pill {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 10px 16px;
                border-radius: 99px;
                background: #ffffff;
                border: 1px solid rgba(226, 232, 240, 0.85);
                font-size: 0.82rem;
                font-weight: 700;
                color: #1e293b;
                white-space: nowrap;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
                min-height: 44px;
                cursor: pointer;
                transition: all 0.18s ease;
            }

            .dean-action-pill:active {
                background: #f8fafc;
                transform: scale(0.97);
            }

            .dean-action-pill.primary {
                background: #2563eb;
                color: #ffffff;
                border-color: #2563eb;
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
            }

            .dean-action-pill.primary:active {
                background: #1d4ed8;
            }

            /* Course and Schedule Card */
            .mobile-course-card {
                background: #ffffff;
                border-radius: 20px;
                padding: 16px;
                border: 1px solid rgba(226, 232, 240, 0.75);
                box-shadow: 0 4px 18px rgba(0, 0, 0, 0.025);
                margin-bottom: 12px;
                transition: transform 0.15s ease, box-shadow 0.15s ease;
                width: 100%;
                box-sizing: border-box;
            }

            .mobile-course-card:active {
                transform: scale(0.985);
            }

            .mc-code {
                font-size: 0.78rem;
                font-weight: 800;
                letter-spacing: 0.04em;
                color: #2563eb;
                background: #eff6ff;
                padding: 3px 9px;
                border-radius: 8px;
                display: inline-block;
            }

            .mc-title {
                font-size: 0.96rem;
                font-weight: 700;
                color: #0f172a;
                margin: 8px 0 6px;
                line-height: 1.35;
            }

            .mc-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                font-size: 0.78rem;
                color: #64748b;
                font-weight: 500;
            }

            .mc-meta-item {
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            /* Capacity bar */
            .cap-bar-track {
                height: 7px;
                background: #f1f5f9;
                border-radius: 99px;
                overflow: hidden;
                width: 100%;
                margin-top: 6px;
            }

            .cap-bar-fill {
                height: 100%;
                border-radius: 99px;
                transition: width 0.3s ease;
            }

            .cap-bar-fill.normal { background: linear-gradient(90deg, #10b981, #059669); }
            .cap-bar-fill.warning { background: linear-gradient(90deg, #f59e0b, #d97706); }
            .cap-bar-fill.danger { background: linear-gradient(90deg, #ef4444, #dc2626); }

            /* Search bar */
            .mobile-search-bar {
                position: relative;
                margin-bottom: 14px;
                width: 100%;
                box-sizing: border-box;
            }

            .mobile-search-bar input {
                width: 100%;
                background: #ffffff;
                border: 1px solid rgba(226, 232, 240, 0.85);
                border-radius: 14px;
                padding: 12px 14px 12px 42px;
                font-size: 0.88rem;
                color: #0f172a;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
                min-height: 46px;
            }

            .mobile-search-bar input:focus {
                outline: none;
                border-color: #2563eb;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
            }

            .mobile-search-bar i {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: #94a3b8;
                font-size: 1rem;
                pointer-events: none;
            }

            /* Segmented Control for People Directory */
            .dean-segmented-ctrl {
                display: flex;
                background: #e2e8f0;
                padding: 4px;
                border-radius: 16px;
                margin-bottom: 16px;
                gap: 4px;
                width: 100%;
                box-sizing: border-box;
            }

            .dean-seg-btn {
                flex: 1;
                border: none;
                background: transparent;
                padding: 8px 12px;
                border-radius: 12px;
                font-size: 0.82rem;
                font-weight: 700;
                color: #64748b;
                transition: all 0.2s ease;
                min-height: 42px;
            }

            .dean-seg-btn.active {
                background: #ffffff;
                color: #0f172a;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.06);
            }

            /* Executive Dean Digital Credential ID Card */
            .dean-cred-card {
                background: linear-gradient(135deg, #091e3a 0%, #172554 45%, #1e3a8a 100%);
                border-radius: 24px;
                padding: 22px;
                color: #ffffff;
                position: relative;
                overflow: hidden;
                box-shadow: 0 16px 36px rgba(9, 30, 58, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.14);
                margin-bottom: 16px;
                width: 100%;
                box-sizing: border-box;
            }

            .dean-cred-card::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(
                    105deg,
                    transparent 20%,
                    rgba(255, 215, 0, 0.08) 35%,
                    rgba(255, 255, 255, 0.2) 50%,
                    rgba(255, 215, 0, 0.08) 65%,
                    transparent 80%
                );
                background-size: 200% 200%;
                animation: foilSweep 7s infinite ease-in-out;
                pointer-events: none;
            }

            @keyframes foilSweep {
                0% { background-position: -100% -100%; }
                50% { background-position: 100% 100%; }
                100% { background-position: -100% -100%; }
            }

            .dean-barcode {
                display: flex;
                align-items: center;
                gap: 2px;
                height: 26px;
                opacity: 0.85;
            }

            .dean-bar {
                background: #ffffff;
                height: 100%;
                border-radius: 1px;
            }

            /* Floating Island Bottom Dock (Unified Standard) */
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
                line-height: 1;
                margin-bottom: 2px;
                transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1), color 0.2s ease;
            }

            .dock-tab-btn.active i {
                transform: translateY(-1px);
                color: #2563eb;
            }

            /* Mobile Toast */
            .mobile-toast {
                position: fixed;
                bottom: calc(env(safe-area-inset-bottom, 16px) + 84px);
                left: 50%;
                transform: translateX(-50%) translateY(20px);
                background: #0f172a;
                color: #ffffff;
                padding: 9px 18px;
                border-radius: 99px;
                font-size: 0.8rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 8px;
                box-shadow: 0 10px 30px rgba(15, 23, 42, 0.25);
                z-index: 1060;
                opacity: 0;
                pointer-events: none;
                transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .mobile-toast.show {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
                pointer-events: auto;
            }

            /* Filter chip strip */
            .filter-chip-strip {
                display: flex;
                gap: 6px;
                overflow-x: auto;
                padding-bottom: 6px;
                margin-bottom: 12px;
                -webkit-overflow-scrolling: touch;
                scrollbar-width: none;
                width: 100%;
                box-sizing: border-box;
            }

            .filter-chip-strip::-webkit-scrollbar {
                display: none;
            }

            .filter-chip {
                border: 1px solid #e2e8f0;
                background: #ffffff;
                color: #475569;
                font-size: 0.76rem;
                font-weight: 600;
                padding: 6px 14px;
                border-radius: 99px;
                white-space: nowrap;
                cursor: pointer;
                transition: all 0.15s ease;
                min-height: 36px;
                display: inline-flex;
                align-items: center;
            }

            .filter-chip.active {
                background: #2563eb;
                color: #ffffff;
                border-color: #2563eb;
                font-weight: 700;
            }
        }

        @media (min-width: 768px) {
            .mobile-app-container {
                display: none !important;
            }
        }
    </style>
</head>
<body>

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
                                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1" data-bs-toggle="modal" data-bs-target="#sectionStudentsModal${section.id}" style="font-size:0.8rem;">
                                                <i class="bi bi-people me-1"></i> Students (${section.enrolledCount})
                                            </button>
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="removeClassSection">
                                                <input type="hidden" name="sectionId" value="${section.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Are you sure you want to delete this scheduled class section?');" style="font-size:0.8rem;">
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

    <!-- ============================================================= -->
    <!-- DEAN NATIVE MOBILE EXPERIENCE (VIEWPORT < 768px)               -->
    <!-- ============================================================= -->
    <div class="mobile-app-container d-block d-md-none">

        <!-- Sticky Safe-Area Aware Top Bar -->
        <header class="dean-mobile-topbar" role="banner">
            <div class="d-flex align-items-center justify-content-between w-100">
                <div class="d-flex align-items-center gap-3">
                    <div class="dean-top-avatar">
                        <c:choose>
                            <c:when test="${user.gender == 'FEMALE'}">
                                <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar" style="width:100%;height:100%;object-fit:cover;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="fw-extrabold text-dark" style="font-size: 1.05rem; letter-spacing: -0.02em;">Dean Admin</span>
                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 rounded-pill px-2 py-0" style="font-size:0.65rem; font-weight:700;">DEAN</span>
                        </div>
                        <div class="text-muted small fw-medium text-truncate" style="max-width: 170px; font-size: 0.75rem;">${user.fullName}</div>
                    </div>
                </div>

                <div class="d-flex align-items-center gap-2">
                    <a href="${pageContext.request.contextPath}/professor/dashboard" class="dean-prof-switch-pill text-decoration-none" title="Switch to Professor View">
                        <i class="bi bi-person-workspace text-primary"></i>
                        <span>Prof View</span>
                    </a>
                    <button type="button" class="btn btn-light rounded-circle p-0 d-flex align-items-center justify-content-center shadow-xs" style="width: 38px; height: 38px; border: 1px solid rgba(226,232,240,0.8);" onclick="switchDeanMobileTab('profile')" aria-label="Open profile settings">
                        <i class="bi bi-gear-fill text-secondary" style="font-size: 1rem;"></i>
                    </button>
                </div>
            </div>
        </header>

        <!-- ===== TAB 1: OVERVIEW / HUB ===== -->
        <section id="mobile-view-home" class="mobile-sub-view active" role="tabpanel" aria-labelledby="dock-tab-home">
            <!-- Hero Banner -->
            <div class="dean-hero-banner">
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span class="badge bg-white bg-opacity-20 text-white rounded-pill px-3 py-1 font-monospace" style="font-size:0.75rem; font-weight:700;">
                        <i class="bi bi-mortarboard-fill me-1 text-warning"></i>${deanSchool.schoolName}
                    </span>
                    <span class="badge bg-success bg-opacity-90 text-white rounded-pill px-2 py-1" style="font-size:0.7rem; font-weight:700;">
                        <i class="bi bi-circle-fill me-1" style="font-size:0.5rem;"></i>Active Term
                    </span>
                </div>
                <h2 class="fw-extrabold text-white mb-1" style="font-size:1.35rem; letter-spacing:-0.02em;">Dean Leadership Hub</h2>
                <p class="text-white text-opacity-80 small mb-3">Academic Curriculum & Department Administration</p>
            </div>

            <!-- KPI 2x2 Grid -->
            <div class="dean-kpi-grid">
                <div class="dean-kpi-card" onclick="switchDeanMobileTab('courses')" role="button" tabindex="0">
                    <div class="kpi-icon-box blue"><i class="bi bi-book-half"></i></div>
                    <div>
                        <div class="dean-kpi-val">${courses.size()}</div>
                        <div class="dean-kpi-label">Master Courses</div>
                    </div>
                </div>
                <div class="dean-kpi-card" onclick="switchDeanMobileTab('schedules')" role="button" tabindex="0">
                    <div class="kpi-icon-box indigo"><i class="bi bi-clock-history"></i></div>
                    <div>
                        <div class="dean-kpi-val">${sections.size()}</div>
                        <div class="dean-kpi-label">Class Sections</div>
                    </div>
                </div>
                <div class="dean-kpi-card" onclick="switchDeanMobileTab('people'); toggleDeanPeopleSegment('faculty');" role="button" tabindex="0">
                    <div class="kpi-icon-box purple"><i class="bi bi-person-badge-fill"></i></div>
                    <div>
                        <div class="dean-kpi-val">${professors.size()}</div>
                        <div class="dean-kpi-label">Faculty Staff</div>
                    </div>
                </div>
                <div class="dean-kpi-card" onclick="switchDeanMobileTab('people'); toggleDeanPeopleSegment('students');" role="button" tabindex="0">
                    <div class="kpi-icon-box emerald"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="dean-kpi-val">${students.size()}</div>
                        <div class="dean-kpi-label">Enrolled Students</div>
                    </div>
                </div>
            </div>

            <!-- Quick Action Horizontal Strip -->
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="fw-bold text-dark small">Administrative Quick Actions</span>
            </div>
            <div class="dean-action-strip">
                <button type="button" class="dean-action-pill primary" data-bs-toggle="modal" data-bs-target="#addCourseModal">
                    <i class="bi bi-plus-circle-fill"></i> Add Course
                </button>
                <button type="button" class="dean-action-pill" data-bs-toggle="modal" data-bs-target="#scheduleClassModal">
                    <i class="bi bi-calendar-plus text-primary"></i> Schedule Class
                </button>
                <button type="button" class="dean-action-pill" data-bs-toggle="modal" data-bs-target="#addTermModal">
                    <i class="bi bi-calendar2-range text-indigo"></i> Add Term
                </button>
                <button type="button" class="dean-action-pill" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                    <i class="bi bi-door-open text-success"></i> Add Room
                </button>
                <button type="button" class="dean-action-pill" data-bs-toggle="modal" data-bs-target="#batchRoomModal">
                    <i class="bi bi-layers text-secondary"></i> Batch Rooms
                </button>
            </div>

            <!-- Active Class Sections Spotlight -->
            <div class="d-flex justify-content-between align-items-center mb-3 mt-1">
                <div>
                    <h3 class="fw-extrabold text-dark mb-0" style="font-size:1.05rem;">Scheduled Classes</h3>
                    <span class="text-muted" style="font-size:0.75rem;">${sections.size()} active class offerings</span>
                </div>
                <button type="button" class="btn btn-sm btn-link text-primary fw-bold text-decoration-none p-0" onclick="switchDeanMobileTab('schedules')">
                    See All <i class="bi bi-arrow-right"></i>
                </button>
            </div>

            <c:forEach var="section" items="${sections}" end="3">
                <div class="mobile-course-card" onclick="switchDeanMobileTab('schedules')" role="button" tabindex="0">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div>
                            <span class="mc-code me-1">${section.courseCode}</span>
                            <span class="badge bg-light border text-muted">${section.termName}</span>
                        </div>
                        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold">${section.sessionShift}</span>
                    </div>
                    <div class="mc-title">${section.courseTitle}</div>
                    <div class="mc-meta mb-2">
                        <div class="mc-meta-item"><i class="bi bi-person-badge text-primary"></i>${section.professorName}</div>
                        <div class="mc-meta-item"><i class="bi bi-geo-alt text-primary"></i>Room ${section.roomName}</div>
                        <div class="mc-meta-item"><i class="bi bi-calendar3 text-primary"></i>${section.daysOfWeek}</div>
                    </div>
                    <div class="pt-2 border-top">
                        <div class="d-flex justify-content-between align-items-center text-muted" style="font-size:0.75rem;">
                            <span>Enrollment Capacity</span>
                            <span class="fw-bold ${section.enrolledCount >= section.roomCapacity ? 'text-danger' : 'text-dark'}">${section.enrolledCount} / ${section.roomCapacity}</span>
                        </div>
                        <div class="cap-bar-track">
                            <div class="cap-bar-fill ${section.enrolledCount >= section.roomCapacity ? 'danger' : ((section.roomCapacity > 0 && (section.enrolledCount * 100 / section.roomCapacity >= 75)) ? 'warning' : 'normal')}"
                                 style="width: ${section.roomCapacity > 0 ? (section.enrolledCount * 100 / section.roomCapacity) : 0}%;"></div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty sections}">
                <div class="mobile-course-card text-center py-4">
                    <i class="bi bi-calendar-x text-muted fs-2 mb-2 d-block"></i>
                    <div class="fw-bold small text-dark mb-1">No class sections scheduled</div>
                    <div class="small text-muted mb-3">Schedule your first class section to get started</div>
                    <button type="button" class="btn btn-sm btn-primary rounded-pill px-4 fw-bold" data-bs-toggle="modal" data-bs-target="#scheduleClassModal">
                        <i class="bi bi-plus-lg me-1"></i> Schedule Class
                    </button>
                </div>
            </c:if>

            <!-- Terms Spotlight -->
            <div class="d-flex justify-content-between align-items-center mb-2 mt-3">
                <h3 class="fw-extrabold text-dark mb-0" style="font-size:1.05rem;">Academic Terms</h3>
                <span class="badge bg-light border text-muted">${terms.size()} Terms</span>
            </div>
            <div class="mobile-course-card p-2 mb-3">
                <div class="list-group list-group-flush">
                    <c:forEach var="term" items="${terms}">
                        <div class="list-group-item d-flex justify-content-between align-items-center px-2 py-3 border-bottom border-light">
                            <div class="d-flex align-items-center gap-2">
                                <span class="badge bg-light border text-primary rounded-pill px-2 py-1 fw-bold font-monospace">T${term.termNumber}</span>
                                <span class="fw-bold text-dark small">${term.termName}</span>
                            </div>
                            <button type="button" class="btn btn-sm btn-light rounded-pill px-3 border" data-bs-toggle="modal" data-bs-target="#editTermModal${term.id}" style="font-size:0.75rem;">
                                <i class="bi bi-pencil"></i>
                            </button>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- ===== TAB 2: MASTER COURSES ===== -->
        <section id="mobile-view-courses" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-courses">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h2 class="fw-extrabold text-dark mb-0" style="font-size:1.25rem;">Curriculum & Courses</h2>
                    <span class="text-muted" style="font-size:0.75rem;">${courses.size()} courses &bull; ${curriculumMap.size()} term bundles</span>
                </div>
                <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 py-2 fw-bold" data-bs-toggle="modal" data-bs-target="#addCourseModal" style="font-size:0.8rem; min-height:40px;">
                    <i class="bi bi-plus-lg me-1"></i> New Course
                </button>
            </div>

            <div class="dean-seg-control mb-3">
                <button type="button" id="deanSegCatalogBtn" class="dean-seg-btn active" onclick="toggleDeanCourseSegment('catalog')">
                    <i class="bi bi-book me-1"></i> Courses Catalog (${courses.size()})
                </button>
                <button type="button" id="deanSegBundlesBtn" class="dean-seg-btn" onclick="toggleDeanCourseSegment('bundles')">
                    <i class="bi bi-collection me-1"></i> Term Bundles (${curriculumMap.size()})
                </button>
            </div>

            <!-- Search Input -->
            <div class="mobile-search-bar">
                <i class="bi bi-search"></i>
                <input type="text" id="mobileDeanCourseSearch" placeholder="Search by course code or title..." aria-label="Search courses" oninput="filterMobileDeanCourses(this.value)">
            </div>

            <!-- Course Items List -->
            <div id="mobileDeanCoursesContainer">
                <c:forEach var="course" items="${courses}">
                    <div class="mobile-course-card mobile-dean-course-item">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="mc-code">${course.courseCode}</span>
                            <span class="badge bg-info-subtle text-info-emphasis border rounded-pill px-2 py-1">${course.credits} Credits</span>
                        </div>
                        <h3 class="mc-title mb-3">${course.courseTitle}</h3>
                        <div class="d-flex justify-content-end align-items-center gap-2 pt-2 border-top">
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3 py-1 fw-bold" data-bs-toggle="modal" data-bs-target="#editCourseModal${course.id}" style="min-height:38px; display:inline-flex; align-items:center; gap:4px;">
                                <i class="bi bi-pencil"></i> Edit
                            </button>
                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="d-inline">
                                <input type="hidden" name="action" value="deleteCourse">
                                <input type="hidden" name="courseId" value="${course.id}">
                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-1 fw-bold" onclick="return confirm('Are you sure you want to delete course ${course.courseCode}?');" style="min-height:38px; display:inline-flex; align-items:center; gap:4px;">
                                    <i class="bi bi-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                <div id="mobileDeanCoursesEmpty" class="mobile-course-card text-center py-4" style="display:none;">
                    <i class="bi bi-search text-muted fs-2 mb-2 d-block"></i>
                    <div class="fw-bold small text-dark mb-1">No matching courses</div>
                    <div class="small text-muted mb-2">Try adjusting your search keywords</div>
                    <button type="button" class="btn btn-sm btn-light border rounded-pill px-3" onclick="clearMobileDeanCourseSearch()">Clear Search</button>
                </div>
            </div>
            <div id="mobileDeanBundlesContainer" style="display:none;">
                <c:forEach var="entry" items="${curriculumMap}">
                    <c:set var="term" value="${entry.key}" />
                    <c:set var="termCourses" value="${entry.value}" />
                    <div class="mobile-course-card p-3 mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div>
                                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 rounded-pill px-2 py-1 fw-bold font-monospace">${term.termName}</span>
                                <span class="text-muted small ms-2">${termCourses.size()} courses</span>
                            </div>
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3 py-1 fw-semibold" data-bs-toggle="modal" data-bs-target="#bundleModal${term.id}" style="font-size:0.75rem;">
                                <i class="bi bi-plus-lg me-1"></i> Bundle Course
                            </button>
                        </div>
                        <div class="list-group list-group-flush border-top border-light mt-2 pt-1">
                            <c:forEach var="course" items="${termCourses}">
                                <div class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-bottom border-light">
                                    <div>
                                        <div class="fw-bold text-dark small">${course.courseCode}</div>
                                        <div class="text-muted" style="font-size:0.75rem;">${course.courseTitle} &bull; ${course.credits} cr</div>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="m-0 p-0">
                                        <input type="hidden" name="action" value="unbundleCourse">
                                        <input type="hidden" name="termId" value="${term.id}">
                                        <input type="hidden" name="courseId" value="${course.id}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger border-0 rounded-circle p-1" title="Remove course from term" onclick="return confirm('Remove ${course.courseCode} from ${term.termName}?');">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </form>
                                </div>
                            </c:forEach>
                            <c:if test="${empty termCourses}">
                                <div class="text-center text-muted py-3 small">No courses bundled in this term yet.</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty curriculumMap}">
                    <div class="mobile-course-card text-center py-4">
                        <i class="bi bi-collection text-muted fs-2 mb-2 d-block"></i>
                        <div class="fw-bold small text-dark mb-1">No term bundles</div>
                        <div class="small text-muted">Create an academic term first to bundle courses.</div>
                    </div>
                </c:if>
            </div>
        </section>

        <!-- ===== TAB 3: CLASS SCHEDULES ===== -->
        <section id="mobile-view-schedules" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-schedules">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h2 class="fw-extrabold text-dark mb-0" style="font-size:1.25rem;">Class Schedules</h2>
                    <span class="text-muted" style="font-size:0.75rem;">${sections.size()} active class offerings</span>
                </div>
                <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 py-2 fw-bold" data-bs-toggle="modal" data-bs-target="#scheduleClassModal" style="font-size:0.8rem; min-height:42px;">
                    <i class="bi bi-plus-lg me-1"></i> Schedule
                </button>
            </div>

            <!-- Search Input -->
            <div class="mobile-search-bar">
                <i class="bi bi-search"></i>
                <input type="text" id="mobileDeanScheduleSearch" placeholder="Search by course, prof, room..." aria-label="Search schedules" oninput="filterMobileDeanSchedules(this.value)">
            </div>

            <!-- Shift Filter Pills -->
            <div class="filter-chip-strip" id="deanScheduleFilterStrip">
                <button type="button" class="filter-chip active" onclick="filterDeanScheduleShift('all', this)">All</button>
                <button type="button" class="filter-chip" onclick="filterDeanScheduleShift('morning', this)">Morning</button>
                <button type="button" class="filter-chip" onclick="filterDeanScheduleShift('afternoon', this)">Afternoon</button>
                <button type="button" class="filter-chip" onclick="filterDeanScheduleShift('evening', this)">Evening</button>
                <button type="button" class="filter-chip" onclick="filterDeanScheduleShift('weekend', this)">Weekend</button>
            </div>

            <!-- Schedules List -->
            <div id="mobileDeanSchedulesContainer">
                <c:forEach var="section" items="${sections}">
                    <div class="mobile-course-card mobile-dean-section-item" data-shift="${section.sessionShift}" data-days="${section.daysOfWeek}">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div>
                                <span class="mc-code me-1">${section.courseCode}</span>
                                <span class="badge bg-light border text-muted">${section.termName}</span>
                            </div>
                            <span class="badge bg-primary bg-opacity-10 text-primary fw-bold">${section.sessionShift}</span>
                        </div>
                        <h3 class="mc-title mb-2">${section.courseTitle}</h3>
                        <div class="mc-meta mb-3">
                            <div class="mc-meta-item"><i class="bi bi-person-badge text-primary"></i>${section.professorName}</div>
                            <div class="mc-meta-item"><i class="bi bi-geo-alt text-primary"></i>Room ${section.roomName}</div>
                            <div class="mc-meta-item"><i class="bi bi-calendar3 text-primary"></i>${section.daysOfWeek}</div>
                        </div>

                        <div class="pt-2 border-top mb-3">
                            <div class="d-flex justify-content-between align-items-center text-muted" style="font-size:0.75rem;">
                                <span>Enrollment: <strong class="text-dark">${section.enrolledCount} / ${section.roomCapacity}</strong></span>
                                <span class="${section.enrolledCount >= section.roomCapacity ? 'text-danger fw-bold' : ''}">${section.roomCapacity > 0 ? (section.enrolledCount * 100 / section.roomCapacity) : 0}%</span>
                            </div>
                            <div class="cap-bar-track">
                                <div class="cap-bar-fill ${section.enrolledCount >= section.roomCapacity ? 'danger' : ((section.roomCapacity > 0 && (section.enrolledCount * 100 / section.roomCapacity >= 75)) ? 'warning' : 'normal')}"
                                     style="width: ${section.roomCapacity > 0 ? (section.enrolledCount * 100 / section.roomCapacity) : 0}%;"></div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end align-items-center gap-2">
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3 py-1 fw-bold" data-bs-toggle="modal" data-bs-target="#sectionStudentsModal${section.id}" style="min-height:38px; display:inline-flex; align-items:center; gap:4px; font-size:0.8rem;">
                                <i class="bi bi-people"></i> Students (${section.enrolledCount})
                            </button>
                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="d-inline m-0">
                                <input type="hidden" name="action" value="removeClassSection">
                                <input type="hidden" name="sectionId" value="${section.id}">
                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-1 fw-bold" onclick="return confirm('Are you sure you want to delete this scheduled class section?');" style="min-height:38px; display:inline-flex; align-items:center; gap:4px;">
                                    <i class="bi bi-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                <div id="mobileDeanSchedulesEmpty" class="mobile-course-card text-center py-4" style="display:none;">
                    <i class="bi bi-calendar-x text-muted fs-2 mb-2 d-block"></i>
                    <div class="fw-bold small text-dark mb-1">No matching class sections</div>
                    <div class="small text-muted">Try clearing search or filters</div>
                </div>
            </div>
        </section>

        <!-- ===== TAB 4: PEOPLE DIRECTORY ===== -->
        <section id="mobile-view-people" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-people">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h2 class="fw-extrabold text-dark mb-0" style="font-size:1.25rem;">People Directory</h2>
                    <span class="text-muted" style="font-size:0.75rem;">Faculty members and enrolled students</span>
                </div>
            </div>

            <!-- Segmented Control -->
            <div class="dean-segmented-ctrl">
                <button type="button" id="deanSegFacultyBtn" class="dean-seg-btn active" onclick="toggleDeanPeopleSegment('faculty')">
                    <i class="bi bi-person-badge-fill me-1"></i> Faculty (${professors.size()})
                </button>
                <button type="button" id="deanSegStudentsBtn" class="dean-seg-btn" onclick="toggleDeanPeopleSegment('students')">
                    <i class="bi bi-people-fill me-1"></i> Students (${students.size()})
                </button>
            </div>

            <!-- Search Input -->
            <div class="mobile-search-bar">
                <i class="bi bi-search"></i>
                <input type="text" id="mobileDeanPeopleSearch" placeholder="Search by name, ID, or email..." aria-label="Search people" oninput="filterMobileDeanPeople(this.value)">
            </div>

            <!-- Faculty List -->
            <div id="deanFacultyContainer">
                <c:forEach var="prof" items="${professors}">
                    <div class="mobile-course-card mobile-dean-person-item faculty-person-item p-3 mb-2">
                        <div class="d-flex align-items-center gap-3">
                            <div style="width:44px; height:44px; border-radius:14px; background:#eff6ff; color:#2563eb; display:flex; align-items:center; justify-content:center; font-size:1.15rem; flex-shrink:0; border:1px solid #dbeafe;">
                                <i class="bi bi-person-fill"></i>
                            </div>
                            <div class="flex-grow-1 min-w-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-dark text-truncate" style="font-size:0.92rem;">${prof.fullName}</span>
                                    <span class="badge bg-primary-subtle text-primary border rounded-pill px-2 py-0" style="font-size:0.65rem;">FACULTY</span>
                                </div>
                                <div class="text-muted small text-truncate" style="font-size:0.78rem;">${prof.email}</div>
                                <div class="mt-1">
                                    <button type="button" class="btn btn-sm btn-light border rounded-pill px-2 py-0 fw-bold font-monospace" style="font-size:0.7rem;" data-id="${prof.formattedIdentifier}" onclick="copyDeanId(this.getAttribute('data-id'), this)" title="Copy Faculty ID">
                                        <i class="bi bi-copy text-muted me-1"></i>${prof.formattedIdentifier}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Students List -->
            <div id="deanStudentsContainer" style="display:none;">
                <c:forEach var="student" items="${students}">
                    <div class="mobile-course-card mobile-dean-person-item student-person-item p-3 mb-2">
                        <div class="d-flex align-items-center gap-3">
                            <div style="width:44px; height:44px; border-radius:14px; background:#ecfdf5; color:#059669; display:flex; align-items:center; justify-content:center; font-size:1.15rem; flex-shrink:0; border:1px solid #a7f3d0;">
                                <i class="bi bi-mortarboard"></i>
                            </div>
                            <div class="flex-grow-1 min-w-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-dark text-truncate" style="font-size:0.92rem;">${student.fullName}</span>
                                    <span class="badge bg-success-subtle text-success border rounded-pill px-2 py-0" style="font-size:0.65rem;">STUDENT</span>
                                </div>
                                <div class="text-muted small text-truncate" style="font-size:0.78rem;">${student.email}</div>
                                <div class="mt-1 d-flex align-items-center gap-2">
                                    <button type="button" class="btn btn-sm btn-light border rounded-pill px-2 py-0 fw-bold font-monospace" style="font-size:0.7rem;" data-id="${student.formattedIdentifier}" onclick="copyDeanId(this.getAttribute('data-id'), this)" title="Copy Student ID">
                                        <i class="bi bi-copy text-muted me-1"></i>${student.formattedIdentifier}
                                    </button>
                                    <c:if test="${not empty student.major}">
                                        <span class="badge bg-light text-muted border rounded-pill px-2 py-0" style="font-size:0.65rem;">${student.major}</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div id="mobileDeanPeopleEmpty" class="mobile-course-card text-center py-4" style="display:none;">
                <i class="bi bi-people text-muted fs-2 mb-2 d-block"></i>
                <div class="fw-bold small text-dark mb-1">No people found</div>
                <div class="small text-muted">Try adjusting your search criteria</div>
            </div>
        </section>

        <!-- ===== TAB 5: PROFILE & CREDENTIALS ===== -->
        <section id="mobile-view-profile" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-profile">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h2 class="fw-extrabold text-dark mb-0" style="font-size:1.25rem;">Executive Profile</h2>
                    <span class="text-muted" style="font-size:0.75rem;">Official credential and administrative controls</span>
                </div>
            </div>

            <!-- Executive Dean Digital Credential ID Card -->
            <div class="dean-cred-card">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div class="d-flex align-items-center gap-2">
                        <div style="width:34px; height:34px; border-radius:10px; background:rgba(255,255,255,0.15); display:flex; align-items:center; justify-content:center; border:1px solid rgba(255,255,255,0.25);">
                            <i class="bi bi-mortarboard-fill text-warning" style="font-size:1.1rem;"></i>
                        </div>
                        <div>
                            <div class="fw-extrabold text-white text-uppercase" style="font-size:0.72rem; letter-spacing:0.08em;">UniTRS University</div>
                            <div class="text-white text-opacity-70" style="font-size:0.65rem;">Office of Academic Affairs</div>
                        </div>
                    </div>
                    <span class="badge bg-warning text-dark fw-extrabold rounded-pill px-2 py-1" style="font-size:0.65rem; letter-spacing:0.04em;">EXECUTIVE DEAN</span>
                </div>

                <div class="mb-3">
                    <div class="text-white text-opacity-70 small mb-0" style="font-size:0.72rem;">Dean of School</div>
                    <div class="fw-bold text-white text-truncate mb-2" style="font-size:0.95rem;">${deanSchool.schoolName}</div>
                    <div class="fw-extrabold text-white" style="font-size:1.25rem; letter-spacing:-0.02em;">${user.fullName}</div>
                </div>

                <div class="d-flex justify-content-between align-items-end pt-3 border-top border-white border-opacity-20">
                    <div>
                        <div class="text-white text-opacity-70" style="font-size:0.65rem; text-transform:uppercase; letter-spacing:0.05em;">Dean ID / Barcode</div>
                        <div class="d-flex align-items-center gap-2 mt-1">
                            <button type="button" class="btn btn-sm btn-white bg-white text-dark rounded-pill px-3 py-1 fw-bold font-monospace border-0" data-id="${user.formattedIdentifier}" onclick="copyDeanId(this.getAttribute('data-id'), this)" style="font-size:0.78rem;" title="Click to copy Dean ID">
                                <i class="bi bi-copy text-primary me-1"></i>${user.formattedIdentifier}
                            </button>
                        </div>
                    </div>

                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-white bg-opacity-20 text-white border border-white border-opacity-25 rounded-pill px-3 py-1 font-monospace" style="font-size:0.75rem;">
                            <i class="bi bi-shield-check me-1 text-warning"></i>VERIFIED DEAN
                        </span>
                    </div>
                </div>
            </div>

            <!-- Campus Facilities Card -->
            <div class="mobile-course-card p-3 mb-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <div class="d-flex align-items-center gap-2">
                        <div class="kpi-icon-box emerald mb-0"><i class="bi bi-building-fill"></i></div>
                        <div>
                            <div class="fw-bold text-dark small">Campus Facilities & Rooms</div>
                            <div class="text-muted" style="font-size:0.72rem;">${rooms.size()} classrooms registered</div>
                        </div>
                    </div>
                    <div class="d-flex gap-1">
                        <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 py-1 fw-bold" data-bs-toggle="modal" data-bs-target="#addRoomModal" style="font-size:0.75rem;">
                            <i class="bi bi-plus-lg"></i> Room
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-2 py-1 fw-bold" data-bs-toggle="modal" data-bs-target="#batchRoomModal" style="font-size:0.75rem;" title="Batch generate rooms">
                            <i class="bi bi-layers"></i>
                        </button>
                    </div>
                </div>
                <div class="list-group list-group-flush border-top border-light mt-2 pt-1" style="max-height: 200px; overflow-y: auto;">
                    <c:forEach var="room" items="${rooms}">
                        <div class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-bottom border-light">
                            <div class="d-flex align-items-center gap-2">
                                <span class="badge bg-light border text-dark fw-bold font-monospace">Room ${room.roomNumber}</span>
                                <span class="text-muted small">Floor ${room.floorNumber} &bull; Cap: <strong>${room.capacity}</strong></span>
                            </div>
                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="m-0 p-0">
                                <input type="hidden" name="action" value="deleteRoom">
                                <input type="hidden" name="roomId" value="${room.id}">
                                <button type="submit" class="btn btn-sm btn-link text-danger p-0" title="Delete room" onclick="return confirm('Delete Room ${room.roomNumber}?');">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                    <c:if test="${empty rooms}">
                        <div class="text-center text-muted py-3 small">No rooms registered yet.</div>
                    </c:if>
                </div>
            </div>

            <!-- Two-Factor Authentication Security Card -->
            <div class="mobile-course-card p-3 mb-3">
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="d-flex align-items-center gap-2">
                        <div class="kpi-icon-box blue mb-0"><i class="bi bi-shield-lock-fill"></i></div>
                        <div>
                            <div class="fw-bold text-dark small">Two-Factor Authentication</div>
                            <div class="text-muted" style="font-size:0.72rem;">Enhance account login security</div>
                        </div>
                    </div>
                    <span class="badge ${user.twoFactorEnabled ? 'bg-success' : 'bg-warning text-dark'} rounded-pill px-2 py-1" style="font-size:0.68rem; font-weight:700;">
                        ${user.twoFactorEnabled ? 'Enabled' : 'Disabled'}
                    </span>
                </div>
                <p class="text-muted small mb-3" style="font-size:0.78rem;">Requires a one-time OTP email code upon every login attempt.</p>
                <form action="${pageContext.request.contextPath}/auth/toggle-2fa" method="post" class="d-inline">
                    <input type="hidden" name="redirect" value="/dean/dashboard?tab=profile">
                    <button type="submit" class="btn btn-sm ${user.twoFactorEnabled ? 'btn-outline-danger' : 'btn-primary'} w-100 rounded-pill py-2 fw-bold" style="min-height:44px;">
                        <i class="bi ${user.twoFactorEnabled ? 'bi-shield-slash' : 'bi-shield-check'} me-1"></i>
                        ${user.twoFactorEnabled ? 'Disable 2-Step Verification' : 'Enable 2-Step Verification'}
                    </button>
                </form>
            </div>


            <!-- Sign Out Button -->
            <div class="pt-2 mb-4">
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger w-100 rounded-pill py-3 fw-bold text-decoration-none shadow-sm" style="min-height:48px; display:flex; align-items:center; justify-content:center; gap:8px;">
                    <i class="bi bi-box-arrow-right"></i> Sign Out of Dean Account
                </a>
            </div>
        </section>

        <!-- Floating Island Bottom Dock -->
        <nav class="mobile-bottom-dock mobile-dock" role="navigation" aria-label="Dean Mobile Navigation">
            <button type="button" class="dock-tab-btn active" id="dock-tab-home" data-tab="home" onclick="switchDeanMobileTab('home')" role="tab" aria-selected="true" aria-controls="mobile-view-home" aria-label="Home Overview">
                <i class="bi bi-house-door-fill"></i>
                <span>Home</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-courses" data-tab="courses" onclick="switchDeanMobileTab('courses')" role="tab" aria-selected="false" aria-controls="mobile-view-courses" aria-label="Courses Catalog">
                <i class="bi bi-book"></i>
                <span>Courses</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-schedules" data-tab="schedules" onclick="switchDeanMobileTab('schedules')" role="tab" aria-selected="false" aria-controls="mobile-view-schedules" aria-label="Class Schedules">
                <i class="bi bi-clock-history"></i>
                <span>Schedules</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-people" data-tab="people" onclick="switchDeanMobileTab('people')" role="tab" aria-selected="false" aria-controls="mobile-view-people" aria-label="People Directory">
                <i class="bi bi-people"></i>
                <span>People</span>
            </button>
            <button type="button" class="dock-tab-btn" id="dock-tab-profile" data-tab="profile" onclick="switchDeanMobileTab('profile')" role="tab" aria-selected="false" aria-controls="mobile-view-profile" aria-label="Executive Profile">
                <i class="bi bi-person-badge"></i>
                <span>Profile</span>
            </button>
        </nav>

        <!-- Floating Toast Notification -->
        <div id="deanMobileToast" class="mobile-toast" role="status" aria-live="polite">
            <i class="bi bi-check-circle-fill text-success"></i>
            <span id="deanMobileToastText">Copied to clipboard!</span>
        </div>

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

    <c:forEach var="section" items="${sections}">
        <div class="modal fade" id="sectionStudentsModal${section.id}" tabindex="-1" aria-labelledby="sectionStudentsModalLabel${section.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 border-0 shadow">
                    <div class="modal-header border-bottom pb-3">
                        <div>
                            <h5 class="modal-title fw-bold text-dark" id="sectionStudentsModalLabel${section.id}">
                                <i class="bi bi-people text-primary me-2"></i>Enrolled Students
                            </h5>
                            <div class="text-muted small">${section.courseCode} - ${section.courseTitle} &bull; Room ${section.roomName}</div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3">
                        <c:set var="secStudents" value="${sectionStudentsMap[section.id]}" />
                        <c:choose>
                            <c:when test="${empty secStudents}">
                                <div class="text-center text-muted py-4 small">
                                    <i class="bi bi-people fs-2 d-block mb-2 text-muted"></i>
                                    No students are currently enrolled in this section.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="list-group list-group-flush">
                                    <c:forEach var="st" items="${secStudents}">
                                        <div class="list-group-item d-flex justify-content-between align-items-center px-0 py-2 border-bottom">
                                            <div>
                                                <div class="fw-bold text-dark small">${st.fullName}</div>
                                                <div class="text-muted" style="font-size:0.75rem;">${st.formattedIdentifier} &bull; ${st.email}</div>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="m-0">
                                                <input type="hidden" name="action" value="unenrollStudent">
                                                <input type="hidden" name="studentId" value="${st.id}">
                                                <input type="hidden" name="sectionId" value="${section.id}">
                                                <input type="hidden" name="tab" value="schedules">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-1 fw-bold" style="font-size:0.75rem;" onclick="return confirm('Remove student ${st.fullName} from this section?');">
                                                    <i class="bi bi-person-x me-1"></i>Unenroll
                                                </button>
                                            </form>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="modal-footer border-top py-2">
                        <button type="button" class="btn btn-sm btn-light rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

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

        // ========================================================
        // DEAN MOBILE SCRIPTS
        // ========================================================
        function switchDeanMobileTab(tabName) {
            var views = document.querySelectorAll('.mobile-sub-view');
            views.forEach(function(v) { v.classList.remove('active'); });

            var target = document.getElementById('mobile-view-' + tabName);
            if (target) {
                target.classList.add('active');
            }

            var btns = document.querySelectorAll('.dock-tab-btn');
            var iconMap = {
                home: ['bi-house-door-fill', 'bi-house-door'],
                courses: ['bi-book-fill', 'bi-book'],
                schedules: ['bi-clock-history', 'bi-clock'],
                people: ['bi-people-fill', 'bi-people'],
                profile: ['bi-person-badge-fill', 'bi-person-badge']
            };

            btns.forEach(function(b) {
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
            });

            try {
                var url = new URL(window.location);
                url.searchParams.set('tab', tabName);
                window.history.replaceState({}, '', url);
            } catch(e) {}
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function filterMobileDeanCourses(q) {
            q = (q || '').toLowerCase().trim();
            var items = document.querySelectorAll('.mobile-dean-course-item');
            var visible = 0;
            items.forEach(function(item) {
                var match = (item.textContent || '').toLowerCase().indexOf(q) !== -1;
                item.style.display = match ? '' : 'none';
                if (match) visible++;
            });
            var empty = document.getElementById('mobileDeanCoursesEmpty');
            if (empty) {
                empty.style.display = (visible === 0 && items.length > 0) ? 'block' : 'none';
            }
        }

        function clearMobileDeanCourseSearch() {
            var inp = document.getElementById('mobileDeanCourseSearch');
            if (inp) inp.value = '';
            filterMobileDeanCourses('');
        }

        function filterMobileDeanSchedules(q) {
            q = (q || '').toLowerCase().trim();
            var items = document.querySelectorAll('.mobile-dean-section-item');
            var visible = 0;
            items.forEach(function(item) {
                var match = (item.textContent || '').toLowerCase().indexOf(q) !== -1;
                item.style.display = match ? '' : 'none';
                if (match) visible++;
            });
            var empty = document.getElementById('mobileDeanSchedulesEmpty');
            if (empty) {
                empty.style.display = (visible === 0 && items.length > 0) ? 'block' : 'none';
            }
        }

        function filterDeanScheduleShift(shift, btn) {
            var strip = document.getElementById('deanScheduleFilterStrip');
            if (strip) {
                strip.querySelectorAll('.filter-chip').forEach(function(c) { c.classList.remove('active'); });
            }
            if (btn) btn.classList.add('active');

            var items = document.querySelectorAll('.mobile-dean-section-item');
            var visible = 0;
            shift = (shift || 'all').toLowerCase();

            items.forEach(function(item) {
                var itemShift = (item.getAttribute('data-shift') || '').toLowerCase();
                var match = (shift === 'all') || (itemShift.indexOf(shift) !== -1);
                item.style.display = match ? '' : 'none';
                if (match) visible++;
            });

            var empty = document.getElementById('mobileDeanSchedulesEmpty');
            if (empty) {
                empty.style.display = (visible === 0 && items.length > 0) ? 'block' : 'none';
            }
        }

        function toggleDeanCourseSegment(target) {
            var btnCatalog = document.getElementById('deanSegCatalogBtn');
            var btnBundles = document.getElementById('deanSegBundlesBtn');
            var catalogContainer = document.getElementById('mobileDeanCoursesContainer');
            var bundlesContainer = document.getElementById('mobileDeanBundlesContainer');
            var searchBar = document.querySelector('#mobile-view-courses .mobile-search-bar');

            if (target === 'catalog') {
                if (btnCatalog) btnCatalog.classList.add('active');
                if (btnBundles) btnBundles.classList.remove('active');
                if (catalogContainer) catalogContainer.style.display = '';
                if (bundlesContainer) bundlesContainer.style.display = 'none';
                if (searchBar) searchBar.style.display = '';
            } else {
                if (btnBundles) btnBundles.classList.add('active');
                if (btnCatalog) btnCatalog.classList.remove('active');
                if (catalogContainer) catalogContainer.style.display = 'none';
                if (bundlesContainer) bundlesContainer.style.display = '';
                if (searchBar) searchBar.style.display = 'none';
            }
        }

        function toggleDeanPeopleSegment(target) {
            var btnFaculty = document.getElementById('deanSegFacultyBtn');
            var btnStudents = document.getElementById('deanSegStudentsBtn');
            var facultyList = document.getElementById('deanFacultyContainer');
            var studentsList = document.getElementById('deanStudentsContainer');

            if (target === 'faculty') {
                if (btnFaculty) btnFaculty.classList.add('active');
                if (btnStudents) btnStudents.classList.remove('active');
                if (facultyList) facultyList.style.display = '';
                if (studentsList) studentsList.style.display = 'none';
            } else {
                if (btnStudents) btnStudents.classList.add('active');
                if (btnFaculty) btnFaculty.classList.remove('active');
                if (facultyList) facultyList.style.display = 'none';
                if (studentsList) studentsList.style.display = '';
            }

            var search = document.getElementById('mobileDeanPeopleSearch');
            if (search) {
                filterMobileDeanPeople(search.value);
            }
        }

        function filterMobileDeanPeople(q) {
            q = (q || '').toLowerCase().trim();
            var activeFaculty = document.getElementById('deanSegFacultyBtn').classList.contains('active');
            var items = activeFaculty
                ? document.querySelectorAll('#deanFacultyContainer .faculty-person-item')
                : document.querySelectorAll('#deanStudentsContainer .student-person-item');
            var visible = 0;

            items.forEach(function(item) {
                var match = (item.textContent || '').toLowerCase().indexOf(q) !== -1;
                item.style.display = match ? '' : 'none';
                if (match) visible++;
            });

            var empty = document.getElementById('mobileDeanPeopleEmpty');
            if (empty) {
                empty.style.display = (visible === 0 && items.length > 0) ? 'block' : 'none';
            }
        }

        function copyDeanId(idText, btnEl) {
            if (!idText) return;
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(idText).then(onCopySuccess).catch(fallbackCopy);
            } else {
                fallbackCopy();
            }

            function fallbackCopy() {
                var ta = document.createElement('textarea');
                ta.value = idText;
                ta.style.position = 'fixed';
                ta.style.left = '-9999px';
                document.body.appendChild(ta);
                ta.select();
                try { document.execCommand('copy'); onCopySuccess(); } catch (e) {}
                document.body.removeChild(ta);
            }

            function onCopySuccess() {
                var toast = document.getElementById('deanMobileToast');
                var toastText = document.getElementById('deanMobileToastText');
                if (toast) {
                    if (toastText) toastText.textContent = 'ID copied: ' + idText;
                    toast.classList.add('show');
                    clearTimeout(window._deanToastTimer);
                    window._deanToastTimer = setTimeout(function () {
                        toast.classList.remove('show');
                    }, 2500);
                }
                if (btnEl) {
                    var origHtml = btnEl.innerHTML;
                    btnEl.innerHTML = '<i class="bi bi-check2 text-success"></i> <span>Copied!</span>';
                    setTimeout(function () { btnEl.innerHTML = origHtml; }, 1800);
                }
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            try {
                var params = new URLSearchParams(window.location.search);
                var tab = params.get('tab');
                if (tab) {
                    if (document.getElementById('mobile-view-' + tab)) {
                        switchDeanMobileTab(tab);
                    }
                }
            } catch(e) {}
        });
    </script>
</body>
</html>
