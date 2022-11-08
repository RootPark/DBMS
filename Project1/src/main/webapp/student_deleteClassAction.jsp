<%@ page import="DB_struct.enrolledClass.EnrolledClassDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>수강 취소 액션</title>
</head>
<body>
<%
  String studentID = request.getParameter("student_id");
  String deleteId = request.getParameter("deletedId");
%>
<%
  EnrolledClassDao enrolledClassDao = new EnrolledClassDao();
  int result = enrolledClassDao.deleteClass(studentID,deleteId);

  PrintWriter script = response.getWriter();
  script.println("<script>");
  script.println("alert('수강 취소가 완료되었습니다.')");
  script.println("history.back()");
  script.println("</script>");
%>
</body>
</html>
