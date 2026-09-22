<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>University Users</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #007bff; color: white; }
        tr:hover { background-color: #f1f1f1; }
        h1 { color: #333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Registered Users</h1>
        <p>This is your brand new endpoint displaying data straight from the database!</p>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Identifier</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <!-- Loop over the "users" attribute attached by UserController -->
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.formattedIdentifier}</td>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.role}</td>
                    </tr>
                </c:forEach>
                
                <!-- Fallback if no users exist -->
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="5" style="text-align: center; color: #888;">No users found in the database.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
