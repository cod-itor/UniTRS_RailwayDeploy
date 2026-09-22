<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Student Dashboard - UniTRS</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
                rel="stylesheet">
            <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
            <style>
                body {
                    font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                    color: #1e293b;
                    background-color: #f6f8fb;
                }

                .dashboard-header {
                    background-color: #198754;
                    color: white;
                    padding: 2rem 0;
                    margin-bottom: 2rem;
                }

                .nav-tabs .nav-link {
                    color: #495057;
                    font-weight: 500;
                }

                .nav-tabs .nav-link.active {
                    font-weight: 700;
                    color: #198754;
                }

                .card-custom {
                    border: none;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
                    border-radius: 14px;
                }

                .table th {
                    background-color: #f1f3f5;
                    font-weight: 600;
                }

                @media (max-width: 767.98px) {
                    body {
                        background: #f8fafc;
                        padding-bottom: calc(96px + env(safe-area-inset-bottom, 16px));
                        -webkit-tap-highlight-color: transparent;
                    }

                    .mobile-app-container {
                        padding: 16px 16px calc(24px + env(safe-area-inset-bottom, 16px));
                        max-width: 520px;
                        margin: 0 auto;
                    }

                    /* Accessible Focus Rings */
                    button:focus-visible, a:focus-visible, input:focus-visible, select:focus-visible {
                        outline: 2px solid #3b82f6 !important;
                        outline-offset: 2px !important;
                    }

                    /* Top Bar */
                    .mobile-top-bar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                        padding-top: 4px;
                    }

                    .mobile-user-info {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .mobile-avatar-frame {
                        width: 48px;
                        height: 48px;
                        border-radius: 16px;
                        overflow: hidden;
                        box-shadow: 0 4px 14px rgba(15, 23, 42, 0.08);
                        border: 2.5px solid #fff;
                        flex-shrink: 0;
                        background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
                        position: relative;
                    }

                    .mobile-avatar-frame img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    .mobile-user-greeting {
                        font-size: 1.1rem;
                        font-weight: 800;
                        color: #0f172a;
                        margin-bottom: 2px;
                        line-height: 1.25;
                        letter-spacing: -0.02em;
                    }

                    .mobile-badge-pill {
                        display: inline-flex;
                        align-items: center;
                        gap: 5px;
                        background: #f1f5f9;
                        color: #475569;
                        font-size: 0.72rem;
                        font-weight: 700;
                        padding: 3px 10px;
                        border-radius: 20px;
                        border: 1px solid #e2e8f0;
                    }

                    .mobile-top-action-btn {
                        width: 44px;
                        height: 44px;
                        background: #fff;
                        border-radius: 14px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border: 1px solid #e2e8f0;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                        color: #1e293b;
                        font-size: 1.2rem;
                        cursor: pointer;
                        position: relative;
                        transition: transform 0.15s ease, background 0.15s ease;
                    }

                    .mobile-top-action-btn:active {
                        transform: scale(0.92);
                        background: #f1f5f9;
                    }

                    .mobile-top-action-btn .btn-badge-dot {
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        width: 8px;
                        height: 8px;
                        background: #3b82f6;
                        border-radius: 50%;
                        border: 1.5px solid #fff;
                    }

                    /* 7-Day Interactive Date Strip */
                    .date-strip-section {
                        margin-bottom: 22px;
                    }

                    .mobile-date-strip {
                        display: flex;
                        gap: 8px;
                        overflow-x: auto;
                        padding: 4px 2px 8px;
                        scroll-snap-type: x proximity;
                        -webkit-overflow-scrolling: touch;
                        scrollbar-width: none;
                    }

                    .mobile-date-strip::-webkit-scrollbar {
                        display: none;
                    }

                    .date-strip-item {
                        flex: 0 0 58px;
                        min-height: 68px;
                        background: #ffffff;
                        border: 1px solid #e2e8f0;
                        border-radius: 18px;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        padding: 8px 4px;
                        color: #64748b;
                        transition: all 0.22s cubic-bezier(0.4, 0, 0.2, 1);
                        cursor: pointer;
                        user-select: none;
                        scroll-snap-align: start;
                        box-shadow: 0 2px 6px rgba(15, 23, 42, 0.03);
                    }

                    .date-strip-item:active {
                        transform: scale(0.93);
                    }

                    .date-strip-item.is-today:not(.active) {
                        border-color: #93c5fd;
                        color: #1d4ed8;
                        background: #eff6ff;
                    }

                    .date-strip-item.active {
                        background: #0f172a;
                        border-color: #0f172a;
                        color: #ffffff;
                        box-shadow: 0 8px 20px -4px rgba(15, 23, 42, 0.35);
                        transform: translateY(-2px);
                    }

                    .ds-day {
                        font-size: 0.68rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.4px;
                        margin-bottom: 4px;
                    }

                    .ds-date {
                        font-size: 1.25rem;
                        font-weight: 800;
                        line-height: 1;
                    }

                    .date-strip-item.active .ds-day {
                        color: rgba(255, 255, 255, 0.75);
                    }

                    .date-strip-item.active .ds-date {
                        color: #ffffff;
                    }

                    .date-strip-item.active::after {
                        content: '';
                        display: block;
                        width: 5px;
                        height: 5px;
                        background: #22c55e;
                        border-radius: 50%;
                        margin-top: 5px;
                        animation: pulseDot 1.8s infinite ease-in-out;
                    }

                    @keyframes pulseDot {
                        0%, 100% { transform: scale(0.9); opacity: 0.8; }
                        50% { transform: scale(1.4); opacity: 1; }
                    }

                    /* Next Class Hero Card */
                    .mobile-hero-banner {
                        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
                        border-radius: 24px;
                        padding: 18px 20px;
                        color: #fff;
                        box-shadow: 0 12px 30px -6px rgba(15, 23, 42, 0.25);
                        display: flex;
                        align-items: center;
                        gap: 16px;
                        margin-bottom: 22px;
                        position: relative;
                        overflow: hidden;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .mobile-hero-banner::before {
                        content: '';
                        position: absolute;
                        top: -50%;
                        right: -20%;
                        width: 220px;
                        height: 220px;
                        background: radial-gradient(circle, rgba(59, 130, 246, 0.25) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .hero-avatar-box {
                        width: 68px;
                        height: 68px;
                        border-radius: 18px;
                        overflow: hidden;
                        flex-shrink: 0;
                        background: rgba(255, 255, 255, 0.1);
                        border: 2px solid rgba(255, 255, 255, 0.2);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
                    }

                    .hero-avatar-box img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    .hero-content {
                        flex: 1;
                        min-width: 0;
                        z-index: 1;
                    }

                    .hero-label {
                        font-size: 0.65rem;
                        font-weight: 800;
                        letter-spacing: 0.8px;
                        color: #94a3b8;
                        text-transform: uppercase;
                        margin-bottom: 4px;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .hero-label .pulse-indicator {
                        width: 6px;
                        height: 6px;
                        background: #22c55e;
                        border-radius: 50%;
                        box-shadow: 0 0 8px #22c55e;
                        animation: pulseDot 1.8s infinite;
                    }

                    .hero-title {
                        font-size: 1.02rem;
                        font-weight: 800;
                        color: #ffffff;
                        margin-bottom: 5px;
                        line-height: 1.25;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }

                    .hero-meta-row {
                        font-size: 0.76rem;
                        color: #cbd5e1;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        margin-bottom: 3px;
                    }

                    .hero-pills {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 6px;
                        margin-top: 8px;
                    }

                    .hero-pill-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 4px;
                        background: rgba(255, 255, 255, 0.12);
                        color: #f1f5f9;
                        font-size: 0.68rem;
                        font-weight: 700;
                        padding: 3px 9px;
                        border-radius: 12px;
                        backdrop-filter: blur(6px);
                    }

                    /* Academic Progress Swipeable Cards */
                    .section-header-wrap {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 12px;
                    }

                    .mobile-section-heading {
                        font-size: 1.05rem;
                        font-weight: 800;
                        color: #0f172a;
                        letter-spacing: -0.01em;
                        margin-bottom: 0;
                    }

                    .mobile-section-badge {
                        font-size: 0.72rem;
                        font-weight: 700;
                        padding: 3px 10px;
                        border-radius: 20px;
                        background: #eff6ff;
                        color: #2563eb;
                        border: 1px solid #dbeafe;
                    }

                    .progress-swiper-wrap {
                        position: relative;
                        margin-bottom: 22px;
                    }

                    .progress-swiper {
                        display: flex;
                        gap: 14px;
                        overflow-x: auto;
                        scroll-snap-type: x mandatory;
                        padding: 4px 2px 10px;
                        scrollbar-width: none;
                        -webkit-overflow-scrolling: touch;
                    }

                    .progress-swiper::-webkit-scrollbar {
                        display: none;
                    }

                    .progress-card-item {
                        flex: 0 0 calc(86vw - 32px);
                        max-width: 340px;
                        min-width: 270px;
                        scroll-snap-align: start;
                        background: #ffffff;
                        border-radius: 24px;
                        padding: 18px;
                        box-shadow: 0 6px 20px rgba(15, 23, 42, 0.05);
                        border: 1px solid #e2e8f0;
                        position: relative;
                    }

                    .pc-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        margin-bottom: 12px;
                    }

                    .pc-course-code {
                        font-size: 0.8rem;
                        font-weight: 800;
                        color: #4f46e5;
                        background: #eef2ff;
                        padding: 4px 10px;
                        border-radius: 12px;
                        letter-spacing: 0.3px;
                    }

                    .pc-gpa-badge {
                        font-size: 1.15rem;
                        font-weight: 800;
                        color: #0f172a;
                    }

                    .pc-gpa-label {
                        font-size: 0.65rem;
                        font-weight: 700;
                        color: #64748b;
                        text-transform: uppercase;
                    }

                    .pc-title {
                        font-size: 0.88rem;
                        font-weight: 700;
                        color: #0f172a;
                        margin-bottom: 12px;
                        line-height: 1.3;
                        display: -webkit-box;
                        -webkit-line-clamp: 2;
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                    }

                    .pc-score-row {
                        display: flex;
                        flex-direction: column;
                        gap: 7px;
                        margin-bottom: 12px;
                    }

                    .pc-score-item {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .pc-score-label {
                        font-size: 0.7rem;
                        font-weight: 700;
                        color: #64748b;
                        width: 88px;
                        flex-shrink: 0;
                    }

                    .pc-score-bar-wrap {
                        flex: 1;
                        background: #f1f5f9;
                        border-radius: 99px;
                        height: 7px;
                        overflow: hidden;
                    }

                    .pc-score-bar {
                        height: 7px;
                        border-radius: 99px;
                        transition: width 0.7s cubic-bezier(0.4, 0, 0.2, 1);
                    }

                    .pc-score-val {
                        font-size: 0.72rem;
                        font-weight: 800;
                        color: #0f172a;
                        min-width: 28px;
                        text-align: right;
                    }

                    .pc-footer {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding-top: 12px;
                        border-top: 1px solid #f1f5f9;
                    }

                    .pc-letter {
                        font-size: 1.55rem;
                        font-weight: 900;
                        line-height: 1;
                    }

                    .grade-A { color: #16a34a; }
                    .grade-B { color: #2563eb; }
                    .grade-C { color: #d97706; }
                    .grade-F { color: #dc2626; }
                    .grade-na { color: #94a3b8; }

                    .pc-credits {
                        font-size: 0.72rem;
                        color: #64748b;
                        text-align: right;
                    }

                    .pc-credits strong {
                        color: #0f172a;
                        display: block;
                        font-size: 0.9rem;
                    }

                    /* Swipe Dots */
                    .swipe-dots {
                        display: flex;
                        justify-content: center;
                        gap: 6px;
                        margin-top: 4px;
                        margin-bottom: 20px;
                    }

                    .swipe-dot {
                        width: 6px;
                        height: 6px;
                        background: #cbd5e1;
                        border-radius: 50%;
                        transition: all 0.25s ease;
                    }

                    .swipe-dot.active {
                        background: #0f172a;
                        width: 20px;
                        border-radius: 4px;
                    }

                    /* Cards System */
                    .mobile-course-card {
                        background: #ffffff;
                        border-radius: 20px;
                        padding: 16px;
                        margin-bottom: 12px;
                        border: 1px solid #e2e8f0;
                        box-shadow: 0 4px 14px rgba(15, 23, 42, 0.03);
                        cursor: pointer;
                        transition: transform 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease;
                    }

                    .mobile-course-card:active {
                        transform: scale(0.985);
                        box-shadow: 0 2px 6px rgba(15, 23, 42, 0.06);
                        border-color: #cbd5e1;
                    }

                    .mobile-card-code-badge {
                        font-size: 0.76rem;
                        font-weight: 800;
                        padding: 3px 9px;
                        border-radius: 10px;
                        background: #eef2ff;
                        color: #4f46e5;
                    }

                    .mobile-card-title {
                        font-size: 0.95rem;
                        font-weight: 800;
                        color: #0f172a;
                        margin-bottom: 6px;
                        line-height: 1.3;
                    }

                    .mobile-card-meta {
                        font-size: 0.75rem;
                        color: #64748b;
                        display: flex;
                        flex-direction: column;
                        gap: 4px;
                    }

                    .mobile-card-meta-row {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .mobile-card-footer {
                        margin-top: 10px;
                        padding-top: 10px;
                        border-top: 1px solid #f1f5f9;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    /* Schedule Sub-View Day Pill Strip */
                    .schedule-day-filter-strip {
                        display: flex;
                        gap: 6px;
                        overflow-x: auto;
                        padding-bottom: 6px;
                        margin-bottom: 16px;
                        scrollbar-width: none;
                    }

                    .schedule-day-filter-strip::-webkit-scrollbar {
                        display: none;
                    }

                    .schedule-filter-pill {
                        flex: 0 0 auto;
                        min-height: 38px;
                        padding: 0 14px;
                        border-radius: 99px;
                        border: 1px solid #e2e8f0;
                        background: #fff;
                        color: #64748b;
                        font-size: 0.75rem;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        transition: all 0.18s ease;
                    }

                    .schedule-filter-pill:active {
                        transform: scale(0.95);
                    }

                    .schedule-filter-pill.active {
                        background: #0f172a;
                        color: #fff;
                        border-color: #0f172a;
                        box-shadow: 0 4px 12px rgba(15, 23, 42, 0.15);
                    }

                    /* Capacity Bar for Course Registration */
                    .capacity-bar-wrap {
                        background: #f1f5f9;
                        border-radius: 99px;
                        height: 6px;
                        overflow: hidden;
                        margin-top: 6px;
                    }

                    .capacity-bar {
                        height: 6px;
                        border-radius: 99px;
                        transition: width 0.4s ease;
                    }

                    /* Grades Hero & Metric Cards */
                    .grades-hero-card {
                        background: linear-gradient(135deg, #059669 0%, #047857 50%, #065f46 100%);
                        border-radius: 24px;
                        padding: 20px;
                        color: #fff;
                        box-shadow: 0 12px 28px -6px rgba(5, 150, 105, 0.35);
                        margin-bottom: 20px;
                        border: 1px solid rgba(255, 255, 255, 0.15);
                        position: relative;
                        overflow: hidden;
                    }

                    .grades-hero-card::after {
                        content: '';
                        position: absolute;
                        bottom: -30%;
                        right: -20%;
                        width: 180px;
                        height: 180px;
                        background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
                        pointer-events: none;
                    }

                    .grades-stat-chip {
                        display: inline-flex;
                        align-items: center;
                        gap: 5px;
                        background: rgba(255, 255, 255, 0.2);
                        padding: 4px 10px;
                        border-radius: 12px;
                        font-size: 0.72rem;
                        font-weight: 700;
                        backdrop-filter: blur(4px);
                    }

                    /* Digital Student ID Card */
                    .student-id-card {
                        background: linear-gradient(135deg, #0f172a 0%, #1e293b 60%, #334155 100%);
                        border-radius: 24px;
                        padding: 22px;
                        color: #fff;
                        box-shadow: 0 16px 36px -8px rgba(15, 23, 42, 0.45);
                        border: 1px solid rgba(255, 255, 255, 0.15);
                        margin-bottom: 20px;
                        position: relative;
                        overflow: hidden;
                    }

                    .student-id-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 4px;
                        background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
                    }

                    .id-card-top {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 16px;
                    }

                    .id-card-univ-title {
                        font-size: 0.68rem;
                        font-weight: 800;
                        letter-spacing: 1px;
                        text-transform: uppercase;
                        color: #94a3b8;
                    }

                    .id-card-body {
                        display: flex;
                        gap: 16px;
                        align-items: center;
                        margin-bottom: 16px;
                    }

                    .id-photo-box {
                        width: 72px;
                        height: 84px;
                        border-radius: 16px;
                        overflow: hidden;
                        border: 2px solid rgba(255, 255, 255, 0.3);
                        background: #1e293b;
                        flex-shrink: 0;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                    }

                    .id-photo-box img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }

                    .id-info-col {
                        flex: 1;
                        min-width: 0;
                    }

                    .id-student-name {
                        font-size: 1.12rem;
                        font-weight: 800;
                        color: #ffffff;
                        line-height: 1.25;
                        margin-bottom: 4px;
                    }

                    .id-number-pill {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        background: rgba(255, 255, 255, 0.12);
                        padding: 3px 10px;
                        border-radius: 12px;
                        font-size: 0.75rem;
                        font-family: 'SF Mono', Monaco, Inconsolata, monospace;
                        font-weight: 700;
                        color: #93c5fd;
                        cursor: pointer;
                        transition: background 0.15s;
                    }

                    .id-number-pill:active {
                        background: rgba(255, 255, 255, 0.22);
                    }

                    .id-card-barcode-row {
                        background: rgba(255, 255, 255, 0.08);
                        border-radius: 14px;
                        padding: 10px 14px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        border: 1px solid rgba(255, 255, 255, 0.08);
                    }

                    .barcode-mock {
                        display: flex;
                        gap: 2px;
                        align-items: center;
                        height: 24px;
                    }

                    .barcode-mock span {
                        display: block;
                        background: #cbd5e1;
                        height: 100%;
                    }

                    /* Floating Island Bottom Navigation Dock */
                    .mobile-bottom-dock {
                        position: fixed;
                        bottom: calc(12px + env(safe-area-inset-bottom, 8px));
                        left: 16px;
                        right: 16px;
                        max-width: 480px;
                        margin: 0 auto;
                        background: rgba(255, 255, 255, 0.88);
                        backdrop-filter: blur(24px);
                        -webkit-backdrop-filter: blur(24px);
                        border: 1px solid rgba(255, 255, 255, 0.6);
                        border-radius: 32px;
                        display: flex;
                        justify-content: space-around;
                        align-items: center;
                        padding: 8px 6px;
                        z-index: 1040;
                        box-shadow: 0 16px 36px -6px rgba(15, 23, 42, 0.12), 0 4px 12px rgba(0, 0, 0, 0.04);
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
                        font-weight: 700;
                        min-width: 58px;
                        min-height: 48px;
                        padding: 4px 8px;
                        border-radius: 20px;
                        cursor: pointer;
                        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                        text-decoration: none;
                        position: relative;
                        user-select: none;
                    }

                    .dock-tab-btn i {
                        font-size: 1.3rem;
                        margin-bottom: 2px;
                        transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
                    }

                    .dock-tab-btn:active {
                        transform: scale(0.92);
                    }

                    .dock-tab-btn.active {
                        color: #0f172a;
                        background: #f1f5f9;
                    }

                    .dock-tab-btn.active i {
                        transform: translateY(-2px);
                        color: #2563eb;
                    }

                    /* Sub-views Animation */
                    .mobile-sub-view {
                        display: none;
                        animation: mobileFadeSlide 0.25s cubic-bezier(0.4, 0, 0.2, 1);
                    }

                    .mobile-sub-view.active {
                        display: block;
                    }

                    @keyframes mobileFadeSlide {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    /* Course Detail Bottom Sheet Modal */
                    .course-modal-overlay {
                        position: fixed;
                        inset: 0;
                        background: rgba(15, 23, 42, 0.6);
                        z-index: 1050;
                        display: none;
                        align-items: flex-end;
                        justify-content: center;
                        backdrop-filter: blur(6px);
                        -webkit-backdrop-filter: blur(6px);
                        animation: modalFadeIn 0.2s ease;
                    }

                    @keyframes modalFadeIn {
                        from { opacity: 0; }
                        to { opacity: 1; }
                    }

                    .course-modal-overlay.open {
                        display: flex;
                    }

                    .course-modal-sheet {
                        background: #ffffff;
                        border-radius: 28px 28px 0 0;
                        width: 100%;
                        max-width: 500px;
                        max-height: 88vh;
                        overflow-y: auto;
                        padding: 0 0 calc(28px + env(safe-area-inset-bottom, 16px));
                        animation: springSlideUp 0.32s cubic-bezier(0.34, 1.2, 0.64, 1);
                        box-shadow: 0 -10px 40px rgba(0, 0, 0, 0.2);
                    }

                    @keyframes springSlideUp {
                        from { transform: translateY(100%); }
                        to { transform: translateY(0); }
                    }

                    .sheet-drag-handle {
                        width: 44px;
                        height: 5px;
                        background: #cbd5e1;
                        border-radius: 99px;
                        margin: 12px auto 6px;
                    }

                    .sheet-header {
                        padding: 14px 20px 14px;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .sheet-header-code {
                        font-size: 0.78rem;
                        font-weight: 800;
                        color: #4f46e5;
                        background: #eef2ff;
                        padding: 3px 10px;
                        border-radius: 10px;
                        display: inline-block;
                        margin-bottom: 6px;
                    }

                    .sheet-header-title {
                        font-size: 1.05rem;
                        font-weight: 800;
                        color: #0f172a;
                        line-height: 1.3;
                        margin-bottom: 4px;
                    }

                    .sheet-header-meta {
                        font-size: 0.75rem;
                        color: #64748b;
                        display: flex;
                        flex-wrap: wrap;
                        gap: 12px;
                    }

                    .sheet-body {
                        padding: 18px 20px;
                    }

                    .sheet-section-label {
                        font-size: 0.72rem;
                        font-weight: 800;
                        text-transform: uppercase;
                        letter-spacing: 0.6px;
                        color: #64748b;
                        margin-bottom: 10px;
                        margin-top: 14px;
                    }

                    .score-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 10px;
                        margin-bottom: 4px;
                    }

                    .score-tile {
                        background: #f8fafc;
                        border-radius: 16px;
                        padding: 14px;
                        border: 1px solid #e2e8f0;
                    }

                    .score-tile-label {
                        font-size: 0.68rem;
                        font-weight: 700;
                        color: #64748b;
                        text-transform: uppercase;
                        letter-spacing: 0.4px;
                        margin-bottom: 4px;
                    }

                    .score-tile-val {
                        font-size: 1.4rem;
                        font-weight: 900;
                        color: #0f172a;
                        line-height: 1;
                    }

                    .score-tile-val.pending {
                        font-size: 0.85rem;
                        color: #94a3b8;
                        font-weight: 600;
                    }

                    .score-tile.highlight {
                        background: linear-gradient(135deg, #eef2ff, #f0fdf4);
                        border-color: #c7d2fe;
                    }

                    .score-tile.highlight .score-tile-val {
                        color: #4338ca;
                    }

                    .attendance-list {
                        display: flex;
                        flex-direction: column;
                        gap: 8px;
                    }

                    .att-row {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        padding: 10px 14px;
                        background: #f8fafc;
                        border-radius: 14px;
                        border: 1px solid #f1f5f9;
                    }

                    .att-date {
                        font-size: 0.75rem;
                        font-weight: 600;
                        color: #334155;
                    }

                    .att-badge {
                        font-size: 0.68rem;
                        font-weight: 800;
                        padding: 3px 10px;
                        border-radius: 99px;
                    }

                    .att-PRESENT { background: #dcfce7; color: #15803d; }
                    .att-ABSENT { background: #fee2e2; color: #b91c1c; }
                    .att-LATE { background: #fef3c7; color: #b45309; }
                    .att-EXCUSED { background: #e0f2fe; color: #0369a1; }

                    .att-empty {
                        font-size: 0.82rem;
                        color: #94a3b8;
                        text-align: center;
                        padding: 20px 0;
                    }

                    .att-summary {
                        display: flex;
                        gap: 8px;
                        flex-wrap: wrap;
                        margin-bottom: 12px;
                    }

                    .att-sum-chip {
                        display: inline-flex;
                        align-items: center;
                        gap: 5px;
                        font-size: 0.72rem;
                        font-weight: 700;
                        padding: 4px 11px;
                        border-radius: 99px;
                    }

                    /* Toast Notification for ID copy */
                    .mobile-toast {
                        position: fixed;
                        bottom: 80px;
                        left: 50%;
                        transform: translateX(-50%) translateY(20px);
                        background: #0f172a;
                        color: #fff;
                        padding: 8px 18px;
                        border-radius: 99px;
                        font-size: 0.78rem;
                        font-weight: 700;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
                        z-index: 1060;
                        opacity: 0;
                        pointer-events: none;
                        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .mobile-toast.show {
                        opacity: 1;
                        transform: translateX(-50%) translateY(0);
                    }
                }
            </style>
        </head>

        <body>

            <%-- Compute earned credits --%>
                <c:set var="earnedCredits" value="0" />
                <c:forEach var="gradeItem" items="${grades}">
                    <c:if
                        test="${gradeItem.letterGrade != 'F' && gradeItem.letterGrade != 'N/A' && not empty gradeItem.letterGrade}">
                        <c:set var="earnedCredits" value="${earnedCredits + gradeItem.credits}" />
                    </c:if>
                </c:forEach>

                <%--==================================================================--%>
                    <%-- DESKTOP VIEW (>= 768px) --%>
                        <%--==================================================================--%>
                            <%--==================================================================--%>
                                <%-- DESKTOP VIEW (>= 768px) --%>
                                    <%--==================================================================--%>
                                        <div class="d-none d-md-flex desktop-app-container">
                                            <style>
                                                body.modal-open {
                                                    padding-right: 0 !important;
                                                    overflow-y: hidden !important;
                                                }

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

                                                .modal.fade .modal-dialog {
                                                    transition: transform 0.22s cubic-bezier(0.16, 1, 0.3, 1), opacity 0.22s ease-out;
                                                    transform: scale(0.96) translateY(-8px);
                                                    opacity: 0;
                                                }

                                                .modal.show .modal-dialog {
                                                    transform: scale(1) translateY(0);
                                                    opacity: 1;
                                                }

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
                                                    margin-bottom: 30px;
                                                    padding: 0 10px;
                                                }

                                                .sidebar-logo i {
                                                    color: #10b981;
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
                                                    border-color: #e2e8f0;
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

                                                /* PROMO CARD */
                                                .sidebar-promo {
                                                    background: linear-gradient(145deg, #fef2f2, #fff1f2);
                                                    border-radius: 24px;
                                                    padding: 24px;
                                                    text-align: center;
                                                    margin-top: 24px;
                                                    position: relative;
                                                    overflow: hidden;
                                                    border: 1px solid #ffe4e6;
                                                }

                                                .sidebar-promo .star-icon {
                                                    width: 48px;
                                                    height: 48px;
                                                    background: #f43f5e;
                                                    color: white;
                                                    border-radius: 16px;
                                                    display: inline-flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    font-size: 1.5rem;
                                                    margin-bottom: 16px;
                                                    box-shadow: 0 8px 16px rgba(244, 63, 94, 0.25);
                                                    transform: rotate(-10deg);
                                                }

                                                .sidebar-promo h4 {
                                                    font-size: 1rem;
                                                    font-weight: 800;
                                                    color: #0f172a;
                                                    margin-bottom: 8px;
                                                }

                                                .sidebar-promo p {
                                                    font-size: 0.75rem;
                                                    color: #64748b;
                                                    margin-bottom: 16px;
                                                    line-height: 1.4;
                                                }

                                                .sidebar-promo button {
                                                    background: #0f172a;
                                                    color: white;
                                                    border: none;
                                                    width: 100%;
                                                    padding: 10px;
                                                    border-radius: 12px;
                                                    font-size: 0.8rem;
                                                    font-weight: 700;
                                                    transition: all 0.2s;
                                                }

                                                .sidebar-promo button:hover {
                                                    background: #1e293b;
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
                                                    margin-bottom: 30px;
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
                                                    border: none;
                                                    display: flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    color: #64748b;
                                                    font-size: 1.1rem;
                                                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
                                                    transition: all 0.2s;
                                                    position: relative;
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
                                                    gap: 24px;
                                                    margin-bottom: 24px;
                                                }

                                                .metric-card {
                                                    background: #ffffff;
                                                    border-radius: 24px;
                                                    padding: 24px;
                                                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                                                    position: relative;
                                                }

                                                .mc-header {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    margin-bottom: 20px;
                                                }

                                                .mc-icon-wrap {
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 12px;
                                                }

                                                .mc-icon {
                                                    width: 36px;
                                                    height: 36px;
                                                    border-radius: 10px;
                                                    display: flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    font-size: 1.1rem;
                                                }

                                                .mc-icon.green {
                                                    background: #dcfce7;
                                                    color: #16a34a;
                                                }

                                                .mc-icon.orange {
                                                    background: #ffedd5;
                                                    color: #f97316;
                                                }

                                                .mc-icon.blue {
                                                    background: #e0f2fe;
                                                    color: #0284c7;
                                                }

                                                .mc-title {
                                                    font-size: 0.9rem;
                                                    font-weight: 700;
                                                    color: #0f172a;
                                                }

                                                .mc-value {
                                                    font-size: 2.5rem;
                                                    font-weight: 800;
                                                    color: #0f172a;
                                                    line-height: 1;
                                                    margin-bottom: 8px;
                                                }

                                                .mc-subtitle {
                                                    font-size: 0.75rem;
                                                    color: #64748b;
                                                    margin-bottom: 20px;
                                                }

                                                .mc-footer {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: flex-end;
                                                }

                                                .mc-trend {
                                                    display: inline-flex;
                                                    align-items: center;
                                                    gap: 4px;
                                                    padding: 4px 10px;
                                                    border-radius: 99px;
                                                    font-size: 0.7rem;
                                                    font-weight: 700;
                                                }

                                                .mc-trend.positive {
                                                    background: #f0fdf4;
                                                    color: #16a34a;
                                                }

                                                .mc-trend.neutral {
                                                    background: #f1f5f9;
                                                    color: #64748b;
                                                }

                                                .mc-extra {
                                                    font-size: 0.85rem;
                                                    font-weight: 700;
                                                    color: #0f172a;
                                                }

                                                /* MIDDLE ROW */
                                                .middle-grid {
                                                    display: grid;
                                                    grid-template-columns: 2fr 1fr;
                                                    gap: 24px;
                                                    margin-bottom: 24px;
                                                }

                                                /* CHART CARD */
                                                .chart-card {
                                                    background: #ffffff;
                                                    border-radius: 24px;
                                                    padding: 28px;
                                                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                                                    display: flex;
                                                    flex-direction: column;
                                                }

                                                .chart-header {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: flex-start;
                                                    margin-bottom: 30px;
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

                                                .chart-actions {
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 16px;
                                                }

                                                .chart-legend {
                                                    display: flex;
                                                    gap: 16px;
                                                    font-size: 0.75rem;
                                                    color: #64748b;
                                                    font-weight: 600;
                                                }

                                                .legend-item {
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 6px;
                                                }

                                                .legend-dot {
                                                    width: 8px;
                                                    height: 8px;
                                                    border-radius: 50%;
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

                                                .chart-area {
                                                    flex: 1;
                                                    position: relative;
                                                    min-height: 200px;
                                                    /* Placeholder for beautiful custom CSS chart */
                                                    background-image:
                                                        linear-gradient(to right, #f8fafc 1px, transparent 1px),
                                                        linear-gradient(to bottom, #f8fafc 1px, transparent 1px);
                                                    background-size: calc(100% / 6) calc(100% / 4);
                                                    display: flex;
                                                    align-items: flex-end;
                                                    justify-content: space-between;
                                                    padding: 20px 0 0;
                                                }

                                                .chart-bar-group {
                                                    width: calc(100% / 6 - 20px);
                                                    height: 100%;
                                                    display: flex;
                                                    align-items: flex-end;
                                                    justify-content: center;
                                                    gap: 6px;
                                                    position: relative;
                                                }

                                                .chart-bar {
                                                    width: 14px;
                                                    border-radius: 99px;
                                                    position: relative;
                                                    animation: growUp 1s cubic-bezier(0.34, 1.12, 0.64, 1) forwards;
                                                    transform-origin: bottom;
                                                }

                                                .chart-bar.green {
                                                    background: linear-gradient(180deg, #34d399 0%, #10b981 100%);
                                                }

                                                .chart-bar.orange {
                                                    background: linear-gradient(180deg, #fb923c 0%, #ea580c 100%);
                                                    height: 40%;
                                                }

                                                .chart-bar.purple {
                                                    background: linear-gradient(180deg, #c084fc 0%, #9333ea 100%);
                                                    height: 60%;
                                                }

                                                .chart-labels {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    margin-top: 16px;
                                                    padding: 0 10px;
                                                }

                                                .chart-label {
                                                    font-size: 0.7rem;
                                                    color: #94a3b8;
                                                    font-weight: 600;
                                                    text-align: center;
                                                    width: calc(100% / 6);
                                                }

                                                /* SEGMENTATION CARD (Courses) */
                                                .seg-card {
                                                    background: #ffffff;
                                                    border-radius: 24px;
                                                    padding: 28px;
                                                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                                                    display: flex;
                                                    flex-direction: column;
                                                }

                                                .seg-header {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    margin-bottom: 24px;
                                                }

                                                .seg-header h3 {
                                                    font-size: 1rem;
                                                    font-weight: 800;
                                                    color: #0f172a;
                                                    margin: 0;
                                                }

                                                .seg-header i {
                                                    color: #94a3b8;
                                                    cursor: pointer;
                                                }

                                                .seg-list {
                                                    display: flex;
                                                    flex-direction: column;
                                                    gap: 18px;
                                                    overflow-y: auto;
                                                    flex: 1;
                                                }

                                                .seg-item {
                                                    display: flex;
                                                    flex-direction: column;
                                                    gap: 8px;
                                                }

                                                .seg-info {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                }

                                                .seg-name {
                                                    font-size: 0.8rem;
                                                    font-weight: 600;
                                                    color: #64748b;
                                                }

                                                .seg-val {
                                                    font-size: 0.8rem;
                                                    font-weight: 800;
                                                    color: #0f172a;
                                                }

                                                .seg-bar-bg {
                                                    height: 6px;
                                                    background: #f1f5f9;
                                                    border-radius: 99px;
                                                    overflow: hidden;
                                                }

                                                .seg-bar-fill {
                                                    height: 100%;
                                                    border-radius: 99px;
                                                }

                                                /* BOTTOM TABLE CARD */
                                                .table-card {
                                                    background: #ffffff;
                                                    border-radius: 24px;
                                                    padding: 28px;
                                                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                                                }

                                                .tc-header {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    margin-bottom: 24px;
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
                                                    border-spacing: 0 12px;
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
                                                    padding: 16px;
                                                    font-size: 0.85rem;
                                                    color: #334155;
                                                    font-weight: 600;
                                                    border-top: 1px solid transparent;
                                                    border-bottom: 1px solid transparent;
                                                    transition: all 0.2s;
                                                }

                                                .tc-table tr {
                                                    transition: all 0.2s;
                                                }

                                                .tc-table tbody tr:hover td {
                                                    background: #f8fafc;
                                                }

                                                .tc-table tbody tr td:first-child {
                                                    border-top-left-radius: 16px;
                                                    border-bottom-left-radius: 16px;
                                                }

                                                .tc-table tbody tr td:last-child {
                                                    border-top-right-radius: 16px;
                                                    border-bottom-right-radius: 16px;
                                                }

                                                .tc-badge {
                                                    display: inline-flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    padding: 6px 12px;
                                                    border-radius: 99px;
                                                    font-size: 0.7rem;
                                                    font-weight: 700;
                                                }

                                                .tc-badge.success {
                                                    background: #dcfce7;
                                                    color: #16a34a;
                                                }

                                                .tc-badge.info {
                                                    background: #e0f2fe;
                                                    color: #0284c7;
                                                }

                                                .tc-badge.purple {
                                                    background: #f3e8ff;
                                                    color: #7e22ce;
                                                }

                                                .tc-badge.warning {
                                                    background: #ffedd5;
                                                    color: #c2410c;
                                                }

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

                                                /* TAB CONTENT PANELS */
                                                .tab-panel {
                                                    display: none;
                                                    animation: fadeIn 0.3s ease;
                                                }

                                                .tab-panel.active {
                                                    display: block;
                                                }

                                                @keyframes fadeIn {
                                                    from {
                                                        opacity: 0;
                                                        transform: translateY(10px);
                                                    }

                                                    to {
                                                        opacity: 1;
                                                        transform: translateY(0);
                                                    }
                                                }

                                                @keyframes growUp {
                                                    from {
                                                        height: 0;
                                                    }
                                                }

                                                 .timetable-card {
                                                     background: #ffffff;
                                                     border-radius: 24px;
                                                     padding: 24px;
                                                     box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
                                                     border: 1px solid rgba(226, 232, 240, 0.7);
                                                 }

                                                 .timetable-toolbar {
                                                     display: flex;
                                                     justify-content: space-between;
                                                     align-items: center;
                                                     flex-wrap: wrap;
                                                     gap: 16px;
                                                     margin-bottom: 20px;
                                                 }

                                                 .view-toggle-group {
                                                     display: inline-flex;
                                                     background: #f1f5f9;
                                                     padding: 4px;
                                                     border-radius: 99px;
                                                     border: 1px solid #e2e8f0;
                                                 }

                                                 .view-toggle-btn {
                                                     border: none;
                                                     background: transparent;
                                                     padding: 6px 18px;
                                                     border-radius: 99px;
                                                     font-size: 0.8rem;
                                                     font-weight: 700;
                                                     color: #64748b;
                                                     cursor: pointer;
                                                     transition: all 0.2s ease;
                                                     display: inline-flex;
                                                     align-items: center;
                                                     gap: 6px;
                                                 }

                                                 .view-toggle-btn.active {
                                                     background: #ffffff;
                                                     color: #2563eb;
                                                     box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                                                 }

                                                 .timetable-scroll {
                                                     overflow-x: auto;
                                                     border-radius: 18px;
                                                     border: 1px solid #edf2f7;
                                                     background: #ffffff;
                                                 }

                                                 .timetable-table {
                                                     width: 100%;
                                                     border-collapse: separate;
                                                     border-spacing: 0;
                                                     min-width: 980px;
                                                 }

                                                 .timetable-table th, .timetable-table td {
                                                     border-right: 1px solid #edf2f7;
                                                     border-bottom: 1px solid #edf2f7;
                                                     padding: 14px;
                                                     vertical-align: top;
                                                     transition: opacity 0.2s ease, filter 0.2s ease;
                                                 }

                                                 .timetable-table th:last-child, .timetable-table td:last-child {
                                                     border-right: none;
                                                 }

                                                 .timetable-table tr:last-child td {
                                                     border-bottom: none;
                                                 }

                                                 .timetable-header-cell {
                                                     background: #f8fafc;
                                                     text-align: center;
                                                     padding: 16px 14px;
                                                     position: relative;
                                                 }

                                                 .timetable-header-cell.is-today {
                                                     background: #eff6ff;
                                                     border-bottom: 2px solid #2563eb;
                                                 }

                                                 .timetable-day-name {
                                                     font-size: 0.92rem;
                                                     font-weight: 800;
                                                     color: #0f172a;
                                                     letter-spacing: 0.3px;
                                                 }

                                                 .timetable-today-badge {
                                                     display: inline-block;
                                                     background: #2563eb;
                                                     color: #ffffff;
                                                     font-size: 0.62rem;
                                                     font-weight: 800;
                                                     padding: 2px 8px;
                                                     border-radius: 99px;
                                                     margin-top: 4px;
                                                     letter-spacing: 0.5px;
                                                     text-transform: uppercase;
                                                 }

                                                 .timetable-shift-cell {
                                                     width: 150px;
                                                     min-width: 150px;
                                                     background: #fafbfc;
                                                     border-right: 2px solid #e2e8f0 !important;
                                                 }

                                                 .shift-badge-box {
                                                     display: flex;
                                                     flex-direction: column;
                                                     gap: 4px;
                                                 }

                                                 .shift-name-title {
                                                     font-size: 0.85rem;
                                                     font-weight: 800;
                                                     color: #0f172a;
                                                     display: flex;
                                                     align-items: center;
                                                     gap: 6px;
                                                 }

                                                 .shift-time-range {
                                                     font-size: 0.72rem;
                                                     font-weight: 600;
                                                     color: #64748b;
                                                 }

                                                 .timetable-slot-cell {
                                                     min-width: 170px;
                                                     background: #ffffff;
                                                     transition: background 0.15s ease, opacity 0.2s ease;
                                                 }

                                                 .timetable-slot-cell.is-today {
                                                     background: #fafcff;
                                                 }

                                                 .timetable-slot-cell:hover {
                                                     background: #f8fafc;
                                                 }

                                                 .timetable-course-card {
                                                     background: #ffffff;
                                                     border: 1px solid #e2e8f0;
                                                     border-left: 4px solid #2563eb;
                                                     border-radius: 14px;
                                                     padding: 12px 14px;
                                                     margin-bottom: 8px;
                                                     box-shadow: 0 2px 6px rgba(15, 23, 42, 0.03);
                                                     transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                                                 }

                                                 .timetable-course-card:last-child {
                                                     margin-bottom: 0;
                                                 }

                                                 .timetable-course-card:hover {
                                                     transform: translateY(-2px);
                                                     box-shadow: 0 8px 20px rgba(37, 99, 235, 0.1);
                                                     border-color: #93c5fd;
                                                 }

                                                 .tt-code-badge {
                                                     display: inline-block;
                                                     font-size: 0.72rem;
                                                     font-weight: 800;
                                                     color: #2563eb;
                                                     background: #eff6ff;
                                                     padding: 3px 8px;
                                                     border-radius: 6px;
                                                     margin-bottom: 6px;
                                                 }

                                                 .tt-course-title {
                                                     font-size: 0.84rem;
                                                     font-weight: 700;
                                                     color: #0f172a;
                                                     line-height: 1.3;
                                                     margin-bottom: 8px;
                                                     display: -webkit-box;
                                                     -webkit-line-clamp: 2;
                                                     -webkit-box-orient: vertical;
                                                     overflow: hidden;
                                                 }

                                                 .tt-meta-row {
                                                     display: flex;
                                                     justify-content: space-between;
                                                     align-items: center;
                                                     font-size: 0.72rem;
                                                     color: #64748b;
                                                     margin-bottom: 8px;
                                                 }

                                                 .tt-room-pill {
                                                     background: #f1f5f9;
                                                     color: #334155;
                                                     font-weight: 600;
                                                     padding: 2px 7px;
                                                     border-radius: 6px;
                                                     display: inline-flex;
                                                     align-items: center;
                                                     gap: 4px;
                                                 }

                                                 .tt-prof-row {
                                                     font-size: 0.72rem;
                                                     font-weight: 600;
                                                     color: #475569;
                                                     margin-bottom: 8px;
                                                     display: flex;
                                                     align-items: center;
                                                     gap: 5px;
                                                     overflow: hidden;
                                                     text-overflow: ellipsis;
                                                     white-space: nowrap;
                                                 }

                                                 .tt-actions-row {
                                                     display: flex;
                                                     gap: 6px;
                                                     padding-top: 8px;
                                                     border-top: 1px dashed #edf2f7;
                                                     align-items: center;
                                                     justify-content: space-between;
                                                 }

                                                 .tt-action-btn {
                                                     border: none;
                                                     border-radius: 8px;
                                                     padding: 4px 10px;
                                                     font-size: 0.72rem;
                                                     font-weight: 700;
                                                     display: inline-flex;
                                                     align-items: center;
                                                     justify-content: center;
                                                     gap: 4px;
                                                     cursor: pointer;
                                                     transition: all 0.15s ease;
                                                 }

                                                 .tt-action-btn.drop-btn {
                                                     background: #fef2f2;
                                                     color: #dc2626;
                                                     border: 1px solid #fecaca;
                                                 }
                                                 .tt-action-btn.drop-btn:hover {
                                                     background: #dc2626;
                                                     color: #ffffff;
                                                     border-color: #dc2626;
                                                 }

                                                 .timetable-empty-slot {
                                                     height: 100%;
                                                     min-height: 80px;
                                                     display: flex;
                                                     align-items: center;
                                                     justify-content: center;
                                                     border: 1px dashed #e2e8f0;
                                                     border-radius: 12px;
                                                     background: #fafbfc;
                                                     color: #94a3b8;
                                                     font-size: 0.75rem;
                                                     font-weight: 600;
                                                     transition: all 0.15s ease;
                                                 }

                                                 .timetable-empty-slot:hover {
                                                     background: #f1f5f9;
                                                     border-color: #cbd5e1;
                                                 }

                                                 .timetable-stats-bar {
                                                     display: flex;
                                                     gap: 16px;
                                                     flex-wrap: wrap;
                                                     margin-bottom: 20px;
                                                 }

                                                 .tt-stat-chip {
                                                     background: #ffffff;
                                                     border: 1px solid #e2e8f0;
                                                     border-radius: 14px;
                                                     padding: 10px 16px;
                                                     display: flex;
                                                     align-items: center;
                                                     gap: 12px;
                                                     box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
                                                 }

                                                 .tt-stat-icon {
                                                     width: 38px;
                                                     height: 38px;
                                                     border-radius: 10px;
                                                     display: flex;
                                                     align-items: center;
                                                     justify-content: center;
                                                     font-size: 1.15rem;
                                                 }

                                                 .tt-stat-info {
                                                     display: flex;
                                                     flex-direction: column;
                                                 }

                                                 .tt-stat-label {
                                                     font-size: 0.7rem;
                                                     font-weight: 600;
                                                     color: #64748b;
                                                     text-transform: uppercase;
                                                 }

                                                 .tt-stat-val {
                                                     font-size: 1.15rem;
                                                     font-weight: 800;
                                                     color: #0f172a;
                                                     line-height: 1;
                                                 }

                                                 .day-pill-btn {
                                                     transition: all 0.15s ease;
                                                 }
                                             </style>

                                            <%-- SIDEBAR --%>
                                                <aside class="desktop-sidebar">
                                                    <div class="sidebar-logo">
                                                        <i class="bi bi-mortarboard-fill"></i>
                                                        <span>UniTRS</span>
                                                    </div>

                                                    <div class="sidebar-search">
                                                        <i class="bi bi-search"></i>
                                                        <input type="text" placeholder="Search courses...">
                                                    </div>

                                                    <nav class="sidebar-nav">
                                                        <button class="active" id="tab-dashboard"
                                                            onclick="switchDesktopTab('dashboard', this)">
                                                            <i class="bi bi-grid-fill"></i> Dashboard
                                                        </button>
                                                        <button id="tab-schedule" onclick="switchDesktopTab('schedule', this)">
                                                            <i class="bi bi-calendar-event"></i> My Schedule
                                                        </button>
                                                        <button id="tab-registration" onclick="switchDesktopTab('registration', this)">
                                                            <i class="bi bi-journal-plus"></i> Term Registration
                                                        </button>
                                                        <button id="tab-transcript" onclick="switchDesktopTab('transcript', this)">
                                                            <i class="bi bi-file-earmark-bar-graph"></i> Transcript
                                                        </button>
                                                        <button id="tab-settings" onclick="switchDesktopTab('settings', this)">
                                                            <i class="bi bi-gear"></i> Settings
                                                        </button>
                                                    </nav>

                                                    <div class="sidebar-promo">
                                                        <div class="star-icon"><i class="bi bi-star-fill"></i></div>
                                                        <h4>Dean's List</h4>
                                                        <p>Maintain a GPA of 3.8+ to achieve Dean's List honors this
                                                            term.</p>
                                                        <button>View Requirements</button>
                                                    </div>
                                                </aside>

                                                <%-- MAIN CONTENT --%>
                                                    <main class="desktop-main">
                                                        <%-- HEADER --%>
                                                            <header class="desktop-header">
                                                                <div>
                                                                    <div class="header-title">Student Overview</div>
                                                                    <c:if test="${not empty studentSchool}">
                                                                        <div class="text-muted small mt-1 fw-medium"><i
                                                                                class="bi bi-building me-1"></i>
                                                                            ${studentSchool.schoolName}</div>
                                                                    </c:if>
                                                                </div>

                                                                <div class="header-actions">
                                                                    <button class="action-btn has-dot"><i
                                                                            class="bi bi-bell"></i></button>
                                                                    <button class="action-btn"><i
                                                                            class="bi bi-chat-dots"></i></button>

                                                                    <div class="dropdown">
                                                                        <button class="user-profile dropdown-toggle border-0 text-start" type="button" id="studentProfileDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false" aria-label="User profile menu for ${user.fullName}">
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
                                                                                <span class="user-role">${user.formattedIdentifier} <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill ms-1 px-2 py-0" style="font-size: 0.65rem; font-weight: 700;">${user.role}</span> <i class="bi bi-chevron-down ms-1" style="font-size:0.65rem;"></i></span>
                                                                            </div>
                                                                        </button>

                                                                        <div class="dropdown-menu dropdown-menu-end shadow-lg rounded-4 p-0 border-0 mt-2 overflow-hidden user-dropdown-menu" aria-labelledby="studentProfileDropdown" style="width: 300px; z-index: 1060;" onclick="event.stopPropagation();">
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
                                                                                        <div class="text-muted small text-uppercase fw-semibold" style="font-size: 0.68rem; letter-spacing: 0.5px;">Account Email</div>
                                                                                        <div class="fw-semibold text-dark text-truncate" style="font-size: 0.85rem;">${user.email}</div>
                                                                                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill mt-1" style="font-size: 0.68rem; font-weight: 700;">
                                                                                            <i class="bi bi-mortarboard-fill me-1"></i>${user.role}
                                                                                        </span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                            <!-- Details Rows -->
                                                                            <div class="p-3">
                                                                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom" style="font-size: 0.82rem;">
                                                                                    <span class="text-muted d-flex align-items-center gap-2">
                                                                                        <i class="bi bi-person-badge text-primary" style="font-size: 0.95rem;"></i> Student ID
                                                                                    </span>
                                                                                    <span class="fw-bold text-dark font-monospace text-end text-truncate ms-2" style="max-width: 170px;">
                                                                                        ${user.formattedIdentifier}
                                                                                    </span>
                                                                                </div>

                                                                                <div class="d-flex justify-content-between align-items-center py-2" style="font-size: 0.82rem;">
                                                                                    <span class="text-muted d-flex align-items-center gap-2">
                                                                                        <i class="bi bi-building text-primary" style="font-size: 0.95rem;"></i> School
                                                                                    </span>
                                                                                    <span class="fw-semibold text-dark text-end text-truncate ms-2" style="max-width: 170px;" title="${not empty studentSchool ? studentSchool.schoolName : (not empty user.major ? user.major : 'Not Assigned')}">
                                                                                        <c:choose>
                                                                                            <c:when test="${not empty studentSchool}">${studentSchool.schoolName}</c:when>
                                                                                            <c:when test="${not empty user.major}">${user.major}</c:when>
                                                                                            <c:otherwise>Not Assigned</c:otherwise>
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
                                                                <c:if test="${param.twoFactorUpdated == 'true'}">
                                                                    <div
                                                                        class="alert alert-success alert-dismissible fade show rounded-4">
                                                                        <i class="bi bi-shield-check me-2"></i>2FA is
                                                                        now <strong>enabled</strong>.<button
                                                                            type="button" class="btn-close"
                                                                            data-bs-dismiss="alert"></button></div>
                                                                </c:if>
                                                                <c:if test="${param.twoFactorUpdated == 'false'}">
                                                                    <div
                                                                        class="alert alert-info alert-dismissible fade show rounded-4">
                                                                        <i class="bi bi-shield-slash me-2"></i>2FA has
                                                                        been <strong>disabled</strong>.<button
                                                                            type="button" class="btn-close"
                                                                            data-bs-dismiss="alert"></button></div>
                                                                </c:if>
                                                                <c:if test="${not empty successMessage}">
                                                                    <div
                                                                        class="alert alert-success alert-dismissible fade show rounded-4">
                                                                        <i
                                                                            class="bi bi-check-circle-fill me-2"></i>${successMessage}<button
                                                                            type="button" class="btn-close"
                                                                            data-bs-dismiss="alert"></button></div>
                                                                </c:if>
                                                                <c:if test="${not empty errorMessage}">
                                                                    <div
                                                                        class="alert alert-danger alert-dismissible fade show rounded-4">
                                                                        <i
                                                                            class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}<button
                                                                            type="button" class="btn-close"
                                                                            data-bs-dismiss="alert"></button></div>
                                                                </c:if>

                                                                <c:choose>
                                                                    <c:when test="${empty user.studentSchoolId}">
                                                                        <div
                                                                            class="card table-card border-0 text-center py-5">
                                                                            <i class="bi bi-building text-success mb-3"
                                                                                style="font-size:4rem;"></i>
                                                                            <h3 class="mb-4 fw-bold">Welcome to UniTRS
                                                                            </h3>
                                                                            <p class="text-muted mb-4">Please select
                                                                                your academic school to unlock your
                                                                                dashboard.</p>
                                                                            <form
                                                                                action="${pageContext.request.contextPath}/student/dashboard"
                                                                                method="post" class="mx-auto"
                                                                                style="max-width: 400px;">
                                                                                <input type="hidden" name="action"
                                                                                    value="selectSchool">
                                                                                <select
                                                                                    class="form-select form-select-lg rounded-4 mb-4"
                                                                                    name="schoolId" required>
                                                                                    <option value="" selected disabled>
                                                                                        -- Choose a School --</option>
                                                                                    <c:forEach var="school"
                                                                                        items="${schools}">
                                                                                        <option value="${school.id}">
                                                                                            ${school.schoolName}
                                                                                        </option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                                <button type="submit"
                                                                                    class="btn btn-success btn-lg w-100 rounded-pill fw-bold">Continue</button>
                                                                            </form>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>

                                                                        <%-- TAB: DASHBOARD --%>
                                                                            <div id="dt-dashboard"
                                                                                class="tab-panel active">
                                                                                <%-- METRICS GRID --%>
                                                                                    <div class="metrics-grid">
                                                                                        <div class="metric-card">
                                                                                            <div class="mc-header">
                                                                                                <div
                                                                                                    class="mc-icon-wrap">
                                                                                                    <div
                                                                                                        class="mc-icon green">
                                                                                                        <i
                                                                                                            class="bi bi-journal-bookmark-fill"></i>
                                                                                                    </div>
                                                                                                    <span
                                                                                                        class="mc-title">Cumulative
                                                                                                        GPA</span>
                                                                                                </div>
                                                                                                <i
                                                                                                    class="bi bi-three-dots-vertical text-muted"></i>
                                                                                            </div>
                                                                                            <div class="mc-value">
                                                                                                ${termGpa}</div>
                                                                                            <div class="mc-subtitle">
                                                                                                Academic Year 2026-2027
                                                                                            </div>
                                                                                            <div class="mc-footer">
                                                                                                <div
                                                                                                    class="mc-trend positive">
                                                                                                    <i
                                                                                                        class="bi bi-arrow-up-right"></i>
                                                                                                    Top 10%</div>
                                                                                                <div class="mc-extra">
                                                                                                    Excellent</div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="metric-card">
                                                                                            <div class="mc-header">
                                                                                                <div
                                                                                                    class="mc-icon-wrap">
                                                                                                    <div
                                                                                                        class="mc-icon orange">
                                                                                                        <i
                                                                                                            class="bi bi-award-fill"></i>
                                                                                                    </div>
                                                                                                    <span
                                                                                                        class="mc-title">Credits
                                                                                                        Earned</span>
                                                                                                </div>
                                                                                                <i
                                                                                                    class="bi bi-three-dots-vertical text-muted"></i>
                                                                                            </div>
                                                                                            <div class="mc-value">
                                                                                                ${earnedCredits}</div>
                                                                                            <div class="mc-subtitle">
                                                                                                Total Accumulated
                                                                                                Credits</div>
                                                                                            <div class="mc-footer">
                                                                                                <div
                                                                                                    class="mc-trend neutral">
                                                                                                    <i
                                                                                                        class="bi bi-dash"></i>
                                                                                                    On Track</div>
                                                                                                <div class="mc-extra">
                                                                                                    120 Required</div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="metric-card">
                                                                                            <div class="mc-header">
                                                                                                <div
                                                                                                    class="mc-icon-wrap">
                                                                                                    <div
                                                                                                        class="mc-icon blue">
                                                                                                        <i
                                                                                                            class="bi bi-backpack-fill"></i>
                                                                                                    </div>
                                                                                                    <span
                                                                                                        class="mc-title">Enrolled
                                                                                                        Courses</span>
                                                                                                </div>
                                                                                                <i
                                                                                                    class="bi bi-three-dots-vertical text-muted"></i>
                                                                                            </div>
                                                                                            <div class="mc-value">
                                                                                                ${schedule.size()}</div>
                                                                                            <div class="mc-subtitle">
                                                                                                Current Term Schedule
                                                                                            </div>
                                                                                            <div class="mc-footer">
                                                                                                <div
                                                                                                    class="mc-trend positive">
                                                                                                    <i
                                                                                                        class="bi bi-check-circle-fill"></i>
                                                                                                    Active</div>
                                                                                                <div class="mc-extra">
                                                                                                    View Schedule <i
                                                                                                        class="bi bi-arrow-right"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                    <%-- MIDDLE ROW --%>
                                                                                        <div class="middle-grid">
                                                                                            <%-- Chart Placeholder --%>
                                                                                                <div class="chart-card">
                                                                                                    <div
                                                                                                        class="chart-header">
                                                                                                        <div
                                                                                                            class="chart-title-box">
                                                                                                            <h3>Academic
                                                                                                                Performance
                                                                                                            </h3>
                                                                                                            <p>Score
                                                                                                                trends
                                                                                                                across
                                                                                                                enrolled
                                                                                                                courses
                                                                                                            </p>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="chart-actions">
                                                                                                            <div
                                                                                                                class="chart-legend">
                                                                                                                <div
                                                                                                                    class="legend-item">
                                                                                                                    <div class="legend-dot"
                                                                                                                        style="background:#10b981;">
                                                                                                                    </div>
                                                                                                                    Midterm
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="legend-item">
                                                                                                                    <div class="legend-dot"
                                                                                                                        style="background:#f97316;">
                                                                                                                    </div>
                                                                                                                    Assignment
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <button
                                                                                                                class="chart-btn">Export</button>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div
                                                                                                        class="chart-area">
                                                                                                        <c:forEach
                                                                                                            var="enrollment"
                                                                                                            items="${schedule}">
                                                                                                            <c:set
                                                                                                                var="enrollGrade"
                                                                                                                value="${gradeMap[enrollment.id]}" />
                                                                                                            <c:set
                                                                                                                var="midH"
                                                                                                                value="${enrollGrade != null && enrollGrade.midtermScore > 0 ? (enrollGrade.midtermScore / 30 * 100) : 10}" />
                                                                                                            <c:set
                                                                                                                var="asgH"
                                                                                                                value="${enrollGrade != null && enrollGrade.assignmentScore > 0 ? (enrollGrade.assignmentScore / 25 * 100) : 10}" />
                                                                                                            <div
                                                                                                                class="chart-bar-group">
                                                                                                                <div class="chart-bar green"
                                                                                                                    style="height: ${midH}%;">
                                                                                                                </div>
                                                                                                                <div class="chart-bar orange"
                                                                                                                    style="height: ${asgH}%;">
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </c:forEach>
                                                                                                        <c:if
                                                                                                            test="${empty schedule}">
                                                                                                            <div
                                                                                                                class="w-100 text-center text-muted fw-bold">
                                                                                                                No data
                                                                                                                available
                                                                                                            </div>
                                                                                                        </c:if>
                                                                                                    </div>
                                                                                                    <div
                                                                                                        class="chart-labels">
                                                                                                        <c:forEach
                                                                                                            var="enrollment"
                                                                                                            items="${schedule}">
                                                                                                            <div
                                                                                                                class="chart-label">
                                                                                                                ${enrollment.courseCode}
                                                                                                            </div>
                                                                                                        </c:forEach>
                                                                                                    </div>
                                                                                                </div>

                                                                                                <%-- Course Segmentation
                                                                                                    --%>
                                                                                                    <div
                                                                                                        class="seg-card">
                                                                                                        <div
                                                                                                            class="seg-header">
                                                                                                            <h3>Course
                                                                                                                Progress
                                                                                                            </h3>
                                                                                                            <i
                                                                                                                class="bi bi-info-circle"></i>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="seg-list">
                                                                                                            <c:forEach
                                                                                                                var="enrollment"
                                                                                                                items="${schedule}">
                                                                                                                <c:set
                                                                                                                    var="enrollGrade"
                                                                                                                    value="${gradeMap[enrollment.id]}" />
                                                                                                                <c:set
                                                                                                                    var="totalVal"
                                                                                                                    value="${enrollGrade != null ? enrollGrade.totalScore : 0}" />
                                                                                                                <c:set
                                                                                                                    var="colorClass"
                                                                                                                    value="${totalVal > 80 ? '#10b981' : (totalVal > 60 ? '#f97316' : '#ef4444')}" />

                                                                                                                <div
                                                                                                                    class="seg-item">
                                                                                                                    <div
                                                                                                                        class="seg-info">
                                                                                                                        <span
                                                                                                                            class="seg-name">${enrollment.courseCode}</span>
                                                                                                                        <span
                                                                                                                            class="seg-val">${totalVal}%</span>
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="seg-bar-bg">
                                                                                                                        <div class="seg-bar-fill"
                                                                                                                            style="width: ${totalVal}%; background: ${colorClass};">
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </c:forEach>
                                                                                                            <c:if
                                                                                                                test="${empty schedule}">
                                                                                                                <div
                                                                                                                    class="text-center text-muted small mt-4">
                                                                                                                    No
                                                                                                                    courses
                                                                                                                    enrolled.
                                                                                                                </div>
                                                                                                            </c:if>
                                                                                                        </div>
                                                                                                    </div>
                                                                                        </div>
                                                                            </div>

                                                                            <%-- TAB: REGISTRATION (Data Table) --%>
                                                                                <div id="dt-registration"
                                                                                    class="tab-panel">
                                                                                    <div class="table-card">
                                                                                        <div class="tc-header">
                                                                                            <h3>Available Courses for
                                                                                                Registration</h3>
                                                                                            <button
                                                                                                class="chart-btn d-flex align-items-center gap-2">Term
                                                                                                1 <i
                                                                                                    class="bi bi-chevron-down"></i></button>
                                                                                        </div>
                                                                                        <div class="tc-table-wrap">
                                                                                            <table class="tc-table">
                                                                                                <thead>
                                                                                                    <tr>
                                                                                                        <th>Course</th>
                                                                                                        <th>Professor
                                                                                                        </th>
                                                                                                        <th>Time / Shift
                                                                                                        </th>
                                                                                                        <th>Status</th>
                                                                                                        <th>Credits</th>
                                                                                                        <th>Capacity
                                                                                                        </th>
                                                                                                        <th>Action</th>
                                                                                                    </tr>
                                                                                                </thead>
                                                                                                <tbody>
                                                                                                    <c:forEach
                                                                                                        var="section"
                                                                                                        items="${availableClasses}">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <div
                                                                                                                    class="d-flex align-items-center">
                                                                                                                    <div
                                                                                                                        class="tc-course-icon">
                                                                                                                        <i
                                                                                                                            class="bi bi-journal-text"></i>
                                                                                                                    </div>
                                                                                                                    <div>
                                                                                                                        <div
                                                                                                                            class="fw-bold text-dark">
                                                                                                                            ${section.courseCode}
                                                                                                                        </div>
                                                                                                                        <div
                                                                                                                            class="small text-muted">
                                                                                                                            ${section.courseTitle}
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                            <td>${section.professorName}
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <div
                                                                                                                    class="fw-bold">
                                                                                                                    ${section.sessionShift}
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="small text-muted">
                                                                                                                    ${section.daysOfWeek}
                                                                                                                </div>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <c:choose>
                                                                                                                    <c:when
                                                                                                                        test="${section.enrolledCount >= section.roomCapacity}">
                                                                                                                        <span
                                                                                                                            class="tc-badge warning">Full</span>
                                                                                                                    </c:when>
                                                                                                                    <c:otherwise>
                                                                                                                        <span
                                                                                                                            class="tc-badge success">Available</span>
                                                                                                                    </c:otherwise>
                                                                                                                </c:choose>
                                                                                                            </td>
                                                                                                            <td
                                                                                                                class="fw-bold">
                                                                                                                ${section.credits}
                                                                                                            </td>
                                                                                                            <td>${section.enrolledCount}
                                                                                                                /
                                                                                                                ${section.roomCapacity}
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <c:set
                                                                                                                        var="isEnrolled"
                                                                                                                        value="false" />
                                                                                                                    <c:forEach
                                                                                                                        var="myClass"
                                                                                                                        items="${schedule}">
                                                                                                                        <c:if
                                                                                                                            test="${myClass.courseCode == section.courseCode}">
                                                                                                                            <c:set
                                                                                                                                var="isEnrolled"
                                                                                                                                value="true" />
                                                                                                                        </c:if>
                                                                                                                    </c:forEach>
                                                                                                                    <c:choose>
                                                                                                                        <c:when
                                                                                                                            test="${isEnrolled}">
                                                                                                                            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-1 small fw-bold"><i class="bi bi-check2 me-1"></i> Enrolled</span>
                                                                                                                        </c:when>
                                                                                                                        <c:when
                                                                                                                            test="${section.enrolledCount >= section.roomCapacity}">
                                                                                                                            <button
                                                                                                                                type="button"
                                                                                                                                class="btn btn-sm btn-outline-danger rounded-pill fw-bold disabled">Full</button>
                                                                                                                        </c:when>
                                                                                                                        <c:otherwise>
                                                                                                                            <button
                                                                                                                                type="button"
                                                                                                                                class="btn btn-sm btn-dark rounded-pill px-3 fw-bold"
                                                                                                                                onclick="openEnrollConfirm('${section.id}', '${section.courseCode}', '${section.courseTitle}', '${section.professorName}', 'registration')">Enroll</button>
                                                                                                                        </c:otherwise>
                                                                                                                    </c:choose>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </c:forEach>
                                                                                                    <c:if
                                                                                                        test="${empty availableClasses}">
                                                                                                        <tr>
                                                                                                            <td colspan="7"
                                                                                                                class="text-center py-4 text-muted">
                                                                                                                No
                                                                                                                classes
                                                                                                                available
                                                                                                                to
                                                                                                                register
                                                                                                                for
                                                                                                                right
                                                                                                                now.
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </c:if>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>


                                                        <%-- TAB: SCHEDULE --%>
                                                        <div id="dt-schedule" class="tab-panel">
                                                            <div class="timetable-toolbar">
                                                                <div>
                                                                    <h2 class="h4 fw-bold text-dark mb-1">Weekly Academic Timetable</h2>
                                                                    <p class="text-muted small mb-0">Overview of your enrolled courses, lecture shifts, and classroom locations</p>
                                                                </div>
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <div class="view-toggle-group" role="group" aria-label="Schedule View Switcher">
                                                                        <button type="button" class="view-toggle-btn active" id="btnStudentViewTimetable" onclick="setStudentScheduleView('grid')">
                                                                            <i class="bi bi-grid-3x3-gap-fill" aria-hidden="true"></i> Timetable Grid
                                                                        </button>
                                                                        <button type="button" class="view-toggle-btn" id="btnStudentViewTable" onclick="setStudentScheduleView('table')">
                                                                            <i class="bi bi-table" aria-hidden="true"></i> Table View
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <c:if test="${empty schedule}">
                                                                <div class="table-card text-center py-5">
                                                                    <i class="bi bi-calendar-x fs-1 text-muted d-block mb-3" aria-hidden="true"></i>
                                                                    <h5 class="fw-bold text-dark">No Enrolled Classes</h5>
                                                                    <p class="text-muted mb-0">You are not currently enrolled in any courses for this academic term.</p>
                                                                </div>
                                                            </c:if>

                                                            <c:if test="${not empty schedule}">
                                                                <c:set var="totalCreditsEnrolled" value="0" />
                                                                <c:forEach var="enr" items="${schedule}">
                                                                    <c:set var="totalCreditsEnrolled" value="${totalCreditsEnrolled + enr.credits}" />
                                                                </c:forEach>
                                                                <c:set var="schedAcademicYear" value="2026-2027" />
                                                                <c:set var="schedTermName" value="Fall Term" />
                                                                <c:forEach var="enr" items="${schedule}" begin="0" end="0">
                                                                    <c:if test="${not empty enr.academicYear}">
                                                                        <c:set var="schedAcademicYear" value="${enr.academicYear}" />
                                                                    </c:if>
                                                                    <c:if test="${not empty enr.termName}">
                                                                        <c:set var="schedTermName" value="${enr.termName}" />
                                                                    </c:if>
                                                                </c:forEach>

                                                                <div class="timetable-stats-bar">
                                                                    <div class="tt-stat-chip">
                                                                        <div class="tt-stat-icon" style="background:#eff6ff; color:#2563eb;">
                                                                            <i class="bi bi-journal-bookmark-fill"></i>
                                                                        </div>
                                                                        <div class="tt-stat-info">
                                                                            <span class="tt-stat-label">Enrolled Courses</span>
                                                                            <span class="tt-stat-val">${schedule.size()}</span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="tt-stat-chip">
                                                                        <div class="tt-stat-icon" style="background:#f0fdf4; color:#16a34a;">
                                                                            <i class="bi bi-mortarboard-fill"></i>
                                                                        </div>
                                                                        <div class="tt-stat-info">
                                                                            <span class="tt-stat-label">Total Credits</span>
                                                                            <span class="tt-stat-val">${totalCreditsEnrolled} <span style="font-size:0.75rem; font-weight:600; color:#64748b;">Credits</span></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="tt-stat-chip">
                                                                        <div class="tt-stat-icon" style="background:#fdf4ff; color:#a855f7;">
                                                                            <i class="bi bi-clock-history"></i>
                                                                        </div>
                                                                        <div class="tt-stat-info">
                                                                            <span class="tt-stat-label">Term & Year</span>
                                                                            <span class="tt-stat-val" style="font-size:0.95rem;">${schedTermName} &bull; ${schedAcademicYear}</span>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- VIEW 1: TIMETABLE GRID -->
                                                                <div id="studentTimetableView" class="timetable-card mb-4">
                                                                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                                                                        <div class="d-flex align-items-center gap-2">
                                                                            <span class="badge bg-light border text-secondary px-3 py-2 rounded-pill small fw-semibold">
                                                                                <i class="bi bi-calendar-week me-1 text-primary"></i> Weekly Academic Matrix
                                                                            </span>
                                                                        </div>
                                                                        <div class="d-flex align-items-center gap-2 flex-wrap" id="studentTimetableDayFilterGroup"></div>
                                                                    </div>

                                                                    <div class="timetable-scroll">
                                                                        <div id="studentTimetableGridContainer"></div>
                                                                    </div>
                                                                </div>

                                                                <!-- VIEW 2: TABLE VIEW (PRESERVED) -->
                                                                <div id="studentScheduleListView" style="display: none;">
                                                                    <div class="table-card">
                                                                        <div class="tc-header">
                                                                            <h3>My Current Schedule</h3>
                                                                        </div>
                                                                        <div class="tc-table-wrap">
                                                                            <table class="tc-table">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>Term</th>
                                                                                        <th>Course</th>
                                                                                        <th>Professor</th>
                                                                                        <th>Schedule</th>
                                                                                        <th>Room</th>
                                                                                        <th>Status</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <c:forEach var="enrollment" items="${schedule}">
                                                                                        <tr>
                                                                                            <td><span class="tc-badge purple">${enrollment.termName}</span></td>
                                                                                            <td>
                                                                                                <div class="fw-bold text-dark">${enrollment.courseCode}</div>
                                                                                                <div class="small text-muted">${enrollment.courseTitle}</div>
                                                                                            </td>
                                                                                            <td>${enrollment.professorName}</td>
                                                                                            <td>
                                                                                                <div class="fw-bold">${enrollment.sessionShift}</div>
                                                                                                <div class="small text-muted">${enrollment.daysOfWeek}</div>
                                                                                            </td>
                                                                                            <td><span class="tc-badge info"><i class="bi bi-geo-alt-fill me-1"></i>${enrollment.room}</span></td>
                                                                                            <td><span class="tc-badge success">Enrolled</span></td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                                                        <%-- TAB: TRANSCRIPT --%>
                                                                                        <div id="dt-transcript"
                                                                                            class="tab-panel">
                                                                                            <div class="table-card">
                                                                                                <div class="tc-header">
                                                                                                    <h3>Academic
                                                                                                        Transcript</h3>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="tc-table-wrap">
                                                                                                    <table
                                                                                                        class="tc-table">
                                                                                                        <thead>
                                                                                                            <tr>
                                                                                                                <th>Term
                                                                                                                </th>
                                                                                                                <th>Course
                                                                                                                </th>
                                                                                                                <th>Credits
                                                                                                                </th>
                                                                                                                <th>Total
                                                                                                                    Score
                                                                                                                </th>
                                                                                                                <th>Letter
                                                                                                                    Grade
                                                                                                                </th>
                                                                                                                <th>GPA
                                                                                                                    Points
                                                                                                                </th>
                                                                                                            </tr>
                                                                                                        </thead>
                                                                                                        <tbody>
                                                                                                            <c:forEach
                                                                                                                var="grade"
                                                                                                                items="${grades}">
                                                                                                                <tr>
                                                                                                                    <td><span
                                                                                                                            class="tc-badge purple">${grade.termName}</span>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <div
                                                                                                                            class="fw-bold text-dark">
                                                                                                                            ${grade.courseCode}
                                                                                                                        </div>
                                                                                                                        <div
                                                                                                                            class="small text-muted">
                                                                                                                            ${grade.courseTitle}
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                    <td
                                                                                                                        class="fw-bold">
                                                                                                                        ${grade.credits}
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <c:choose>
                                                                                                                            <c:when
                                                                                                                                test="${grade.totalScore > 0}">
                                                                                                                                ${grade.totalScore}%
                                                                                                                            </c:when>
                                                                                                                            <c:otherwise>
                                                                                                                                <span
                                                                                                                                    class="text-muted small">Pending</span>
                                                                                                                            </c:otherwise>
                                                                                                                        </c:choose>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <c:choose>
                                                                                                                            <c:when
                                                                                                                                test="${grade.letterGrade == 'A'}">
                                                                                                                                <span
                                                                                                                                    class="tc-badge success">A</span>
                                                                                                                            </c:when>
                                                                                                                            <c:when
                                                                                                                                test="${grade.letterGrade == 'F'}">
                                                                                                                                <span
                                                                                                                                    class="tc-badge warning">F</span>
                                                                                                                            </c:when>
                                                                                                                            <c:when
                                                                                                                                test="${grade.letterGrade != 'N/A'}">
                                                                                                                                <span
                                                                                                                                    class="tc-badge info">${grade.letterGrade}</span>
                                                                                                                            </c:when>
                                                                                                                            <c:otherwise>
                                                                                                                                <span
                                                                                                                                    class="text-muted small">-</span>
                                                                                                                            </c:otherwise>
                                                                                                                        </c:choose>
                                                                                                                    </td>
                                                                                                                    <td
                                                                                                                        class="fw-bold text-dark">
                                                                                                                        <c:choose>
                                                                                                                            <c:when
                                                                                                                                test="${grade.letterGrade != 'N/A'}">
                                                                                                                                ${grade.gpaPoint}
                                                                                                                            </c:when>
                                                                                                                            <c:otherwise>
                                                                                                                                -
                                                                                                                            </c:otherwise>
                                                                                                                        </c:choose>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </c:forEach>
                                                                                                            <c:if
                                                                                                                test="${empty grades}">
                                                                                                                <tr>
                                                                                                                    <td colspan="6"
                                                                                                                        class="text-center py-4 text-muted">
                                                                                                                        No
                                                                                                                        grades
                                                                                                                        recorded
                                                                                                                        yet.
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </c:if>
                                                                                                        </tbody>
                                                                                                    </table>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <%-- TAB: SETTINGS --%>
                                                                                            <div id="dt-settings"
                                                                                                class="tab-panel">
                                                                                                <div class="table-card"
                                                                                                    style="max-width: 600px;">
                                                                                                    <h3 class="mb-4">
                                                                                                        Account Settings
                                                                                                    </h3>

                                                                                                    <div
                                                                                                        class="d-flex align-items-center gap-4 mb-4 pb-4 border-bottom">
                                                                                                        <div class="user-avatar"
                                                                                                            style="width:80px;height:80px;">
                                                                                                            <c:choose>
                                                                                                                <c:when
                                                                                                                    test="${user.gender == 'FEMALE'}">
                                                                                                                    <img src="${pageContext.request.contextPath}/static/images/default_female.svg"
                                                                                                                        alt="Avatar">
                                                                                                                </c:when>
                                                                                                                <c:otherwise>
                                                                                                                    <img src="${pageContext.request.contextPath}/static/images/default_male.svg"
                                                                                                                        alt="Avatar">
                                                                                                                </c:otherwise>
                                                                                                            </c:choose>
                                                                                                        </div>
                                                                                                        <div>
                                                                                                            <h4
                                                                                                                class="mb-1 fw-bold">
                                                                                                                ${user.fullName}
                                                                                                            </h4>
                                                                                                            <p
                                                                                                                class="text-muted mb-0">
                                                                                                                ${user.email}
                                                                                                            </p>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <h5
                                                                                                        class="fw-bold mb-3">
                                                                                                        Security
                                                                                                        (Two-Factor
                                                                                                        Authentication)
                                                                                                    </h5>
                                                                                                    <div
                                                                                                        class="d-flex justify-content-between align-items-center p-3 bg-light rounded-4 mb-3">
                                                                                                        <div>
                                                                                                            <div
                                                                                                                class="fw-bold text-dark mb-1">
                                                                                                                Email
                                                                                                                OTP
                                                                                                                Verification
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="small text-muted">
                                                                                                                Require
                                                                                                                an OTP
                                                                                                                sent to
                                                                                                                your
                                                                                                                email
                                                                                                                when
                                                                                                                logging
                                                                                                                in.
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <form
                                                                                                            action="${pageContext.request.contextPath}/auth/update-2fa"
                                                                                                            method="POST"
                                                                                                            class="m-0">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="redirect"
                                                                                                                value="/student/dashboard?tab=settings">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="twoFactorEnabled"
                                                                                                                value="${!user.twoFactorEnabled}">
                                                                                                            <c:choose>
                                                                                                                <c:when
                                                                                                                    test="${user.twoFactorEnabled}">
                                                                                                                    <button
                                                                                                                        type="submit"
                                                                                                                        class="btn btn-sm btn-danger rounded-pill px-4 fw-bold">Disable</button>
                                                                                                                </c:when>
                                                                                                                <c:otherwise>
                                                                                                                    <button
                                                                                                                        type="submit"
                                                                                                                        class="btn btn-sm btn-success rounded-pill px-4 fw-bold">Enable</button>
                                                                                                                </c:otherwise>
                                                                                                            </c:choose>
                                                                                                        </form>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                    </c:otherwise>
                                                                </c:choose>
                                                    </main>

                                                    <script>
                                                        function switchDesktopTab(tabId, btnElement) {
                                                            // Update active button
                                                            const buttons = document.querySelectorAll('.sidebar-nav button');
                                                            buttons.forEach(btn => btn.classList.remove('active'));
                                                            if (btnElement) btnElement.classList.add('active');

                                                            // Show corresponding panel
                                                            const panels = document.querySelectorAll('.desktop-app-container .tab-panel');
                                                            panels.forEach(panel => panel.classList.remove('active'));

                                                            const targetPanel = document.getElementById('dt-' + tabId);
                                                            if (targetPanel) targetPanel.classList.add('active');

                                                            if (tabId === 'schedule' && typeof renderStudentWeeklyTimetable === 'function') {
                                                                renderStudentWeeklyTimetable();
                                                            }

                                                            try {
                                                                const url = new URL(window.location);
                                                                url.searchParams.set('tab', tabId);
                                                                window.history.replaceState({}, '', url);
                                                            } catch (e) {}
                                                        }
                                                    </script>
                                        </div>


                                        <%--==================================================================--%>
                                            <%-- MOBILE VIEW (< 768px) --%>
                                                <%--==================================================================--%>
                                                    <div class="d-block d-md-none mobile-app-container">

                                                        <c:if test="${param.twoFactorUpdated == 'true'}">
                                                            <div class="alert alert-success alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small shadow-sm">
                                                                <i class="bi bi-shield-check me-1"></i>2FA <strong>enabled</strong>.
                                                                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${param.twoFactorUpdated == 'false'}">
                                                            <div class="alert alert-info alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small shadow-sm">
                                                                <i class="bi bi-shield-slash me-1"></i>2FA <strong>disabled</strong>.
                                                                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${not empty successMessage}">
                                                            <div class="alert alert-success alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small shadow-sm">
                                                                <i class="bi bi-check-circle-fill me-1"></i>${successMessage}
                                                                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${not empty errorMessage}">
                                                            <div class="alert alert-danger alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small shadow-sm">
                                                                <i class="bi bi-exclamation-triangle-fill me-1"></i>${errorMessage}
                                                                <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
                                                            </div>
                                                        </c:if>

                                                        <c:choose>
                                                            <c:when test="${empty user.studentSchoolId}">
                                                                <div class="card border-0 shadow-sm rounded-4 p-4 text-center my-4 bg-white">
                                                                    <i class="bi bi-building text-primary mb-3" style="font-size:3rem;"></i>
                                                                    <h4 class="fw-bold mb-2">Welcome to UniTRS</h4>
                                                                    <p class="text-muted small mb-4">Please select your academic school to get started.</p>
                                                                    <form action="${pageContext.request.contextPath}/student/dashboard" method="post">
                                                                        <input type="hidden" name="action" value="selectSchool">
                                                                        <div class="mb-3 text-start">
                                                                            <label class="form-label small fw-bold" for="mobileSelectSchool">Select School</label>
                                                                            <select class="form-select rounded-3" id="mobileSelectSchool" name="schoolId" required>
                                                                                <option value="" selected disabled>-- Choose a School --</option>
                                                                                <c:forEach var="school" items="${schools}">
                                                                                    <option value="${school.id}">${school.schoolName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <button type="submit" class="btn btn-primary w-100 rounded-3 py-2 fw-semibold">Continue</button>
                                                                    </form>
                                                                </div>
                                                            </c:when>

                                                            <c:otherwise>

                                                                <%-- Top Bar --%>
                                                                <header class="mobile-top-bar" role="banner">
                                                                    <div class="mobile-user-info">
                                                                        <div class="mobile-avatar-frame" aria-hidden="true">
                                                                            <c:choose>
                                                                                <c:when test="${user.gender == 'FEMALE'}">
                                                                                    <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Student Avatar">
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Student Avatar">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div>
                                                                            <div class="mobile-user-greeting">Hello, ${user.fullName}</div>
                                                                            <span class="mobile-badge-pill">
                                                                                <i class="bi bi-mortarboard-fill text-primary" style="font-size:0.68rem;"></i>
                                                                                ${not empty studentSchool ? studentSchool.schoolName : 'UniTRS Student'}
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                    <button class="mobile-top-action-btn" type="button" data-bs-toggle="modal" data-bs-target="#mobileSecurityModal" aria-label="Notifications and Security Settings">
                                                                        <i class="bi bi-bell"></i>
                                                                        <span class="btn-badge-dot"></span>
                                                                    </button>
                                                                </header>

                                                                <%--===== HOME SUB-VIEW =====--%>
                                                                <section id="mobile-view-home" class="mobile-sub-view active" role="tabpanel" aria-labelledby="dock-tab-home">

                                                                    <%-- 7-Day Interactive Date Strip --%>
                                                                    <div class="date-strip-section">
                                                                        <div class="d-flex justify-content-between align-items-center mb-2 px-1">
                                                                            <span class="small fw-bold text-muted text-uppercase" style="letter-spacing:0.6px;font-size:0.7rem;">
                                                                                <i class="bi bi-calendar2-week me-1 text-primary"></i>Weekly Schedule
                                                                            </span>
                                                                            <span class="small text-muted" style="font-size:0.7rem;">Select day</span>
                                                                        </div>
                                                                        <div class="mobile-date-strip" id="mobileDateStrip" role="tablist" aria-label="Select day of week">
                                                                            <!-- Populated by JS -->
                                                                        </div>
                                                                    </div>

                                                                    <%-- Next Class Today Hero Card --%>
                                                                    <div class="mobile-hero-banner" role="region" aria-label="Next Upcoming Class">
                                                                        <div class="hero-avatar-box" aria-hidden="true">
                                                                            <c:choose>
                                                                                <c:when test="${user.gender == 'FEMALE'}">
                                                                                    <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Student">
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Student">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div class="hero-content">
                                                                            <div class="hero-label">
                                                                                <span class="pulse-indicator"></span> NEXT CLASS TODAY
                                                                            </div>
                                                                            <c:set var="todayHeroSet" value="false" />
                                                                            <c:forEach var="enrollment" items="${schedule}">
                                                                                <c:if test="${todayHeroSet == 'false'}">
                                                                                    <div class="hero-title" title="${enrollment.courseCode}: ${enrollment.courseTitle}">
                                                                                        ${enrollment.courseCode}: ${enrollment.courseTitle}
                                                                                    </div>
                                                                                    <div class="hero-meta-row">
                                                                                        <i class="bi bi-geo-alt-fill text-warning"></i> Room ${enrollment.room}
                                                                                        &bull; ${enrollment.sessionShift}
                                                                                    </div>
                                                                                    <div class="hero-pills">
                                                                                        <span class="hero-pill-badge"><i class="bi bi-calendar3"></i> ${enrollment.daysOfWeek}</span>
                                                                                        <span class="hero-pill-badge"><i class="bi bi-person"></i> ${enrollment.professorName}</span>
                                                                                        <span class="hero-pill-badge" style="background:rgba(34,197,94,0.2);color:#4ade80;"><i class="bi bi-check2"></i> Enrolled</span>
                                                                                    </div>
                                                                                    <c:set var="todayHeroSet" value="true" />
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:if test="${empty schedule}">
                                                                                <div class="hero-title">No Classes Enrolled</div>
                                                                                <div class="hero-meta-row">
                                                                                    <i class="bi bi-info-circle-fill"></i> Term registration is currently open
                                                                                </div>
                                                                                <div class="mt-2">
                                                                                    <button type="button" class="btn btn-sm btn-light rounded-pill px-3 fw-bold text-primary" onclick="switchMobileTab('courses')">Explore Courses</button>
                                                                                </div>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>

                                                                    <%-- Academic Progress Swipeable Cards --%>
                                                                    <div class="section-header-wrap">
                                                                        <h2 class="mobile-section-heading">Academic Progress</h2>
                                                                        <span class="mobile-section-badge">${schedule.size()} Courses</span>
                                                                    </div>
                                                                    <div class="progress-swiper-wrap">
                                                                        <div class="progress-swiper" id="progressSwiper" role="region" aria-label="Course score progress carousel">
                                                                            <c:forEach var="enrollment" items="${schedule}">
                                                                                <c:set var="enrollGrade" value="${gradeMap[enrollment.id]}" />
                                                                                <div class="progress-card-item">
                                                                                    <div class="pc-header">
                                                                                        <span class="pc-course-code">${enrollment.courseCode}</span>
                                                                                        <div class="text-end">
                                                                                            <div class="pc-gpa-label">GPA Points</div>
                                                                                            <div class="pc-gpa-badge">
                                                                                                <c:choose>
                                                                                                    <c:when test="${enrollGrade != null && enrollGrade.gpaPoint > 0}">
                                                                                                        ${enrollGrade.gpaPoint}
                                                                                                    </c:when>
                                                                                                    <c:otherwise>&mdash;</c:otherwise>
                                                                                                </c:choose>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="pc-title">${enrollment.courseTitle}</div>

                                                                                    <div class="pc-score-row">
                                                                                        <%-- Attendance --%>
                                                                                        <div class="pc-score-item">
                                                                                            <span class="pc-score-label">Attendance</span>
                                                                                            <div class="pc-score-bar-wrap">
                                                                                                <c:set var="attVal" value="${enrollGrade != null ? enrollGrade.attendanceScore : 0}" />
                                                                                                <div class="pc-score-bar" style="width:${attVal}%;background:linear-gradient(90deg, #10b981, #059669);"></div>
                                                                                            </div>
                                                                                            <span class="pc-score-val">${enrollGrade != null && enrollGrade.attendanceScore > 0 ? enrollGrade.attendanceScore : '&mdash;'}</span>
                                                                                        </div>
                                                                                        <%-- Assignment --%>
                                                                                        <div class="pc-score-item">
                                                                                            <span class="pc-score-label">Assignment</span>
                                                                                            <div class="pc-score-bar-wrap">
                                                                                                <c:set var="asgVal" value="${enrollGrade != null ? enrollGrade.assignmentScore : 0}" />
                                                                                                <div class="pc-score-bar" style="width:${asgVal}%;background:linear-gradient(90deg, #3b82f6, #2563eb);"></div>
                                                                                            </div>
                                                                                            <span class="pc-score-val">${enrollGrade != null && enrollGrade.assignmentScore > 0 ? enrollGrade.assignmentScore : '&mdash;'}</span>
                                                                                        </div>
                                                                                        <%-- Midterm --%>
                                                                                        <div class="pc-score-item">
                                                                                            <span class="pc-score-label">Midterm</span>
                                                                                            <div class="pc-score-bar-wrap">
                                                                                                <c:set var="midVal" value="${enrollGrade != null ? enrollGrade.midtermScore : 0}" />
                                                                                                <div class="pc-score-bar" style="width:${midVal}%;background:linear-gradient(90deg, #f59e0b, #d97706);"></div>
                                                                                            </div>
                                                                                            <span class="pc-score-val">${enrollGrade != null && enrollGrade.midtermScore > 0 ? enrollGrade.midtermScore : '&mdash;'}</span>
                                                                                        </div>
                                                                                        <%-- Final Exam --%>
                                                                                        <div class="pc-score-item">
                                                                                            <span class="pc-score-label">Final Exam</span>
                                                                                            <div class="pc-score-bar-wrap">
                                                                                                <c:set var="finVal" value="${enrollGrade != null ? enrollGrade.finalScore : 0}" />
                                                                                                <div class="pc-score-bar" style="width:${finVal}%;background:linear-gradient(90deg, #8b5cf6, #7c3aed);"></div>
                                                                                            </div>
                                                                                            <span class="pc-score-val">${enrollGrade != null && enrollGrade.finalScore > 0 ? enrollGrade.finalScore : '&mdash;'}</span>
                                                                                        </div>
                                                                                    </div>

                                                                                    <div class="pc-footer">
                                                                                        <div>
                                                                                            <div class="pc-gpa-label">Letter Grade</div>
                                                                                            <c:choose>
                                                                                                <c:when test="${enrollGrade != null && enrollGrade.letterGrade == 'A'}">
                                                                                                    <div class="pc-letter grade-A">A</div>
                                                                                                </c:when>
                                                                                                <c:when test="${enrollGrade != null && (enrollGrade.letterGrade == 'B' || enrollGrade.letterGrade == 'B+' || enrollGrade.letterGrade == 'B-')}">
                                                                                                    <div class="pc-letter grade-B">${enrollGrade.letterGrade}</div>
                                                                                                </c:when>
                                                                                                <c:when test="${enrollGrade != null && (enrollGrade.letterGrade == 'C' || enrollGrade.letterGrade == 'C+' || enrollGrade.letterGrade == 'C-')}">
                                                                                                    <div class="pc-letter grade-C">${enrollGrade.letterGrade}</div>
                                                                                                </c:when>
                                                                                                <c:when test="${enrollGrade != null && enrollGrade.letterGrade == 'F'}">
                                                                                                    <div class="pc-letter grade-F">F</div>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <div class="pc-letter grade-na">&mdash;</div>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </div>
                                                                                        <div class="pc-credits">
                                                                                            <strong>${enrollment.credits}</strong> Credits
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:forEach>

                                                                            <c:if test="${empty schedule}">
                                                                                <div class="progress-card-item text-center py-4">
                                                                                    <i class="bi bi-bar-chart-line fs-2 text-secondary mb-2 d-block"></i>
                                                                                    <div class="fw-bold small text-dark">No Enrolled Courses</div>
                                                                                    <p class="small text-muted mb-0">Enroll in courses to see your academic progress.</p>
                                                                                </div>
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="swipe-dots" id="swiperDots" aria-hidden="true"></div>
                                                                    </div>

                                                                    <%-- Day Filtered Schedule Feed --%>
                                                                    <div class="section-header-wrap">
                                                                        <h2 class="mobile-section-heading" id="homeScheduleTitle">This Term's Courses</h2>
                                                                        <span class="mobile-section-badge" id="homeScheduleCount">${schedule.size()} Enrolled</span>
                                                                    </div>

                                                                    <c:choose>
                                                                        <c:when test="${not empty schedule}">
                                                                            <div id="homeScheduleContainer">
                                                                                <c:forEach var="enrollment" items="${schedule}">
                                                                                    <c:set var="enrollGrade" value="${gradeMap[enrollment.id]}" />
                                                                                    <div class="mobile-course-card home-schedule-card" data-days="${enrollment.daysOfWeek}" onclick="openCourseModal('${enrollment.id}')" role="button" tabindex="0" onkeydown="if(event.key==='Enter'||event.key===' ')openCourseModal('${enrollment.id}')" aria-label="View details for ${enrollment.courseCode}: ${enrollment.courseTitle}">
                                                                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                                                                            <span class="mobile-card-code-badge">${enrollment.courseCode}</span>
                                                                                            <c:choose>
                                                                                                <c:when test="${enrollGrade != null && enrollGrade.letterGrade != 'N/A' && not empty enrollGrade.letterGrade}">
                                                                                                    <span class="badge ${enrollGrade.letterGrade == 'A' ? 'bg-success' : (enrollGrade.letterGrade == 'F' ? 'bg-danger' : 'bg-primary')} bg-opacity-15 text-${enrollGrade.letterGrade == 'A' ? 'success' : (enrollGrade.letterGrade == 'F' ? 'danger' : 'primary')} fw-bold px-2 py-1 rounded-pill">${enrollGrade.letterGrade}</span>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <span class="badge bg-light border text-muted fw-normal px-2 py-1 rounded-pill">In Progress</span>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </div>
                                                                                        <div class="mobile-card-title">${enrollment.courseTitle}</div>
                                                                                        <div class="mobile-card-meta">
                                                                                            <div class="mobile-card-meta-row">
                                                                                                <i class="bi bi-clock text-primary"></i> ${enrollment.sessionShift} &bull; ${enrollment.daysOfWeek}
                                                                                            </div>
                                                                                            <div class="mobile-card-meta-row">
                                                                                                <i class="bi bi-geo-alt text-primary"></i> Room ${enrollment.room} &bull; <i class="bi bi-person text-secondary ms-1"></i> ${enrollment.professorName}
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="mobile-card-footer">
                                                                                            <span class="small text-muted" style="font-size:0.72rem;"><i class="bi bi-chevron-right me-1 text-primary"></i>Tap for scores &amp; attendance</span>
                                                                                            <span class="badge bg-light border text-secondary rounded-pill" style="font-size:0.7rem;">${enrollment.credits} Credits</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:forEach>
                                                                                <div id="homeScheduleEmpty" class="mobile-course-card text-center py-4" style="display:none;">
                                                                                    <i class="bi bi-calendar-x fs-2 text-secondary mb-2 d-block"></i>
                                                                                    <div class="fw-bold small text-dark mb-1" id="homeScheduleEmptyText">No classes scheduled</div>
                                                                                    <div class="small text-muted">Enjoy your free time!</div>
                                                                                </div>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="mobile-course-card text-center py-4">
                                                                                <i class="bi bi-calendar-x fs-2 text-secondary mb-2 d-block"></i>
                                                                                <div class="fw-bold small text-dark mb-1">No Courses Enrolled</div>
                                                                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-4 mt-2" onclick="switchMobileTab('courses')">Browse Courses</button>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </section>

                                                                <%--===== SCHEDULE SUB-VIEW =====--%>
                                                                <section id="mobile-view-schedule" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-schedule">
                                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                                        <div>
                                                                            <h2 class="mobile-section-heading mb-0">Class Schedule</h2>
                                                                            <span class="text-muted" style="font-size:0.75rem;">7-Day Weekly Timetable</span>
                                                                        </div>
                                                                        <span class="mobile-section-badge" id="scheduleTabCount">${schedule.size()} Enrolled</span>
                                                                    </div>

                                                                    <%-- Day Filter Pills for Schedule --%>
                                                                    <div class="schedule-day-filter-strip" id="scheduleTabFilterStrip" role="tablist" aria-label="Schedule Day Filter">
                                                                        <button type="button" class="schedule-filter-pill active" onclick="filterScheduleTabView('all', this)">All Week</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('mon', this)">Mon</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('tue', this)">Tue</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('wed', this)">Wed</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('thu', this)">Thu</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('fri', this)">Fri</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('sat', this)">Sat</button>
                                                                        <button type="button" class="schedule-filter-pill" onclick="filterScheduleTabView('sun', this)">Sun</button>
                                                                    </div>

                                                                    <c:choose>
                                                                        <c:when test="${not empty schedule}">
                                                                            <div id="scheduleTabListContainer">
                                                                                <c:forEach var="enrollment" items="${schedule}">
                                                                                    <div class="mobile-course-card schedule-tab-card" data-days="${enrollment.daysOfWeek}" onclick="openCourseModal('${enrollment.id}')" role="button" tabindex="0" onkeydown="if(event.key==='Enter'||event.key===' ')openCourseModal('${enrollment.id}')" aria-label="View details for ${enrollment.courseCode}: ${enrollment.courseTitle}">
                                                                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                                                                            <div>
                                                                                                <span class="mobile-card-code-badge me-1">${enrollment.courseCode}</span>
                                                                                                <span class="badge bg-secondary bg-opacity-10 text-secondary">${enrollment.termName}</span>
                                                                                            </div>
                                                                                            <span class="badge bg-light border text-dark fw-bold">${enrollment.sessionShift}</span>
                                                                                        </div>
                                                                                        <div class="mobile-card-title">${enrollment.courseTitle}</div>
                                                                                        <div class="mobile-card-meta">
                                                                                            <div class="mobile-card-meta-row">
                                                                                                <i class="bi bi-calendar3 text-primary"></i> ${enrollment.daysOfWeek}
                                                                                            </div>
                                                                                            <div class="mobile-card-meta-row">
                                                                                                <i class="bi bi-door-open text-primary"></i> Room ${enrollment.room} &bull; <i class="bi bi-person text-secondary ms-1"></i> ${enrollment.professorName}
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="mobile-card-footer">
                                                                                            <span class="small text-muted" style="font-size:0.72rem;"><i class="bi bi-chevron-right me-1 text-primary"></i>Tap for scores &amp; attendance</span>
                                                                                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-2 py-1" style="font-size:0.7rem;"><i class="bi bi-check2 me-1"></i>Enrolled</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:forEach>
                                                                                <div id="scheduleTabEmpty" class="mobile-course-card text-center py-4" style="display:none;">
                                                                                    <i class="bi bi-calendar-x fs-2 text-secondary mb-2 d-block"></i>
                                                                                    <div class="fw-bold small text-dark mb-1" id="scheduleTabEmptyText">No classes on this day</div>
                                                                                    <div class="small text-muted">Enjoy your time off!</div>
                                                                                </div>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="text-center py-5 text-muted">
                                                                                <i class="bi bi-calendar-x fs-1 text-secondary mb-2 d-block"></i>
                                                                                <div class="fw-bold">No Classes Enrolled</div>
                                                                                <button type="button" class="btn btn-sm btn-primary rounded-pill px-4 mt-2" onclick="switchMobileTab('courses')">Go to Registration</button>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </section>

                                                                <%--===== COURSES CATALOG SUB-VIEW =====--%>
                                                                <section id="mobile-view-courses" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-courses">
                                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                                        <div>
                                                                            <h2 class="mobile-section-heading mb-0">Course Registration</h2>
                                                                            <span class="text-muted" style="font-size:0.75rem;">Available for ${studentSchool.schoolName}</span>
                                                                        </div>
                                                                        <span class="mobile-section-badge" id="mobileCourseCountBadge">${availableClasses.size()} Classes</span>
                                                                    </div>

                                                                    <div class="input-group mb-3 shadow-sm rounded-4 overflow-hidden border bg-white">
                                                                        <span class="input-group-text bg-white border-0 text-muted ps-3"><i class="bi bi-search"></i></span>
                                                                        <input type="text" id="mobileCourseSearchInput" class="form-control border-0 py-2" placeholder="Search code, title, professor..." oninput="filterMobileCourses(this.value)" aria-label="Search course catalog">
                                                                        <button type="button" class="btn bg-white border-0 text-muted pe-3" id="clearMobileCourseSearchBtn" style="display:none;" onclick="clearMobileCourseSearch()" aria-label="Clear search">
                                                                            <i class="bi bi-x-circle-fill"></i>
                                                                        </button>
                                                                    </div>

                                                                    <div id="mobileCourseList">
                                                                        <c:forEach var="section" items="${availableClasses}">
                                                                            <div class="mobile-course-card mobile-course-item" style="cursor:default;">
                                                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                                                    <div>
                                                                                        <span class="mobile-card-code-badge me-1">${section.courseCode}</span>
                                                                                        <span class="badge bg-secondary bg-opacity-10 text-secondary">${section.credits} Credits</span>
                                                                                    </div>
                                                                                    <span class="badge bg-light text-dark border">${section.termName}</span>
                                                                                </div>
                                                                                <h3 class="mobile-card-title mb-2" style="font-size:0.95rem;">${section.courseTitle}</h3>
                                                                                <div class="mobile-card-meta mb-3">
                                                                                    <div class="mobile-card-meta-row">
                                                                                        <i class="bi bi-person text-primary"></i> ${section.professorName}
                                                                                    </div>
                                                                                    <div class="mobile-card-meta-row">
                                                                                        <i class="bi bi-clock text-primary"></i> ${section.sessionShift} (${section.daysOfWeek})
                                                                                    </div>
                                                                                    <div class="mobile-card-meta-row">
                                                                                        <i class="bi bi-door-open text-primary"></i> Room ${section.roomName}
                                                                                    </div>
                                                                                </div>

                                                                                <%-- Seat Capacity Meter --%>
                                                                                <c:set var="capRatio" value="${section.roomCapacity > 0 ? (section.enrolledCount * 100 / section.roomCapacity) : 0}" />
                                                                                <div class="mb-3">
                                                                                    <div class="d-flex justify-content-between small text-muted" style="font-size:0.72rem;">
                                                                                        <span><i class="bi bi-people-fill me-1"></i>Seat Capacity</span>
                                                                                        <span class="fw-bold ${section.enrolledCount >= section.roomCapacity ? 'text-danger' : (capRatio >= 75 ? 'text-warning' : 'text-success')}">
                                                                                            ${section.enrolledCount} / ${section.roomCapacity} seats (${Math.round(capRatio)}%)
                                                                                        </span>
                                                                                    </div>
                                                                                    <div class="capacity-bar-wrap">
                                                                                        <div class="capacity-bar" style="width:${capRatio > 100 ? 100 : capRatio}%;background:${section.enrolledCount >= section.roomCapacity ? '#ef4444' : (capRatio >= 75 ? '#f59e0b' : '#10b981')};"></div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                                                                                    <c:set var="isEnrolledM" value="false" />
                                                                                    <c:forEach var="myClass" items="${schedule}">
                                                                                        <c:if test="${myClass.courseCode == section.courseCode}">
                                                                                            <c:set var="isEnrolledM" value="true" />
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <span class="small text-muted" style="font-size:0.75rem;">Status</span>
                                                                                    <c:choose>
                                                                                        <c:when test="${isEnrolledM}">
                                                                                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3 py-2 small fw-bold">
                                                                                                <i class="bi bi-check2 me-1"></i> Enrolled
                                                                                            </span>
                                                                                        </c:when>
                                                                                        <c:when test="${section.enrolledCount >= section.roomCapacity}">
                                                                                            <button type="button" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-2 disabled" style="min-height:44px;">Class Full</button>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <button type="button" class="btn btn-sm btn-primary rounded-pill px-4 py-2 fw-bold" style="min-height:44px;" data-section-id="${section.id}" data-course-code="${section.courseCode}" data-course-title="${section.courseTitle}" data-professor-name="${section.professorName}" onclick="openEnrollConfirm(this.dataset.sectionId, this.dataset.courseCode, this.dataset.courseTitle, this.dataset.professorName, 'courses')">
                                                                                                <i class="bi bi-plus-lg me-1"></i> Enroll Now
                                                                                            </button>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </div>
                                                                            </div>
                                                                        </c:forEach>
                                                                        <div id="mobileCourseEmpty" class="text-center py-5 text-muted" style="display:none;">
                                                                            <i class="bi bi-search fs-1 text-secondary mb-2 d-block"></i>
                                                                            <div class="fw-bold">No Matching Courses</div>
                                                                            <p class="small">Try searching with a different course title or code.</p>
                                                                        </div>
                                                                        <c:if test="${empty availableClasses}">
                                                                            <div class="text-center py-5 text-muted">
                                                                                <i class="bi bi-journal-x fs-1 text-secondary mb-2 d-block"></i>
                                                                                <div class="fw-bold">No Classes Available</div>
                                                                                <p class="small">No classes currently open for registration in this term.</p>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </section>

                                                                <%--===== GRADES & TRANSCRIPT SUB-VIEW =====--%>
                                                                <section id="mobile-view-grades" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-grades">
                                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                                        <h2 class="mobile-section-heading mb-0">Academic Transcript</h2>
                                                                        <div class="bg-white border rounded-pill px-3 py-1 shadow-sm">
                                                                            <span class="small text-muted me-1">Term GPA:</span>
                                                                            <span class="fw-bold text-success">${termGpa}</span>
                                                                        </div>
                                                                    </div>

                                                                    <%-- GPA Summary Hero Card --%>
                                                                    <div class="grades-hero-card" role="region" aria-label="GPA and Degree Progress Summary">
                                                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                                                            <div>
                                                                                <div class="small text-white-50 text-uppercase fw-bold" style="letter-spacing:0.5px;">Cumulative GPA</div>
                                                                                <div class="fs-1 fw-bolder">${termGpa}</div>
                                                                            </div>
                                                                            <div>
                                                                                <c:choose>
                                                                                    <c:when test="${termGpa >= 3.5}">
                                                                                        <span class="grades-stat-chip"><i class="bi bi-award-fill text-warning"></i> Dean's List</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span class="grades-stat-chip"><i class="bi bi-check-circle-fill text-white"></i> Good Standing</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                        </div>
                                                                        <div>
                                                                            <div class="d-flex justify-content-between small text-white-50 mb-1" style="font-size:0.75rem;">
                                                                                <span>Earned Credits Progress</span>
                                                                                <span class="text-white fw-bold">${earnedCredits} / 60 Credits</span>
                                                                            </div>
                                                                            <div class="progress" style="height:6px;background:rgba(255,255,255,0.2);border-radius:99px;">
                                                                                <div class="progress-bar bg-white" style="width:${(earnedCredits / 60) * 100 > 100 ? 100 : (earnedCredits / 60) * 100}%;border-radius:99px;"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <c:choose>
                                                                        <c:when test="${not empty grades}">
                                                                            <c:forEach var="grade" items="${grades}">
                                                                                <div class="mobile-course-card" onclick="openCourseModal('${grade.enrollmentId}')" role="button" tabindex="0" onkeydown="if(event.key==='Enter'||event.key===' ')openCourseModal('${grade.enrollmentId}')" aria-label="View grade breakdown for ${grade.courseCode}: ${grade.courseTitle}">
                                                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                                                        <span class="badge bg-secondary bg-opacity-10 text-secondary">${grade.termName}</span>
                                                                                        <c:choose>
                                                                                            <c:when test="${grade.letterGrade == 'A' || grade.letterGrade == 'A-'}">
                                                                                                <span class="badge bg-success bg-opacity-15 text-success fw-bold px-2 py-1 rounded-pill">${grade.letterGrade}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${grade.letterGrade == 'B' || grade.letterGrade == 'B+' || grade.letterGrade == 'B-'}">
                                                                                                <span class="badge bg-primary bg-opacity-15 text-primary fw-bold px-2 py-1 rounded-pill">${grade.letterGrade}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${grade.letterGrade != 'N/A' && not empty grade.letterGrade}">
                                                                                                <span class="badge bg-warning bg-opacity-25 text-dark fw-bold px-2 py-1 rounded-pill">${grade.letterGrade}</span>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <span class="badge bg-light border text-muted px-2 py-1 rounded-pill">Pending</span>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                    <div class="mobile-card-code-badge d-inline-block mb-1">${grade.courseCode}</div>
                                                                                    <div class="mobile-card-title mb-2">${grade.courseTitle}</div>
                                                                                    <div class="d-flex justify-content-between align-items-center pt-2 border-top small text-muted" style="font-size:0.75rem;">
                                                                                        <span>Credits: <strong class="text-dark">${grade.credits}</strong></span>
                                                                                        <span>Score: <strong class="text-dark">${grade.totalScore > 0 ? grade.totalScore : '&mdash;'}</strong></span>
                                                                                        <span>GPA: <strong class="text-success">${grade.letterGrade != 'N/A' ? grade.gpaPoint : '&mdash;'}</strong></span>
                                                                                    </div>
                                                                                    <div class="mt-2 d-flex align-items-center gap-1" style="font-size:0.68rem;color:#94a3b8;">
                                                                                        <i class="bi bi-chevron-right text-primary"></i> Tap to view scores &amp; attendance
                                                                                    </div>
                                                                                </div>
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="text-center py-5 text-muted">
                                                                                <i class="bi bi-journal-x fs-1 text-secondary mb-2 d-block"></i>
                                                                                <div class="fw-bold">No Grades Available</div>
                                                                                <p class="small">Grades will appear once published by your course professors.</p>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </section>

                                                                <%--===== PROFILE SUB-VIEW =====--%>
                                                                <section id="mobile-view-profile" class="mobile-sub-view" role="tabpanel" aria-labelledby="dock-tab-profile">
                                                                    <h2 class="mobile-section-heading mb-3">Student Profile</h2>

                                                                    <%-- Digital University Student ID Card --%>
                                                                    <div class="student-id-card" role="region" aria-label="Digital Student ID Card">
                                                                        <div class="id-card-top">
                                                                            <div class="id-card-univ-title">
                                                                                <i class="bi bi-shield-fill-check me-1 text-primary"></i> UniTRS ACADEMIC ID
                                                                            </div>
                                                                            <span class="badge bg-success bg-opacity-25 text-white border border-success border-opacity-50 rounded-pill px-2 py-1" style="font-size:0.68rem;">ACTIVE 2024-25</span>
                                                                        </div>
                                                                        <div class="id-card-body">
                                                                            <div class="id-photo-box" aria-hidden="true">
                                                                                <img src="${pageContext.request.contextPath}/static/images/student_headshot.jpg" alt="Student Photo" onerror="this.src='https://ui-avatars.com/api/?name=${user.fullName}&background=1e293b&color=ffffff&bold=true'">
                                                                            </div>
                                                                            <div class="id-info-col">
                                                                                <div class="id-student-name">${user.fullName}</div>
                                                                                <div class="text-white-50 small mb-2" style="font-size:0.75rem;">${not empty user.major ? user.major : 'Undergraduate Student'}</div>
                                                                                <button type="button" class="id-number-pill border-0" onclick="copyStudentId('${user.formattedIdentifier}', this)" title="Click to copy ID" aria-label="Copy student ID ${user.formattedIdentifier}">
                                                                                    <i class="bi bi-copy"></i>
                                                                                    <span>${user.formattedIdentifier}</span>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                        <div class="id-card-barcode-row">
                                                                            <div class="barcode-mock" aria-hidden="true">
                                                                                <span style="width:3px;"></span><span style="width:1px;"></span><span style="width:4px;"></span><span style="width:2px;"></span><span style="width:1px;"></span><span style="width:3px;"></span><span style="width:5px;"></span><span style="width:2px;"></span><span style="width:1px;"></span><span style="width:4px;"></span><span style="width:2px;"></span><span style="width:3px;"></span><span style="width:1px;"></span><span style="width:4px;"></span>
                                                                            </div>
                                                                            <div class="text-white-50 small" style="font-size:0.7rem;font-family:monospace;">
                                                                                <i class="bi bi-qr-code me-1"></i>UniTRS VERIFIED
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <%-- Academic Details Card --%>
                                                                    <div class="mobile-course-card mb-3 p-3" style="cursor:default;">
                                                                        <div class="fw-bold small text-dark mb-3">
                                                                            <i class="bi bi-mortarboard me-2 text-primary"></i>Academic Details
                                                                        </div>
                                                                        <div class="d-flex justify-content-between py-2 border-bottom small">
                                                                            <span class="text-muted">School:</span>
                                                                            <span class="fw-semibold text-dark">${not empty studentSchool ? studentSchool.schoolName : 'Not Set'}</span>
                                                                        </div>
                                                                        <div class="d-flex justify-content-between py-2 border-bottom small">
                                                                            <span class="text-muted">Major / Program:</span>
                                                                            <span class="fw-semibold text-dark">${not empty user.major ? user.major : 'Undeclared'}</span>
                                                                        </div>
                                                                        <div class="d-flex justify-content-between py-2 border-bottom small">
                                                                            <span class="text-muted">Cumulative GPA:</span>
                                                                            <span class="fw-bold text-success">${termGpa}</span>
                                                                        </div>
                                                                        <div class="d-flex justify-content-between py-2 small">
                                                                            <span class="text-muted">Earned Credits:</span>
                                                                            <span class="fw-bold text-primary">${earnedCredits} Cr</span>
                                                                        </div>
                                                                    </div>

                                                                    <%-- Two-Factor Security Card --%>
                                                                    <div class="mobile-course-card mb-3 p-3" style="cursor:default;">
                                                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                                                            <div>
                                                                                <div class="fw-bold small text-dark">
                                                                                    <i class="bi bi-shield-lock me-2 text-primary"></i>Two-Factor Authentication
                                                                                </div>
                                                                                <div class="text-muted" style="font-size:0.72rem;">Email OTP security verification on login</div>
                                                                            </div>
                                                                            <span class="badge ${user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">${user.twoFactorEnabled ? 'Enabled' : 'Disabled'}</span>
                                                                        </div>
                                                                        <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="mt-3">
                                                                            <input type="hidden" name="redirect" value="/student/dashboard?tab=profile">
                                                                            <div class="input-group">
                                                                                <label class="input-group-text small bg-light" for="mobileTwoFactorSelect">Status</label>
                                                                                <select id="mobileTwoFactorSelect" name="twoFactorEnabled" class="form-select form-select-sm" onchange="this.form.submit()">
                                                                                    <option value="false" ${!user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                                                                                    <option value="true" ${user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                                                                                </select>
                                                                                <button type="submit" class="btn btn-sm btn-outline-primary">Save</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>

                                                                    <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger w-100 rounded-3 py-2 fw-semibold" style="min-height:44px;display:flex;align-items:center;justify-content:center;">
                                                                        <i class="bi bi-box-arrow-right me-2"></i>Sign Out
                                                                    </a>
                                                                </section>

                                                                <%-- Floating Island Bottom Navigation Dock --%>
                                                                <nav class="mobile-bottom-dock" role="navigation" aria-label="Mobile Navigation">
                                                                    <button type="button" class="dock-tab-btn active" id="dock-tab-home" data-tab="home" onclick="switchMobileTab('home')" role="tab" aria-selected="true" aria-controls="mobile-view-home">
                                                                        <i class="bi bi-house-door-fill"></i>
                                                                        <span>Home</span>
                                                                    </button>
                                                                    <button type="button" class="dock-tab-btn" id="dock-tab-schedule" data-tab="schedule" onclick="switchMobileTab('schedule')" role="tab" aria-selected="false" aria-controls="mobile-view-schedule">
                                                                        <i class="bi bi-calendar3"></i>
                                                                        <span>Schedule</span>
                                                                    </button>
                                                                    <button type="button" class="dock-tab-btn" id="dock-tab-courses" data-tab="courses" onclick="switchMobileTab('courses')" role="tab" aria-selected="false" aria-controls="mobile-view-courses">
                                                                        <i class="bi bi-journal-bookmark"></i>
                                                                        <span>Courses</span>
                                                                    </button>
                                                                    <button type="button" class="dock-tab-btn" id="dock-tab-grades" data-tab="grades" onclick="switchMobileTab('grades')" role="tab" aria-selected="false" aria-controls="mobile-view-grades">
                                                                        <i class="bi bi-mortarboard"></i>
                                                                        <span>Grades</span>
                                                                    </button>
                                                                    <button type="button" class="dock-tab-btn" id="dock-tab-profile" data-tab="profile" onclick="switchMobileTab('profile')" role="tab" aria-selected="false" aria-controls="mobile-view-profile">
                                                                        <i class="bi bi-person"></i>
                                                                        <span>Profile</span>
                                                                    </button>
                                                                </nav>

                                                                <%-- Toast Notification for Clipboard --%>
                                                                <div id="mobileToast" class="mobile-toast" role="status" aria-live="polite">
                                                                    <i class="bi bi-check2-circle text-success fs-6"></i>
                                                                    <span id="mobileToastText">Copied to clipboard!</span>
                                                                </div>

                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>            </div>


                                                    <%--==================================================================--%>
                                                        <%-- COURSE DETAIL MODAL SHEET (shared, filled via JS) --%>
                                                            <%--==================================================================--%>
                                                                <div class="course-modal-overlay d-md-none"
                                                                    id="courseModalOverlay"
                                                                    onclick="closeCourseModalOnOverlay(event)">
                                                                    <div class="course-modal-sheet"
                                                                        id="courseModalSheet">
                                                                        <div class="sheet-drag-handle"></div>
                                                                        <div class="sheet-header">
                                                                            <div class="sheet-header-code"
                                                                                id="sheetCourseCode">ITE 205</div>
                                                                            <div class="sheet-header-title"
                                                                                id="sheetCourseTitle">Database Systems
                                                                                Administration</div>
                                                                            <div class="sheet-header-meta"
                                                                                id="sheetCourseMeta"></div>
                                                                            <button type="button"
                                                                                class="btn btn-sm btn-light rounded-3 mt-3 w-100"
                                                                                onclick="closeCourseModal()"><i
                                                                                    class="bi bi-x me-1"></i>Close</button>
                                                                        </div>
                                                                        <div class="sheet-body">
                                                                            <div class="sheet-section-label">Score
                                                                                Breakdown</div>
                                                                            <div class="score-grid" id="sheetScoreGrid">
                                                                            </div>

                                                                            <div class="sheet-section-label mt-3">
                                                                                Overall</div>
                                                                            <div class="score-grid"
                                                                                id="sheetOverallGrid"></div>

                                                                            <div class="sheet-section-label mt-3">
                                                                                Attendance Record</div>
                                                                            <div id="sheetAttendanceSummary"
                                                                                class="att-summary"></div>
                                                                            <div class="attendance-list"
                                                                                id="sheetAttendanceList"></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="modal fade" id="mobileSecurityModal"
                                                                    tabindex="-1" aria-labelledby="securityModalLabel"
                                                                    aria-hidden="true">
                                                                    <div
                                                                        class="modal-dialog modal-dialog-centered modal-sm">
                                                                        <div
                                                                            class="modal-content rounded-4 border-0 shadow">
                                                                            <div class="modal-header border-0 pb-0">
                                                                                <h6 class="modal-title fw-bold"
                                                                                    id="securityModalLabel"><i
                                                                                        class="bi bi-bell me-2 text-primary"></i>Notifications
                                                                                </h6><button type="button"
                                                                                    class="btn-close"
                                                                                    data-bs-dismiss="modal"></button>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div
                                                                                    class="p-3 bg-light rounded-3 mb-3">
                                                                                    <div
                                                                                        class="d-flex align-items-center justify-content-between mb-1">
                                                                                        <span class="small fw-bold">2FA
                                                                                            Status</span><span
                                                                                            class="badge ${user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">${user.twoFactorEnabled
                                                                                            ? 'Enabled' :
                                                                                            'Disabled'}</span></div>
                                                                                    <p class="small text-muted mb-0"
                                                                                        style="font-size:0.72rem;">
                                                                                        ${user.twoFactorEnabled ?
                                                                                        'Account secured with email
                                                                                        OTP.' : '2FA is currently off.'}
                                                                                    </p>
                                                                                </div>
                                                                                <button type="button"
                                                                                    class="btn btn-sm btn-primary w-100 rounded-3 py-2 fw-semibold"
                                                                                    data-bs-dismiss="modal"
                                                                                    onclick="switchMobileTab('profile')">Manage
                                                                                    in Profile</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Enroll Confirmation Modal -->
                                                                <div class="modal fade" id="enrollConfirmModal" tabindex="-1" aria-labelledby="enrollConfirmModalLabel" aria-hidden="true">
                                                                    <div class="modal-dialog modal-dialog-centered modal-sm">
                                                                        <div class="modal-content rounded-4 border-0 shadow">
                                                                            <div class="modal-header border-0 pb-0">
                                                                                <h6 class="modal-title fw-bold" id="enrollConfirmModalLabel">
                                                                                    <i class="bi bi-journal-plus me-2 text-primary"></i>Confirm Enrollment
                                                                                </h6>
                                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                            </div>
                                                                            <form action="${pageContext.request.contextPath}/student/dashboard" method="post" id="enrollConfirmForm" class="m-0">
                                                                                <input type="hidden" name="action" value="enroll">
                                                                                <input type="hidden" name="tab" id="enrollConfirmTab" value="courses">
                                                                                <input type="hidden" name="classSectionId" id="enrollConfirmSectionId" value="">
                                                                                <div class="modal-body pt-2 pb-3">
                                                                                    <p class="small text-muted mb-2">Are you sure you want to enroll in:</p>
                                                                                    <div class="p-3 bg-light rounded-3 mb-3 border">
                                                                                        <div class="fw-bold text-dark mb-1" id="enrollConfirmCourseCode"></div>
                                                                                        <div class="small text-secondary mb-2" id="enrollConfirmCourseTitle"></div>
                                                                                        <div class="small text-muted" id="enrollConfirmProfessor" style="font-size:0.75rem;"></div>
                                                                                    </div>
                                                                                    <div class="d-flex gap-2">
                                                                                        <button type="button" class="btn btn-sm btn-light w-50 rounded-pill fw-semibold border" data-bs-dismiss="modal">Cancel</button>
                                                                                        <button type="submit" class="btn btn-sm btn-primary w-50 rounded-pill fw-bold">Enroll Now</button>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>



                                                                <%-- Enrollment data for JS modal --%>
                                                                    <script>
                                                                        var enrollmentData = {};
                                                                    </script>
                                                                    <c:forEach var="enrollment" items="${schedule}">
                                                                        <c:set var="enrollGrade"
                                                                            value="${gradeMap[enrollment.id]}" />
                                                                        <c:set var="attList"
                                                                            value="${attendanceMap[enrollment.id]}" />
                                                                        <script>
                                                                            (function () {
                                                                                var eid = ${ enrollment.id };
                                                                                var attRows = [];
                                                                                <c:if test="${not empty attList}">
                                                                                    <c:forEach var="ae" items="${attList}">
                                                                                        attRows.push({date: '${ae.sessionDate}', status: '${ae.status}' });
                                                                                    </c:forEach>
                                                                                </c:if>
                                                                                enrollmentData[eid] = {
                                                                                    code: '${enrollment.courseCode}',
                                                                                    title: '${enrollment.courseTitle}',
                                                                                    shift: '${enrollment.sessionShift}',
                                                                                    days: '${enrollment.daysOfWeek}',
                                                                                    room: '${enrollment.room}',
                                                                                    prof: '${enrollment.professorName}',
                                                                                    credits: ${ enrollment.credits },
                                                                                attScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.attendanceScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                                                                                    asgScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.assignmentScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                                                                                        midScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.midtermScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                                                                                            finScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.finalScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                                                                                                totalScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.totalScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                                                                                                    letter: '<c:choose><c:when test="${enrollGrade != null}">${enrollGrade.letterGrade}</c:when><c:otherwise>N/A</c:otherwise></c:choose>',
                                                                                                        gpa: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.gpaPoint}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                                                                                                            attendance: attRows
                                                                            };
    }) ();
                                                                        </script>
                                                                     </c:forEach>
                                                                    <c:forEach var="g" items="${grades}">
                                                                        <script>
                                                                            (function() {
                                                                                var gid = ${g.enrollmentId};
                                                                                if (!enrollmentData[gid]) {
                                                                                    enrollmentData[gid] = {
                                                                                        code: '${g.courseCode}',
                                                                                        title: '${g.courseTitle}',
                                                                                        shift: '${not empty g.sessionShift ? g.sessionShift : "-"}',
                                                                                        days: '-',
                                                                                        room: '-',
                                                                                        prof: '-',
                                                                                        credits: ${g.credits},
                                                                                        attScore: ${g.attendanceScore},
                                                                                        asgScore: ${g.assignmentScore},
                                                                                        midScore: ${g.midtermScore},
                                                                                        finScore: ${g.finalScore},
                                                                                        totalScore: ${g.totalScore},
                                                                                        letter: '${g.letterGrade}',
                                                                                        gpa: ${g.gpaPoint},
                                                                                        attendance: []
                                                                                    };
                                                                                }
                                                                            })();
                                                                        </script>
                                                                    </c:forEach>


                                                                    <script
                                                                        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                                                                    <script>
                                                                        var _lastActiveCourseModalElement = null;

                                                                        function switchMobileTab(tabName) {
                                                                            var views = document.querySelectorAll('.mobile-sub-view');
                                                                            for (var i = 0; i < views.length; i++) views[i].classList.remove('active');
                                                                            var target = document.getElementById('mobile-view-' + tabName);
                                                                            if (target) target.classList.add('active');

                                                                            var btns = document.querySelectorAll('.dock-tab-btn');
                                                                            var iconMap = { 
                                                                                home: ['bi-house-door-fill', 'bi-house-door'], 
                                                                                courses: ['bi-journal-bookmark-fill', 'bi-journal-bookmark'], 
                                                                                grades: ['bi-mortarboard-fill', 'bi-mortarboard'], 
                                                                                schedule: ['bi-calendar3-fill', 'bi-calendar3'], 
                                                                                profile: ['bi-person-fill', 'bi-person'] 
                                                                            };
                                                                            for (var j = 0; j < btns.length; j++) {
                                                                                var b = btns[j], bTab = b.getAttribute('data-tab'), ic = b.querySelector('i');
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
                                                                            window.scrollTo({ top: 0, behavior: 'smooth' });
                                                                        }

                                                                        function filterScheduleTabView(dayShort, element) {
                                                                            var pills = document.querySelectorAll('.schedule-filter-pill');
                                                                            pills.forEach(function (pill) { pill.classList.remove('active'); });
                                                                            if (element) {
                                                                                element.classList.add('active');
                                                                            }

                                                                            var cards = document.querySelectorAll('.schedule-tab-card');
                                                                            var emptyBox = document.getElementById('scheduleTabEmpty');
                                                                            var emptyText = document.getElementById('scheduleTabEmptyText');
                                                                            var countBadge = document.getElementById('scheduleTabCount');
                                                                            var visibleCount = 0;

                                                                            cards.forEach(function (card) {
                                                                                var days = (card.getAttribute('data-days') || '').toLowerCase();
                                                                                var match = false;

                                                                                if (dayShort === 'all') {
                                                                                    match = true;
                                                                                } else if (days.indexOf('mon-fri') !== -1) {
                                                                                    match = ['mon', 'tue', 'wed', 'thu', 'fri'].indexOf(dayShort) !== -1;
                                                                                } else if (days.indexOf('sat-sun') !== -1) {
                                                                                    match = ['sat', 'sun'].indexOf(dayShort) !== -1;
                                                                                } else {
                                                                                    match = days.indexOf(dayShort) !== -1;
                                                                                }

                                                                                if (match) {
                                                                                    card.style.display = '';
                                                                                    visibleCount++;
                                                                                } else {
                                                                                    card.style.display = 'none';
                                                                                }
                                                                            });

                                                                            if (emptyBox) {
                                                                                if (visibleCount === 0 && cards.length > 0) {
                                                                                    emptyBox.style.display = 'block';
                                                                                    var dayNames = { mon: 'Monday', tue: 'Tuesday', wed: 'Wednesday', thu: 'Thursday', fri: 'Friday', sat: 'Saturday', sun: 'Sunday' };
                                                                                    if (emptyText) emptyText.textContent = 'No classes scheduled for ' + (dayNames[dayShort] || 'this day');
                                                                                } else {
                                                                                    emptyBox.style.display = 'none';
                                                                                }
                                                                            }

                                                                            if (countBadge) {
                                                                                countBadge.textContent = visibleCount + (visibleCount === 1 ? ' Class' : ' Classes');
                                                                            }
                                                                        }

                                                                        function filterMobileCourses(q) {
                                                                            q = (q || '').toLowerCase().trim();
                                                                            var clearBtn = document.getElementById('clearMobileCourseSearchBtn');
                                                                            if (clearBtn) {
                                                                                clearBtn.style.display = q.length > 0 ? 'inline-flex' : 'none';
                                                                            }

                                                                            var items = document.querySelectorAll('.mobile-course-item');
                                                                            var visibleCount = 0;
                                                                            for (var i = 0; i < items.length; i++) {
                                                                                var text = (items[i].textContent || '').toLowerCase();
                                                                                if (text.indexOf(q) !== -1) {
                                                                                    items[i].style.display = '';
                                                                                    visibleCount++;
                                                                                } else {
                                                                                    items[i].style.display = 'none';
                                                                                }
                                                                            }

                                                                            var badge = document.getElementById('mobileCourseCountBadge');
                                                                            if (badge) {
                                                                                badge.textContent = visibleCount + (visibleCount === 1 ? ' Class' : ' Classes');
                                                                            }
                                                                        }

                                                                        function clearMobileCourseSearch() {
                                                                            var inp = document.getElementById('mobileCourseSearchInput');
                                                                            if (inp) {
                                                                                inp.value = '';
                                                                                filterMobileCourses('');
                                                                                inp.focus();
                                                                            }
                                                                        }

                                                                        function copyStudentId(idText, btnEl) {
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
                                                                                var toast = document.getElementById('mobileToast');
                                                                                var toastText = document.getElementById('mobileToastText');
                                                                                if (toast) {
                                                                                    if (toastText) toastText.textContent = 'Student ID copied: ' + idText;
                                                                                    toast.classList.add('show');
                                                                                    clearTimeout(window._mobileToastTimer);
                                                                                    window._mobileToastTimer = setTimeout(function () {
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

                                                                        function openCourseModal(enrollmentId) {
                                                                            _lastActiveCourseModalElement = document.activeElement;
                                                                            var d = enrollmentData[parseInt(enrollmentId, 10)];
                                                                            if (!d) return;

                                                                            document.getElementById('sheetCourseCode').textContent = d.code;
                                                                            document.getElementById('sheetCourseTitle').textContent = d.title;
                                                                            document.getElementById('sheetCourseMeta').innerHTML =
                                                                                '<span><i class="bi bi-clock me-1"></i>' + d.shift + ' &bull; ' + d.days + '</span>' +
                                                                                '<span><i class="bi bi-door-open me-1"></i>Room ' + d.room + '</span>' +
                                                                                '<span><i class="bi bi-person me-1"></i>' + d.prof + '</span>';

                                                                            var pendingHtml = '<span class="text-muted" style="font-size:0.78rem;font-style:italic;">Pending</span>';

                                                                            document.getElementById('sheetScoreGrid').innerHTML =
                                                                                makeTile('Attendance', d.attScore > 0 ? d.attScore : null, false) +
                                                                                makeTile('Assignment', d.asgScore > 0 ? d.asgScore : null, false) +
                                                                                makeTile('Midterm', d.midScore > 0 ? d.midScore : null, false) +
                                                                                makeTile('Final Exam', d.finScore > 0 ? d.finScore : null, false);

                                                                            var letterColor = d.letter === 'A' ? '#16a34a' : (d.letter === 'F' ? '#dc2626' : (d.letter === 'N/A' ? '#94a3b8' : '#2563eb'));
                                                                            document.getElementById('sheetOverallGrid').innerHTML =
                                                                                '<div class="score-tile highlight"><div class="score-tile-label">Total Score</div><div class="score-tile-val ' + (d.totalScore > 0 ? '' : 'pending') + '">' + (d.totalScore > 0 ? d.totalScore : 'Pending') + '</div></div>' +
                                                                                '<div class="score-tile highlight"><div class="score-tile-label">Letter Grade</div><div class="score-tile-val" style="color:' + letterColor + ';font-size:1.6rem;">' + (d.letter !== 'N/A' ? d.letter : '—') + '</div></div>' +
                                                                                '<div class="score-tile"><div class="score-tile-label">GPA Points</div><div class="score-tile-val ' + (d.gpa > 0 ? '' : 'pending') + '">' + (d.gpa > 0 ? d.gpa : '—') + '</div></div>' +
                                                                                '<div class="score-tile"><div class="score-tile-label">Credits</div><div class="score-tile-val">' + d.credits + '</div></div>';

                                                                            var att = d.attendance || [];
                                                                            var present = 0, absent = 0, late = 0, excused = 0;
                                                                            for (var i = 0; i < att.length; i++) {
                                                                                if (att[i].status === 'PRESENT') present++;
                                                                                else if (att[i].status === 'ABSENT') absent++;
                                                                                else if (att[i].status === 'LATE') late++;
                                                                                else if (att[i].status === 'EXCUSED') excused++;
                                                                            }

                                                                            var sumHtml = '';
                                                                            if (att.length > 0) {
                                                                                sumHtml += '<span class="att-sum-chip att-PRESENT"><i class="bi bi-check-circle-fill"></i>' + present + ' Present</span>';
                                                                                if (absent > 0) sumHtml += '<span class="att-sum-chip att-ABSENT"><i class="bi bi-x-circle-fill"></i>' + absent + ' Absent</span>';
                                                                                if (late > 0) sumHtml += '<span class="att-sum-chip att-LATE"><i class="bi bi-clock-fill"></i>' + late + ' Late</span>';
                                                                                if (excused > 0) sumHtml += '<span class="att-sum-chip att-EXCUSED"><i class="bi bi-shield-check-fill"></i>' + excused + ' Excused</span>';
                                                                            }
                                                                            document.getElementById('sheetAttendanceSummary').innerHTML = sumHtml;

                                                                            var listHtml = '';
                                                                            if (att.length === 0) {
                                                                                listHtml = '<div class="att-empty"><i class="bi bi-calendar-x d-block mb-1 fs-4"></i>No attendance records yet</div>';
                                                                            } else {
                                                                                for (var k = 0; k < att.length; k++) {
                                                                                    listHtml += '<div class="att-row"><span class="att-date"><i class="bi bi-calendar3 me-2"></i>' + att[k].date + '</span><span class="att-badge att-' + att[k].status + '">' + att[k].status.charAt(0) + att[k].status.slice(1).toLowerCase() + '</span></div>';
                                                                                }
                                                                            }
                                                                            document.getElementById('sheetAttendanceList').innerHTML = listHtml;

                                                                            var overlay = document.getElementById('courseModalOverlay');
                                                                            overlay.classList.add('open');
                                                                            document.body.style.overflow = 'hidden';

                                                                            var closeBtn = overlay.querySelector('.sheet-close-btn');
                                                                            if (closeBtn) closeBtn.focus();
                                                                        }

                                                                        function makeTile(label, val, highlight) {
                                                                            var cls = highlight ? 'score-tile highlight' : 'score-tile';
                                                                            var valHtml = val !== null ? '<div class="score-tile-val">' + val + '</div>' : '<div class="score-tile-val pending">Pending</div>';
                                                                            return '<div class="' + cls + '"><div class="score-tile-label">' + label + '</div>' + valHtml + '</div>';
                                                                        }

                                                                        function closeCourseModal() {
                                                                            var overlay = document.getElementById('courseModalOverlay');
                                                                            if (overlay) overlay.classList.remove('open');
                                                                            document.body.style.overflow = '';
                                                                            if (_lastActiveCourseModalElement && typeof _lastActiveCourseModalElement.focus === 'function') {
                                                                                _lastActiveCourseModalElement.focus();
                                                                            }
                                                                        }

                                                                        function closeCourseModalOnOverlay(e) {
                                                                            if (e.target === document.getElementById('courseModalOverlay')) closeCourseModal();
                                                                        }

                                                                        document.addEventListener('keydown', function (e) {
                                                                            if (e.key === 'Escape') {
                                                                                var overlay = document.getElementById('courseModalOverlay');
                                                                                if (overlay && overlay.classList.contains('open')) {
                                                                                    closeCourseModal();
                                                                                }
                                                                            }
                                                                        });

                                                                        function openEnrollConfirm(sectionId, courseCode, courseTitle, professorName, returnTab) {
                                                                            document.getElementById('enrollConfirmSectionId').value = sectionId;
                                                                            document.getElementById('enrollConfirmTab').value = returnTab || 'courses';
                                                                            document.getElementById('enrollConfirmCourseCode').textContent = courseCode;
                                                                            document.getElementById('enrollConfirmCourseTitle').textContent = courseTitle;
                                                                            var profEl = document.getElementById('enrollConfirmProfessor');
                                                                            if (profEl) {
                                                                                profEl.innerHTML = professorName ? ('<i class="bi bi-person me-1"></i> ' + professorName) : '';
                                                                            }
                                                                            new bootstrap.Modal(document.getElementById('enrollConfirmModal')).show();
                                                                        }


                                                                        function initMobileDateStrip() {
                                                                            var strip = document.getElementById('mobileDateStrip');
                                                                            if (!strip) return;

                                                                            var today = new Date();
                                                                            var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

                                                                            // Get Monday of current week
                                                                            var dayOfWeek = today.getDay();
                                                                            var diffToMonday = today.getDate() - dayOfWeek + (dayOfWeek === 0 ? -6 : 1);
                                                                            var monday = new Date(today.setDate(diffToMonday));

                                                                            var html = '';
                                                                            // Prepend 'All' option
                                                                            html += '<div class="date-strip-item active" onclick="filterScheduleByDay(\'all\', this, \'All\')">' +
                                                                                '<div class="ds-day">All</div>' +
                                                                                '<div class="ds-date"><i class="bi bi-grid-fill" style="font-size:1.1rem;"></i></div>' +
                                                                                '</div>';

                                                                            for (var i = 0; i < 7; i++) {
                                                                                var d = new Date(monday);
                                                                                d.setDate(monday.getDate() + i);

                                                                                var isToday = (d.getDate() === new Date().getDate() && d.getMonth() === new Date().getMonth());
                                                                                var dayShort = days[d.getDay()].toLowerCase();
                                                                                var dayLabel = days[d.getDay()];

                                                                                html += '<div class="date-strip-item' + (isToday ? ' is-today' : '') + '" onclick="filterScheduleByDay(\'' + dayShort + '\', this, \'' + dayLabel + '\')">' +
                                                                                    '<div class="ds-day">' + dayLabel + (isToday ? ' &bull;' : '') + '</div>' +
                                                                                    '<div class="ds-date">' + d.getDate() + '</div>' +
                                                                                    '</div>';
                                                                            }
                                                                            strip.innerHTML = html;
                                                                        }

                                                                        function filterScheduleByDay(dayShort, element, dayLabel) {
                                                                            var strip = document.getElementById('mobileDateStrip');
                                                                            if (strip) {
                                                                                var items = strip.querySelectorAll('.date-strip-item');
                                                                                items.forEach(function (item) { item.classList.remove('active'); });
                                                                            }
                                                                            if (element) {
                                                                                element.classList.add('active');
                                                                            }

                                                                            var cards = document.querySelectorAll('.home-schedule-card');
                                                                            var emptyBox = document.getElementById('homeScheduleEmpty');
                                                                            var emptyText = document.getElementById('homeScheduleEmptyText');
                                                                            var titleEl = document.getElementById('homeScheduleTitle');
                                                                            var countEl = document.getElementById('homeScheduleCount');

                                                                            var visibleCount = 0;

                                                                            cards.forEach(function (card) {
                                                                                var days = (card.getAttribute('data-days') || '').toLowerCase();
                                                                                var match = false;

                                                                                if (dayShort === 'all') {
                                                                                    match = true;
                                                                                } else if (days.indexOf('mon-fri') !== -1) {
                                                                                    match = ['mon', 'tue', 'wed', 'thu', 'fri'].indexOf(dayShort) !== -1;
                                                                                } else if (days.indexOf('sat-sun') !== -1) {
                                                                                    match = ['sat', 'sun'].indexOf(dayShort) !== -1;
                                                                                } else {
                                                                                    match = days.indexOf(dayShort) !== -1;
                                                                                }

                                                                                if (match) {
                                                                                    card.style.display = '';
                                                                                    visibleCount++;
                                                                                } else {
                                                                                    card.style.display = 'none';
                                                                                }
                                                                            });

                                                                            if (emptyBox) {
                                                                                if (visibleCount === 0 && cards.length > 0) {
                                                                                    emptyBox.style.display = 'block';
                                                                                    if (emptyText) emptyText.textContent = 'No classes scheduled for ' + (dayLabel || 'this day');
                                                                                } else {
                                                                                    emptyBox.style.display = 'none';
                                                                                }
                                                                            }

                                                                            if (titleEl) {
                                                                                if (dayShort === 'all') {
                                                                                    titleEl.textContent = "This Term's Courses";
                                                                                } else {
                                                                                    titleEl.textContent = (dayLabel || 'Day') + "'s Schedule";
                                                                                }
                                                                            }

                                                                            if (countEl) {
                                                                                countEl.textContent = visibleCount + (visibleCount === 1 ? ' Class' : ' Classes');
                                                                            }
                                                                        }

                                                                        var studentTimetableData = [
                                                                            <c:forEach var="enr" items="${schedule}">
                                                                            {
                                                                                id: ${enr.id},
                                                                                classSectionId: ${enr.classSectionId},
                                                                                code: '${enr.courseCode}',
                                                                                title: '${enr.courseTitle.replace("'", "\\'")}',
                                                                                credits: ${enr.credits},
                                                                                shift: '${enr.sessionShift != null ? enr.sessionShift : ""}',
                                                                                daysOfWeek: '${enr.daysOfWeek != null ? enr.daysOfWeek : ""}',
                                                                                room: '${enr.room != null ? enr.room : ""}',
                                                                                professor: '${enr.professorName != null ? enr.professorName.replace("'", "\\'") : ""}',
                                                                                term: '${enr.termName != null ? enr.termName.replace("'", "\\'") : ""}',
                                                                                year: '${enr.academicYear != null ? enr.academicYear : ""}'
                                                                            },
                                                                            </c:forEach>
                                                                        ];

                                                                        function matchesDay(daysOfWeek, dayCode) {
                                                                            if (!daysOfWeek) return false;
                                                                            var d = daysOfWeek.toLowerCase();
                                                                            var target = dayCode.toLowerCase();
                                                                            if (d.indexOf('mon-fri') !== -1) {
                                                                                return ['mon', 'tue', 'wed', 'thu', 'fri'].indexOf(target) !== -1;
                                                                            }
                                                                            if (d.indexOf('sat-sun') !== -1) {
                                                                                return ['sat', 'sun'].indexOf(target) !== -1;
                                                                            }
                                                                            return d.indexOf(target) !== -1;
                                                                        }

                                                                        function setStudentScheduleView(view) {
                                                                            var grid = document.getElementById('studentTimetableView');
                                                                            var list = document.getElementById('studentScheduleListView');
                                                                            var btnGrid = document.getElementById('btnStudentViewTimetable');
                                                                            var btnList = document.getElementById('btnStudentViewTable');
                                                                            if (!grid || !list) return;

                                                                            if (view === 'table') {
                                                                                grid.style.display = 'none';
                                                                                list.style.display = 'block';
                                                                                if (btnGrid) btnGrid.classList.remove('active');
                                                                                if (btnList) btnList.classList.add('active');
                                                                                try { localStorage.setItem('student_schedule_view', 'table'); } catch(e){}
                                                                            } else {
                                                                                grid.style.display = 'block';
                                                                                list.style.display = 'none';
                                                                                if (btnGrid) btnGrid.classList.add('active');
                                                                                if (btnList) btnList.classList.remove('active');
                                                                                try { localStorage.setItem('student_schedule_view', 'grid'); } catch(e){}
                                                                            }
                                                                        }

                                                                        function renderStudentWeeklyTimetable() {
                                                                            var container = document.getElementById('studentTimetableGridContainer');
                                                                            if (!container) return;

                                                                            var days = [
                                                                                { key: 'mon', label: 'Monday', short: 'Mon' },
                                                                                { key: 'tue', label: 'Tuesday', short: 'Tue' },
                                                                                { key: 'wed', label: 'Wednesday', short: 'Wed' },
                                                                                { key: 'thu', label: 'Thursday', short: 'Thu' },
                                                                                { key: 'fri', label: 'Friday', short: 'Fri' },
                                                                                { key: 'sat', label: 'Saturday', short: 'Sat' },
                                                                                { key: 'sun', label: 'Sunday', short: 'Sun' }
                                                                            ];

                                                                            var shifts = [
                                                                                { key: 'MORNING', label: 'Morning', time: '08:00 - 11:15', icon: 'bi-sun-fill text-warning' },
                                                                                { key: 'AFTERNOON', label: 'Afternoon', time: '14:00 - 17:15', icon: 'bi-cloud-sun-fill text-primary' },
                                                                                { key: 'EVENING', label: 'Evening', time: '17:45 - 20:45', icon: 'bi-moon-stars-fill text-indigo' }
                                                                            ];

                                                                            var hasWeekendShift = studentTimetableData.some(function(s) {
                                                                                return s.shift && s.shift.toUpperCase() === 'WEEKEND';
                                                                            });
                                                                            if (hasWeekendShift) {
                                                                                shifts.push({ key: 'WEEKEND', label: 'Weekend Shift', time: '08:00 - 16:30', icon: 'bi-calendar2-week-fill text-success' });
                                                                            }

                                                                            var todayIndex = new Date().getDay();
                                                                            var dayMap = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
                                                                            var todayKey = dayMap[todayIndex];

                                                                            var tableHtml = '<table class="timetable-table">';
                                                                            tableHtml += '<thead><tr><th class="timetable-shift-cell text-center"><span class="small fw-bold text-muted text-uppercase">Time / Shift</span></th>';
                                                                            days.forEach(function(d) {
                                                                                var isToday = (d.key === todayKey);
                                                                                tableHtml += '<th class="timetable-header-cell ' + (isToday ? 'is-today' : '') + '" data-day="' + d.key + '">';
                                                                                tableHtml += '<div class="timetable-day-name">' + d.label + '</div>';
                                                                                if (isToday) {
                                                                                    tableHtml += '<span class="timetable-today-badge"><i class="bi bi-clock me-1"></i>Today</span>';
                                                                                }
                                                                                tableHtml += '</th>';
                                                                            });
                                                                            tableHtml += '</tr></thead>';

                                                                            tableHtml += '<tbody>';
                                                                            shifts.forEach(function(sh) {
                                                                                tableHtml += '<tr>';
                                                                                tableHtml += '<td class="timetable-shift-cell">';
                                                                                tableHtml += '<div class="shift-badge-box">';
                                                                                tableHtml += '<span class="shift-name-title"><i class="bi ' + sh.icon + '"></i> ' + sh.label + '</span>';
                                                                                tableHtml += '<span class="shift-time-range">' + sh.time + '</span>';
                                                                                tableHtml += '</div>';
                                                                                tableHtml += '</td>';

                                                                                days.forEach(function(d) {
                                                                                    var isToday = (d.key === todayKey);
                                                                                    tableHtml += '<td class="timetable-slot-cell ' + (isToday ? 'is-today' : '') + '" data-day="' + d.key + '" data-shift="' + sh.key + '">';

                                                                                    var matched = studentTimetableData.filter(function(sec) {
                                                                                        var shiftMatch = (sec.shift && sec.shift.toUpperCase() === sh.key);
                                                                                        return shiftMatch && matchesDay(sec.daysOfWeek, d.key);
                                                                                    });

                                                                                    if (matched.length > 0) {
                                                                                        matched.forEach(function(sec) {
                                                                                            tableHtml += '<div class="timetable-course-card">';
                                                                                            tableHtml += '<div class="d-flex justify-content-between align-items-center mb-1">';
                                                                                            tableHtml += '<span class="tt-code-badge">' + sec.code + '</span>';
                                                                                            tableHtml += '<span class="badge bg-light border text-secondary px-2 py-0 rounded-pill" style="font-size:0.68rem; font-weight:700;">' + sec.credits + ' Cr</span>';
                                                                                            tableHtml += '</div>';
                                                                                            tableHtml += '<div class="tt-course-title" title="' + sec.title + '">' + sec.title + '</div>';
                                                                                            tableHtml += '<div class="tt-meta-row">';
                                                                                            tableHtml += '<span class="tt-room-pill"><i class="bi bi-geo-alt-fill text-primary"></i> ' + (sec.room ? 'Room ' + sec.room : 'TBA') + '</span>';
                                                                                            tableHtml += '</div>';
                                                                                            if (sec.professor) {
                                                                                                tableHtml += '<div class="tt-prof-row" title="Professor ' + sec.professor + '"><i class="bi bi-person-fill text-primary"></i> <span>' + sec.professor + '</span></div>';
                                                                                            }
                                                                                            tableHtml += '<div class="tt-actions-row justify-content-end">';
                                                                                            tableHtml += '<span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill small fw-bold"><i class="bi bi-check2 me-1"></i>Enrolled</span>';
                                                                                            tableHtml += '</div>';
                                                                                            tableHtml += '</div>';
                                                                                        });
                                                                                    } else {
                                                                                        tableHtml += '<div class="timetable-empty-slot"><span>&bull; Free Slot &bull;</span></div>';
                                                                                    }

                                                                                    tableHtml += '</td>';
                                                                                });
                                                                                tableHtml += '</tr>';
                                                                            });
                                                                            tableHtml += '</tbody></table>';

                                                                            container.innerHTML = tableHtml;

                                                                            var filterGroup = document.getElementById('studentTimetableDayFilterGroup');
                                                                            if (filterGroup) {
                                                                                var fHtml = '<button class="btn btn-sm btn-primary text-white border rounded-pill px-3 py-1 fw-bold small active student-day-pill-btn" onclick="highlightStudentTimetableDay(\'all\', this)">All Week</button>';
                                                                                days.forEach(function(d) {
                                                                                    var isToday = (d.key === todayKey);
                                                                                    fHtml += '<button class="btn btn-sm btn-light border rounded-pill px-3 py-1 fw-bold small student-day-pill-btn" onclick="highlightStudentTimetableDay(\'' + d.key + '\', this)">' + d.short + (isToday ? ' &bull;' : '') + '</button>';
                                                                                });
                                                                                filterGroup.innerHTML = fHtml;
                                                                            }

                                                                            try {
                                                                                var savedView = localStorage.getItem('student_schedule_view');
                                                                                if (savedView === 'table') {
                                                                                    setStudentScheduleView('table');
                                                                                }
                                                                            } catch(e) {}
                                                                        }

                                                                        function highlightStudentTimetableDay(dayKey, btn) {
                                                                            var btns = document.querySelectorAll('.student-day-pill-btn');
                                                                            btns.forEach(function(b) { b.classList.remove('active', 'btn-primary', 'text-white'); b.classList.add('btn-light'); });
                                                                            if (btn) {
                                                                                btn.classList.remove('btn-light');
                                                                                btn.classList.add('active', 'btn-primary', 'text-white');
                                                                            }

                                                                            var cells = document.querySelectorAll('#studentTimetableGridContainer .timetable-table th, #studentTimetableGridContainer .timetable-table td');
                                                                            if (dayKey === 'all') {
                                                                                cells.forEach(function(c) {
                                                                                    c.style.opacity = '1';
                                                                                    c.style.filter = 'none';
                                                                                });
                                                                            } else {
                                                                                cells.forEach(function(c) {
                                                                                    var cDay = c.getAttribute('data-day');
                                                                                    if (!cDay) return;
                                                                                    if (cDay === dayKey) {
                                                                                        c.style.opacity = '1';
                                                                                        c.style.filter = 'none';
                                                                                    } else {
                                                                                        c.style.opacity = '0.32';
                                                                                        c.style.filter = 'grayscale(70%)';
                                                                                    }
                                                                                });
                                                                            }
                                                                        }

                                                                        function initSwiperDots() {
                                                                            var swiper = document.getElementById('progressSwiper');
                                                                            var dots = document.getElementById('swiperDots');
                                                                            if (!swiper || !dots) return;
                                                                            var cards = swiper.querySelectorAll('.progress-card-item');
                                                                            if (cards.length <= 1) { dots.style.display = 'none'; return; }
                                                                            for (var i = 0; i < cards.length; i++) {
                                                                                var dot = document.createElement('div');
                                                                                dot.className = 'swipe-dot' + (i === 0 ? ' active' : '');
                                                                                dots.appendChild(dot);
                                                                            }
                                                                            swiper.addEventListener('scroll', function () {
                                                                                var idx = Math.round(swiper.scrollLeft / (swiper.scrollWidth / cards.length));
                                                                                var allDots = dots.querySelectorAll('.swipe-dot');
                                                                                for (var j = 0; j < allDots.length; j++) allDots[j].classList.toggle('active', j === idx);
                                                                            });
                                                                        }

                                                                        document.addEventListener('DOMContentLoaded', function () {
                                                                            initMobileDateStrip();
                                                                            initSwiperDots();
                                                                            renderStudentWeeklyTimetable();
                                                                            try {
                                                                                var urlParams = new URLSearchParams(window.location.search);
                                                                                var tab = urlParams.get('tab');
                                                                                if (tab) {
                                                                                    // Mobile tab restoration
                                                                                    if (document.getElementById('mobile-view-' + tab)) {
                                                                                        switchMobileTab(tab);
                                                                                    } else if (tab === 'registration') {
                                                                                        switchMobileTab('courses');
                                                                                    } else if (tab === 'transcript') {
                                                                                        switchMobileTab('grades');
                                                                                    } else if (tab === 'settings') {
                                                                                        switchMobileTab('profile');
                                                                                    } else if (tab === 'dashboard') {
                                                                                        switchMobileTab('home');
                                                                                    }

                                                                                    // Desktop tab restoration
                                                                                    var dtBtn = document.getElementById('tab-' + tab);
                                                                                    if (dtBtn) {
                                                                                        switchDesktopTab(tab, dtBtn);
                                                                                    } else if (tab === 'courses') {
                                                                                        switchDesktopTab('registration', document.getElementById('tab-registration'));
                                                                                    } else if (tab === 'grades') {
                                                                                        switchDesktopTab('transcript', document.getElementById('tab-transcript'));
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