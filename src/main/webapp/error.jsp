<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8d7da; color: #721c24; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .error-container { background: #fff; padding: 40px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; }
        h1 { margin-top: 0; }
        .btn { display: inline-block; padding: 10px 20px; margin-top: 20px; background-color: #721c24; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Oops! Something went wrong.</h1>
        <p><strong>Error Details:</strong> <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unknown error occurred." %></p>
        <a href="${pageContext.request.contextPath}/" class="btn">Go Back Home</a>
    </div>
</body>
</html>
