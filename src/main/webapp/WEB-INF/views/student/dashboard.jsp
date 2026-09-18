<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - UniTRS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .dashboard-header { background-color: #198754; color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .nav-tabs .nav-link { color: #495057; font-weight: 500; }
        .nav-tabs .nav-link.active { font-weight: 700; color: #198754; }
        .card-custom { border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-radius: 12px; }
        .table th { background-color: #f1f3f5; font-weight: 600; }
    </style>
</head>
<body>

    <!-- Header -->
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
                    <label for="twoFactorSelect" class="text-white me-2 small mb-0"><i class="bi bi-shield-lock me-1"></i>2FA:</label>
                    <select id="twoFactorSelect" name="twoFactorEnabled" class="form-select form-select-sm bg-light text-dark border-0 py-0" style="font-size: 0.8rem; width: auto;" onchange="this.form.submit()">
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

        <!-- Alerts -->
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
                <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:choose>
            <%-- State 1: School Selection Required --%>
            <c:when test="${empty user.studentSchoolId}">
                <div class="row justify-content-center mt-5">
                    <div class="col-md-6">
                        <div class="card card-custom border-top border-success border-4">
                            <div class="card-body text-center p-5">
                                <i class="bi bi-building text-success mb-3" style="font-size: 4rem;"></i>
                                <h3 class="card-title mb-4">Welcome to UniTRS</h3>
                                <p class="text-muted mb-4">Before you can register for classes and view your schedule, you must select your academic school.</p>
                                
                                <form action="${pageContext.request.contextPath}/student/dashboard" method="post">
                                    <input type="hidden" name="action" value="selectSchool">
                                    <div class="mb-4 text-start">
                                        <label class="form-label fw-bold">Select Your School</label>
                                        <select class="form-select form-select-lg" name="schoolId" required>
                                            <option value="" selected disabled>-- Choose a School --</option>
                                            <c:forEach var="school" items="${schools}">
                                                <option value="${school.id}">${school.schoolName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-success btn-lg w-100">Continue to Dashboard <i class="bi bi-arrow-right ms-1"></i></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            
            <%-- State 2: Full Dashboard --%>
            <c:otherwise>
                
                <!-- Navigation Tabs -->
                <ul class="nav nav-tabs mb-4" id="studentTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="schedule-tab" data-bs-toggle="tab" data-bs-target="#schedule" type="button" role="tab"><i class="bi bi-calendar3 me-2"></i>My Schedule</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="registration-tab" data-bs-toggle="tab" data-bs-target="#registration" type="button" role="tab"><i class="bi bi-plus-circle me-2"></i>Term Registration</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="grades-tab" data-bs-toggle="tab" data-bs-target="#grades" type="button" role="tab"><i class="bi bi-journal-check me-2"></i>Grades & Transcript</button>
                    </li>
                </ul>

                <div class="tab-content" id="studentTabsContent">
                    
                    <!-- 1. My Schedule Tab -->
                    <div class="tab-pane fade show active" id="schedule" role="tabpanel">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Current Schedule</h4>
                        </div>
                        
                        <div class="card card-custom">
                            <div class="card-body p-0">
                                <c:if test="${empty schedule}">
                                    <div class="p-5 text-center text-muted">
                                        <i class="bi bi-calendar-x mb-3" style="font-size: 3rem;"></i>
                                        <h5>No Classes Scheduled</h5>
                                        <p>You haven't registered for any classes yet. Head over to the Registration tab to get started.</p>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty schedule}">
                                    <table class="table table-hover mb-0 align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-3">Term</th>
                                                <th>Course</th>
                                                <th>Professor</th>
                                                <th>Time & Days</th>
                                                <th>Room</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="enrollment" items="${schedule}">
                                                <tr>
                                                    <td class="ps-3"><span class="badge bg-success">${enrollment.termName}</span><br><small class="text-muted">${enrollment.academicYear}</small></td>
                                                    <td><strong>${enrollment.courseCode}</strong><br><small>${enrollment.courseTitle}</small></td>
                                                    <td><i class="bi bi-person-badge text-primary me-1"></i>${enrollment.professorName}</td>
                                                    <td>
                                                        <span class="badge bg-light border text-dark">${enrollment.sessionShift}</span><br>
                                                        <small class="text-muted"><i class="bi bi-clock me-1"></i>${enrollment.daysOfWeek}</small>
                                                    </td>
                                                    <td><i class="bi bi-door-open me-1"></i>${enrollment.room}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- 2. Registration Tab -->
                    <div class="tab-pane fade" id="registration" role="tabpanel">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Available Classes</h4>
                            <span class="text-muted small">Showing classes offered for ${studentSchool.schoolName}</span>
                        </div>
                        
                        <div class="row g-4">
                            <c:forEach var="section" items="${availableClasses}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="card card-custom h-100 position-relative">
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
                                                    <i class="bi bi-people-fill me-1"></i> ${section.enrolledCount}/${section.roomCapacity} Enrolled
                                                </span>
                                                
                                                <form action="${pageContext.request.contextPath}/student/dashboard" method="post">
                                                    <input type="hidden" name="action" value="enroll">
                                                    <input type="hidden" name="classSectionId" value="${section.id}">
                                                    
                                                    <c:set var="isEnrolled" value="false" />
                                                    <c:forEach var="myClass" items="${schedule}">
                                                        <c:if test="${myClass.courseCode == section.courseCode}">
                                                            <c:set var="isEnrolled" value="true" />
                                                        </c:if>
                                                    </c:forEach>
                                                    
                                                    <c:choose>
                                                        <c:when test="${isEnrolled}">
                                                            <button type="button" class="btn btn-outline-success btn-sm disabled">Enrolled</button>
                                                        </c:when>
                                                        <c:when test="${section.enrolledCount >= section.roomCapacity}">
                                                            <button type="button" class="btn btn-danger btn-sm disabled">Full</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="submit" class="btn btn-success btn-sm">Enroll</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty availableClasses}">
                                <div class="col-12">
                                    <div class="alert alert-info">There are currently no classes scheduled for your school this term. Please check back later.</div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 3. Grades & Transcript Tab -->
                    <div class="tab-pane fade" id="grades" role="tabpanel">
                        <div class="row align-items-center mb-3">
                            <div class="col">
                                <h4 class="mb-0">Academic Transcript</h4>
                            </div>
                            <div class="col-auto text-end">
                                <div class="bg-light border rounded px-4 py-2 d-inline-block shadow-sm">
                                    <div class="small text-muted text-uppercase fw-bold mb-1">Cumulative GPA</div>
                                    <div class="fs-3 fw-bold text-success">${termGpa}</div>
                                </div>
                            </div>
                        </div>

                        <div class="card card-custom">
                            <div class="card-body p-0">
                                <c:if test="${empty grades}">
                                    <div class="p-5 text-center text-muted">
                                        <i class="bi bi-journal-x mb-3" style="font-size: 3rem;"></i>
                                        <h5>No Grades Yet</h5>
                                        <p>Your grades will appear here once your professors have finalized them.</p>
                                    </div>
                                </c:if>

                                <c:if test="${not empty grades}">
                                    <table class="table table-hover mb-0 align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-3">Term</th>
                                                <th>Course</th>
                                                <th class="text-center">Credits</th>
                                                <th class="text-center">Total Score</th>
                                                <th class="text-center">Letter Grade</th>
                                                <th class="text-center pe-3">GPA Points</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="grade" items="${grades}">
                                                <tr>
                                                    <td class="ps-3"><span class="badge bg-secondary">${grade.termName}</span></td>
                                                    <td><strong>${grade.courseCode}</strong><br><small class="text-muted">${grade.courseTitle}</small></td>
                                                    <td class="text-center">${grade.credits}</td>
                                                    <td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${grade.totalScore > 0}">${grade.totalScore}</c:when>
                                                            <c:otherwise><span class="text-muted fst-italic">Pending</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center fw-bold text-success">
                                                        <c:choose>
                                                            <c:when test="${grade.letterGrade != 'N/A'}">${grade.letterGrade}</c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center pe-3 fw-bold">
                                                        <c:choose>
                                                            <c:when test="${grade.letterGrade != 'N/A'}">${grade.gpaPoint}</c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div> <!-- End Tabs Content -->
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
