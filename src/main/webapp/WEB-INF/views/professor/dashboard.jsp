<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professor Dashboard - UniTRS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        @media (max-width: 767.98px) {
            body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f6f8fb; padding-bottom: 90px; }
            .mobile-app-container { padding: 16px 16px 20px; }

            /* Top Bar */
                    .mobile-top-bar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                    }

                    .mobile-user-info {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .mobile-avatar-frame {
                        width: 46px;
                        height: 46px;
                        border-radius: 14px;
                        overflow: hidden;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                        border: 2px solid #fff;
                        flex-shrink: 0;
                        background: #e2e8f0;
                    }

                    .mobile-avatar-frame img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    .mobile-user-greeting {
                        font-size: 1.05rem;
                        font-weight: 800;
                        color: #0f172a;
                        margin-bottom: 2px;
                        line-height: 1.2;
                    }

                    .mobile-badge-pill {
                        display: inline-block;
                        background: #e9edf2;
                        color: #64748b;
                        font-size: 0.72rem;
                        font-weight: 600;
                        padding: 2px 10px;
                        border-radius: 20px;
                    }

                    .mobile-top-action-btn {
                        width: 42px;
                        height: 42px;
                        background: #fff;
                        border-radius: 14px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border: 1px solid #edf2f7;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
                        color: #334155;
                        font-size: 1.15rem;
                        cursor: pointer;
                        transition: transform 0.15s ease, background 0.15s ease;
                    }

                    .mobile-top-action-btn:active {
                        transform: scale(0.92);
                        background: #f1f5f9;
                    }

                    
            /* Hero Banner */
            .mobile-hero-banner {
                background: linear-gradient(135deg, #0284c7 0%, #3b82f6 30%, #4338ca 70%, #312e81 100%);
                border-radius: 24px; padding: 16px; color: #fff;
                box-shadow: 0 12px 28px rgba(59,130,246,0.28);
                display: flex; align-items: center; gap: 14px; margin-bottom: 20px;
                position: relative; overflow: hidden;
            }
            .mobile-hero-banner::after {
                content: ''; position: absolute; top: -40%; right: -40%; width: 100%; height: 100%;
                background: radial-gradient(circle, rgba(255,255,255,0.22) 0%, transparent 60%); pointer-events: none;
            }
            .hero-avatar-box {
                width: 86px; height: 86px; border-radius: 18px; overflow: hidden; flex-shrink: 0;
                background: rgba(255,255,255,0.15); border: 2px solid rgba(255,255,255,0.45);
                box-shadow: 0 6px 14px rgba(0,0,0,0.2); display: flex; align-items: center; justify-content: center;
                font-size: 2.5rem; color: #fff;
            }
            .hero-avatar-box img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .hero-content { flex: 1; min-width: 0; z-index: 1; }
            .hero-label { font-size: 0.65rem; font-weight: 800; letter-spacing: 0.8px; color: rgba(255,255,255,0.85); text-transform: uppercase; margin-bottom: 3px; }
            .hero-title { font-size: 0.95rem; font-weight: 800; color: #fff; margin-bottom: 4px; line-height: 1.25; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
            .hero-meta-row { font-size: 0.72rem; color: rgba(255,255,255,0.92); display: flex; align-items: center; gap: 5px; margin-bottom: 3px; }
            .hero-status-tag {
                display: inline-flex; align-items: center; gap: 4px; background: rgba(255,255,255,0.92);
                color: #0369a1; font-size: 0.65rem; font-weight: 700; padding: 3px 8px; border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            /* Multi-day Date Strip */
                    .mobile-date-strip {
                        display: flex;
                        gap: 8px;
                        overflow-x: auto;
                        margin-bottom: 20px;
                        padding-bottom: 5px;
                        scrollbar-width: none;
                    }

                    .mobile-date-strip::-webkit-scrollbar {
                        display: none;
                    }

                    .date-strip-item {
                        flex: 0 0 calc(100% / 5.5);
                        background: #fff;
                        border: 1px solid #e2e8f0;
                        border-radius: 16px;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        padding: 12px 0;
                        color: #64748b;
                        transition: all 0.2s;
                    }

                    .date-strip-item.active {
                        background: #11141a;
                        border-color: #11141a;
                        color: #fff;
                        box-shadow: 0 6px 12px rgba(17, 20, 26, 0.15);
                        transform: translateY(-2px);
                    }

                    .ds-day {
                        font-size: 0.7rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        margin-bottom: 4px;
                    }

                    .ds-date {
                        font-size: 1.25rem;
                        font-weight: 800;
                        line-height: 1;
                    }

                    .date-strip-item.active .ds-day {
                        color: rgba(255, 255, 255, 0.7);
                    }

                    .date-strip-item.active .ds-date {
                        color: #fff;
                    }

                    .date-strip-item.active::after {
                        content: '';
                        display: block;
                        width: 6px;
                        height: 6px;
                        background: #22c55e;
                        border-radius: 50%;
                        margin-top: 6px;
                        animation: pulse 1.8s infinite;
                    }

                    @keyframes pulse {

                        0%,
                        100% {
                            transform: scale(0.9);
                            opacity: 0.8;
                        }

                        50% {
                            transform: scale(1.4);
                            opacity: 1;
                        }
                    }

            /* Class Cards */
                    .section-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 12px;
                    }

                    .section-title {
                        font-size: 1.0rem;
                        font-weight: 800;
                        color: #0f172a;
                    }

                    .mobile-course-card,
                    .mobile-class-card {
                        background: #fff;
                        border-radius: 18px;
                        padding: 15px;
                        margin-bottom: 12px;
                        border: 1px solid #edf2f7;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
                        cursor: pointer;
                        transition: transform 0.15s ease, box-shadow 0.15s ease;
                    }

                    .mobile-course-card:active,
                    .mobile-class-card:active {
                        transform: scale(0.98);
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
                    }

                    .mc-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; }
                    .mc-code { font-size: 0.78rem; font-weight: 800; color: #0369a1; background: #e0f2fe; padding: 3px 10px; border-radius: 12px; }
                    .mc-badge { font-size: 0.7rem; font-weight: 700; background: #f1f5f9; color: #64748b; padding: 3px 8px; border-radius: 8px; }
                    .mc-title { font-size: 0.95rem; font-weight: 800; color: #0f172a; margin-bottom: 12px; line-height: 1.25; }
                    .mc-meta { display: flex; flex-wrap: wrap; gap: 15px; font-size: 0.75rem; color: #64748b; }
                    .mc-meta-item { display: flex; align-items: center; gap: 5px; }
                    
                    .mc-students { display: flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 700; color: #16a34a; background: #dcfce7; padding: 4px 10px; border-radius: 12px; margin-top: 12px; display: inline-flex; }

            /* Bottom dock */
                    .mobile-bottom-dock {
                        position: fixed;
                        bottom: 0;
                        left: 0;
                        right: 0;
                        background: rgba(255, 255, 255, 0.96);
                        backdrop-filter: blur(18px);
                        -webkit-backdrop-filter: blur(18px);
                        border-top: 1px solid #eef2f6;
                        display: flex;
                        justify-content: space-around;
                        align-items: center;
                        padding: 8px 10px calc(8px + env(safe-area-inset-bottom, 8px));
                        z-index: 1040;
                        box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.03);
                    }

                    .dock-tab-btn {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        background: transparent;
                        border: none;
                        color: #94a3b8;
                        font-size: 0.68rem;
                        font-weight: 600;
                        padding: 4px 6px;
                        cursor: pointer;
                        transition: all 0.18s ease;
                        text-decoration: none;
                    }

                    .dock-tab-btn i {
                        font-size: 1.25rem;
                        margin-bottom: 2px;
                        transition: transform 0.18s ease;
                    }

                    .dock-tab-btn.active {
                        color: #0f172a;
                        font-weight: 700;
                    }

                    .dock-tab-btn.active i {
                        transform: translateY(-2px);
                    }

                    
            .mobile-sub-view { display: none; animation: fadeUp 0.22s ease; }
            .mobile-sub-view.active { display: block; }
            @keyframes fadeUp { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }

            
            /* Action Sheets */
            .action-sheet-overlay {
                position: fixed; inset: 0; background: rgba(15,23,42,0.55);
                z-index: 1060; display: none; align-items: flex-end; justify-content: center;
                backdrop-filter: blur(4px); -webkit-backdrop-filter: blur(4px);
            }
            .action-sheet-overlay.open { display: flex; }
            .action-sheet {
                background: #fff; border-radius: 26px 26px 0 0; width: 100%; max-width: 480px;
                max-height: 85vh; overflow-y: auto; display: flex; flex-direction: column;
                animation: slideUp 0.28s cubic-bezier(0.34,1.12,0.64,1);
            }
            @keyframes slideUp { from { transform: translateY(100%); } to { transform: translateY(0); } }
            .sheet-drag { width: 40px; height: 5px; background: #e2e8f0; border-radius: 99px; margin: 12px auto 0; flex-shrink: 0; }
            .sheet-header { padding: 16px 20px 10px; border-bottom: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; flex-shrink: 0; }
            .sheet-title { font-size: 1.1rem; font-weight: 800; color: #0f172a; margin: 0; line-height: 1.3; }
            .sheet-body { padding: 16px 20px; overflow-y: auto; flex: 1; }
            .sheet-footer { padding: 16px 20px; border-top: 1px solid #f1f5f9; flex-shrink: 0; background: #fff; }

            /* Action Buttons inside Course Sheet */
            .action-btn { display: flex; align-items: center; gap: 12px; padding: 16px; border-radius: 16px; margin-bottom: 12px; font-weight: 700; border: none; width: 100%; text-align: left; transition: all 0.15s; }
            .action-btn-primary { background: #e0e7ff; color: #4338ca; }
            .action-btn-success { background: #dcfce7; color: #15803d; }
            .action-btn-info { background: #e0f2fe; color: #0369a1; }
            .action-btn-secondary { background: #f1f5f9; color: #475569; }
            .action-btn:active { transform: scale(0.98); filter: brightness(0.95); }
            .action-btn i { font-size: 1.4rem; }
            .action-btn-text { display: flex; flex-direction: column; }
            .action-btn-desc { font-size: 0.7rem; font-weight: 600; opacity: 0.8; margin-top: 2px; }

            /* Mobile Forms */
            .form-section-title { font-size: 0.8rem; font-weight: 800; text-transform: uppercase; color: #64748b; margin-bottom: 10px; margin-top: 15px; }
            .student-row { background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 12px; margin-bottom: 10px; }
            .student-info { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 10px; }
            .student-name { font-size: 0.9rem; font-weight: 700; color: #0f172a; }
            .student-id { font-size: 0.7rem; color: #64748b; font-family: monospace; }
            
            /* Attendance Radio Chips */
            .radio-group { display: flex; gap: 6px; flex-wrap: wrap; }
            .radio-chip { flex: 1; min-width: 70px; }
            .radio-chip input { display: none; }
            .radio-chip label { display: block; text-align: center; font-size: 0.7rem; font-weight: 700; padding: 8px 4px; border-radius: 8px; border: 1px solid #e2e8f0; color: #64748b; cursor: pointer; transition: all 0.15s; }
            .radio-chip input[value="PRESENT"]:checked + label { background: #16a34a; border-color: #16a34a; color: white; }
            .radio-chip input[value="ABSENT"]:checked + label { background: #dc2626; border-color: #dc2626; color: white; }
            .radio-chip input[value="LATE"]:checked + label { background: #d97706; border-color: #d97706; color: white; }
            .radio-chip input[value="EXCUSED"]:checked + label { background: #0284c7; border-color: #0284c7; color: white; }

            /* Grading Inputs */
            .grade-input-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
            .grade-input-box { background: #f8fafc; border-radius: 10px; padding: 8px 10px; border: 1px solid #e2e8f0; }
            .grade-input-label { font-size: 0.65rem; font-weight: 700; color: #64748b; margin-bottom: 4px; display: block; }
            .grade-input-box input { width: 100%; border: none; background: transparent; font-size: 1.1rem; font-weight: 800; color: #0f172a; outline: none; padding: 0; }
            .grade-input-box input:focus { color: #2563eb; }
        }
    </style>
</head>
<body>
<div class="d-none d-md-flex desktop-app-container">
    <style>
        .desktop-app-container {
            min-height: 100vh;
            background-color: #f3f5f8;
            font-family: 'Plus Jakarta Sans', sans-serif;
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
            font-size: 1.5rem;
            font-weight: 800;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 28px;
            padding: 0 10px;
        }

        .sidebar-logo i {
            color: #2563eb;
            font-size: 1.8rem;
        }

        .sidebar-search {
            position: relative;
            margin-bottom: 24px;
        }

        .sidebar-search input {
            width: 100%;
            background: #f8fafc;
            border: 1px solid #f1f5f9;
            border-radius: 99px;
            padding: 12px 16px 12px 42px;
            font-size: 0.85rem;
            color: #334155;
            transition: all 0.2s;
        }

        .sidebar-search input:focus {
            outline: none;
            background: #fff;
            border-color: #cbd5e1;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
        }

        .sidebar-search i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 1rem;
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
            padding: 14px 18px;
            border-radius: 16px;
            font-size: 0.95rem;
            font-weight: 600;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
            width: 100%;
        }

        .sidebar-nav button i {
            font-size: 1.25rem;
            color: #94a3b8;
            transition: all 0.2s;
        }

        .sidebar-nav button:hover {
            color: #0f172a;
            background: #f8fafc;
        }

        .sidebar-nav button:hover i {
            color: #0f172a;
        }

        .sidebar-nav button.active {
            background: #0f172a;
            color: #ffffff;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.2);
        }

        .sidebar-nav button.active i {
            color: #ffffff;
        }

        /* PROMO / FACULTY WIDGET */
        .sidebar-promo {
            background: linear-gradient(145deg, #eff6ff, #dbeafe);
            border-radius: 24px;
            padding: 22px 18px;
            text-align: center;
            margin-top: 24px;
            position: relative;
            overflow: hidden;
            border: 1px solid #bfdbfe;
        }

        .sidebar-promo .star-icon {
            width: 48px;
            height: 48px;
            background: #2563eb;
            color: white;
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 14px;
            box-shadow: 0 8px 16px rgba(37, 99, 235, 0.25);
            transform: rotate(-8deg);
        }

        .sidebar-promo h4 {
            font-size: 0.95rem;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 6px;
        }

        .sidebar-promo p {
            font-size: 0.72rem;
            color: #475569;
            margin-bottom: 14px;
            line-height: 1.4;
        }

        .sidebar-promo button, .sidebar-promo a.btn {
            background: #0f172a;
            color: white;
            border: none;
            width: 100%;
            padding: 10px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 700;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .sidebar-promo button:hover, .sidebar-promo a.btn:hover {
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
            padding: 10px 0;
        }

        .header-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: #0f172a;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .action-btn {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #ffffff;
            border: 1px solid #f1f5f9;
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
            color: #0f172a;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }

        .action-btn.has-dot::after {
            content: '';
            position: absolute;
            top: 10px;
            right: 12px;
            width: 8px;
            height: 8px;
            background: #ef4444;
            border-radius: 50%;
            border: 2px solid #fff;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #ffffff;
            padding: 6px 16px 6px 6px;
            border-radius: 99px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            color: inherit;
            border: 1px solid #f1f5f9;
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
        }

        .user-avatar {
            width: 40px;
            height: 40px;
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
            color: #0f172a;
            line-height: 1.2;
        }

        .user-role {
            font-size: 0.7rem;
            color: #64748b;
        }

        /* METRIC CARDS */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }

        .metric-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            border: 1px solid rgba(226, 232, 240, 0.6);
            position: relative;
        }

        .mc-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .mc-icon-wrap {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .mc-icon {
            width: 38px;
            height: 38px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
        }

        .mc-icon.green { background: #dcfce7; color: #16a34a; }
        .mc-icon.orange { background: #ffedd5; color: #f97316; }
        .mc-icon.blue { background: #e0f2fe; color: #0284c7; }
        .mc-icon.purple { background: #f3e8ff; color: #9333ea; }

        .mc-title { font-size: 0.9rem; font-weight: 700; color: #0f172a; }
        .mc-value { font-size: 2.4rem; font-weight: 800; color: #0f172a; line-height: 1; margin-bottom: 8px; }
        .mc-subtitle { font-size: 0.75rem; color: #64748b; margin-bottom: 18px; }
        .mc-footer { display: flex; justify-content: space-between; align-items: flex-end; }
        .mc-trend { display: inline-flex; align-items: center; gap: 4px; padding: 4px 10px; border-radius: 99px; font-size: 0.7rem; font-weight: 700; }
        .mc-trend.positive { background: #f0fdf4; color: #16a34a; }
        .mc-trend.neutral { background: #f1f5f9; color: #64748b; }
        .mc-extra { font-size: 0.8rem; font-weight: 700; color: #64748b; }

        /* MIDDLE GRID */
        .middle-grid {
            display: grid;
            grid-template-columns: 2fr 1.1fr;
            gap: 24px;
            margin-bottom: 24px;
        }

        .chart-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 26px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            border: 1px solid rgba(226, 232, 240, 0.6);
            display: flex;
            flex-direction: column;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .chart-title-box h3 {
            font-size: 1.1rem;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 4px;
        }

        .chart-title-box p {
            font-size: 0.75rem;
            color: #64748b;
            margin: 0;
        }

        .chart-btn {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            padding: 6px 16px;
            border-radius: 99px;
            font-size: 0.75rem;
            font-weight: 700;
            color: #334155;
            cursor: pointer;
            transition: all 0.2s;
        }

        .chart-btn:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        .seg-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 26px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            border: 1px solid rgba(226, 232, 240, 0.6);
            display: flex;
            flex-direction: column;
        }

        .seg-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .seg-header h3 {
            font-size: 1.05rem;
            font-weight: 800;
            color: #0f172a;
            margin: 0;
        }

        .seg-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
            overflow-y: auto;
            flex: 1;
        }

        .seg-item {
            display: flex;
            flex-direction: column;
        }

        .seg-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 26px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            border: 1px solid rgba(226, 232, 240, 0.6);
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
            color: #0f172a;
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
        }

        .tc-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 5px 12px;
            border-radius: 99px;
            font-size: 0.72rem;
            font-weight: 700;
        }

        .tc-badge.success { background: #dcfce7; color: #15803d; }
        .tc-badge.info { background: #e0f2fe; color: #0369a1; }
        .tc-badge.warning { background: #fef3c7; color: #b45309; }
        .tc-badge.purple { background: #f3e8ff; color: #7e22ce; }

        .tc-course-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-right: 12px;
            color: #64748b;
        }

        .tab-panel {
            display: none;
            animation: fadeIn 0.25s ease;
        }

        .tab-panel.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ACCESSIBILITY FOCUS & SKIP LINK */
        .skip-link {
            position: absolute;
            top: -60px;
            left: 20px;
            background: #0f172a;
            color: #ffffff;
            padding: 10px 18px;
            border-radius: 12px;
            font-weight: 700;
            z-index: 10000;
            transition: top 0.2s ease;
            text-decoration: none;
            box-shadow: 0 4px 14px rgba(0,0,0,0.25);
        }

        .skip-link:focus {
            top: 20px;
            outline: 3px solid #2563eb;
        }

        *:focus-visible {
            outline: 2px solid #2563eb !important;
            outline-offset: 2px !important;
        }
    </style>

    <!-- Accessible Skip to Content Link -->
    <a href="#desktop-main-content" class="skip-link">Skip to main content</a>

    <!-- Screen Reader Live Announcer -->
    <div class="visually-hidden" aria-live="polite" id="sr-announcer"></div>

    <%-- DESKTOP SIDEBAR --%>
    <aside class="desktop-sidebar" role="complementary" aria-label="Faculty Navigation">
        <div class="sidebar-logo">
            <i class="bi bi-mortarboard-fill" aria-hidden="true"></i>
            <span>UniTRS</span>
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill ms-auto" style="font-size:0.65rem; padding: 4px 8px;">Faculty</span>
        </div>

        <div class="sidebar-search">
            <i class="bi bi-search" aria-hidden="true"></i>
            <input type="text" id="desktopSearchInput" placeholder="Search classes, students..." aria-label="Search classes and student rosters" onkeyup="filterDesktopClasses(this.value)">
        </div>

        <nav class="sidebar-nav" role="tablist" aria-label="Dashboard sections">
            <button role="tab" id="tab-dashboard" aria-selected="true" aria-controls="dt-dashboard" class="active" onclick="switchDesktopTab('dashboard', this)">
                <i class="bi bi-grid-fill" aria-hidden="true"></i> Dashboard
            </button>
            <button role="tab" id="tab-classes" aria-selected="false" aria-controls="dt-classes" tabindex="-1" onclick="switchDesktopTab('classes', this)">
                <i class="bi bi-journal-bookmark-fill" aria-hidden="true"></i> My Classes
            </button>
            <button role="tab" id="tab-schedule" aria-selected="false" aria-controls="dt-schedule" tabindex="-1" onclick="switchDesktopTab('schedule', this)">
                <i class="bi bi-calendar-event" aria-hidden="true"></i> Term Schedule
            </button>
            <button role="tab" id="tab-settings" aria-selected="false" aria-controls="dt-settings" tabindex="-1" onclick="switchDesktopTab('settings', this)">
                <i class="bi bi-gear" aria-hidden="true"></i> Settings
            </button>
        </nav>

        <div class="sidebar-promo">
            <div class="star-icon"><i class="bi bi-person-workspace" aria-hidden="true"></i></div>
            <h4>Faculty Portal</h4>
            <p>Active Term 2026-2027. Record attendance and grade submissions on time.</p>
            <c:choose>
                <c:when test="${sessionScope.user.deanSchoolId != null}">
                    <a href="${pageContext.request.contextPath}/dean/dashboard" class="btn">Switch to Dean View</a>
                </c:when>
                <c:otherwise>
                    <button type="button" onclick="switchDesktopTab('schedule', document.getElementById('tab-schedule'))">View My Schedule</button>
                </c:otherwise>
            </c:choose>
        </div>
    </aside>

    <%-- DESKTOP MAIN CONTENT --%>
    <main class="desktop-main" id="desktop-main-content" role="main" tabindex="-1">
        <%-- HEADER --%>
        <header class="desktop-header">
            <div>
                <h1 class="header-title mb-0">Faculty Overview</h1>
                <div class="text-muted small mt-1 fw-medium">
                    <i class="bi bi-mortarboard-fill text-primary me-1" aria-hidden="true"></i>
                    UniTRS Academic Faculty Portal &bull; Term 2026-2027
                </div>
            </div>

            <div class="header-actions">
                <button type="button" class="action-btn has-dot" aria-label="Notifications (1 new)">
                    <i class="bi bi-bell" aria-hidden="true"></i>
                </button>
                <button type="button" class="action-btn" aria-label="Messages">
                    <i class="bi bi-chat-dots" aria-hidden="true"></i>
                </button>

                <div class="dropdown">
                    <button class="user-profile dropdown-toggle border-0 text-start" type="button" id="professorProfileDropdown" data-bs-toggle="dropdown" aria-expanded="false" aria-label="User profile menu for ${sessionScope.user.fullName}">
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
                            <span class="user-role">${sessionScope.user.formattedIdentifier} <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill ms-1 px-2 py-0" style="font-size: 0.65rem; font-weight: 700;">${sessionScope.user.role}</span> <i class="bi bi-chevron-down ms-1" style="font-size:0.65rem;"></i></span>
                        </div>
                    </button>

                    <div class="dropdown-menu dropdown-menu-end shadow-lg rounded-4 p-0 border-0 mt-2 overflow-hidden user-dropdown-menu" aria-labelledby="professorProfileDropdown" style="width: 300px; z-index: 1060;">
                        <!-- Header Banner -->
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
                                    <div class="text-muted small text-uppercase fw-semibold" style="font-size: 0.68rem; letter-spacing: 0.5px;">Account Email</div>
                                    <div class="fw-semibold text-dark text-truncate" style="font-size: 0.85rem;">${sessionScope.user.email}</div>
                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill mt-1" style="font-size: 0.68rem; font-weight: 700;">
                                        <i class="bi bi-person-workspace me-1"></i>${sessionScope.user.role}
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Details Rows -->
                        <div class="p-3">
                            <div class="d-flex justify-content-between align-items-center py-2 border-bottom" style="font-size: 0.82rem;">
                                <span class="text-muted d-flex align-items-center gap-2">
                                    <i class="bi bi-person-badge text-primary" style="font-size: 0.95rem;"></i> Professor ID
                                </span>
                                <span class="fw-bold text-dark font-monospace text-end text-truncate ms-2" style="max-width: 170px;">
                                    ${sessionScope.user.formattedIdentifier}
                                </span>
                            </div>

                            <div class="d-flex justify-content-between align-items-center py-2" style="font-size: 0.82rem;">
                                <span class="text-muted d-flex align-items-center gap-2">
                                    <i class="bi bi-building text-primary" style="font-size: 0.95rem;"></i> School
                                </span>
                                <span class="fw-semibold text-dark text-end text-truncate ms-2" style="max-width: 170px;" title="${not empty professorSchool ? professorSchool.schoolName : (not empty sessionScope.user.major ? sessionScope.user.major : 'College of Science and Technology')}">
                                    <c:choose>
                                        <c:when test="${not empty professorSchool}">${professorSchool.schoolName}</c:when>
                                        <c:when test="${not empty sessionScope.user.major}">${sessionScope.user.major}</c:when>
                                        <c:otherwise>College of Science and Technology</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <!-- Logout Button -->
                        <div class="p-3 bg-light border-top">
                            <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger w-100 rounded-pill py-2 fw-bold d-flex align-items-center justify-content-center gap-2" style="font-size: 0.85rem; transition: all 0.2s;">
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
                    <i class="bi bi-shield-check me-2" aria-hidden="true"></i>Two-Factor Authentication (2FA) is now <strong>enabled</strong> for your account.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${param.twoFactorUpdated == 'false'}">
                <div class="alert alert-info alert-dismissible fade show rounded-4" role="alert">
                    <i class="bi bi-shield-slash me-2" aria-hidden="true"></i>Two-Factor Authentication (2FA) has been <strong>disabled</strong> for your account.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show rounded-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2" aria-hidden="true"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2" aria-hidden="true"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>

        <%-- Calculate total enrolled students --%>
        <c:set var="totalEnrolledCount" value="0" />
        <c:forEach var="entry" items="${sectionStudentsMap}">
            <c:set var="totalEnrolledCount" value="${totalEnrolledCount + entry.value.size()}" />
        </c:forEach>

        <%-- ================================================================== --%>
        <%-- TAB: DASHBOARD                                                     --%>
        <%-- ================================================================== --%>
        <div id="dt-dashboard" class="tab-panel active" role="tabpanel" aria-labelledby="tab-dashboard" tabindex="0">
            <%-- METRICS GRID --%>
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="mc-header">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon blue">
                                <i class="bi bi-journal-bookmark-fill" aria-hidden="true"></i>
                            </div>
                            <div class="mc-title">Assigned Classes</div>
                        </div>
                    </div>
                    <div class="mc-value">${sectionStudentsMap.size()}</div>
                    <div class="mc-subtitle">Active teaching sections this semester</div>
                    <div class="mc-footer">
                        <span class="mc-trend positive"><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Active</span>
                        <span class="mc-extra">Term 2026-2027</span>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="mc-header">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon green">
                                <i class="bi bi-people-fill" aria-hidden="true"></i>
                            </div>
                            <div class="mc-title">Total Students</div>
                        </div>
                    </div>
                    <div class="mc-value">${totalEnrolledCount}</div>
                    <div class="mc-subtitle">Students currently enrolled in your classes</div>
                    <div class="mc-footer">
                        <span class="mc-trend positive"><i class="bi bi-person-check-fill" aria-hidden="true"></i> Enrolled</span>
                        <span class="mc-extra">Across ${sectionStudentsMap.size()} Sections</span>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="mc-header">
                        <div class="mc-icon-wrap">
                            <div class="mc-icon orange">
                                <i class="bi bi-calendar-check-fill" aria-hidden="true"></i>
                            </div>
                            <div class="mc-title">Weekly Sessions</div>
                        </div>
                    </div>
                    <div class="mc-value">${sectionStudentsMap.size()}</div>
                    <div class="mc-subtitle">Classroom meeting blocks per week</div>
                    <div class="mc-footer">
                        <span class="mc-trend neutral"><i class="bi bi-clock-history" aria-hidden="true"></i> Midterm & Final</span>
                        <span class="mc-extra">On Track</span>
                    </div>
                </div>
            </div>

            <!-- Middle Grid: Schedule Overview & Quick Actions -->
            <div class="middle-grid">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title-box">
                            <h3><i class="bi bi-calendar3 me-2 text-primary" aria-hidden="true"></i>Teaching Schedule Overview</h3>
                            <p>Your weekly scheduled lecture and laboratory hours</p>
                        </div>
                        <button type="button" class="chart-btn" onclick="switchDesktopTab('schedule', document.getElementById('tab-schedule'))">View Full Schedule</button>
                    </div>

                    <c:if test="${empty sectionStudentsMap}">
                        <div class="text-center py-5 text-muted">
                            <i class="bi bi-calendar-x fs-1 d-block mb-2" aria-hidden="true"></i>
                            No classes scheduled for this term.
                        </div>
                    </c:if>

                    <div class="d-flex flex-column gap-3">
                        <c:forEach var="entry" items="${sectionStudentsMap}">
                            <c:set var="section" value="${entry.key}" />
                            <c:set var="students" value="${entry.value}" />
                            <div class="p-3 bg-light rounded-4 d-flex justify-content-between align-items-center border">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="tc-course-icon" style="width:48px; height:48px; border-radius:16px; background:#e0f2fe; color:#0284c7; display:flex; align-items:center; justify-content:center; font-size:1.4rem;">
                                        <i class="bi bi-book-half" aria-hidden="true"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark fs-6">${section.courseCode} - ${section.courseTitle}</div>
                                        <div class="text-muted small mt-1">
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle me-2"><i class="bi bi-clock me-1" aria-hidden="true"></i>${section.sessionShift}</span>
                                            <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle me-2"><i class="bi bi-calendar-event me-1" aria-hidden="true"></i>${section.daysOfWeek}</span>
                                            <span><i class="bi bi-door-open me-1" aria-hidden="true"></i>Room ${section.roomName}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <button type="button" class="btn btn-sm btn-primary rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#attendanceModal${section.id}">
                                        <i class="bi bi-clipboard-check me-1" aria-hidden="true"></i> Take Attendance
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="seg-card">
                    <div class="seg-header">
                        <h3><i class="bi bi-lightning-charge-fill text-warning me-2" aria-hidden="true"></i>Quick Class Actions</h3>
                    </div>
                    <div class="seg-list">
                        <c:if test="${empty sectionStudentsMap}">
                            <div class="text-center py-4 text-muted small">No active classes.</div>
                        </c:if>
                        <c:forEach var="entry" items="${sectionStudentsMap}">
                            <c:set var="section" value="${entry.key}" />
                            <c:set var="students" value="${entry.value}" />
                            <div class="seg-item pb-3 border-bottom">
                                <div class="seg-info mb-2">
                                    <span class="seg-name fw-bold text-dark">${section.courseCode}</span>
                                    <span class="seg-val badge bg-success-subtle text-success border border-success-subtle">${students.size()} Enrolled</span>
                                </div>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-sm btn-outline-primary w-50 rounded-3 py-1" data-bs-toggle="modal" data-bs-target="#attendanceModal${section.id}">
                                        <i class="bi bi-clipboard-check me-1" aria-hidden="true"></i>Attendance
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-success w-50 rounded-3 py-1" data-bs-toggle="modal" data-bs-target="#gradesModal${section.id}">
                                        <i class="bi bi-journal-text me-1" aria-hidden="true"></i>Grades
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Bottom Table Card: Courses Summary -->
            <div class="table-card">
                <div class="tc-header">
                    <h3><i class="bi bi-list-task me-2 text-primary" aria-hidden="true"></i>Course Sections Summary</h3>
                    <button type="button" class="chart-btn" onclick="switchDesktopTab('classes', document.getElementById('tab-classes'))">Manage Roster</button>
                </div>
                <div class="tc-table-wrap">
                    <table class="tc-table" aria-label="Assigned courses table">
                        <thead>
                            <tr>
                                <th scope="col">Course Code & Title</th>
                                <th scope="col">Term</th>
                                <th scope="col">Schedule & Shift</th>
                                <th scope="col">Classroom</th>
                                <th scope="col">Enrolled Students</th>
                                <th scope="col" class="text-end pe-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty sectionStudentsMap}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">You have not been assigned to teach any classes.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="entry" items="${sectionStudentsMap}">
                                <c:set var="section" value="${entry.key}" />
                                <c:set var="students" value="${entry.value}" />
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="tc-course-icon"><i class="bi bi-journal-text" aria-hidden="true"></i></div>
                                            <div>
                                                <div class="fw-bold text-dark">${section.courseCode}</div>
                                                <div class="text-muted small">${section.courseTitle}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="tc-badge info">${section.termName}</span></td>
                                    <td>
                                        <div class="fw-semibold text-dark">${section.daysOfWeek}</div>
                                        <div class="text-muted small">${section.sessionShift}</div>
                                    </td>
                                    <td><span class="badge bg-light text-dark border"><i class="bi bi-door-open me-1" aria-hidden="true"></i>${section.roomName}</span></td>
                                    <td><span class="tc-badge success"><i class="bi bi-people-fill me-1" aria-hidden="true"></i>${students.size()} Students</span></td>
                                    <td class="text-end pe-3">
                                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill me-1" data-bs-toggle="modal" data-bs-target="#historyModal${section.id}" title="Attendance History" aria-label="Attendance history for ${section.courseCode}">
                                            <i class="bi bi-clock-history" aria-hidden="true"></i>
                                        </button>
                                        <button type="button" class="btn btn-sm btn-primary rounded-pill me-1" data-bs-toggle="modal" data-bs-target="#attendanceModal${section.id}" title="Take Attendance" aria-label="Take attendance for ${section.courseCode}">
                                            <i class="bi bi-clipboard-check" aria-hidden="true"></i>
                                        </button>
                                        <button type="button" class="btn btn-sm btn-success rounded-pill" data-bs-toggle="modal" data-bs-target="#gradesModal${section.id}" title="Manage Grades" aria-label="Manage grades for ${section.courseCode}">
                                            <i class="bi bi-journal-text" aria-hidden="true"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- ================================================================== --%>
        <%-- TAB: MY CLASSES                                                    --%>
        <%-- ================================================================== --%>
        <div id="dt-classes" class="tab-panel" role="tabpanel" aria-labelledby="tab-classes" tabindex="0">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="h4 fw-bold text-dark mb-1">Assigned Classes & Student Rosters</h2>
                    <p class="text-muted small mb-0">Review student enrollment, record session attendance, and submit academic grades</p>
                </div>
            </div>

            <c:if test="${empty sectionStudentsMap}">
                <div class="table-card text-center py-5">
                    <i class="bi bi-journal-x fs-1 text-muted d-block mb-3" aria-hidden="true"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">No Classes Assigned</h3>
                    <p class="text-muted mb-0">You are currently not assigned to teach any course sections for this academic term.</p>
                </div>
            </c:if>

            <c:forEach var="entry" items="${sectionStudentsMap}">
                <c:set var="section" value="${entry.key}" />
                <c:set var="students" value="${entry.value}" />

                <section class="table-card mb-4 desktop-class-card" data-course-code="${section.courseCode.toLowerCase()}" data-course-title="${section.courseTitle.toLowerCase()}" aria-labelledby="section-heading-${section.id}">
                    <div class="d-flex flex-wrap justify-content-between align-items-center border-bottom pb-3 mb-3 gap-3">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="badge bg-primary fs-6 px-3 py-1 rounded-pill">${section.courseCode}</span>
                                <span class="badge bg-light text-dark border px-3 py-1 rounded-pill">${section.termName}</span>
                            </div>
                            <h3 class="h5 fw-bold text-dark mb-1" id="section-heading-${section.id}">${section.courseTitle}</h3>
                            <div class="text-muted small d-flex flex-wrap align-items-center gap-3">
                                <span><i class="bi bi-calendar-event me-1 text-primary" aria-hidden="true"></i>${section.daysOfWeek} (${section.sessionShift})</span>
                                <span><i class="bi bi-door-open me-1 text-primary" aria-hidden="true"></i>Room ${section.roomName}</span>
                                <span><i class="bi bi-people-fill me-1 text-success" aria-hidden="true"></i>${students.size()} Students Enrolled</span>
                            </div>
                        </div>

                        <div class="d-flex flex-wrap gap-2">
                            <button type="button" class="btn btn-outline-secondary rounded-pill px-3 py-2 fw-semibold btn-sm" data-bs-toggle="modal" data-bs-target="#historyModal${section.id}">
                                <i class="bi bi-clock-history me-1" aria-hidden="true"></i> Attendance History
                            </button>
                            <button type="button" class="btn btn-primary rounded-pill px-3 py-2 fw-semibold btn-sm" data-bs-toggle="modal" data-bs-target="#attendanceModal${section.id}">
                                <i class="bi bi-clipboard-check me-1" aria-hidden="true"></i> Take Attendance
                            </button>
                            <button type="button" class="btn btn-success rounded-pill px-3 py-2 fw-semibold btn-sm" data-bs-toggle="modal" data-bs-target="#gradesModal${section.id}">
                                <i class="bi bi-journal-text me-1" aria-hidden="true"></i> Manage Grades
                            </button>
                        </div>
                    </div>

                    <div class="tc-table-wrap">
                        <table class="tc-table mb-0" aria-label="Enrolled students for ${section.courseCode}">
                            <thead>
                                <tr>
                                    <th scope="col">Student ID</th>
                                    <th scope="col">Full Name</th>
                                    <th scope="col">Email Address</th>
                                    <th scope="col">Academic Major</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr>
                                        <td><span class="badge bg-light text-dark border px-3 py-2 rounded-pill font-monospace">${student.formattedIdentifier}</span></td>
                                        <td><strong class="text-dark">${student.fullName}</strong></td>
                                        <td class="text-muted">${student.email}</td>
                                        <td><span class="tc-badge info">${student.major}</span></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty students}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-4">No students have enrolled in this class section yet.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </section>
            </c:forEach>
        </div>

        <%-- ================================================================== --%>
        <%-- TAB: SCHEDULE                                                      --%>
        <%-- ================================================================== --%>
        <div id="dt-schedule" class="tab-panel" role="tabpanel" aria-labelledby="tab-schedule" tabindex="0">
            <div class="mb-4">
                <h2 class="h4 fw-bold text-dark mb-1">Weekly Teaching Timetable</h2>
                <p class="text-muted small mb-0">Overview of classroom allocations, schedule shifts, and lecture sessions</p>
            </div>

            <div class="row g-4">
                <c:if test="${empty sectionStudentsMap}">
                    <div class="col-12">
                        <div class="table-card text-center py-5">
                            <i class="bi bi-calendar-x fs-1 text-muted d-block mb-3" aria-hidden="true"></i>
                            <p class="text-muted mb-0">No classes scheduled for the current academic term.</p>
                        </div>
                    </div>
                </c:if>

                <c:forEach var="entry" items="${sectionStudentsMap}">
                    <c:set var="section" value="${entry.key}" />
                    <c:set var="students" value="${entry.value}" />
                    <div class="col-md-6 col-xl-4">
                        <div class="table-card h-100 mb-0 d-flex flex-column justify-content-between">
                            <div>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1 rounded-pill fw-bold">${section.courseCode}</span>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill"><i class="bi bi-people me-1" aria-hidden="true"></i>${students.size()} Students</span>
                                </div>
                                <h3 class="h6 fw-bold text-dark mb-3">${section.courseTitle}</h3>
                                <div class="p-3 bg-light rounded-4 mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-calendar3 text-primary me-2 fs-5" aria-hidden="true"></i>
                                        <div>
                                            <div class="small fw-bold text-dark">${section.daysOfWeek}</div>
                                            <div class="text-muted" style="font-size:0.75rem;">Session Days</div>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-clock text-primary me-2 fs-5" aria-hidden="true"></i>
                                        <div>
                                            <div class="small fw-bold text-dark">${section.sessionShift}</div>
                                            <div class="text-muted" style="font-size:0.75rem;">Shift Time</div>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-door-open text-primary me-2 fs-5" aria-hidden="true"></i>
                                        <div>
                                            <div class="small fw-bold text-dark">Room ${section.roomName}</div>
                                            <div class="text-muted" style="font-size:0.75rem;">Assigned Classroom</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="pt-2 border-top d-flex gap-2">
                                <button type="button" class="btn btn-sm btn-primary w-100 rounded-pill" data-bs-toggle="modal" data-bs-target="#attendanceModal${section.id}">
                                    <i class="bi bi-clipboard-check me-1" aria-hidden="true"></i> Attendance
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-success w-100 rounded-pill" data-bs-toggle="modal" data-bs-target="#gradesModal${section.id}">
                                    <i class="bi bi-journal-text me-1" aria-hidden="true"></i> Grades
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%-- ================================================================== --%>
        <%-- TAB: SETTINGS                                                      --%>
        <%-- ================================================================== --%>
        <div id="dt-settings" class="tab-panel" role="tabpanel" aria-labelledby="tab-settings" tabindex="0">
            <div class="mb-4">
                <h2 class="h4 fw-bold text-dark mb-1">Faculty Account Settings</h2>
                <p class="text-muted small mb-0">Manage security settings, two-factor authentication, and academic roles</p>
            </div>

            <div class="row g-4">
                <div class="col-lg-6">
                    <!-- Profile Card -->
                    <div class="table-card mb-4">
                        <h3 class="h5 fw-bold text-dark mb-3"><i class="bi bi-person-badge text-primary me-2" aria-hidden="true"></i>Faculty Profile</h3>
                        <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                            <div class="user-avatar" style="width:64px; height:64px; border-radius:20px;">
                                <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="" aria-hidden="true" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=e2e8f0&color=475569'">
                            </div>
                            <div>
                                <h4 class="h6 fw-bold text-dark mb-1">${sessionScope.user.fullName}</h4>
                                <div class="text-muted small">ID: ${sessionScope.user.formattedIdentifier}</div>
                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle mt-1 rounded-pill">Faculty Member</span>
                            </div>
                        </div>
                        <div class="small">
                            <div class="d-flex justify-content-between py-2 border-bottom">
                                <span class="text-muted">Email Address</span>
                                <span class="fw-semibold text-dark">${sessionScope.user.email}</span>
                            </div>
                            <div class="d-flex justify-content-between py-2 border-bottom">
                                <span class="text-muted">Account Role</span>
                                <span class="fw-semibold text-dark">${sessionScope.user.role}</span>
                            </div>
                            <div class="d-flex justify-content-between py-2">
                                <span class="text-muted">Academic Term</span>
                                <span class="fw-semibold text-dark">AY 2026-2027</span>
                            </div>
                        </div>
                    </div>

                    <!-- Dean Switcher Card -->
                    <c:if test="${sessionScope.user.deanSchoolId != null}">
                        <div class="table-card border-info border-opacity-25" style="background: linear-gradient(145deg, #f0fdfa, #ccfbf1);">
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <div class="mc-icon" style="background:#0d9488; color:white; width:44px; height:44px; border-radius:14px; display:flex; align-items:center; justify-content:center; font-size:1.3rem;">
                                    <i class="bi bi-mortarboard" aria-hidden="true"></i>
                                </div>
                                <div>
                                    <h3 class="h6 fw-bold text-dark mb-0">Dean Privileges Active</h3>
                                    <div class="text-muted small">You have faculty leadership access</div>
                                </div>
                            </div>
                            <p class="small text-muted mb-3">Access curriculum approvals, faculty assignments, and school-wide performance reporting.</p>
                            <a href="${pageContext.request.contextPath}/dean/dashboard" class="btn btn-dark w-100 rounded-pill py-2 fw-bold text-white text-decoration-none">
                                <i class="bi bi-mortarboard me-2" aria-hidden="true"></i> Switch to Dean Dashboard
                            </a>
                        </div>
                    </c:if>
                </div>

                <div class="col-lg-6">
                    <!-- Security / 2FA Card -->
                    <div class="table-card mb-4">
                        <h3 class="h5 fw-bold text-dark mb-3"><i class="bi bi-shield-lock text-primary me-2" aria-hidden="true"></i>Security & Authentication</h3>
                        
                        <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="p-3 bg-light rounded-4 border mb-4">
                            <input type="hidden" name="redirect" value="/professor/dashboard?tab=settings">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <label for="desktopTwoFactorSwitch" class="fw-bold text-dark mb-0 cursor-pointer">Two-Factor Authentication (2FA)</label>
                                    <p class="small text-muted mb-0 mt-1" id="twoFactorHelp">Receive an OTP security code via email each time you log in.</p>
                                </div>
                                <div class="form-check form-switch fs-4 mb-0">
                                    <input class="form-check-input" type="checkbox" role="switch" id="desktopTwoFactorSwitch" name="twoFactorEnabled" value="true" aria-describedby="twoFactorHelp" ${sessionScope.user.twoFactorEnabled ? 'checked' : ''} onchange="this.form.submit()">
                                </div>
                            </div>
                        </form>

                        <div class="border-top pt-3">
                            <h4 class="h6 fw-bold text-dark mb-2">Session Termination</h4>
                            <p class="small text-muted mb-3">Safely sign out of your faculty account on this browser.</p>
                            <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger rounded-pill px-4 fw-bold">
                                <i class="bi bi-box-arrow-right me-2" aria-hidden="true"></i> Sign Out
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%-- ================================================================== --%>
    <%-- DESKTOP MODALS (ACCESSIBLE & MODERNIZED)                            --%>
    <%-- ================================================================== --%>
    <c:forEach var="entry" items="${sectionStudentsMap}">
        <c:set var="section" value="${entry.key}" />
        <c:set var="students" value="${entry.value}" />

        <!-- Take Attendance Modal -->
        <div class="modal fade" id="attendanceModal${section.id}" tabindex="-1" aria-labelledby="attModalLabel${section.id}" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content rounded-4 border-0 shadow-lg">
                    <form action="${pageContext.request.contextPath}/professor/attendance/save" method="post">
                        <input type="hidden" name="classSectionId" value="${section.id}">
                        <input type="hidden" name="tab" value="classes">
                        <div class="modal-header bg-primary text-white border-0 py-3">
                            <h5 class="modal-title h6 fw-bold mb-0" id="attModalLabel${section.id}">
                                <i class="bi bi-clipboard-check me-2" aria-hidden="true"></i>Take Attendance - ${section.courseCode}
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-4">
                            <div class="mb-4">
                                <label for="sessionDate_${section.id}" class="form-label fw-bold text-dark">Session Date</label>
                                <input type="date" class="form-control rounded-3 w-50" id="sessionDate_${section.id}" name="sessionDate" required>
                            </div>
                            
                            <h6 class="border-bottom pb-2 mb-3 fw-bold text-dark">Student Roster</h6>
                            <c:if test="${empty students}">
                                <p class="text-muted text-center py-4">No students enrolled in this class section yet.</p>
                            </c:if>
                            
                            <c:forEach var="student" items="${students}">
                                <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 p-3 border rounded-3 bg-light-subtle">
                                    <div class="mb-2 mb-md-0">
                                        <strong class="text-dark">${student.fullName}</strong>
                                        <div class="text-muted small">${student.formattedIdentifier} &bull; ${student.major}</div>
                                    </div>
                                    <div>
                                        <fieldset class="btn-group" role="group" aria-label="Attendance status for ${student.fullName}">
                                            <input type="radio" class="btn-check" name="status_${student.id}" id="present_${section.id}_${student.id}" value="PRESENT" checked>
                                            <label class="btn btn-outline-success btn-sm px-3" for="present_${section.id}_${student.id}">Present</label>
                                          
                                            <input type="radio" class="btn-check" name="status_${student.id}" id="absent_${section.id}_${student.id}" value="ABSENT">
                                            <label class="btn btn-outline-danger btn-sm px-3" for="absent_${section.id}_${student.id}">Absent</label>
                                          
                                            <input type="radio" class="btn-check" name="status_${student.id}" id="late_${section.id}_${student.id}" value="LATE">
                                            <label class="btn btn-outline-warning btn-sm px-3" for="late_${section.id}_${student.id}">Late</label>
                                            
                                            <input type="radio" class="btn-check" name="status_${student.id}" id="excused_${section.id}_${student.id}" value="EXCUSED">
                                            <label class="btn btn-outline-info btn-sm px-3" for="excused_${section.id}_${student.id}">Excused</label>
                                        </fieldset>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="modal-footer border-0 bg-light py-3 rounded-bottom-4">
                            <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                            <c:if test="${not empty students}">
                                <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Save Attendance</button>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Attendance History Modal -->
        <div class="modal fade" id="historyModal${section.id}" tabindex="-1" aria-labelledby="histModalLabel${section.id}" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content rounded-4 border-0 shadow-lg">
                    <div class="modal-header border-0 py-3">
                        <h5 class="modal-title h6 fw-bold mb-0 text-dark" id="histModalLabel${section.id}">
                            <i class="bi bi-clock-history me-2 text-primary" aria-hidden="true"></i>Attendance History - ${section.courseCode}
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-0">
                        <c:set var="records" value="${sectionAttendanceMap[section.id]}" />
                        <c:if test="${empty records}">
                            <div class="p-5 text-center text-muted">
                                <i class="bi bi-calendar-x fs-2 d-block mb-2 text-muted" aria-hidden="true"></i>
                                No attendance records found for this section.
                            </div>
                        </c:if>
                        <c:if test="${not empty records}">
                            <table class="table mb-0 align-middle" aria-label="Attendance history records for ${section.courseCode}">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col" class="ps-4">Date (Click to View Breakdown)</th>
                                        <th scope="col">Present</th>
                                        <th scope="col">Absent</th>
                                        <th scope="col">Late/Excused</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="record" items="${records}">
                                        <tr>
                                            <td class="ps-4">
                                                <a class="text-decoration-none fw-bold text-dark d-inline-flex align-items-center gap-1" data-bs-toggle="collapse" href="#recordDetails_${section.id}_${record.id}" role="button" aria-expanded="false" aria-controls="recordDetails_${section.id}_${record.id}">
                                                    <i class="bi bi-chevron-down small text-primary" aria-hidden="true"></i>
                                                    <span>${record.sessionDate}</span>
                                                </a>
                                            </td>
                                            <td><span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill">${record.presentCount} Present</span></td>
                                            <td><span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1 rounded-pill">${record.absentCount} Absent</span></td>
                                            <td><span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1 rounded-pill">${record.lateCount + record.excusedCount} Other</span></td>
                                        </tr>
                                        <tr class="collapse" id="recordDetails_${section.id}_${record.id}">
                                            <td colspan="4" class="p-0 bg-light">
                                                <div class="p-3 border-start border-end">
                                                    <div class="small fw-semibold text-muted mb-2">Student Statuses for ${record.sessionDate}:</div>
                                                    <div class="row row-cols-1 row-cols-md-2 g-2">
                                                        <c:forEach var="entry" items="${record.entries}">
                                                            <div class="col">
                                                                <div class="d-flex justify-content-between align-items-center p-2 border rounded bg-white small">
                                                                    <div>
                                                                        <strong>${entry.studentName}</strong>
                                                                        <span class="text-muted ms-1">(${entry.formattedStudentIdentifier})</span>
                                                                    </div>
                                                                    <div>
                                                                        <c:choose>
                                                                            <c:when test="${entry.status == 'PRESENT'}"><span class="badge bg-success">Present</span></c:when>
                                                                            <c:when test="${entry.status == 'ABSENT'}"><span class="badge bg-danger">Absent</span></c:when>
                                                                            <c:when test="${entry.status == 'LATE'}"><span class="badge bg-warning text-dark">Late</span></c:when>
                                                                            <c:when test="${entry.status == 'EXCUSED'}"><span class="badge bg-info text-dark">Excused</span></c:when>
                                                                            <c:otherwise><span class="badge bg-secondary">${entry.status}</span></c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                    <div class="modal-footer border-0 bg-light py-3 rounded-bottom-4">
                        <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Manage Grades Modal -->
        <div class="modal fade" id="gradesModal${section.id}" tabindex="-1" aria-labelledby="gradesModalLabel${section.id}" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content rounded-4 border-0 shadow-lg">
                    <form action="${pageContext.request.contextPath}/professor/grades/save" method="post">
                        <input type="hidden" name="classSectionId" value="${section.id}">
                        <input type="hidden" name="tab" value="classes">
                        <div class="modal-header bg-success text-white border-0 py-3">
                            <h5 class="modal-title h6 fw-bold mb-0" id="gradesModalLabel${section.id}">
                                <i class="bi bi-journal-text me-2" aria-hidden="true"></i>Manage Grades - ${section.courseCode}
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-0">
                            <c:set var="grades" value="${sectionGradesMap[section.id]}" />
                            <c:if test="${empty grades}">
                                <div class="p-5 text-center text-muted">
                                    <i class="bi bi-people fs-2 d-block mb-2 text-muted" aria-hidden="true"></i>
                                    No enrolled students to grade yet.
                                </div>
                            </c:if>
                            <c:if test="${not empty grades}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0 align-middle" aria-label="Student grades for ${section.courseCode}">
                                        <thead class="table-light">
                                            <tr>
                                                <th scope="col" class="ps-4">Student Name</th>
                                                <th scope="col" style="width: 120px;">Attendance (15)</th>
                                                <th scope="col" style="width: 120px;">Assignment (25)</th>
                                                <th scope="col" style="width: 120px;">Midterm (30)</th>
                                                <th scope="col" style="width: 120px;">Final (30)</th>
                                                <th scope="col" style="width: 100px;">Total</th>
                                                <th scope="col" style="width: 80px;">Grade</th>
                                                <th scope="col" class="pe-4" style="width: 80px;">GPA</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="grade" items="${grades}">
                                                <tr>
                                                    <td class="ps-4">
                                                        <strong class="text-dark">${grade.studentName}</strong>
                                                        <div class="text-muted small">${grade.formattedStudentIdentifier}</div>
                                                    </td>
                                                    <td>
                                                        <input type="number" class="form-control form-control-sm text-center rounded-3" 
                                                               name="attendance_${grade.enrollmentId}" value="${grade.attendanceScore}" 
                                                               min="0" max="15" step="0.01" required
                                                               aria-label="Attendance score for ${grade.studentName} (max 15)">
                                                    </td>
                                                    <td>
                                                        <input type="number" class="form-control form-control-sm text-center rounded-3" 
                                                               name="assignment_${grade.enrollmentId}" value="${grade.assignmentScore}" 
                                                               min="0" max="25" step="0.01" required
                                                               aria-label="Assignment score for ${grade.studentName} (max 25)">
                                                    </td>
                                                    <td>
                                                        <input type="number" class="form-control form-control-sm text-center rounded-3" 
                                                               name="midterm_${grade.enrollmentId}" value="${grade.midtermScore}" 
                                                               min="0" max="30" step="0.01" required
                                                               aria-label="Midterm score for ${grade.studentName} (max 30)">
                                                    </td>
                                                    <td>
                                                        <input type="number" class="form-control form-control-sm text-center rounded-3" 
                                                               name="final_${grade.enrollmentId}" value="${grade.finalScore}" 
                                                               min="0" max="30" step="0.01" required
                                                               aria-label="Final score for ${grade.studentName} (max 30)">
                                                    </td>
                                                    <td class="text-center fw-bold bg-light">${grade.totalScore}</td>
                                                    <td class="text-center fw-bold bg-light text-primary">${grade.letterGrade}</td>
                                                    <td class="pe-4 text-center text-muted bg-light">${grade.gpaPoint}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                        <div class="modal-footer border-0 bg-light py-3 rounded-bottom-4">
                            <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                            <c:if test="${not empty grades}">
                                <button type="submit" class="btn btn-success rounded-pill px-4 fw-bold">Save Grades</button>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>

    <%-- DESKTOP SCRIPT --%>
    <script>
        function switchDesktopTab(tabId, btnElement) {
            // Update active nav button
            const buttons = document.querySelectorAll('.sidebar-nav button');
            buttons.forEach(btn => {
                btn.classList.remove('active');
                btn.setAttribute('aria-selected', 'false');
                btn.setAttribute('tabindex', '-1');
            });

            if (btnElement) {
                btnElement.classList.add('active');
                btnElement.setAttribute('aria-selected', 'true');
                btnElement.setAttribute('tabindex', '0');
            }

            // Show target panel
            const panels = document.querySelectorAll('.desktop-app-container .tab-panel');
            panels.forEach(panel => panel.classList.remove('active'));

            const targetPanel = document.getElementById('dt-' + tabId);
            if (targetPanel) {
                targetPanel.classList.add('active');
            }

            // Announce to screen reader
            const announcer = document.getElementById('sr-announcer');
            if (announcer) {
                announcer.textContent = tabId.charAt(0).toUpperCase() + tabId.slice(1) + ' tab loaded';
            }

            try {
                const url = new URL(window.location);
                url.searchParams.set('tab', tabId);
                window.history.replaceState({}, '', url);
            } catch (e) {}
        }

        // Live Class Search Filtering
        function filterDesktopClasses(query) {
            const q = query.toLowerCase().trim();
            const cards = document.querySelectorAll('.desktop-class-card');
            let matchCount = 0;

            cards.forEach(card => {
                const code = card.getAttribute('data-course-code') || '';
                const title = card.getAttribute('data-course-title') || '';
                const text = card.textContent.toLowerCase();

                if (!q || code.includes(q) || title.includes(q) || text.includes(q)) {
                    card.style.display = '';
                    matchCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            const announcer = document.getElementById('sr-announcer');
            if (announcer && q) {
                announcer.textContent = matchCount + ' classes match search';
            }
        }

        // Setup Arrow Key Navigation for Tablist
        document.addEventListener('DOMContentLoaded', function() {
            const tabButtons = Array.from(document.querySelectorAll('.sidebar-nav button[role="tab"]'));
            tabButtons.forEach((btn, index) => {
                btn.addEventListener('keydown', function(e) {
                    let newIndex = index;
                    if (e.key === 'ArrowDown' || e.key === 'ArrowRight') {
                        newIndex = (index + 1) % tabButtons.length;
                        e.preventDefault();
                    } else if (e.key === 'ArrowUp' || e.key === 'ArrowLeft') {
                        newIndex = (index - 1 + tabButtons.length) % tabButtons.length;
                        e.preventDefault();
                    } else if (e.key === 'Home') {
                        newIndex = 0;
                        e.preventDefault();
                    } else if (e.key === 'End') {
                        newIndex = tabButtons.length - 1;
                        e.preventDefault();
                    }
                    if (newIndex !== index) {
                        tabButtons[newIndex].focus();
                        tabButtons[newIndex].click();
                    }
                });
            });

            // Set today's date for attendance inputs by default if empty
            document.querySelectorAll('.modal input[type="date"][name="sessionDate"]').forEach(input => {
                if (!input.value) {
                    input.valueAsDate = new Date();
                }
            });
        });
    </script>
</div><!-- End Desktop App Container -->

<div class="d-block d-md-none mobile-app-container">

    <c:if test="${param.twoFactorUpdated == 'true'}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small">
            <i class="bi bi-shield-check me-1"></i>2FA <strong>enabled</strong>.<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.twoFactorUpdated == 'false'}">
        <div class="alert alert-info alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small">
            <i class="bi bi-shield-slash me-1"></i>2FA <strong>disabled</strong>.<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small">
            <i class="bi bi-check-circle-fill me-1"></i>${successMessage}<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small">
            <i class="bi bi-exclamation-triangle-fill me-1"></i>${errorMessage}<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <!-- Top Bar -->
    <div class="mobile-top-bar">
        <div class="mobile-user-info">
            <div class="mobile-avatar-frame">
                <c:choose>
                    <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                        <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <div class="mobile-user-greeting">Hello, ${sessionScope.user.fullName}</div>
                <span class="mobile-badge-pill">Faculty Member</span>
            </div>
        </div>
        <button class="mobile-top-action-btn" type="button" data-bs-toggle="modal" data-bs-target="#mobileSecurityModal">
            <i class="bi bi-bell"></i>
        </button>
    </div>

    <!-- Home View -->
    <div id="mobile-view-home" class="mobile-sub-view active">
        <div class="mobile-date-strip" id="mobileDateStrip"></div>

        <%-- Hero Banner --%>
        <div class="mobile-hero-banner">
            <div class="hero-avatar-box">
                <c:choose>
                    <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                        <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Faculty">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Faculty">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="hero-content">
                <div class="hero-label">FACULTY STATUS</div>
                <div class="hero-title">${sessionScope.user.fullName}</div>
                <div class="hero-meta-row">
                    <i class="bi bi-journal-bookmark-fill"></i> ${sectionStudentsMap.size()} Classes Assigned
                </div>
                <div class="hero-meta-row">
                    <i class="bi bi-building"></i> ${not empty sessionScope.user.major ? sessionScope.user.major : 'Faculty of Science & Technology'}
                </div>
                <div class="mt-2">
                    <span class="hero-status-tag"><span style="width:6px;height:6px;background:#22c55e;border-radius:50%;display:inline-block;animation:pulse 1.8s infinite;"></span> Active Faculty</span>
                </div>
            </div>
        </div>
        
        <div class="section-header mt-2">
            <div class="section-title">Today's Schedule</div>
        </div>
        
        <c:if test="${empty sectionStudentsMap}">
            <div class="text-center p-4 bg-white rounded-4 border" style="border-color:#e2e8f0;">
                <i class="bi bi-cup-hot text-muted" style="font-size:2rem;"></i>
                <div class="fw-bold mt-2 text-dark">No Classes Today</div>
                <div class="small text-muted">Enjoy your free time!</div>
            </div>
        </c:if>
        
        <c:forEach var="entry" items="${sectionStudentsMap}">
            <c:set var="section" value="${entry.key}" />
            <c:set var="students" value="${entry.value}" />
            <div class="mobile-course-card mobile-class-card" onclick="openCourseSheet('${section.id}')">
                <div class="mc-header">
                    <div class="mc-code">${section.courseCode}</div>
                    <div class="mc-badge">${section.termName}</div>
                </div>
                <div class="mc-title">${section.courseTitle}</div>
                <div class="mc-meta">
                    <div class="mc-meta-item"><i class="bi bi-clock"></i>${section.sessionShift}</div>
                    <div class="mc-meta-item"><i class="bi bi-door-open"></i>Room ${section.roomName}</div>
                    <div class="mc-meta-item"><i class="bi bi-people"></i>${students.size()} Students</div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Classes View -->
    <div id="mobile-view-classes" class="mobile-sub-view">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h5 class="fw-bold mb-0">Assigned Classes</h5>
                <span class="text-muted" style="font-size:0.75rem;">Teaching schedule & enrolled students</span>
            </div>
            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 rounded-pill px-3 py-2 fw-bold">${sectionStudentsMap.size()} Classes</span>
        </div>

        <div class="input-group mb-3 shadow-sm rounded-4 overflow-hidden border">
            <span class="input-group-text bg-white border-0 text-muted ps-3"><i class="bi bi-search"></i></span>
            <input type="text" class="form-control border-0 py-2" placeholder="Search class code or course title..." oninput="filterMobileClasses(this.value)">
        </div>
        
        <c:if test="${empty sectionStudentsMap}">
            <div class="text-center p-4 bg-white rounded-4 border" style="border-color:#e2e8f0;">
                <i class="bi bi-journal-x text-muted" style="font-size:2rem;"></i>
                <div class="fw-bold mt-2 text-dark">No classes assigned</div>
                <div class="small text-muted">Contact the academic registrar or dean.</div>
            </div>
        </c:if>
        
        <div id="mobileClassList">
            <c:forEach var="entry" items="${sectionStudentsMap}">
                <c:set var="section" value="${entry.key}" />
                <c:set var="students" value="${entry.value}" />
                <div class="mobile-course-card mobile-class-card mobile-class-item" onclick="openCourseSheet('${section.id}')">
                    <div class="mc-header">
                        <div class="mc-code">${section.courseCode}</div>
                        <div class="mc-badge">${section.termName}</div>
                    </div>
                    <div class="mc-title">${section.courseTitle}</div>
                    <div class="mc-meta">
                        <div class="mc-meta-item"><i class="bi bi-calendar-event"></i>${section.daysOfWeek}</div>
                        <div class="mc-meta-item"><i class="bi bi-clock"></i>${section.sessionShift}</div>
                        <div class="mc-meta-item"><i class="bi bi-door-open"></i>Room ${section.roomName}</div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center pt-2 border-top mt-3">
                        <span class="mc-students m-0"><i class="bi bi-people-fill"></i> ${students.size()} Students Enrolled</span>
                        <span class="small text-primary fw-semibold" style="font-size:0.75rem;">Manage <i class="bi bi-chevron-right ms-1"></i></span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Profile View -->
    <div id="mobile-view-profile" class="mobile-sub-view">
        <h5 class="fw-bold mb-3">Professor Profile</h5>
        
        <div class="mobile-course-card text-center p-4 mb-3" style="cursor:default;">
            <div class="mobile-avatar-frame mx-auto mb-3" style="width:72px;height:72px;border-radius:20px;">
                <c:choose>
                    <c:when test="${sessionScope.user.gender == 'FEMALE'}">
                        <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                    </c:otherwise>
                </c:choose>
            </div>
            <h5 class="fw-bold text-dark mb-1">${sessionScope.user.fullName}</h5>
            <div class="badge bg-light border text-dark mb-2 px-3 py-1">ID: ${sessionScope.user.formattedIdentifier}</div>
            <div class="text-muted small">${sessionScope.user.email}</div>
        </div>

        <div class="mobile-course-card mb-3 p-3" style="cursor:default;">
            <div class="fw-bold small text-dark mb-3"><i class="bi bi-mortarboard me-2 text-primary"></i>Faculty Details</div>
            <div class="d-flex justify-content-between py-2 border-bottom small">
                <span class="text-muted">Role:</span>
                <span class="fw-semibold text-dark">Professor / Faculty</span>
            </div>
            <div class="d-flex justify-content-between py-2 border-bottom small">
                <span class="text-muted">Department:</span>
                <span class="fw-semibold text-dark">${not empty sessionScope.user.major ? sessionScope.user.major : 'Faculty of Science & Technology'}</span>
            </div>
            <div class="d-flex justify-content-between py-2 border-bottom small">
                <span class="text-muted">Classes Assigned:</span>
                <span class="fw-bold text-primary">${sectionStudentsMap.size()} Classes</span>
            </div>
            <div class="d-flex justify-content-between py-2 small">
                <span class="text-muted">Account Status:</span>
                <span class="badge bg-success bg-opacity-10 text-success fw-bold">Active Faculty</span>
            </div>
        </div>

        <div class="mobile-course-card mb-3 p-3" style="cursor:default;">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <div>
                    <div class="fw-bold small text-dark"><i class="bi bi-shield-lock me-2 text-primary"></i>Two-Factor Authentication</div>
                    <div class="text-muted" style="font-size:0.72rem;">Email OTP on login</div>
                </div>
                <span class="badge ${sessionScope.user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">${sessionScope.user.twoFactorEnabled ? 'Enabled' : 'Disabled'}</span>
            </div>
            <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="mt-3">
                <input type="hidden" name="redirect" value="/professor/dashboard?tab=profile">
                <div class="input-group">
                    <label class="input-group-text small bg-light" for="mobileTwoFactorSelectProf">Status</label>
                    <select id="mobileTwoFactorSelectProf" name="twoFactorEnabled" class="form-select form-select-sm" onchange="this.form.submit()">
                        <option value="false" ${!sessionScope.user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                        <option value="true" ${sessionScope.user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                    </select>
                    <button type="submit" class="btn btn-sm btn-outline-primary">Save</button>
                </div>
            </form>
        </div>

        <c:if test="${sessionScope.user.deanSchoolId != null}">
            <a href="${pageContext.request.contextPath}/dean/dashboard" class="btn btn-outline-info w-100 rounded-3 py-2 fw-semibold mb-3">
                <i class="bi bi-mortarboard me-2"></i>Switch to Dean Dashboard
            </a>
        </c:if>

        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger w-100 rounded-3 py-2 fw-semibold">
            <i class="bi bi-box-arrow-right me-2"></i>Sign Out
        </a>
    </div>

    <!-- Bottom Navigation Dock -->
    <nav class="mobile-bottom-dock">
        <button type="button" class="dock-tab-btn active" data-tab="home" onclick="switchMobileTab('home')"><i class="bi bi-house-door-fill"></i><span>Home</span></button>
        <button type="button" class="dock-tab-btn" data-tab="classes" onclick="switchMobileTab('classes')"><i class="bi bi-journal-bookmark"></i><span>Classes</span></button>
        <button type="button" class="dock-tab-btn" data-tab="profile" onclick="switchMobileTab('profile')"><i class="bi bi-person"></i><span>Profile</span></button>
    </nav>
</div>

<!-- Mobile Security / Notifications Modal -->
<div class="modal fade" id="mobileSecurityModal" tabindex="-1" aria-labelledby="securityModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 pb-0">
                <h6 class="modal-title fw-bold" id="securityModalLabel"><i class="bi bi-bell me-2 text-primary"></i>Notifications</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="p-3 bg-light rounded-3 mb-3">
                    <div class="d-flex align-items-center justify-content-between mb-1">
                        <span class="small fw-bold">2FA Status</span>
                        <span class="badge ${sessionScope.user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">${sessionScope.user.twoFactorEnabled ? 'Enabled' : 'Disabled'}</span>
                    </div>
                    <p class="small text-muted mb-0" style="font-size:0.72rem;">
                        ${sessionScope.user.twoFactorEnabled ? 'Account secured with email OTP.' : '2FA is currently off.'}
                    </p>
                </div>
                <button type="button" class="btn btn-sm btn-primary w-100 rounded-3 py-2 fw-semibold" data-bs-dismiss="modal" onclick="switchMobileTab('profile')">Manage in Profile</button>
            </div>
        </div>
    </div>
</div>

<!-- ========================================== -->
<!-- ACTION SHEETS (MOBILE ONLY)                -->
<!-- ========================================== -->

<!-- Main Course Action Sheet -->
<div class="action-sheet-overlay d-md-none" id="courseActionSheet" onclick="closeSheetOnOverlay(event, 'courseActionSheet')">
    <div class="action-sheet">
        <div class="sheet-drag"></div>
        <div class="sheet-header">
            <div>
                <div class="sheet-title" id="casCode">COURSE</div>
                <div class="small text-muted fw-bold mt-1" id="casTitle">Title</div>
            </div>
            <button class="btn btn-light rounded-circle" onclick="closeSheet('courseActionSheet')"><i class="bi bi-x fs-5"></i></button>
        </div>
        <div class="sheet-body pb-4">
            <button class="action-btn action-btn-info" onclick="openSubSheet('rosterSheet')">
                <i class="bi bi-people-fill"></i>
                <div class="action-btn-text">
                    Student Roster
                    <span class="action-btn-desc">View enrolled students &amp; emails</span>
                </div>
            </button>
            <button class="action-btn action-btn-primary" onclick="openSubSheet('attendanceSheet')">
                <i class="bi bi-clipboard-check"></i>
                <div class="action-btn-text">
                    Take Attendance
                    <span class="action-btn-desc">Record today's session</span>
                </div>
            </button>
            <button class="action-btn action-btn-success" onclick="openSubSheet('gradesSheet')">
                <i class="bi bi-journal-check"></i>
                <div class="action-btn-text">
                    Manage Grades
                    <span class="action-btn-desc">Update student scores</span>
                </div>
            </button>
            <button class="action-btn action-btn-secondary" onclick="openSubSheet('historySheet')">
                <i class="bi bi-clock-history"></i>
                <div class="action-btn-text">
                    Attendance History
                    <span class="action-btn-desc">View past records</span>
                </div>
            </button>
        </div>
    </div>
</div>

<!-- Dynamic content forms (JSP rendering per section to ensure inputs work easily without huge JS state parsing) -->
<c:forEach var="entry" items="${sectionStudentsMap}">
    <c:set var="section" value="${entry.key}" />
    <c:set var="students" value="${entry.value}" />
    <c:set var="grades" value="${sectionGradesMap[section.id]}" />
    <c:set var="records" value="${sectionAttendanceMap[section.id]}" />
    <!-- Student Roster Sheet -->
    <div class="action-sheet-overlay d-md-none" id="rosterSheet_${section.id}" onclick="closeSheetOnOverlay(event, 'rosterSheet_${section.id}')">
        <div class="action-sheet">
            <div class="sheet-drag"></div>
            <div class="sheet-header">
                <div>
                    <h5 class="sheet-title m-0">Student Roster</h5>
                    <div class="small text-muted fw-semibold mt-1">${section.courseCode} &bull; ${students.size()} Enrolled</div>
                </div>
                <button class="btn btn-sm btn-light rounded-pill px-3" onclick="closeSubSheet('rosterSheet_${section.id}')">Back</button>
            </div>
            <div class="sheet-body">
                <c:if test="${empty students}">
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-people fs-1 d-block mb-2 text-secondary"></i>
                        <div class="fw-bold">No Students Enrolled</div>
                        <p class="small">Students enrolled in this section will appear here.</p>
                    </div>
                </c:if>
                <c:if test="${not empty students}">
                    <div class="d-flex flex-column gap-2 py-2">
                        <c:forEach var="student" items="${students}">
                            <div class="d-flex align-items-center justify-content-between p-3 bg-white rounded-4 border shadow-sm">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="mobile-avatar-frame" style="width:44px;height:44px;border-radius:14px;background:#f1f5f9;display:flex;align-items:center;justify-content:center;overflow:hidden;flex-shrink:0;">
                                        <img src="https://ui-avatars.com/api/?name=${student.fullName}&background=0284c7&color=fff&bold=true" alt="${student.fullName}" style="width:100%;height:100%;object-fit:cover;">
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark text-truncate" style="max-width: 170px;">${student.fullName}</div>
                                        <div class="text-muted small" style="font-size:0.75rem;">
                                            <span class="badge bg-light border text-secondary me-1">ID: ${student.formattedIdentifier}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <c:if test="${not empty student.email}">
                                        <a href="mailto:${student.email}" class="btn btn-sm btn-light border rounded-pill px-3 py-1 text-primary small fw-semibold" title="${student.email}">
                                            <i class="bi bi-envelope-fill me-1"></i>Email
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Attendance Form Sheet -->
    <div class="action-sheet-overlay d-md-none" id="attendanceSheet_${section.id}" onclick="closeSheetOnOverlay(event, 'attendanceSheet_${section.id}')">
        <div class="action-sheet">
            <div class="sheet-drag"></div>
            <div class="sheet-header">
                <h5 class="sheet-title m-0">Take Attendance</h5>
                <button class="btn btn-sm btn-light" onclick="closeSubSheet('attendanceSheet_${section.id}')">Back</button>
            </div>
            <form action="${pageContext.request.contextPath}/professor/attendance/save" method="post" class="d-flex flex-column" style="flex:1; overflow:hidden;">
                <input type="hidden" name="classSectionId" value="${section.id}">
                <input type="hidden" name="tab" value="classes">
                <div class="sheet-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted text-uppercase">Session Date</label>
                        <input type="date" class="form-control rounded-3 att-date-input" name="sessionDate" required>
                    </div>
                    <div class="form-section-title">Student Roster</div>
                    <c:if test="${empty students}"><div class="text-center text-muted p-3 border rounded-3 bg-light">No students enrolled</div></c:if>
                    <c:forEach var="student" items="${students}">
                        <div class="student-row">
                            <div class="student-info">
                                <div class="student-name">${student.fullName}</div>
                                <div class="student-id">${student.formattedIdentifier}</div>
                            </div>
                            <div class="radio-group">
                                <div class="radio-chip"><input type="radio" name="status_${student.id}" id="mob_p_${section.id}_${student.id}" value="PRESENT" checked><label for="mob_p_${section.id}_${student.id}">Present</label></div>
                                <div class="radio-chip"><input type="radio" name="status_${student.id}" id="mob_a_${section.id}_${student.id}" value="ABSENT"><label for="mob_a_${section.id}_${student.id}">Absent</label></div>
                                <div class="radio-chip"><input type="radio" name="status_${student.id}" id="mob_l_${section.id}_${student.id}" value="LATE"><label for="mob_l_${section.id}_${student.id}">Late</label></div>
                                <div class="radio-chip"><input type="radio" name="status_${student.id}" id="mob_e_${section.id}_${student.id}" value="EXCUSED"><label for="mob_e_${section.id}_${student.id}">Excused</label></div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="sheet-footer">
                    <button type="submit" class="btn btn-primary w-100 rounded-3 py-3 fw-bold fs-6">Save Attendance</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Grades Form Sheet -->
    <div class="action-sheet-overlay d-md-none" id="gradesSheet_${section.id}" onclick="closeSheetOnOverlay(event, 'gradesSheet_${section.id}')">
        <div class="action-sheet">
            <div class="sheet-drag"></div>
            <div class="sheet-header">
                <h5 class="sheet-title m-0">Manage Grades</h5>
                <button class="btn btn-sm btn-light" onclick="closeSubSheet('gradesSheet_${section.id}')">Back</button>
            </div>
            <form action="${pageContext.request.contextPath}/professor/grades/save" method="post" class="d-flex flex-column" style="flex:1; overflow:hidden;">
                <input type="hidden" name="classSectionId" value="${section.id}">
                <input type="hidden" name="tab" value="classes">
                <div class="sheet-body">
                    <c:if test="${empty grades}"><div class="text-center text-muted p-3 border rounded-3 bg-light">No students to grade</div></c:if>
                    <c:forEach var="grade" items="${grades}">
                        <div class="student-row">
                            <div class="student-info">
                                <div class="student-name">${grade.studentName}</div>
                                <div class="student-id">${grade.formattedStudentIdentifier}</div>
                            </div>
                            <div class="grade-input-grid">
                                <div class="grade-input-box">
                                    <span class="grade-input-label">Attendance (15)</span>
                                    <input type="number" name="attendance_${grade.enrollmentId}" value="${grade.attendanceScore}" min="0" max="15" step="0.01" required>
                                </div>
                                <div class="grade-input-box">
                                    <span class="grade-input-label">Assignment (25)</span>
                                    <input type="number" name="assignment_${grade.enrollmentId}" value="${grade.assignmentScore}" min="0" max="25" step="0.01" required>
                                </div>
                                <div class="grade-input-box">
                                    <span class="grade-input-label">Midterm (30)</span>
                                    <input type="number" name="midterm_${grade.enrollmentId}" value="${grade.midtermScore}" min="0" max="30" step="0.01" required>
                                </div>
                                <div class="grade-input-box">
                                    <span class="grade-input-label">Final (30)</span>
                                    <input type="number" name="final_${grade.enrollmentId}" value="${grade.finalScore}" min="0" max="30" step="0.01" required>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="sheet-footer">
                    <button type="submit" class="btn btn-success w-100 rounded-3 py-3 fw-bold fs-6">Save Grades</button>
                </div>
            </form>
        </div>
    </div>

    <!-- History Sheet -->
    <div class="action-sheet-overlay d-md-none" id="historySheet_${section.id}" onclick="closeSheetOnOverlay(event, 'historySheet_${section.id}')">
        <div class="action-sheet">
            <div class="sheet-drag"></div>
            <div class="sheet-header">
                <h5 class="sheet-title m-0">History</h5>
                <button class="btn btn-sm btn-light" onclick="closeSubSheet('historySheet_${section.id}')">Back</button>
            </div>
            <div class="sheet-body">
                <c:if test="${empty records}"><div class="text-center text-muted p-3 border rounded-3 bg-light">No records found</div></c:if>
                <c:forEach var="record" items="${records}">
                    <div class="student-row p-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="fw-bold text-dark"><i class="bi bi-calendar3 me-2"></i>${record.sessionDate}</div>
                        </div>
                        <div class="d-flex gap-2">
                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1"><i class="bi bi-check-circle-fill me-1"></i>${record.presentCount} Present</span>
                            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1"><i class="bi bi-x-circle-fill me-1"></i>${record.absentCount} Absent</span>
                        </div>
                        <div class="mt-2 pt-2 border-top">
                            <a class="text-decoration-none small fw-bold text-primary" data-bs-toggle="collapse" href="#mobRecordDetails_${section.id}_${record.id}">View Student Breakdown <i class="bi bi-chevron-down"></i></a>
                            <div class="collapse mt-2" id="mobRecordDetails_${section.id}_${record.id}">
                                <c:forEach var="entry" items="${record.entries}">
                                    <div class="d-flex justify-content-between border-bottom py-1 small">
                                        <span>${entry.studentName}</span>
                                        <c:choose>
                                            <c:when test="${entry.status == 'PRESENT'}"><span class="text-success fw-bold">P</span></c:when>
                                            <c:when test="${entry.status == 'ABSENT'}"><span class="text-danger fw-bold">A</span></c:when>
                                            <c:when test="${entry.status == 'LATE'}"><span class="text-warning fw-bold">L</span></c:when>
                                            <c:when test="${entry.status == 'EXCUSED'}"><span class="text-info fw-bold">E</span></c:when>
                                            <c:otherwise><span class="text-secondary">${entry.status}</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</c:forEach>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var classData = {
        <c:forEach var="entry" items="${sectionStudentsMap}">
        <c:set var="section" value="${entry.key}" />
        '${section.id}': { code: '${section.courseCode}', title: '${section.courseTitle.replace("'", "\'")}' },
        </c:forEach>
    };

    var currentActiveSectionId = null;

    function switchMobileTab(tabName) {
        var views = document.querySelectorAll('.mobile-sub-view');
        for (var i = 0; i < views.length; i++) views[i].classList.remove('active');
        var target = document.getElementById('mobile-view-' + tabName);
        if (target) target.classList.add('active');

        var btns = document.querySelectorAll('.dock-tab-btn');
        var iconMap = {
            home: ['bi-house-door-fill', 'bi-house-door'],
            classes: ['bi-journal-bookmark-fill', 'bi-journal-bookmark'],
            profile: ['bi-person-fill', 'bi-person']
        };
        for (var j = 0; j < btns.length; j++) {
            var b = btns[j], bTab = b.getAttribute('data-tab'), ic = b.querySelector('i');
            if (bTab === tabName) {
                b.classList.add('active');
                if (ic && iconMap[bTab]) ic.className = 'bi ' + iconMap[bTab][0];
            } else {
                b.classList.remove('active');
                if (ic && iconMap[bTab]) ic.className = 'bi ' + iconMap[bTab][1];
            }
        }
        try {
            var url = new URL(window.location);
            url.searchParams.set('tab', tabName);
            window.history.replaceState({}, '', url);
        } catch (e) {}
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function filterMobileClasses(q) {
        q = (q || '').toLowerCase().trim();
        var items = document.querySelectorAll('.mobile-class-item');
        for (var i = 0; i < items.length; i++) {
            items[i].style.display = (items[i].textContent || '').toLowerCase().indexOf(q) !== -1 ? '' : 'none';
        }
    }

    function openCourseSheet(id) {
        currentActiveSectionId = id;
        document.getElementById('casCode').textContent = classData[id].code;
        document.getElementById('casTitle').textContent = classData[id].title;
        document.getElementById('courseActionSheet').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function openSubSheet(prefix) {
        document.getElementById('courseActionSheet').classList.remove('open');
        var sheetId = prefix + '_' + currentActiveSectionId;
        
        // Auto-fill today's date for attendance
        if (prefix === 'attendanceSheet') {
            var dateInputs = document.querySelectorAll('#' + sheetId + ' .att-date-input');
            dateInputs.forEach(i => { if(!i.value) i.valueAsDate = new Date(); });
        }
        
        document.getElementById(sheetId).classList.add('open');
    }

    function closeSubSheet(sheetId) {
        document.getElementById(sheetId).classList.remove('open');
        document.getElementById('courseActionSheet').classList.add('open');
    }

    function closeSheet(sheetId) {
        document.getElementById(sheetId).classList.remove('open');
        document.body.style.overflow = '';
    }

    function closeSheetOnOverlay(e, sheetId) {
        if (e.target.id === sheetId) closeSheet(sheetId);
    }

    function initMobileDateStrip() {
        var strip = document.getElementById('mobileDateStrip');
        if (!strip) return;
        var today = new Date();
        var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        var dayOfWeek = today.getDay();
        var diffToMonday = today.getDate() - dayOfWeek + (dayOfWeek === 0 ? -6 : 1);
        var monday = new Date(today.setDate(diffToMonday));
        var html = '';
        for (var i = 0; i < 7; i++) {
            var d = new Date(monday);
            d.setDate(monday.getDate() + i);
            var isToday = (d.getDate() === new Date().getDate() && d.getMonth() === new Date().getMonth());
            html += '<div class="date-strip-item ' + (isToday ? 'active' : '') + '">' +
                    '<div class="ds-day">' + days[d.getDay()] + '</div>' +
                    '<div class="ds-date">' + d.getDate() + '</div></div>';
        }
        strip.innerHTML = html;

        setTimeout(function () {
            var active = strip.querySelector('.active');
            if (active) {
                strip.scrollLeft = active.offsetLeft - (strip.offsetWidth / 2) + (active.offsetWidth / 2);
            }
        }, 100);
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        initMobileDateStrip();
        try {
            var urlParams = new URLSearchParams(window.location.search);
            var tab = urlParams.get('tab');
            if (tab) {
                // Mobile tab restoration
                if (document.getElementById('mobile-view-' + tab)) {
                    switchMobileTab(tab);
                } else if (tab === 'settings') {
                    switchMobileTab('profile');
                } else if (tab === 'dashboard') {
                    switchMobileTab('home');
                }

                // Desktop tab restoration
                var dtBtn = document.getElementById('tab-' + tab);
                if (dtBtn) {
                    switchDesktopTab(tab, dtBtn);
                } else if (tab === 'profile') {
                    switchDesktopTab('settings', document.getElementById('tab-settings'));
                } else if (tab === 'home') {
                    switchDesktopTab('dashboard', document.getElementById('tab-dashboard'));
                }
            }
        } catch (e) {}
    });
</script>


</body>
</html>
