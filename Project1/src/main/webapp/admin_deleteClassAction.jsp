<%@ page import="DB_struct.classes.ClassesDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 수업 삭제 액션</title>
</head>
<body>
<%
    String class_id = request.getParameter("class_id");

    ClassesDao classesDao = new ClassesDao();
    int result = classesDao.deleteClass(class_id);

    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('수업이 삭제되었습니다.')");
    script.println("location.href = 'admin_class.jsp'");
    script.println("</script>");
%>
</body>
</html>
