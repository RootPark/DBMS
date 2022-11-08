<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃 액션</title>
</head>
<body>
<%
    session.invalidate();

%>
<script>
    location.href = 'student_login.jsp';
</script>
</body>
</html>
