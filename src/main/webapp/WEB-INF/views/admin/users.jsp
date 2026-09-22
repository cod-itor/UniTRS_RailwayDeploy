<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - UniTRS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-mortarboard-fill me-2"></i>UniTRS Admin
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2 me-1"></i>Dashboard
                </a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
                    <i class="bi bi-people me-1"></i>Users
                </a>
                <span class="navbar-text mx-3">
                    <i class="bi bi-person-circle me-1"></i>${sessionScope.user.fullName}
                </span>
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/auth/logout">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">

        <!-- Pending Verifications Section -->
        <c:if test="${not empty unverifiedStudents}">
            <div class="card mb-4 border-warning">
                <div class="card-header bg-warning text-dark">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    Pending User Verifications (${unverifiedStudents.size()})
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Identifier / ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Requested Role</th>
                                <th>Major / Department</th>
                                <th>Authorize Role & Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${unverifiedStudents}">
                                <tr>
                                    <td>${student.id}</td>
                                    <td><code>${student.formattedIdentifier}</code></td>
                                    <td>${student.fullName}</td>
                                    <td>${student.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${student.role == 'PROFESSOR'}">
                                                <span class="badge bg-success-subtle text-success border border-success px-2 py-1">
                                                    <i class="bi bi-mortarboard-fill me-1"></i>Professor
                                                </span>
                                            </c:when>
                                            <c:when test="${student.role == 'STUDENT'}">
                                                <span class="badge bg-primary-subtle text-primary border border-primary px-2 py-1">
                                                    <i class="bi bi-person-fill me-1"></i>Student
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary-subtle text-secondary border border-secondary px-2 py-1">
                                                    ${student.role}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:out value="${not empty student.major ? student.major : '—'}" /></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/users/verify" method="POST" class="d-flex align-items-center gap-2">
                                            <input type="hidden" name="userId" value="${student.id}">
                                            <div class="input-group input-group-sm" style="width: auto;">
                                                <span class="input-group-text bg-light text-muted small"><i class="bi bi-person-badge"></i></span>
                                                <select name="role" class="form-select form-select-sm" style="width: auto;" required>
                                                    <option value="STUDENT" ${student.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                                    <option value="PROFESSOR" ${student.role == 'PROFESSOR' ? 'selected' : ''}>Professor</option>
                                                    <option value="DEAN" ${student.role == 'DEAN' ? 'selected' : ''}>Dean</option>
                                                    <option value="ADMIN" ${student.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                </select>
                                            </div>
                                            <button type="submit" name="action" value="approve" class="btn btn-success btn-sm text-nowrap">
                                                <i class="bi bi-check-lg"></i> Approve
                                            </button>
                                            <button type="submit" name="action" value="reject" class="btn btn-danger btn-sm text-nowrap">
                                                <i class="bi bi-x-lg"></i> Reject
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

        <!-- All Users Section -->
        <div class="card">
            <div class="card-header bg-dark text-white">
                <i class="bi bi-people-fill me-2"></i>All Users
            </div>
            <div class="card-body p-0">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Identifier</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Verified</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td><code>${user.formattedIdentifier}</code></td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}">
                                            <span class="badge bg-danger">${user.role}</span>
                                        </c:when>
                                        <c:when test="${user.role == 'DEAN'}">
                                            <span class="badge bg-primary">${user.role}</span>
                                        </c:when>
                                        <c:when test="${user.role == 'PROFESSOR'}">
                                            <span class="badge bg-info">${user.role}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${user.role}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.verified}">
                                            <span class="text-success"><i class="bi bi-check-circle-fill"></i></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-warning"><i class="bi bi-clock-fill"></i></span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${user.id != sessionScope.user.id}">
                                        <form action="${pageContext.request.contextPath}/admin/users/status" method="POST" style="display: inline;">
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <c:choose>
                                                <c:when test="${user.active}">
                                                    <input type="hidden" name="action" value="deactivate">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm">
                                                        <i class="bi bi-person-slash"></i> Deactivate
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="action" value="activate">
                                                    <button type="submit" class="btn btn-outline-success btn-sm">
                                                        <i class="bi bi-person-check"></i> Activate
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">No users found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
