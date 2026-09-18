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
</head>
<body>
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
</body>
</html>
