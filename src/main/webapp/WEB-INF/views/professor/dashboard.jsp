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

                    .mobile-class-card:active {
                        transform: scale(0.98);
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
                    }

                    
            .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
            .section-title { font-size: 1.0rem; font-weight: 800; color: #0f172a; }
            .mobile-class-card { background: #fff; border-radius: 18px; padding: 16px; margin-bottom: 12px; border: 1px solid #edf2f7; box-shadow: 0 4px 12px rgba(0,0,0,0.02); position: relative; overflow: hidden; cursor: pointer; transition: transform 0.15s; }
            .mobile-class-card:active { transform: scale(0.98); }
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
<div class="d-none d-md-block desktop-app-container">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/professor/dashboard">
                <i class="bi bi-person-workspace me-2"></i>UniTRS Professor
            </a>
            <div class="navbar-nav ms-auto align-items-center">
                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="d-flex align-items-center me-3 bg-secondary bg-opacity-25 px-2 py-1 rounded">
                    <input type="hidden" name="redirect" value="/professor/dashboard">
                    <label for="twoFactorSelectProf" class="text-white-50 me-2 small mb-0"><i class="bi bi-shield-lock me-1"></i>2FA:</label>
                    <select id="twoFactorSelectProf" name="twoFactorEnabled" class="form-select form-select-sm bg-dark text-white border-secondary py-0" style="font-size: 0.8rem; width: auto;" onchange="this.form.submit()">
                        <option value="false" ${!sessionScope.user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                        <option value="true" ${sessionScope.user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                    </select>
                </form>
                <span class="navbar-text me-3">
                    <i class="bi bi-person-circle me-1"></i>${sessionScope.user.fullName}
                </span>
                <c:if test="${sessionScope.user.deanSchoolId != null}">
                    <a href="${pageContext.request.contextPath}/dean/dashboard" class="btn btn-outline-info btn-sm me-2"><i class="bi bi-mortarboard"></i> Switch to Dean Dashboard</a>
                </c:if>
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/auth/logout">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 mb-5">
        <h2 class="mb-4">My Assigned Classes</h2>
        
        <c:if test="${param.twoFactorUpdated == 'true'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-shield-check me-2"></i>Two-Factor Authentication (2FA) is now <strong>enabled</strong> for your account. You will receive an email code upon login.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${param.twoFactorUpdated == 'false'}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="bi bi-shield-slash me-2"></i>Two-Factor Authentication (2FA) has been <strong>disabled</strong> for your account. You will log in directly.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${empty sectionStudentsMap}">
            <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i>You have not been assigned to teach any classes.
            </div>
        </c:if>
        
        <div class="row">
            <!-- Left Column: Classes and Attendance -->
            <div class="col-lg-8">
                <div class="accordion" id="classesAccordion">
                    <c:forEach var="entry" items="${sectionStudentsMap}" varStatus="status">
                <c:set var="section" value="${entry.key}" />
                <c:set var="students" value="${entry.value}" />
                
                <div class="accordion-item mb-3 border rounded shadow-sm">
                    <h2 class="accordion-header" id="heading${status.index}">
                        <button class="accordion-button ${status.index != 0 ? 'collapsed' : ''}" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${status.index}" aria-expanded="${status.index == 0 ? 'true' : 'false'}" aria-controls="collapse${status.index}">
                            <div class="d-flex w-100 justify-content-between align-items-center me-3">
                                <div>
                                    <strong>${section.courseCode}</strong> - ${section.courseTitle}
                                    <span class="badge bg-primary ms-2">${section.termName}</span>
                                </div>
                                <div class="text-muted small">
                                    <i class="bi bi-calendar-event me-1"></i>${section.daysOfWeek} (${section.sessionShift}) | 
                                    <i class="bi bi-door-open me-1"></i>${section.roomName} | 
                                    <i class="bi bi-people me-1"></i>Students: ${students.size()}
                                </div>
                            </div>
                        </button>
                    </h2>
                    <div id="collapse${status.index}" class="accordion-collapse collapse ${status.index == 0 ? 'show' : ''}" aria-labelledby="heading${status.index}" data-bs-parent="#classesAccordion">
                        <div class="accordion-body p-0">
                            
                            <div class="bg-light p-3 border-bottom d-flex justify-content-end">
                                <button type="button" class="btn btn-outline-secondary btn-sm me-2" data-bs-toggle="modal" data-bs-target="#historyModal${section.id}">
                                    <i class="bi bi-clock-history me-1"></i> Attendance History
                                </button>
                                <button type="button" class="btn btn-primary btn-sm me-2" data-bs-toggle="modal" data-bs-target="#attendanceModal${section.id}">
                                    <i class="bi bi-clipboard-check me-1"></i> Take Attendance
                                </button>
                                <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#gradesModal${section.id}">
                                    <i class="bi bi-journal-text me-1"></i> Manage Grades
                                </button>
                            </div>
                            
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-3">Student ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Major</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td class="ps-3"><span class="badge bg-secondary">${student.userIdentifier}</span></td>
                                            <td><strong>${student.fullName}</strong></td>
                                            <td>${student.email}</td>
                                            <td>${student.major}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty students}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted py-4">No students have enrolled in this class yet.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Take Attendance Modal -->
                <div class="modal fade" id="attendanceModal${section.id}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/professor/attendance/save" method="post">
                                <input type="hidden" name="classSectionId" value="${section.id}">
                                <div class="modal-header bg-primary text-white">
                                    <h5 class="modal-title"><i class="bi bi-clipboard-check me-2"></i>Take Attendance - ${section.courseCode}</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-4">
                                        <label class="form-label fw-bold">Session Date</label>
                                        <input type="date" class="form-control w-50" name="sessionDate" required>
                                    </div>
                                    
                                    <h6 class="border-bottom pb-2 mb-3">Student Roster</h6>
                                    <c:if test="${empty students}">
                                        <p class="text-muted text-center py-3">No students enrolled yet.</p>
                                    </c:if>
                                    
                                    <c:forEach var="student" items="${students}">
                                        <div class="d-flex justify-content-between align-items-center mb-3 p-2 border rounded hover-bg-light">
                                            <div>
                                                <strong>${student.fullName}</strong>
                                                <div class="text-muted small">${student.userIdentifier}</div>
                                            </div>
                                            <div>
                                                <div class="btn-group" role="group">
                                                    <input type="radio" class="btn-check" name="status_${student.id}" id="present_${section.id}_${student.id}" value="PRESENT" checked>
                                                    <label class="btn btn-outline-success btn-sm" for="present_${section.id}_${student.id}">Present</label>
                                                  
                                                    <input type="radio" class="btn-check" name="status_${student.id}" id="absent_${section.id}_${student.id}" value="ABSENT">
                                                    <label class="btn btn-outline-danger btn-sm" for="absent_${section.id}_${student.id}">Absent</label>
                                                  
                                                    <input type="radio" class="btn-check" name="status_${student.id}" id="late_${section.id}_${student.id}" value="LATE">
                                                    <label class="btn btn-outline-warning btn-sm" for="late_${section.id}_${student.id}">Late</label>
                                                    
                                                    <input type="radio" class="btn-check" name="status_${student.id}" id="excused_${section.id}_${student.id}" value="EXCUSED">
                                                    <label class="btn btn-outline-info btn-sm" for="excused_${section.id}_${student.id}">Excused</label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <c:if test="${not empty students}">
                                        <button type="submit" class="btn btn-primary">Save Attendance</button>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Attendance History Modal -->
                <div class="modal fade" id="historyModal${section.id}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><i class="bi bi-clock-history me-2"></i>Attendance History - ${section.courseCode}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-0">
                                <c:set var="records" value="${sectionAttendanceMap[section.id]}" />
                                <c:if test="${empty records}">
                                    <div class="p-4 text-center text-muted">No attendance records found.</div>
                                </c:if>
                                <c:if test="${not empty records}">
                                    <table class="table mb-0 align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-3">Date (Click to View Roster)</th>
                                                <th>Present</th>
                                                <th>Absent</th>
                                                <th>Late/Excused</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="record" items="${records}">
                                                <tr>
                                                    <td class="ps-3">
                                                        <a class="text-decoration-none fw-bold" data-bs-toggle="collapse" href="#recordDetails_${section.id}_${record.id}" role="button" aria-expanded="false">
                                                            <i class="bi bi-chevron-down me-1 small"></i>${record.sessionDate}
                                                        </a>
                                                    </td>
                                                    <td><span class="badge bg-success">${record.presentCount}</span></td>
                                                    <td><span class="badge bg-danger">${record.absentCount}</span></td>
                                                    <td><span class="badge bg-secondary">${record.lateCount + record.excusedCount}</span></td>
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
                                                                                <span class="text-muted ms-1">(${entry.studentIdentifier})</span>
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
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Manage Grades Modal -->
                <div class="modal fade" id="gradesModal${section.id}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/professor/grades/save" method="post">
                                <input type="hidden" name="classSectionId" value="${section.id}">
                                <div class="modal-header bg-success text-white">
                                    <h5 class="modal-title"><i class="bi bi-journal-text me-2"></i>Manage Grades - ${section.courseCode}</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-0">
                                    <c:set var="grades" value="${sectionGradesMap[section.id]}" />
                                    <c:if test="${empty grades}">
                                        <div class="p-4 text-center text-muted">No students enrolled to grade yet.</div>
                                    </c:if>
                                    <c:if test="${not empty grades}">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0 align-middle">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-3">Student Name</th>
                                                        <th style="width: 120px;">Attendance (15)</th>
                                                        <th style="width: 120px;">Assignment (25)</th>
                                                        <th style="width: 120px;">Midterm (30)</th>
                                                        <th style="width: 120px;">Final (30)</th>
                                                        <th style="width: 100px;">Total</th>
                                                        <th style="width: 80px;">Grade</th>
                                                        <th class="pe-3" style="width: 80px;">GPA</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="grade" items="${grades}">
                                                        <tr>
                                                            <td class="ps-3">
                                                                <strong>${grade.studentName}</strong>
                                                                <div class="text-muted small">${grade.studentIdentifier}</div>
                                                            </td>
                                                            <td>
                                                                <input type="number" class="form-control form-control-sm text-center" 
                                                                       name="attendance_${grade.enrollmentId}" value="${grade.attendanceScore}" 
                                                                       min="0" max="15" step="0.01" required>
                                                            </td>
                                                            <td>
                                                                <input type="number" class="form-control form-control-sm text-center" 
                                                                       name="assignment_${grade.enrollmentId}" value="${grade.assignmentScore}" 
                                                                       min="0" max="25" step="0.01" required>
                                                            </td>
                                                            <td>
                                                                <input type="number" class="form-control form-control-sm text-center" 
                                                                       name="midterm_${grade.enrollmentId}" value="${grade.midtermScore}" 
                                                                       min="0" max="30" step="0.01" required>
                                                            </td>
                                                            <td>
                                                                <input type="number" class="form-control form-control-sm text-center" 
                                                                       name="final_${grade.enrollmentId}" value="${grade.finalScore}" 
                                                                       min="0" max="30" step="0.01" required>
                                                            </td>
                                                            <td class="text-center fw-bold bg-light">${grade.totalScore}</td>
                                                            <td class="text-center fw-bold bg-light text-primary">${grade.letterGrade}</td>
                                                            <td class="pe-3 text-center text-muted bg-light">${grade.gpaPoint}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <c:if test="${not empty grades}">
                                        <button type="submit" class="btn btn-success">Save Grades</button>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
            </c:forEach>
                </div>
            </div>
            
            <!-- Right Column: Schedule Overview -->
            <div class="col-lg-4">
                <div class="card shadow-sm sticky-top" style="top: 20px;">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="bi bi-calendar3 me-2 text-primary"></i>Term Schedule</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <c:if test="${empty sectionStudentsMap}">
                            <div class="list-group-item text-muted text-center py-4">
                                No classes scheduled.
                            </div>
                        </c:if>
                        <c:forEach var="entry" items="${sectionStudentsMap}">
                            <c:set var="section" value="${entry.key}" />
                            <div class="list-group-item">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1 fw-bold text-dark">${section.courseCode}</h6>
                                    <small class="text-primary">${section.sessionShift}</small>
                                </div>
                                <p class="mb-1 small text-muted">${section.courseTitle}</p>
                                <small>
                                    <i class="bi bi-clock me-1"></i>${section.daysOfWeek}
                                    <br>
                                    <i class="bi bi-door-open me-1"></i>Room ${section.roomName}
                                </small>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="card-footer bg-light text-center small text-muted">
                        Up through Midterm and Final
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div><!-- End Desktop App Container -->

<div class="d-block d-md-none mobile-app-container">
    
    <!-- Top Bar -->
    <div class="mobile-top-bar">
        <div class="mobile-user-info">
            <div class="mobile-avatar-frame">
                <img src="${pageContext.request.contextPath}/static/images/default-avatar.png" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=e2e8f0&color=475569'" alt="Avatar">
            </div>
            <div>
                <div class="mobile-user-greeting">Hi, Prof. ${sessionScope.user.fullName.split(' ')[0]}</div>
                <div class="mobile-badge-pill">Faculty Member</div>
            </div>
        </div>
        <button class="mobile-top-action-btn"><i class="bi bi-bell"></i></button>
    </div>

    <!-- Home View -->
    <div id="mobile-view-home" class="mobile-sub-view active">
        <div class="mobile-date-strip" id="mobileDateStrip"></div>

        <%-- Hero Banner --%>
        <div class="mobile-hero-banner">
            <div class="hero-avatar-box">
                <i class="bi bi-person-workspace"></i>
            </div>
            <div class="hero-content">
                <div class="hero-label">Current Term Status</div>
                <div class="hero-title">Academic Year 26-27</div>
                <div class="hero-meta-row">
                    <span><i class="bi bi-journal-bookmark-fill"></i> ${sectionStudentsMap.size()} Classes Assigned</span>
                </div>
                <div class="hero-status-tag"><i class="bi bi-check-circle-fill"></i> Active Faculty</div>
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
            <div class="mobile-class-card" onclick="openCourseSheet('${section.id}')">
                <div class="mc-header">
                    <div class="mc-code">${section.courseCode}</div>
                    <div class="mc-badge">${section.termName}</div>
                </div>
                <div class="mc-title">${section.courseTitle}</div>
                <div class="mc-meta">
                    <div class="mc-meta-item"><i class="bi bi-clock"></i>${section.sessionShift}</div>
                    <div class="mc-meta-item"><i class="bi bi-door-open"></i>Room ${section.roomName}</div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Classes View -->
    <div id="mobile-view-classes" class="mobile-sub-view">
        <div class="section-header">
            <div class="section-title">All Assigned Classes</div>
        </div>
        
        <c:if test="${empty sectionStudentsMap}">
            <div class="text-center p-4 bg-white rounded-4 border">
                <div class="fw-bold mt-2 text-dark">No classes assigned</div>
            </div>
        </c:if>
        
        <c:forEach var="entry" items="${sectionStudentsMap}">
            <c:set var="section" value="${entry.key}" />
            <c:set var="students" value="${entry.value}" />
            <div class="mobile-class-card" onclick="openCourseSheet('${section.id}')">
                <div class="mc-header">
                    <div class="mc-code">${section.courseCode}</div>
                    <div class="mc-badge">${section.termName}</div>
                </div>
                <div class="mc-title">${section.courseTitle}</div>
                <div class="mc-meta">
                    <div class="mc-meta-item"><i class="bi bi-calendar-event"></i>${section.daysOfWeek}</div>
                    <div class="mc-meta-item"><i class="bi bi-clock"></i>${section.sessionShift}</div>
                </div>
                <div class="mc-students"><i class="bi bi-people-fill"></i> ${students.size()} Students Enrolled</div>
            </div>
        </c:forEach>
    </div>

    <!-- Profile View -->
    <div id="mobile-view-profile" class="mobile-sub-view">
        <div class="section-header"><div class="section-title">Settings & Profile</div></div>
        
        <div class="bg-white rounded-4 p-3 border mb-3">
            <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST">
                <input type="hidden" name="redirect" value="/professor/dashboard">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="fw-bold text-dark"><i class="bi bi-shield-lock text-primary me-2"></i>Two-Factor Auth</div>
                        <div class="small text-muted mt-1">Receive email code on login</div>
                    </div>
                    <div class="form-check form-switch fs-4 m-0">
                        <input class="form-check-input" type="checkbox" name="twoFactorEnabled" value="true" ${sessionScope.user.twoFactorEnabled ? 'checked' : ''} onchange="this.form.submit()">
                    </div>
                </div>
            </form>
        </div>
        
        <c:if test="${sessionScope.user.deanSchoolId != null}">
            <a href="${pageContext.request.contextPath}/dean/dashboard" class="btn btn-outline-info w-100 rounded-3 py-3 fw-bold mb-3"><i class="bi bi-mortarboard me-2"></i>Switch to Dean View</a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-danger w-100 rounded-3 py-3 fw-bold"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a>
    </div>

    <!-- Bottom Navigation Dock -->
    <nav class="mobile-bottom-dock">
        <button type="button" class="dock-tab-btn active" data-tab="home" onclick="switchMobileTab('home')"><i class="bi bi-house-door-fill"></i><span>Home</span></button>
        <button type="button" class="dock-tab-btn" data-tab="classes" onclick="switchMobileTab('classes')"><i class="bi bi-journal-bookmark-fill"></i><span>Classes</span></button>
        <button type="button" class="dock-tab-btn" data-tab="profile" onclick="switchMobileTab('profile')"><i class="bi bi-person-fill"></i><span>Profile</span></button>
    </nav>
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
                                <div class="student-id">${student.userIdentifier}</div>
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
                <div class="sheet-body">
                    <c:if test="${empty grades}"><div class="text-center text-muted p-3 border rounded-3 bg-light">No students to grade</div></c:if>
                    <c:forEach var="grade" items="${grades}">
                        <div class="student-row">
                            <div class="student-info">
                                <div class="student-name">${grade.studentName}</div>
                                <div class="student-id">${grade.studentIdentifier}</div>
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

<script>
    var classData = {
        <c:forEach var="entry" items="${sectionStudentsMap}">
        <c:set var="section" value="${entry.key}" />
        '${section.id}': { code: '${section.courseCode}', title: '${section.courseTitle.replace("'", "\'")}' },
        </c:forEach>
    };

    var currentActiveSectionId = null;

    function switchMobileTab(tab) {
        document.querySelectorAll('.mobile-sub-view').forEach(el => el.classList.remove('active'));
        document.getElementById('mobile-view-' + tab).classList.add('active');
        document.querySelectorAll('.dock-tab-btn').forEach(btn => {
            btn.classList.toggle('active', btn.getAttribute('data-tab') === tab);
        });
        window.scrollTo(0,0);
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
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        initMobileDateStrip();
    });
</script>


</body>
</html>
