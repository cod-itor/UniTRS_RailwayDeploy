<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dean Dashboard - Curriculum Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        body { background-color: #f8f9fa; }
        .dashboard-header { background-color: #343a40; color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .nav-tabs .nav-link { color: #495057; font-weight: 500; }
        .nav-tabs .nav-link.active { font-weight: 700; color: #0d6efd; }
        .card-custom { border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-radius: 12px; }
        .table th { background-color: #f1f3f5; font-weight: 600; }
    </style>
</head>
<body>

    <!-- Header -->
    <header class="dashboard-header shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-1"><i class="bi bi-mortarboard me-2"></i>Dean Dashboard - ${deanSchool.schoolName}</h2>
                <p class="mb-0 text-white-50">Curriculum & Academic Management</p>
            </div>
            <div class="d-flex align-items-center">
                <form action="${pageContext.request.contextPath}/auth/update-2fa" method="POST" class="d-flex align-items-center me-3 bg-white bg-opacity-10 px-2 py-1 rounded">
                    <input type="hidden" name="redirect" value="/dean/dashboard">
                    <label for="twoFactorSelectDean" class="text-white me-2 small mb-0"><i class="bi bi-shield-lock me-1"></i>2FA:</label>
                    <select id="twoFactorSelectDean" name="twoFactorEnabled" class="form-select form-select-sm bg-light text-dark border-0 py-0" style="font-size: 0.8rem; width: auto;" onchange="this.form.submit()">
                        <option value="false" ${!user.twoFactorEnabled ? 'selected' : ''}>Disabled</option>
                        <option value="true" ${user.twoFactorEnabled ? 'selected' : ''}>Enabled</option>
                    </select>
                </form>
                <span class="me-3 text-white"><i class="bi bi-person-circle me-1"></i> ${user.fullName}</span>
                <c:if test="${user.role == 'PROFESSOR'}">
                    <a href="${pageContext.request.contextPath}/professor/dashboard" class="btn btn-outline-info btn-sm me-2"><i class="bi bi-person-workspace"></i> Switch to Professor Dashboard</a>
                </c:if>
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

        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs mb-4" id="deanTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link ${activeTab == 'courses' ? 'active' : ''}" id="courses-tab" data-bs-toggle="tab" data-bs-target="#courses" type="button" role="tab"><i class="bi bi-book me-2"></i>Master Courses</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link ${activeTab == 'terms' ? 'active' : ''}" id="terms-tab" data-bs-toggle="tab" data-bs-target="#terms" type="button" role="tab"><i class="bi bi-calendar3 me-2"></i>Academic Terms</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link ${activeTab == 'students' ? 'active' : ''}" id="students-tab" data-bs-toggle="tab" data-bs-target="#students" type="button" role="tab"><i class="bi bi-people me-2"></i>Students</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link ${activeTab == 'bundles' ? 'active' : ''}" id="bundles-tab" data-bs-toggle="tab" data-bs-target="#bundles" type="button" role="tab"><i class="bi bi-collection me-2"></i>Curriculum Bundling</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link ${activeTab == 'schedules' ? 'active' : ''}" id="schedules-tab" data-bs-toggle="tab" data-bs-target="#schedules" type="button" role="tab"><i class="bi bi-clock-history me-2"></i>Class Schedules</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link ${activeTab == 'facilities' ? 'active' : ''}" id="facilities-tab" data-bs-toggle="tab" data-bs-target="#facilities" type="button" role="tab"><i class="bi bi-building me-2"></i>Facility Management</button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content" id="deanTabsContent">
            
            <!-- 1. Master Courses Tab -->
            <div class="tab-pane fade ${activeTab == 'courses' ? 'show active' : ''}" id="courses" role="tabpanel">
                <div class="row">
                    <!-- Main Content: Course Catalog -->
                    <div class="col-md-12">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Course Catalog</h4>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCourseModal"><i class="bi bi-plus-lg me-1"></i> Add Course</button>
                        </div>
                        
                        <div class="card card-custom">
                            <div class="card-body p-0">
                                <table class="table table-hover mb-0" id="coursesTable">
                                    <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Course Code</th>
                                    <th>Course Title</th>
                                    <th>School / College</th>
                                    <th>Credits</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="course" items="${courses}">
                                    <tr class="course-row">
                                        <td>${course.id}</td>
                                        <td><span class="badge bg-secondary">${course.courseCode}</span></td>
                                        <td>${course.courseTitle}</td>
                                        <td><small class="text-muted"><i class="bi bi-building me-1"></i>${course.schoolName}</small></td>
                                        <td>${course.credits}</td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editCourseModal${course.id}"><i class="bi bi-pencil"></i> Edit</button>
                                        </td>
                                    </tr>

                                    <!-- Edit Course Modal -->
                                    <div class="modal fade" id="editCourseModal${course.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                                                <input type="hidden" name="action" value="updateCourse">
                                                <input type="hidden" name="courseId" value="${course.id}">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Edit Course</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label class="form-label">Course Code</label>
                                                        <input type="text" class="form-control" name="courseCode" value="${course.courseCode}" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Course Title</label>
                                                        <input type="text" class="form-control" name="courseTitle" value="${course.courseTitle}" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Credits</label>
                                                        <input type="number" class="form-control" name="credits" value="${course.credits}" required min="1" max="10">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty courses}">
                                    <tr id="noCoursesRow"><td colspan="6" class="text-center text-muted py-4">No courses available.</td></tr>
                                </c:if>
                                <tr id="noFilteredCoursesRow" style="display: none;"><td colspan="6" class="text-center text-muted py-4">No courses available for the selected school.</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div> <!-- End Main Content -->
        </div> <!-- End Row -->
    </div> <!-- End Master Courses Tab -->

            <!-- Students Tab -->
            <div class="tab-pane fade ${activeTab == 'students' ? 'show active' : ''}" id="students" role="tabpanel">
                <div class="row mb-3 align-items-center">
                    <div class="col">
                        <h4 class="mb-0">Students in ${deanSchool.schoolName}</h4>
                        <p class="text-muted mb-0 small">List of all officially registered students in this school.</p>
                    </div>
                </div>

                <div class="card card-custom">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Student Name</th>
                                    <th>Email</th>
                                    <th>Major</th>
                                    <th>Status</th>
                                    <th>Account State</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr>
                                        <td><span class="badge bg-secondary">${student.userIdentifier}</span></td>
                                        <td><strong>${student.fullName}</strong></td>
                                        <td>${student.email}</td>
                                        <td>${student.major}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${student.verified}">
                                                    <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i> Verified</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark"><i class="bi bi-hourglass me-1"></i> Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${student.active}">
                                                    <span class="badge bg-primary">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Disabled</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty students}">
                                    <tr><td colspan="6" class="text-center text-muted py-4">No students officially enrolled in this school.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 2. Academic Terms Tab -->
            <div class="tab-pane fade ${activeTab == 'terms' ? 'show active' : ''}" id="terms" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Academic Terms</h4>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTermModal"><i class="bi bi-plus-lg me-1"></i> Add Term</button>
                </div>

                <div class="card card-custom">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Term Number</th>
                                    <th>Term Name</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="term" items="${terms}">
                                    <tr>
                                        <td>${term.id}</td>
                                        <td><span class="badge bg-info text-dark">Term ${term.termNumber}</span></td>
                                        <td>${term.termName}</td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editTermModal${term.id}"><i class="bi bi-pencil"></i> Edit</button>
                                        </td>
                                    </tr>

                                    <!-- Edit Term Modal -->
                                    <div class="modal fade" id="editTermModal${term.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                                                <input type="hidden" name="action" value="updateTerm">
                                                <input type="hidden" name="termId" value="${term.id}">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Edit Term</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label class="form-label">Term Number (e.g. 1, 2, 3)</label>
                                                        <input type="number" class="form-control" name="termNumber" value="${term.termNumber}" required min="1">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Term Name</label>
                                                        <input type="text" class="form-control" name="termName" value="${term.termName}" required>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty terms}">
                                    <tr><td colspan="4" class="text-center text-muted py-4">No terms available.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 3. Curriculum Bundling Tab -->
            <div class="tab-pane fade ${activeTab == 'bundles' ? 'show active' : ''}" id="bundles" role="tabpanel">
                <div class="row mb-3 align-items-center">
                    <div class="col">
                        <h4 class="mb-0">Term Curriculum Bundles</h4>
                        <p class="text-muted mb-0 small">Assign courses that will be offered in each term.</p>
                    </div>
                </div>

                <div class="row g-4">
                    <c:forEach var="entry" items="${curriculumMap}">
                        <c:set var="term" value="${entry.key}" />
                        <c:set var="termCourses" value="${entry.value}" />
                        
                        <div class="col-md-6 col-lg-4">
                            <div class="card card-custom h-100">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                    <h5 class="mb-0 text-primary fw-bold">${term.termName}</h5>
                                    <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#bundleModal${term.id}">
                                        <i class="bi bi-plus"></i> Add Course
                                    </button>
                                </div>
                                <div class="card-body p-0">
                                    <ul class="list-group list-group-flush">
                                        <c:forEach var="course" items="${termCourses}">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                <div>
                                                    <strong>${course.courseCode}</strong><br>
                                                    <small class="text-muted">${course.courseTitle}</small>
                                                </div>
                                                <!-- Unbundle form -->
                                                <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="m-0 p-0">
                                                    <input type="hidden" name="action" value="unbundleCourse">
                                                    <input type="hidden" name="termId" value="${term.id}">
                                                    <input type="hidden" name="courseId" value="${course.id}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger border-0" title="Remove from term" onclick="return confirm('Remove ${course.courseCode} from ${term.termName}?')">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${empty termCourses}">
                                            <li class="list-group-item text-center text-muted py-3">No courses assigned.</li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Bundle Course Modal for this Term -->
                        <div class="modal fade" id="bundleModal${term.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                                    <input type="hidden" name="action" value="bundleCourse">
                                    <input type="hidden" name="termId" value="${term.id}">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Assign Course to ${term.termName}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Select Course</label>
                                            <select name="courseId" class="form-select" required>
                                                <option value="">-- Choose a Course --</option>
                                                <c:forEach var="c" items="${courses}">
                                                    <!-- Check if course is already in this term to disable it -->
                                                    <c:set var="isAssigned" value="false" />
                                                    <c:forEach var="tc" items="${termCourses}">
                                                        <c:if test="${tc.id == c.id}">
                                                            <c:set var="isAssigned" value="true" />
                                                        </c:if>
                                                    </c:forEach>
                                                    <option value="${c.id}" ${isAssigned ? 'disabled' : ''}>
                                                        ${c.courseCode} - ${c.courseTitle} ${isAssigned ? '(Already Assigned)' : ''}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">Assign Course</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty curriculumMap}">
                        <div class="col-12 text-center text-muted py-4">No terms created yet. Please create a term first.</div>
                    </c:if>
                </div>
            </div>

            <!-- 4. Class Schedules Tab -->
            <div class="tab-pane fade ${activeTab == 'schedules' ? 'show active' : ''}" id="schedules" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="mb-0">Class Schedules & Faculty Assignment</h4>
                        <span class="badge bg-secondary mt-1">Total Eligible Students: ${students.size()}</span>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#scheduleClassModal"><i class="bi bi-plus-lg me-1"></i> Schedule Class</button>
                </div>

                <div class="card card-custom">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Term</th>
                                    <th>Course</th>
                                    <th>Professor</th>
                                    <th>Schedule</th>
                                    <th>Room & Enrollment</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="section" items="${sections}">
                                    <tr>
                                        <td><span class="badge bg-info text-dark">${section.termName}</span><br><small class="text-muted">${section.academicYear}</small></td>
                                        <td><strong>${section.courseCode}</strong><br><small>${section.courseTitle}</small></td>
                                        <td><i class="bi bi-person-badge text-primary me-1"></i> ${section.professorName}</td>
                                        <td>
                                            <span class="badge bg-light text-dark border">${section.sessionShift}</span><br>
                                            <small class="text-muted"><i class="bi bi-calendar-event me-1"></i>${section.daysOfWeek}</small>
                                        </td>
                                        <td>
                                            <i class="bi bi-door-open me-1"></i>${section.roomName}
                                            <br>
                                            <small class="text-muted">
                                                Enrolled: <strong>${section.enrolledCount} / ${section.roomCapacity}</strong>
                                            </small>
                                            <div class="progress mt-1" style="height: 5px; width: 120px;">
                                                <div class="progress-bar ${section.enrolledCount >= section.roomCapacity ? 'bg-danger' : 'bg-success'}" role="progressbar" style="width: ${section.roomCapacity > 0 ? (section.enrolledCount * 100 / section.roomCapacity) : 0}%"></div>
                                            </div>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="removeClassSection">
                                                <input type="hidden" name="sectionId" value="${section.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this scheduled class?');"><i class="bi bi-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty sections}">
                                    <tr><td colspan="6" class="text-center text-muted py-4">No classes have been scheduled yet.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 5. Facility Management Tab -->
            <div class="tab-pane fade ${activeTab == 'facilities' ? 'show active' : ''}" id="facilities" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Physical Facility Management</h4>
                    <div>
                        <button class="btn btn-outline-secondary me-2" data-bs-toggle="modal" data-bs-target="#batchRoomModal"><i class="bi bi-layers me-1"></i> Batch Generate Rooms</button>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRoomModal"><i class="bi bi-plus-lg me-1"></i> Add Single Room</button>
                    </div>
                </div>

                <div class="card card-custom">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Floor</th>
                                    <th>Room Number</th>
                                    <th>Max Capacity (Seats)</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${rooms}">
                                    <tr>
                                        <td>Floor ${room.floorNumber}</td>
                                        <td><strong><i class="bi bi-door-open me-1"></i> ${room.roomNumber}</strong></td>
                                        <td><span class="badge bg-secondary">${room.capacity} seats</span></td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="deleteRoom">
                                                <input type="hidden" name="roomId" value="${room.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this room?');"><i class="bi bi-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty rooms}">
                                    <tr><td colspan="4" class="text-center text-muted py-4">No rooms have been created yet. Generate a floor batch to begin.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div> <!-- End Tab Content -->
    </div>

    <!-- Modals for Creating New Items -->

    <!-- Add Course Modal -->
    <div class="modal fade" id="addCourseModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addCourse">
                <div class="modal-header">
                    <h5 class="modal-title">Create New Course</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Course Code (e.g. ITE 301)</label>
                        <input type="text" class="form-control" name="courseCode" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Course Title</label>
                        <input type="text" class="form-control" name="courseTitle" required>
                    </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Credits</label>
                        <input type="number" class="form-control" name="credits" value="3" required min="1" max="10">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Create Course</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Add Term Modal -->
    <div class="modal fade" id="addTermModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addTerm">
                <div class="modal-header">
                    <h5 class="modal-title">Create New Term</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Term Number (e.g. 9)</label>
                        <input type="number" class="form-control" name="termNumber" required min="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Term Name</label>
                        <input type="text" class="form-control" name="termName" placeholder="e.g. Term 9" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Create Term</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Schedule Class Modal -->
    <div class="modal fade" id="scheduleClassModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addClassSection">
                <div class="modal-header">
                    <h5 class="modal-title">Schedule New Class</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Term</label>
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
                            <label class="form-label">Course (Assigned to Term)</label>
                            <select name="courseId" class="form-select" id="courseSelect" required>
                                <option value="">-- Choose Course --</option>
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Assign Professor</label>
                            <select name="professorId" class="form-select" required>
                                <option value="">-- Choose Professor --</option>
                                <c:forEach var="prof" items="${professors}">
                                    <option value="${prof.id}">${prof.fullName} (${prof.email})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Shift</label>
                            <select name="sessionShift" class="form-select" required>
                                <option value="MORNING">Morning</option>
                                <option value="AFTERNOON">Afternoon</option>
                                <option value="EVENING">Evening</option>
                                <option value="WEEKEND">Weekend</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Room</label>
                            <select name="roomId" class="form-select" required>
                                <option value="">-- Choose Room --</option>
                                <c:forEach var="room" items="${rooms}">
                                    <option value="${room.id}">${room.roomNumber} (Cap: ${room.capacity})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Days</label>
                            <select name="daysOfWeek" class="form-select" required>
                                <option value="Mon-Fri">Mon-Fri (Weekday)</option>
                                <option value="Sat-Sun">Sat-Sun (Weekend)</option>
                            </select>
                            <small class="text-muted d-block mt-1" style="font-size: 0.75rem;">Exact days will be auto-calculated</small>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Academic Year</label>
                            <input type="text" class="form-control" name="academicYear" placeholder="e.g. 2026-2027" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Schedule Class</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Add Single Room Modal -->
    <div class="modal fade" id="addRoomModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addRoom">
                <div class="modal-header">
                    <h5 class="modal-title">Add Physical Room</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Room Number</label>
                        <input type="text" class="form-control" name="roomNumber" placeholder="e.g. Room 501" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Floor Number</label>
                        <input type="number" class="form-control" name="floorNumber" min="1" max="10" placeholder="e.g. 5" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Maximum Seating Capacity</label>
                        <input type="number" class="form-control" name="capacity" min="1" placeholder="e.g. 40" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Create Room</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Batch Generate Rooms Modal -->
    <div class="modal fade" id="batchRoomModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="${pageContext.request.contextPath}/dean/dashboard" method="post" class="modal-content">
                <input type="hidden" name="action" value="addRoomsBatch">
                <div class="modal-header">
                    <h5 class="modal-title">Batch Generate Rooms</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info py-2"><i class="bi bi-info-circle me-1"></i> Instantly generate multiple identical rooms for a specific floor.</div>
                    <div class="mb-3">
                        <label class="form-label">Floor Number</label>
                        <input type="number" class="form-control" name="floorNumber" min="1" max="10" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Number of Rooms to Generate</label>
                        <input type="number" class="form-control" name="numberOfRooms" min="1" max="50" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Capacity (Per Room)</label>
                        <input type="number" class="form-control" name="capacityPerRoom" min="1" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-secondary">Generate Batch</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Update URL hash without jumping to keep tab state clean on refresh
        const tabElements = document.querySelectorAll('button[data-bs-toggle="tab"]');
        tabElements.forEach(tab => {
            tab.addEventListener('shown.bs.tab', event => {
                const target = event.target.getAttribute('data-bs-target').substring(1);
                // We use history replaceState to not create a mess of back-buttons
                window.history.replaceState(null, null, '?tab=' + target);
            });
        });

        // Dynamic Course Dropdown based on Term Selection
        const termCoursesMap = {};
        <c:forEach var="entry" items="${curriculumMap}">
            termCoursesMap[${entry.key.id}] = [
                <c:forEach var="course" items="${entry.value}">
                    { id: ${course.id}, code: "${course.courseCode}", title: "${course.courseTitle}" },
                </c:forEach>
            ];
        </c:forEach>
        
        document.getElementById('termSelect').addEventListener('change', function() {
            const termId = this.value;
            const courseSelect = document.getElementById('courseSelect');
            courseSelect.innerHTML = '<option value="">-- Choose Course --</option>';
            
            if (termId && termCoursesMap[termId]) {
                termCoursesMap[termId].forEach(course => {
                    const option = document.createElement('option');
                    option.value = course.id;
                    option.textContent = course.code + ' - ' + course.title;
                    courseSelect.appendChild(option);
                });
            }
        });

        // Sidebar School Filter for Course Catalog
        document.addEventListener("DOMContentLoaded", function() {
            const schoolFilterButtons = document.querySelectorAll('#schoolFilter button');
            const courseRows = document.querySelectorAll('#coursesTable tbody tr.course-row');
            const noCoursesRow = document.getElementById('noCoursesRow');
            const noFilteredCoursesRow = document.getElementById('noFilteredCoursesRow');
            
            schoolFilterButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    // Update active state
                    schoolFilterButtons.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    
                    const schoolId = this.getAttribute('data-school-id');
                    let visibleCount = 0;
                    
                    // Filter rows
                    courseRows.forEach(row => {
                        if (schoolId === 'all' || row.getAttribute('data-course-school-id') === schoolId) {
                            row.style.display = '';
                            visibleCount++;
                        } else {
                            row.style.display = 'none';
                        }
                    });

                    // Handle empty state
                    if (courseRows.length > 0) {
                        if (visibleCount === 0) {
                            noFilteredCoursesRow.style.display = '';
                        } else {
                            noFilteredCoursesRow.style.display = 'none';
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>
