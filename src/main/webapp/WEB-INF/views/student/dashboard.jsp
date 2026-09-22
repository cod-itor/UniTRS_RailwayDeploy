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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: #1e293b;
            background-color: #f6f8fb;
        }
        .dashboard-header { background-color: #198754; color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .nav-tabs .nav-link { color: #495057; font-weight: 500; }
        .nav-tabs .nav-link.active { font-weight: 700; color: #198754; }
        .card-custom { border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.04); border-radius: 14px; }
        .table th { background-color: #f1f3f5; font-weight: 600; }

        @media (max-width: 767.98px) {
            body { background: #f6f8fb; padding-bottom: 90px; }

            .mobile-app-container { max-width: 480px; margin: 0 auto; padding: 16px 16px 20px; }

            /* Top Bar */
            .mobile-top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
            .mobile-user-info { display: flex; align-items: center; gap: 12px; }
            .mobile-avatar-frame {
                width: 46px; height: 46px; border-radius: 14px; overflow: hidden;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08); border: 2px solid #fff; flex-shrink: 0; background: #e2e8f0;
            }
            .mobile-avatar-frame img { width: 100%; height: 100%; object-fit: cover; }
            .mobile-user-greeting { font-size: 1.05rem; font-weight: 800; color: #0f172a; margin-bottom: 2px; line-height: 1.2; }
            .mobile-badge-pill {
                display: inline-block; background: #e9edf2; color: #64748b;
                font-size: 0.72rem; font-weight: 600; padding: 2px 10px; border-radius: 20px;
            }
            .mobile-top-action-btn {
                width: 42px; height: 42px; background: #fff; border-radius: 14px;
                display: flex; align-items: center; justify-content: center;
                border: 1px solid #edf2f7; box-shadow: 0 4px 12px rgba(0,0,0,0.04);
                color: #334155; font-size: 1.15rem; cursor: pointer;
                transition: transform 0.15s ease, background 0.15s ease;
            }
            .mobile-top-action-btn:active { transform: scale(0.92); background: #f1f5f9; }

            /* Multi-day Date Strip */
            .mobile-date-strip { display: flex; gap: 8px; overflow-x: auto; margin-bottom: 20px; padding-bottom: 5px; scrollbar-width: none; }
            .mobile-date-strip::-webkit-scrollbar { display: none; }
            .date-strip-item {
                flex: 0 0 calc(100% / 5.5);
                background: #fff; border: 1px solid #e2e8f0; border-radius: 16px;
                display: flex; flex-direction: column; align-items: center; justify-content: center;
                padding: 12px 0; color: #64748b; transition: all 0.2s;
            }
            .date-strip-item.active {
                background: #11141a; border-color: #11141a; color: #fff;
                box-shadow: 0 6px 12px rgba(17,20,26,0.15); transform: translateY(-2px);
            }
            .ds-day { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
            .ds-date { font-size: 1.25rem; font-weight: 800; line-height: 1; }
            .date-strip-item.active .ds-day { color: rgba(255,255,255,0.7); }
            .date-strip-item.active .ds-date { color: #fff; }
            .date-strip-item.active::after {
                content: ''; display: block; width: 6px; height: 6px; background: #22c55e; border-radius: 50%; margin-top: 6px;
                animation: pulse 1.8s infinite;
            }
            @keyframes pulse { 0%,100% { transform: scale(0.9); opacity: 0.8; } 50% { transform: scale(1.4); opacity: 1; } }

            /* Hero Banner */
            .mobile-hero-banner {
                background: linear-gradient(135deg, #ff7a18 0%, #af002d 30%, #5f11e8 70%, #3a7bd5 100%);
                border-radius: 24px; padding: 16px; color: #fff;
                box-shadow: 0 12px 28px rgba(111,17,232,0.28);
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
                box-shadow: 0 6px 14px rgba(0,0,0,0.2);
            }
            .hero-avatar-box img { width: 100%; height: 100%; object-fit: cover; }
            .hero-content { flex: 1; min-width: 0; z-index: 1; }
            .hero-label { font-size: 0.65rem; font-weight: 800; letter-spacing: 0.8px; color: rgba(255,255,255,0.85); text-transform: uppercase; margin-bottom: 3px; }
            .hero-title { font-size: 0.95rem; font-weight: 800; color: #fff; margin-bottom: 4px; line-height: 1.25; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
            .hero-meta-row { font-size: 0.72rem; color: rgba(255,255,255,0.92); display: flex; align-items: center; gap: 5px; margin-bottom: 3px; }
            .hero-status-tag {
                display: inline-flex; align-items: center; gap: 4px; background: rgba(255,255,255,0.92);
                color: #15803d; font-size: 0.65rem; font-weight: 700; padding: 3px 8px; border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            /* Academic Progress Swipeable Cards */
            .progress-section-label { font-size: 1.0rem; font-weight: 800; color: #0f172a; margin-bottom: 10px; }
            .progress-swiper-wrap { position: relative; margin-bottom: 20px; }
            .progress-swiper {
                display: flex; gap: 12px; overflow-x: auto; scroll-snap-type: x mandatory;
                padding-bottom: 10px; scrollbar-width: none;
            }
            .progress-swiper::-webkit-scrollbar { display: none; }
            .progress-card-item {
                flex: 0 0 calc(85vw - 32px); max-width: 340px; min-width: 260px;
                scroll-snap-align: start;
                background: #fff; border-radius: 22px; padding: 16px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.05); border: 1px solid #edf2f7;
            }
            .pc-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px; }
            .pc-course-code { font-size: 0.78rem; font-weight: 800; color: #5f11e8; background: #f3e8ff; padding: 3px 10px; border-radius: 12px; }
            .pc-gpa-badge { font-size: 1.1rem; font-weight: 800; color: #0f172a; }
            .pc-gpa-label { font-size: 0.65rem; font-weight: 600; color: #64748b; }
            .pc-title { font-size: 0.82rem; font-weight: 700; color: #0f172a; margin-bottom: 10px; line-height: 1.25; }
            .pc-score-row { display: flex; flex-direction: column; gap: 6px; margin-bottom: 10px; }
            .pc-score-item { display: flex; align-items: center; gap: 8px; }
            .pc-score-label { font-size: 0.7rem; font-weight: 600; color: #64748b; width: 90px; flex-shrink: 0; }
            .pc-score-bar-wrap { flex: 1; background: #f1f5f9; border-radius: 99px; height: 7px; overflow: hidden; }
            .pc-score-bar { height: 7px; border-radius: 99px; transition: width 0.6s ease; }
            .pc-score-val { font-size: 0.7rem; font-weight: 700; color: #0f172a; min-width: 28px; text-align: right; }
            .pc-footer { display: flex; justify-content: space-between; align-items: center; padding-top: 10px; border-top: 1px solid #f1f5f9; }
            .pc-letter { font-size: 1.5rem; font-weight: 900; }
            .grade-A { color: #16a34a; } .grade-B { color: #2563eb; } .grade-C { color: #d97706; }
            .grade-F { color: #dc2626; } .grade-na { color: #94a3b8; }
            .pc-credits { font-size: 0.72rem; color: #64748b; text-align: right; }
            .pc-credits strong { color: #0f172a; display: block; font-size: 0.85rem; }

            /* Swipe dots */
            .swipe-dots { display: flex; justify-content: center; gap: 5px; margin-top: 2px; margin-bottom: 18px; }
            .swipe-dot { width: 6px; height: 6px; background: #cbd5e1; border-radius: 50%; transition: all 0.2s ease; }
            .swipe-dot.active { background: #11141a; width: 18px; border-radius: 3px; }

            /* Term Courses list */
            .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
            .section-title { font-size: 1.0rem; font-weight: 800; color: #0f172a; }
            .mobile-course-card {
                background: #fff; border-radius: 18px; padding: 15px;
                margin-bottom: 12px; border: 1px solid #edf2f7;
                box-shadow: 0 4px 12px rgba(0,0,0,0.02); cursor: pointer;
                transition: transform 0.15s ease, box-shadow 0.15s ease;
            }
            .mobile-course-card:active { transform: scale(0.98); box-shadow: 0 2px 6px rgba(0,0,0,0.04); }

            /* Bottom dock */
            .mobile-bottom-dock {
                position: fixed; bottom: 0; left: 0; right: 0;
                background: rgba(255,255,255,0.96); backdrop-filter: blur(18px); -webkit-backdrop-filter: blur(18px);
                border-top: 1px solid #eef2f6;
                display: flex; justify-content: space-around; align-items: center;
                padding: 8px 10px calc(8px + env(safe-area-inset-bottom, 8px));
                z-index: 1040; box-shadow: 0 -4px 20px rgba(0,0,0,0.03);
            }
            .dock-tab-btn {
                display: flex; flex-direction: column; align-items: center;
                background: transparent; border: none; color: #94a3b8;
                font-size: 0.68rem; font-weight: 600; padding: 4px 6px;
                cursor: pointer; transition: all 0.18s ease; text-decoration: none;
            }
            .dock-tab-btn i { font-size: 1.25rem; margin-bottom: 2px; transition: transform 0.18s ease; }
            .dock-tab-btn.active { color: #0f172a; font-weight: 700; }
            .dock-tab-btn.active i { transform: translateY(-2px); }

            /* Sub-views */
            .mobile-sub-view { display: none; animation: fadeUp 0.22s ease; }
            .mobile-sub-view.active { display: block; }
            @keyframes fadeUp { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }

            /* Course detail modal overlay */
            .course-modal-overlay {
                position: fixed; inset: 0; background: rgba(15,23,42,0.55);
                z-index: 1050; display: none; align-items: flex-end; justify-content: center;
                backdrop-filter: blur(4px); -webkit-backdrop-filter: blur(4px);
            }
            .course-modal-overlay.open { display: flex; }
            .course-modal-sheet {
                background: #fff; border-radius: 26px 26px 0 0; width: 100%; max-width: 480px;
                max-height: 85vh; overflow-y: auto; padding: 0 0 32px;
                animation: slideUp 0.28s cubic-bezier(0.34,1.12,0.64,1);
            }
            @keyframes slideUp { from { transform: translateY(100%); } to { transform: translateY(0); } }
            .sheet-drag-handle { width: 40px; height: 5px; background: #e2e8f0; border-radius: 99px; margin: 12px auto 0; }
            .sheet-header { padding: 16px 20px 10px; border-bottom: 1px solid #f1f5f9; }
            .sheet-header-code { font-size: 0.75rem; font-weight: 800; color: #5f11e8; background: #f3e8ff; padding: 3px 10px; border-radius: 10px; display: inline-block; margin-bottom: 6px; }
            .sheet-header-title { font-size: 1rem; font-weight: 800; color: #0f172a; line-height: 1.3; margin-bottom: 4px; }
            .sheet-header-meta { font-size: 0.72rem; color: #64748b; display: flex; flex-wrap: wrap; gap: 10px; }
            .sheet-body { padding: 16px 20px; }
            .sheet-section-label { font-size: 0.75rem; font-weight: 800; text-transform: uppercase; letter-spacing: 0.6px; color: #94a3b8; margin-bottom: 10px; margin-top: 16px; }
            .score-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 4px; }
            .score-tile { background: #f8fafc; border-radius: 14px; padding: 12px; border: 1px solid #f1f5f9; }
            .score-tile-label { font-size: 0.65rem; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
            .score-tile-val { font-size: 1.35rem; font-weight: 900; color: #0f172a; line-height: 1; }
            .score-tile-val.pending { font-size: 0.8rem; color: #94a3b8; font-weight: 600; }
            .score-tile.highlight { background: linear-gradient(135deg, #f3e8ff, #e0f2fe); border-color: transparent; }
            .score-tile.highlight .score-tile-val { color: #5f11e8; }
            .attendance-list { display: flex; flex-direction: column; gap: 7px; }
            .att-row { display: flex; align-items: center; justify-content: space-between; padding: 8px 12px; background: #f8fafc; border-radius: 12px; }
            .att-date { font-size: 0.72rem; font-weight: 600; color: #334155; }
            .att-badge { font-size: 0.65rem; font-weight: 700; padding: 3px 10px; border-radius: 99px; }
            .att-PRESENT { background: #dcfce7; color: #16a34a; }
            .att-ABSENT { background: #fee2e2; color: #dc2626; }
            .att-LATE { background: #fef3c7; color: #d97706; }
            .att-EXCUSED { background: #e0f2fe; color: #0284c7; }
            .att-empty { font-size: 0.8rem; color: #94a3b8; text-align: center; padding: 16px 0; }
            .att-summary { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 10px; }
            .att-sum-chip { display: inline-flex; align-items: center; gap: 5px; font-size: 0.7rem; font-weight: 700; padding: 4px 10px; border-radius: 99px; }
        }
    </style>
</head>
<body>

<%-- Compute earned credits --%>
<c:set var="earnedCredits" value="0" />
<c:forEach var="gradeItem" items="${grades}">
    <c:if test="${gradeItem.letterGrade != 'F' && gradeItem.letterGrade != 'N/A' && not empty gradeItem.letterGrade}">
        <c:set var="earnedCredits" value="${earnedCredits + gradeItem.credits}" />
    </c:if>
</c:forEach>

<%-- ================================================================== --%>
<%-- DESKTOP VIEW (>= 768px)                                              --%>
<%-- ================================================================== --%>
<div class="d-none d-md-block">
    <header class="dashboard-header shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-1"><i class="bi bi-mortarboard-fill me-2"></i>Student Dashboard</h2>
                <c:if test="${not empty studentSchool}">
                    <p class="mb-0 text-white-50"><i class="bi bi-building me-1"></i> ${studentSchool.schoolName} | Major: ${user.major}</p>
                </c:if>
            </div>
            <div class="d-flex align-items-center">
                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="d-flex align-items-center me-3 bg-white bg-opacity-10 px-2 py-1 rounded">
                    <input type="hidden" name="redirect" value="/student/dashboard">
                    <label for="twoFactorSelectDesktop" class="text-white me-2 small mb-0"><i class="bi bi-shield-lock me-1"></i>2FA:</label>
                    <select id="twoFactorSelectDesktop" name="twoFactorEnabled" class="form-select form-select-sm bg-light text-dark border-0 py-0" style="font-size:0.8rem;width:auto;" onchange="this.form.submit()">
                        <option value="false" ${!user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                        <option value="true" ${user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                    </select>
                </form>
                <span class="me-3 text-white"><i class="bi bi-person-circle me-1"></i> ${user.fullName} (${user.userIdentifier})</span>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-light btn-sm"><i class="bi bi-box-arrow-right"></i> Logout</a>
            </div>
        </div>
    </header>

    <div class="container mb-5">
        <c:if test="${param.twoFactorUpdated == 'true'}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-shield-check me-2"></i>2FA is now <strong>enabled</strong>.<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
        <c:if test="${param.twoFactorUpdated == 'false'}"><div class="alert alert-info alert-dismissible fade show"><i class="bi bi-shield-slash me-2"></i>2FA has been <strong>disabled</strong>.<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
        <c:if test="${not empty successMessage}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${successMessage}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
        <c:if test="${not empty errorMessage}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

        <c:choose>
            <c:when test="${empty user.studentSchoolId}">
                <div class="row justify-content-center mt-5"><div class="col-md-6">
                    <div class="card card-custom border-top border-success border-4"><div class="card-body text-center p-5">
                        <i class="bi bi-building text-success mb-3" style="font-size:4rem;"></i>
                        <h3 class="card-title mb-4">Welcome to UniTRS</h3>
                        <p class="text-muted mb-4">Please select your academic school to get started.</p>
                        <form action="${pageContext.request.contextPath}/student/dashboard" method="post">
                            <input type="hidden" name="action" value="selectSchool">
                            <div class="mb-4 text-start">
                                <label class="form-label fw-bold">Select Your School</label>
                                <select class="form-select form-select-lg" name="schoolId" required>
                                    <option value="" selected disabled>-- Choose a School --</option>
                                    <c:forEach var="school" items="${schools}"><option value="${school.id}">${school.schoolName}</option></c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-success btn-lg w-100">Continue to Dashboard <i class="bi bi-arrow-right ms-1"></i></button>
                        </form>
                    </div></div>
                </div></div>
            </c:when>
            <c:otherwise>
                <ul class="nav nav-tabs mb-4" id="studentTabs" role="tablist">
                    <li class="nav-item" role="presentation"><button class="nav-link active" id="schedule-tab" data-bs-toggle="tab" data-bs-target="#schedule" type="button" role="tab"><i class="bi bi-calendar3 me-2"></i>My Schedule</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="registration-tab" data-bs-toggle="tab" data-bs-target="#registration" type="button" role="tab"><i class="bi bi-plus-circle me-2"></i>Term Registration</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="grades-tab" data-bs-toggle="tab" data-bs-target="#grades" type="button" role="tab"><i class="bi bi-journal-check me-2"></i>Grades &amp; Transcript</button></li>
                </ul>
                <div class="tab-content" id="studentTabsContent">
                    <div class="tab-pane fade show active" id="schedule" role="tabpanel">
                        <h4 class="mb-3">Current Schedule</h4>
                        <div class="card card-custom"><div class="card-body p-0">
                            <c:if test="${empty schedule}"><div class="p-5 text-center text-muted"><i class="bi bi-calendar-x mb-3" style="font-size:3rem;"></i><h5>No Classes Scheduled</h5><p>Go to the Registration tab to enroll.</p></div></c:if>
                            <c:if test="${not empty schedule}">
                                <table class="table table-hover mb-0 align-middle">
                                    <thead class="table-light"><tr><th class="ps-3">Term</th><th>Course</th><th>Professor</th><th>Time &amp; Days</th><th>Room</th></tr></thead>
                                    <tbody>
                                        <c:forEach var="enrollment" items="${schedule}">
                                            <tr>
                                                <td class="ps-3"><span class="badge bg-success">${enrollment.termName}</span><br><small class="text-muted">${enrollment.academicYear}</small></td>
                                                <td><strong>${enrollment.courseCode}</strong><br><small>${enrollment.courseTitle}</small></td>
                                                <td><i class="bi bi-person-badge text-primary me-1"></i>${enrollment.professorName}</td>
                                                <td><span class="badge bg-light border text-dark">${enrollment.sessionShift}</span><br><small class="text-muted"><i class="bi bi-clock me-1"></i>${enrollment.daysOfWeek}</small></td>
                                                <td><i class="bi bi-door-open me-1"></i>${enrollment.room}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </div></div>
                    </div>

                    <div class="tab-pane fade" id="registration" role="tabpanel">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Available Classes</h4>
                            <span class="text-muted small">Showing classes for ${studentSchool.schoolName}</span>
                        </div>
                        <div class="row g-4">
                            <c:forEach var="section" items="${availableClasses}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="card card-custom h-100">
                                        <div class="card-header bg-white pt-3 border-bottom-0 pb-0 d-flex justify-content-between">
                                            <span class="badge bg-info text-dark">${section.termName}</span>
                                            <span class="badge bg-secondary">${section.credits} Credits</span>
                                        </div>
                                        <div class="card-body pb-2">
                                            <h5 class="card-title mb-1 text-success fw-bold">${section.courseCode}</h5>
                                            <h6 class="card-subtitle mb-3 text-muted">${section.courseTitle}</h6>
                                            <ul class="list-unstyled small mb-3">
                                                <li class="mb-1"><i class="bi bi-person me-2 text-primary"></i>${section.professorName}</li>
                                                <li class="mb-1"><i class="bi bi-clock me-2 text-primary"></i>${section.sessionShift} (${section.daysOfWeek})</li>
                                                <li class="mb-1"><i class="bi bi-door-open me-2 text-primary"></i>Room ${section.roomName}</li>
                                            </ul>
                                            <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                                                <span class="small ${section.enrolledCount >= section.roomCapacity ? 'text-danger fw-bold' : 'text-muted'}">
                                                    <i class="bi bi-people-fill me-1"></i>${section.enrolledCount}/${section.roomCapacity} Enrolled
                                                </span>
                                                <form action="${pageContext.request.contextPath}/student/dashboard" method="post">
                                                    <input type="hidden" name="action" value="enroll">
                                                    <input type="hidden" name="classSectionId" value="${section.id}">
                                                    <c:set var="isEnrolled" value="false" />
                                                    <c:forEach var="myClass" items="${schedule}"><c:if test="${myClass.courseCode == section.courseCode}"><c:set var="isEnrolled" value="true" /></c:if></c:forEach>
                                                    <c:choose>
                                                        <c:when test="${isEnrolled}"><button type="button" class="btn btn-outline-success btn-sm disabled">Enrolled</button></c:when>
                                                        <c:when test="${section.enrolledCount >= section.roomCapacity}"><button type="button" class="btn btn-danger btn-sm disabled">Full</button></c:when>
                                                        <c:otherwise><button type="submit" class="btn btn-success btn-sm">Enroll</button></c:otherwise>
                                                    </c:choose>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty availableClasses}"><div class="col-12"><div class="alert alert-info">No classes available for your school this term.</div></div></c:if>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="grades" role="tabpanel">
                        <div class="row align-items-center mb-3">
                            <div class="col"><h4 class="mb-0">Academic Transcript</h4></div>
                            <div class="col-auto"><div class="bg-light border rounded px-4 py-2 shadow-sm"><div class="small text-muted text-uppercase fw-bold mb-1">Cumulative GPA</div><div class="fs-3 fw-bold text-success">${termGpa}</div></div></div>
                        </div>
                        <div class="card card-custom"><div class="card-body p-0">
                            <c:if test="${empty grades}"><div class="p-5 text-center text-muted"><i class="bi bi-journal-x mb-3" style="font-size:3rem;"></i><h5>No Grades Yet</h5></div></c:if>
                            <c:if test="${not empty grades}">
                                <table class="table table-hover mb-0 align-middle">
                                    <thead class="table-light"><tr><th class="ps-3">Term</th><th>Course</th><th class="text-center">Credits</th><th class="text-center">Total Score</th><th class="text-center">Letter Grade</th><th class="text-center pe-3">GPA Points</th></tr></thead>
                                    <tbody>
                                        <c:forEach var="grade" items="${grades}">
                                            <tr>
                                                <td class="ps-3"><span class="badge bg-secondary">${grade.termName}</span></td>
                                                <td><strong>${grade.courseCode}</strong><br><small class="text-muted">${grade.courseTitle}</small></td>
                                                <td class="text-center">${grade.credits}</td>
                                                <td class="text-center"><c:choose><c:when test="${grade.totalScore > 0}">${grade.totalScore}</c:when><c:otherwise><span class="text-muted fst-italic">Pending</span></c:otherwise></c:choose></td>
                                                <td class="text-center fw-bold text-success"><c:choose><c:when test="${grade.letterGrade != 'N/A'}">${grade.letterGrade}</c:when><c:otherwise>-</c:otherwise></c:choose></td>
                                                <td class="text-center pe-3 fw-bold"><c:choose><c:when test="${grade.letterGrade != 'N/A'}">${grade.gpaPoint}</c:when><c:otherwise>-</c:otherwise></c:choose></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </div></div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>


<%-- ================================================================== --%>
<%-- MOBILE VIEW (< 768px)                                                --%>
<%-- ================================================================== --%>
<div class="d-block d-md-none mobile-app-container">

    <c:if test="${param.twoFactorUpdated == 'true'}"><div class="alert alert-success alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small"><i class="bi bi-shield-check me-1"></i>2FA <strong>enabled</strong>.<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button></div></c:if>
    <c:if test="${param.twoFactorUpdated == 'false'}"><div class="alert alert-info alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small"><i class="bi bi-shield-slash me-1"></i>2FA <strong>disabled</strong>.<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button></div></c:if>
    <c:if test="${not empty successMessage}"><div class="alert alert-success alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small"><i class="bi bi-check-circle-fill me-1"></i>${successMessage}<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button></div></c:if>
    <c:if test="${not empty errorMessage}"><div class="alert alert-danger alert-dismissible fade show rounded-4 py-2 px-3 mb-3 small"><i class="bi bi-exclamation-triangle-fill me-1"></i>${errorMessage}<button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button></div></c:if>

    <c:choose>
        <c:when test="${empty user.studentSchoolId}">
            <div class="card border-0 shadow-sm rounded-4 p-4 text-center my-4 bg-white">
                <i class="bi bi-building text-success mb-3" style="font-size:3rem;"></i>
                <h4 class="fw-bold mb-2">Welcome to UniTRS</h4>
                <p class="text-muted small mb-4">Please select your academic school to get started.</p>
                <form action="${pageContext.request.contextPath}/student/dashboard" method="post">
                    <input type="hidden" name="action" value="selectSchool">
                    <div class="mb-3 text-start"><label class="form-label small fw-bold">Select School</label>
                        <select class="form-select rounded-3" name="schoolId" required>
                            <option value="" selected disabled>-- Choose a School --</option>
                            <c:forEach var="school" items="${schools}"><option value="${school.id}">${school.schoolName}</option></c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-success w-100 rounded-3 py-2 fw-semibold">Continue</button>
                </form>
            </div>
        </c:when>

        <c:otherwise>

            <%-- Top Bar --%>
            <div class="mobile-top-bar">
                <div class="mobile-user-info">
                    <div class="mobile-avatar-frame">
                        <c:choose>
                            <c:when test="${user.gender == 'FEMALE'}">
                                <img src="${pageContext.request.contextPath}/static/images/default_female.svg" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/static/images/default_male.svg" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <div class="mobile-user-greeting">Hello, ${user.fullName}</div>
                        <span class="mobile-badge-pill">${not empty studentSchool ? studentSchool.schoolName : 'UniTRS'}</span>
                    </div>
                </div>
                <button class="mobile-top-action-btn" type="button" data-bs-toggle="modal" data-bs-target="#mobileSecurityModal">
                    <i class="bi bi-bell"></i>
                </button>
            </div>


            <%-- ===== HOME SUB-VIEW ===== --%>
            <div id="mobile-view-home" class="mobile-sub-view active">

                <%-- Fixed multi-day strip --%>
                <div class="mobile-date-strip" id="mobileDateStrip">
                    <!-- Populated by JS -->
                </div>

                <%-- Hero: NEXT CLASS today --%>
                <div class="mobile-hero-banner">
                    <div class="hero-avatar-box">
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
                        <div class="hero-label">NEXT CLASS TODAY</div>
                        <c:set var="todayHeroSet" value="false" />
                        <c:forEach var="enrollment" items="${schedule}">
                            <c:if test="${todayHeroSet == 'false'}">
                                <div class="hero-title">${enrollment.courseCode}: ${enrollment.courseTitle}</div>
                                <div class="hero-meta-row"><i class="bi bi-geo-alt-fill"></i> Room ${enrollment.room}</div>
                                <div class="hero-meta-row"><i class="bi bi-clock-fill"></i> ${enrollment.sessionShift} &bull; ${enrollment.daysOfWeek}</div>
                                <div class="mt-2"><span class="hero-status-tag"><span style="width:6px;height:6px;background:#22c55e;border-radius:50%;display:inline-block;animation:pulse 1.8s infinite;"></span> Enrolled</span></div>
                                <c:set var="todayHeroSet" value="true" />
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty schedule}">
                            <div class="hero-title">No Classes Enrolled</div>
                            <div class="hero-meta-row"><i class="bi bi-info-circle-fill"></i> Registration is open</div>
                            <div class="mt-2"><button type="button" class="btn btn-sm btn-light rounded-pill px-3 fw-bold text-primary" onclick="switchMobileTab('courses')">Enroll Now</button></div>
                        </c:if>
                    </div>
                </div>

                <%-- Academic Progress swipeable cards --%>
                <div class="progress-section-label">Academic Progress</div>
                <div class="progress-swiper-wrap">
                    <div class="progress-swiper" id="progressSwiper">
                        <c:forEach var="enrollment" items="${schedule}" varStatus="st">
                            <c:set var="enrollGrade" value="${gradeMap[enrollment.id]}" />
                            <div class="progress-card-item">
                                <div class="pc-header">
                                    <span class="pc-course-code">${enrollment.courseCode}</span>
                                    <div class="text-end">
                                        <div class="pc-gpa-label">GPA Points</div>
                                        <div class="pc-gpa-badge">
                                            <c:choose>
                                                <c:when test="${enrollGrade != null && enrollGrade.gpaPoint > 0}">${enrollGrade.gpaPoint}</c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                <div class="pc-title">${enrollment.courseTitle}</div>

                                <div class="pc-score-row">
                                    <%-- Attendance Score --%>
                                    <div class="pc-score-item">
                                        <span class="pc-score-label">Attendance</span>
                                        <div class="pc-score-bar-wrap">
                                            <c:set var="attVal" value="${enrollGrade != null ? enrollGrade.attendanceScore : 0}" />
                                            <div class="pc-score-bar" style="width:${attVal}%;background:#10b981;"></div>
                                        </div>
                                        <span class="pc-score-val">
                                            <c:choose><c:when test="${enrollGrade != null && enrollGrade.attendanceScore > 0}">${enrollGrade.attendanceScore}</c:when><c:otherwise>—</c:otherwise></c:choose>
                                        </span>
                                    </div>
                                    <%-- Assignment Score --%>
                                    <div class="pc-score-item">
                                        <span class="pc-score-label">Assignment</span>
                                        <div class="pc-score-bar-wrap">
                                            <c:set var="asgVal" value="${enrollGrade != null ? enrollGrade.assignmentScore : 0}" />
                                            <div class="pc-score-bar" style="width:${asgVal}%;background:#3b82f6;"></div>
                                        </div>
                                        <span class="pc-score-val">
                                            <c:choose><c:when test="${enrollGrade != null && enrollGrade.assignmentScore > 0}">${enrollGrade.assignmentScore}</c:when><c:otherwise>—</c:otherwise></c:choose>
                                        </span>
                                    </div>
                                    <%-- Midterm Score --%>
                                    <div class="pc-score-item">
                                        <span class="pc-score-label">Midterm</span>
                                        <div class="pc-score-bar-wrap">
                                            <c:set var="midVal" value="${enrollGrade != null ? enrollGrade.midtermScore : 0}" />
                                            <div class="pc-score-bar" style="width:${midVal}%;background:#f59e0b;"></div>
                                        </div>
                                        <span class="pc-score-val">
                                            <c:choose><c:when test="${enrollGrade != null && enrollGrade.midtermScore > 0}">${enrollGrade.midtermScore}</c:when><c:otherwise>—</c:otherwise></c:choose>
                                        </span>
                                    </div>
                                    <%-- Final Score --%>
                                    <div class="pc-score-item">
                                        <span class="pc-score-label">Final Exam</span>
                                        <div class="pc-score-bar-wrap">
                                            <c:set var="finVal" value="${enrollGrade != null ? enrollGrade.finalScore : 0}" />
                                            <div class="pc-score-bar" style="width:${finVal}%;background:#8b5cf6;"></div>
                                        </div>
                                        <span class="pc-score-val">
                                            <c:choose><c:when test="${enrollGrade != null && enrollGrade.finalScore > 0}">${enrollGrade.finalScore}</c:when><c:otherwise>—</c:otherwise></c:choose>
                                        </span>
                                    </div>
                                </div>

                                <div class="pc-footer">
                                    <div>
                                        <div class="pc-gpa-label">Letter Grade</div>
                                        <c:choose>
                                            <c:when test="${enrollGrade != null && enrollGrade.letterGrade == 'A'}"><div class="pc-letter grade-A">A</div></c:when>
                                            <c:when test="${enrollGrade != null && (enrollGrade.letterGrade == 'B' || enrollGrade.letterGrade == 'B+' || enrollGrade.letterGrade == 'B-')}"><div class="pc-letter grade-B">${enrollGrade.letterGrade}</div></c:when>
                                            <c:when test="${enrollGrade != null && (enrollGrade.letterGrade == 'C' || enrollGrade.letterGrade == 'C+' || enrollGrade.letterGrade == 'C-')}"><div class="pc-letter grade-C">${enrollGrade.letterGrade}</div></c:when>
                                            <c:when test="${enrollGrade != null && enrollGrade.letterGrade == 'F'}"><div class="pc-letter grade-F">F</div></c:when>
                                            <c:otherwise><div class="pc-letter grade-na">—</div></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="pc-credits">
                                        <strong>${enrollment.credits}</strong>
                                        Credits
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty schedule}">
                            <div class="progress-card-item text-center py-4">
                                <i class="bi bi-bar-chart-line fs-2 text-secondary mb-2 d-block"></i>
                                <div class="fw-bold small text-dark">No Enrolled Courses</div>
                                <p class="small text-muted">Enroll in courses to see your academic progress.</p>
                            </div>
                        </c:if>
                    </div>
                    <div class="swipe-dots" id="swiperDots"></div>
                </div>

                <%-- All Term Courses list (click to open detail popup) --%>
                <div class="section-header">
                    <span class="section-title">This Term's Courses</span>
                    <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill small">${schedule.size()} Enrolled</span>
                </div>

                <c:choose>
                    <c:when test="${not empty schedule}">
                        <c:forEach var="enrollment" items="${schedule}">
                            <c:set var="enrollGrade" value="${gradeMap[enrollment.id]}" />
                            <div class="mobile-course-card" onclick="openCourseModal('${enrollment.id}')">
                                <div class="d-flex justify-content-between align-items-start mb-1">
                                    <span class="badge bg-primary bg-opacity-10 text-primary fw-bold">${enrollment.courseCode}</span>
                                    <c:choose>
                                        <c:when test="${enrollGrade != null && enrollGrade.letterGrade != 'N/A' && not empty enrollGrade.letterGrade}">
                                            <span class="badge ${enrollGrade.letterGrade == 'A' ? 'bg-success' : (enrollGrade.letterGrade == 'F' ? 'bg-danger' : 'bg-primary')} bg-opacity-15 text-${enrollGrade.letterGrade == 'A' ? 'success' : (enrollGrade.letterGrade == 'F' ? 'danger' : 'primary')} fw-bold">${enrollGrade.letterGrade}</span>
                                        </c:when>
                                        <c:otherwise><span class="badge bg-light border text-muted fw-normal">Pending</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="fw-bold text-dark small mb-1">${enrollment.courseTitle}</div>
                                <div class="text-muted" style="font-size:0.72rem;">
                                    <i class="bi bi-clock me-1"></i>${enrollment.sessionShift} &nbsp;|&nbsp;
                                    <i class="bi bi-geo-alt me-1"></i>Room ${enrollment.room} &nbsp;|&nbsp;
                                    <i class="bi bi-person me-1"></i>${enrollment.professorName}
                                </div>
                                <div class="mt-2 d-flex align-items-center gap-1" style="font-size:0.68rem;color:#94a3b8;">
                                    <i class="bi bi-chevron-right"></i> Tap to view scores &amp; attendance
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="mobile-course-card text-center py-4">
                            <i class="bi bi-calendar-x fs-2 text-secondary mb-2 d-block"></i>
                            <div class="fw-bold small text-dark mb-1">No Courses Enrolled</div>
                            <button type="button" class="btn btn-sm btn-outline-success rounded-pill px-3 mt-1" onclick="switchMobileTab('courses')">Browse Courses</button>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div><%-- end home --%>


            <%-- ===== COURSES SUB-VIEW ===== --%>
            <div id="mobile-view-courses" class="mobile-sub-view">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div><h5 class="fw-bold mb-0">Course Registration</h5><span class="text-muted" style="font-size:0.75rem;">Available for ${studentSchool.schoolName}</span></div>
                </div>
                <div class="input-group mb-3 shadow-sm rounded-4 overflow-hidden border">
                    <span class="input-group-text bg-white border-0 text-muted ps-3"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control border-0 py-2" placeholder="Search course code or title..." oninput="filterMobileCourses(this.value)">
                </div>
                <div id="mobileCourseList">
                    <c:forEach var="section" items="${availableClasses}">
                        <div class="mobile-course-card mobile-course-item" style="cursor:default;">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div><span class="badge bg-primary bg-opacity-10 text-primary fw-bold me-1">${section.courseCode}</span><span class="badge bg-secondary bg-opacity-10 text-secondary">${section.credits} Credits</span></div>
                                <span class="badge bg-light text-dark border">${section.termName}</span>
                            </div>
                            <h6 class="fw-bold text-dark mb-2">${section.courseTitle}</h6>
                            <div class="small text-muted mb-3" style="font-size:0.75rem;">
                                <div class="mb-1"><i class="bi bi-person me-2 text-primary"></i>${section.professorName}</div>
                                <div class="mb-1"><i class="bi bi-clock me-2 text-primary"></i>${section.sessionShift} (${section.daysOfWeek})</div>
                                <div><i class="bi bi-door-open me-2 text-primary"></i>Room ${section.roomName}</div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                                <span class="small ${section.enrolledCount >= section.roomCapacity ? 'text-danger fw-bold' : 'text-muted'}" style="font-size:0.72rem;"><i class="bi bi-people-fill me-1"></i>${section.enrolledCount}/${section.roomCapacity}</span>
                                <form action="${pageContext.request.contextPath}/student/dashboard" method="post" class="m-0">
                                    <input type="hidden" name="action" value="enroll">
                                    <input type="hidden" name="classSectionId" value="${section.id}">
                                    <c:set var="isEnrolledM" value="false" />
                                    <c:forEach var="myClass" items="${schedule}"><c:if test="${myClass.courseCode == section.courseCode}"><c:set var="isEnrolledM" value="true" /></c:if></c:forEach>
                                    <c:choose>
                                        <c:when test="${isEnrolledM}"><button type="button" class="btn btn-sm btn-outline-success rounded-pill px-3 py-1 disabled">Enrolled</button></c:when>
                                        <c:when test="${section.enrolledCount >= section.roomCapacity}"><button type="button" class="btn btn-sm btn-outline-danger rounded-pill px-3 py-1 disabled">Full</button></c:when>
                                        <c:otherwise><button type="submit" class="btn btn-sm btn-success rounded-pill px-3 py-1 fw-bold">Enroll</button></c:otherwise>
                                    </c:choose>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty availableClasses}"><div class="text-center py-5 text-muted"><i class="bi bi-journal-x fs-1 text-secondary mb-2 d-block"></i><div class="fw-bold">No Classes Available</div></div></c:if>
                </div>
            </div>


            <%-- ===== GRADES SUB-VIEW ===== --%>
            <div id="mobile-view-grades" class="mobile-sub-view">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0">Academic Transcript</h5>
                    <div class="bg-white border rounded-pill px-3 py-1 shadow-sm"><span class="small text-muted me-1">GPA:</span><span class="fw-bold text-success">${termGpa}</span></div>
                </div>
                <div class="mobile-course-card mb-3 p-3" style="background:linear-gradient(135deg,#10b981 0%,#059669 100%);color:white;border:none;">
                    <div class="d-flex justify-content-between align-items-center">
                        <div><div class="small text-white-50 text-uppercase fw-bold">Cumulative GPA</div><div class="fs-2 fw-bolder">${termGpa}</div></div>
                        <div class="text-end"><div class="small text-white-50 text-uppercase fw-bold">Earned Credits</div><div class="fs-4 fw-bolder">${earnedCredits} <span class="fs-6 fw-normal text-white-50">/ 60</span></div></div>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${not empty grades}">
                        <c:forEach var="grade" items="${grades}">
                            <div class="mobile-course-card" style="cursor:default;">
                                <div class="d-flex justify-content-between align-items-start mb-1">
                                    <span class="badge bg-secondary bg-opacity-10 text-secondary">${grade.termName}</span>
                                    <c:choose>
                                        <c:when test="${grade.letterGrade == 'A' || grade.letterGrade == 'A-'}"><span class="badge bg-success bg-opacity-15 text-success fw-bold">${grade.letterGrade}</span></c:when>
                                        <c:when test="${grade.letterGrade == 'B' || grade.letterGrade == 'B+' || grade.letterGrade == 'B-'}"><span class="badge bg-primary bg-opacity-15 text-primary fw-bold">${grade.letterGrade}</span></c:when>
                                        <c:when test="${grade.letterGrade != 'N/A' && not empty grade.letterGrade}"><span class="badge bg-warning bg-opacity-25 text-dark fw-bold">${grade.letterGrade}</span></c:when>
                                        <c:otherwise><span class="badge bg-light border text-muted">Pending</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="fw-bold text-dark mb-1">${grade.courseCode}</div>
                                <div class="text-muted small mb-3">${grade.courseTitle}</div>
                                <div class="d-flex justify-content-between align-items-center pt-2 border-top small text-muted" style="font-size:0.75rem;">
                                    <span>Credits: <strong class="text-dark">${grade.credits}</strong></span>
                                    <span>Score: <strong class="text-dark">${grade.totalScore > 0 ? grade.totalScore : '-'}</strong></span>
                                    <span>GPA: <strong class="text-success">${grade.letterGrade != 'N/A' ? grade.gpaPoint : '-'}</strong></span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise><div class="text-center py-5 text-muted"><i class="bi bi-journal-x fs-1 text-secondary mb-2 d-block"></i><div class="fw-bold">No Grades Available</div><p class="small">Grades will appear once finalized by your professors.</p></div></c:otherwise>
                </c:choose>
            </div>


            <%-- ===== SCHEDULE SUB-VIEW ===== --%>
            <div id="mobile-view-schedule" class="mobile-sub-view">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0">Class Schedule</h5>
                    <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill small">${schedule.size()} Enrolled</span>
                </div>
                <c:choose>
                    <c:when test="${not empty schedule}">
                        <c:forEach var="enrollment" items="${schedule}">
                            <div class="mobile-course-card" style="cursor:default;">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <span class="badge bg-success bg-opacity-10 text-success fw-bold">${enrollment.termName}</span>
                                    <span class="badge bg-light border text-dark">${enrollment.sessionShift}</span>
                                </div>
                                <h6 class="fw-bold text-dark mb-1">${enrollment.courseCode}</h6>
                                <div class="text-muted small mb-3">${enrollment.courseTitle}</div>
                                <div class="small text-muted" style="font-size:0.75rem;">
                                    <div class="mb-1"><i class="bi bi-clock me-2 text-primary"></i>${enrollment.daysOfWeek}</div>
                                    <div class="mb-1"><i class="bi bi-door-open me-2 text-primary"></i>Room ${enrollment.room}</div>
                                    <div><i class="bi bi-person me-2 text-primary"></i>${enrollment.professorName}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise><div class="text-center py-5 text-muted"><i class="bi bi-calendar-x fs-1 text-secondary mb-2 d-block"></i><div class="fw-bold">No Classes Enrolled</div><button type="button" class="btn btn-sm btn-success rounded-pill px-3 mt-2" onclick="switchMobileTab('courses')">Go to Registration</button></div></c:otherwise>
                </c:choose>
            </div>


            <%-- ===== PROFILE SUB-VIEW ===== --%>
            <div id="mobile-view-profile" class="mobile-sub-view">
                <h5 class="fw-bold mb-3">Student Profile</h5>
                <div class="mobile-course-card text-center p-4 mb-3" style="cursor:default;">
                    <div class="mobile-avatar-frame mx-auto mb-3" style="width:72px;height:72px;border-radius:20px;">
                        <img src="${pageContext.request.contextPath}/static/images/student_headshot.jpg" alt="Headshot" onerror="this.src='https://ui-avatars.com/api/?name=${user.fullName}&background=e2e8f0&color=0f172a&bold=true'">
                    </div>
                    <h5 class="fw-bold text-dark mb-1">${user.fullName}</h5>
                    <div class="badge bg-light border text-dark mb-2 px-3 py-1">ID: ${user.userIdentifier}</div>
                    <div class="text-muted small">${user.email}</div>
                </div>
                <div class="mobile-course-card mb-3 p-3" style="cursor:default;">
                    <div class="fw-bold small text-dark mb-3"><i class="bi bi-mortarboard me-2 text-primary"></i>Academic Details</div>
                    <div class="d-flex justify-content-between py-2 border-bottom small"><span class="text-muted">School:</span><span class="fw-semibold text-dark">${not empty studentSchool ? studentSchool.schoolName : 'Not Set'}</span></div>
                    <div class="d-flex justify-content-between py-2 border-bottom small"><span class="text-muted">Major:</span><span class="fw-semibold text-dark">${not empty user.major ? user.major : 'Undeclared'}</span></div>
                    <div class="d-flex justify-content-between py-2 small"><span class="text-muted">Cumulative GPA:</span><span class="fw-bold text-success">${termGpa}</span></div>
                </div>
                <div class="mobile-course-card mb-3 p-3" style="cursor:default;">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div><div class="fw-bold small text-dark"><i class="bi bi-shield-lock me-2 text-primary"></i>Two-Factor Authentication</div><div class="text-muted" style="font-size:0.72rem;">Email OTP on login</div></div>
                        <span class="badge ${user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">${user.twoFactorEnabled ? 'Enabled' : 'Disabled'}</span>
                    </div>
                    <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="mt-3">
                        <input type="hidden" name="redirect" value="/student/dashboard">
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
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger w-100 rounded-3 py-2 fw-semibold"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a>
            </div>


            <%-- Bottom Navigation Dock --%>
            <nav class="mobile-bottom-dock">
                <button type="button" class="dock-tab-btn active" data-tab="home" onclick="switchMobileTab('home')"><i class="bi bi-house-door-fill"></i><span>Home</span></button>
                <button type="button" class="dock-tab-btn" data-tab="courses" onclick="switchMobileTab('courses')"><i class="bi bi-journal-bookmark"></i><span>Courses</span></button>
                <button type="button" class="dock-tab-btn" data-tab="grades" onclick="switchMobileTab('grades')"><i class="bi bi-mortarboard"></i><span>Grades</span></button>
                <button type="button" class="dock-tab-btn" data-tab="schedule" onclick="switchMobileTab('schedule')"><i class="bi bi-calendar3"></i><span>Schedule</span></button>
                <button type="button" class="dock-tab-btn" data-tab="profile" onclick="switchMobileTab('profile')"><i class="bi bi-person"></i><span>Profile</span></button>
            </nav>

        </c:otherwise>
    </c:choose>
</div>


<%-- ================================================================== --%>
<%-- COURSE DETAIL MODAL SHEET (shared, filled via JS)                    --%>
<%-- ================================================================== --%>
<div class="course-modal-overlay" id="courseModalOverlay" onclick="closeCourseModalOnOverlay(event)">
    <div class="course-modal-sheet" id="courseModalSheet">
        <div class="sheet-drag-handle"></div>
        <div class="sheet-header">
            <div class="sheet-header-code" id="sheetCourseCode">ITE 205</div>
            <div class="sheet-header-title" id="sheetCourseTitle">Database Systems Administration</div>
            <div class="sheet-header-meta" id="sheetCourseMeta"></div>
            <button type="button" class="btn btn-sm btn-light rounded-3 mt-3 w-100" onclick="closeCourseModal()"><i class="bi bi-x me-1"></i>Close</button>
        </div>
        <div class="sheet-body">
            <div class="sheet-section-label">Score Breakdown</div>
            <div class="score-grid" id="sheetScoreGrid"></div>

            <div class="sheet-section-label mt-3">Overall</div>
            <div class="score-grid" id="sheetOverallGrid"></div>

            <div class="sheet-section-label mt-3">Attendance Record</div>
            <div id="sheetAttendanceSummary" class="att-summary"></div>
            <div class="attendance-list" id="sheetAttendanceList"></div>
        </div>
    </div>
</div>


<%-- Notification Modal --%>
<div class="modal fade" id="mobileSecurityModal" tabindex="-1" aria-labelledby="securityModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 pb-0"><h6 class="modal-title fw-bold" id="securityModalLabel"><i class="bi bi-bell me-2 text-primary"></i>Notifications</h6><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="p-3 bg-light rounded-3 mb-3">
                    <div class="d-flex align-items-center justify-content-between mb-1"><span class="small fw-bold">2FA Status</span><span class="badge ${user.twoFactorEnabled ? 'bg-success' : 'bg-secondary'} rounded-pill">${user.twoFactorEnabled ? 'Enabled' : 'Disabled'}</span></div>
                    <p class="small text-muted mb-0" style="font-size:0.72rem;">${user.twoFactorEnabled ? 'Account secured with email OTP.' : '2FA is currently off.'}</p>
                </div>
                <button type="button" class="btn btn-sm btn-primary w-100 rounded-3 py-2 fw-semibold" data-bs-dismiss="modal" onclick="switchMobileTab('profile')">Manage in Profile</button>
            </div>
        </div>
    </div>
</div>


<%-- Enrollment data for JS modal --%>
<script>
var enrollmentData = {};
</script>
<c:forEach var="enrollment" items="${schedule}">
    <c:set var="enrollGrade" value="${gradeMap[enrollment.id]}" />
    <c:set var="attList" value="${attendanceMap[enrollment.id]}" />
    <script>
    (function() {
        var eid = ${enrollment.id};
        var attRows = [];
        <c:if test="${not empty attList}">
            <c:forEach var="ae" items="${attList}">
        attRows.push({ date: '${ae.sessionDate}', status: '${ae.status}' });
            </c:forEach>
        </c:if>
        enrollmentData[eid] = {
            code: '${enrollment.courseCode}',
            title: '${enrollment.courseTitle}',
            shift: '${enrollment.sessionShift}',
            days: '${enrollment.daysOfWeek}',
            room: '${enrollment.room}',
            prof: '${enrollment.professorName}',
            credits: ${enrollment.credits},
            attScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.attendanceScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
            asgScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.assignmentScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
            midScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.midtermScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
            finScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.finalScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
            totalScore: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.totalScore}</c:when><c:otherwise>0</c:otherwise></c:choose>,
            letter: '<c:choose><c:when test="${enrollGrade != null}">${enrollGrade.letterGrade}</c:when><c:otherwise>N/A</c:otherwise></c:choose>',
            gpa: <c:choose><c:when test="${enrollGrade != null}">${enrollGrade.gpaPoint}</c:when><c:otherwise>0</c:otherwise></c:choose>,
            attendance: attRows
        };
    })();
    </script>
</c:forEach>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function switchMobileTab(tabName) {
        var views = document.querySelectorAll('.mobile-sub-view');
        for (var i = 0; i < views.length; i++) views[i].classList.remove('active');
        var target = document.getElementById('mobile-view-' + tabName);
        if (target) target.classList.add('active');

        var btns = document.querySelectorAll('.dock-tab-btn');
        var iconMap = { home: ['bi-house-door-fill','bi-house-door'], courses: ['bi-journal-bookmark-fill','bi-journal-bookmark'], grades: ['bi-mortarboard-fill','bi-mortarboard'], schedule: ['bi-calendar3-fill','bi-calendar3'], profile: ['bi-person-fill','bi-person'] };
        for (var j = 0; j < btns.length; j++) {
            var b = btns[j], bTab = b.getAttribute('data-tab'), ic = b.querySelector('i');
            if (bTab === tabName) { b.classList.add('active'); if (ic && iconMap[bTab]) ic.className = 'bi ' + iconMap[bTab][0]; }
            else { b.classList.remove('active'); if (ic && iconMap[bTab]) ic.className = 'bi ' + iconMap[bTab][1]; }
        }
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function filterMobileCourses(q) {
        q = (q || '').toLowerCase().trim();
        var items = document.querySelectorAll('.mobile-course-item');
        for (var i = 0; i < items.length; i++) {
            items[i].style.display = (items[i].textContent || '').toLowerCase().indexOf(q) !== -1 ? '' : 'none';
        }
    }

    function openCourseModal(enrollmentId) {
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
    }

    function makeTile(label, val, highlight) {
        var cls = highlight ? 'score-tile highlight' : 'score-tile';
        var valHtml = val !== null ? '<div class="score-tile-val">' + val + '</div>' : '<div class="score-tile-val pending">Pending</div>';
        return '<div class="' + cls + '"><div class="score-tile-label">' + label + '</div>' + valHtml + '</div>';
    }

    function closeCourseModal() {
        document.getElementById('courseModalOverlay').classList.remove('open');
        document.body.style.overflow = '';
    }

    function closeCourseModalOnOverlay(e) {
        if (e.target === document.getElementById('courseModalOverlay')) closeCourseModal();
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
        for (var i = 0; i < 7; i++) {
            var d = new Date(monday);
            d.setDate(monday.getDate() + i);
            
            var isToday = (d.getDate() === new Date().getDate() && d.getMonth() === new Date().getMonth());
            
            html += '<div class="date-strip-item ' + (isToday ? 'active' : '') + '">' +
                    '<div class="ds-day">' + days[d.getDay()] + '</div>' +
                    '<div class="ds-date">' + d.getDate() + '</div>' +
                    '</div>';
        }
        strip.innerHTML = html;
        
        // Scroll slightly if active element is towards the right
        setTimeout(function() {
            var active = strip.querySelector('.active');
            if (active) {
                strip.scrollLeft = active.offsetLeft - (strip.offsetWidth / 2) + (active.offsetWidth / 2);
            }
        }, 100);
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
        swiper.addEventListener('scroll', function() {
            var idx = Math.round(swiper.scrollLeft / (swiper.scrollWidth / cards.length));
            var allDots = dots.querySelectorAll('.swipe-dot');
            for (var j = 0; j < allDots.length; j++) allDots[j].classList.toggle('active', j === idx);
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        initMobileDateStrip();
        initSwiperDots();
    });
</script>
</body>
</html>
