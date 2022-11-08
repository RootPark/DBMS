<%@ page import="DB_struct.student.StudentDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 학생 삭제 액션</title>
</head>
<body>
<%
  String student_id = request.getParameter("student_id");

  StudentDao studentDao = new StudentDao();
  int result = studentDao.deleteStudent(student_id);

  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('학생정보가 삭제되었습니다.')");
  script.println("location.href = 'admin_student.jsp'");
  script.println("</script>");
%>

</body>
</html>
