<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Deans - UniTRS</title>
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
                <span class="navbar-text me-3">
                    <i class="bi bi-person-circle me-1"></i>${sessionScope.user.fullName}
                </span>
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/auth/logout">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-building me-2"></i>Assign Deans</h2>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
            </a>
        </div>

        <div class="card card-custom">
            <div class="card-body p-0">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>School Name</th>
                            <th>Current Dean</th>
                            <th>Assign / Change Dean</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="school" items="${schools}">
                            <c:set var="currentDean" value="${currentDeans[school.id]}" />
                            <tr>
                                <td>${school.id}</td>
                                <td><span class="fw-bold">${school.schoolName}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty currentDean}">
                                            <span class="badge bg-success"><i class="bi bi-person-check-fill me-1"></i>${currentDean.fullName}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Unassigned</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/deans/assign" method="post" class="d-flex align-items-center">
                                        <input type="hidden" name="schoolId" value="${school.id}">
                                        <select name="professorId" class="form-select form-select-sm me-2" style="max-width: 250px;">
                                            <option value="">-- Unassign Dean --</option>
                                            <c:forEach var="prof" items="${professors}">
                                                <option value="${prof.id}" ${not empty currentDean && currentDean.id == prof.id ? 'selected' : ''}>
                                                    ${prof.fullName} (${prof.email})
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <button type="submit" class="btn btn-primary btn-sm">Save</button>
                                    </form>
                                </td>
                                <td class="text-end">
                                    <!-- Additional actions if needed -->
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
