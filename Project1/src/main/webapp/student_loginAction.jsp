<%@ page import="java.io.PrintWriter" %>
<%@ page import="DB_struct.student.StudentDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DB_struct.student.Student" %>
<jsp:useBean id="student" class="DB_struct.student.Student" scope="page" />
<jsp:setProperty name="student" property="student_id" />
<jsp:setProperty name="student" property="password" />

<html>
<head>
    <title>학생 로그인 액션</title>
</head>
<body>
<%
    String ID = null;
    if(session.getAttribute("student_id")!=null){
        ID = (String) session.getAttribute("student_id");
    }
    if(ID!= null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인 되어있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }

    StudentDao studentDao = new StudentDao();

    int result = studentDao.login(student.getStudent_id(), student.getPassword());

    if(result == 1){
        session.setAttribute("student_id",student.getStudent_id());
        PrintWriter script = response.getWriter();
        script.println("<script>");
        System.out.println("LOGIN SUCCESS!");
        script.println("location.href = 'student_main.jsp'");
        script.println("</script>");
    }
    else if(result == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == -1)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == -2)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>
