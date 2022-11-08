<%@ page import="DB_struct.classes.Classes" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DB_struct.classes.ClassesDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:useBean id="classes" class="DB_struct.classes.Classes" scope="page" />
<jsp:setProperty name="classes" property="class_id" />
<jsp:setProperty name="classes" property="class_no" />
<jsp:setProperty name="classes" property="course_id" />
<jsp:setProperty name="classes" property="name" />
<jsp:setProperty name="classes" property="major_id" />
<jsp:setProperty name="classes" property="year" />
<jsp:setProperty name="classes" property="lecturer_id" />
<jsp:setProperty name="classes" property="person_max" />
<jsp:setProperty name="classes" property="opened" />
<jsp:setProperty name="classes" property="room_id" />
<jsp:setProperty name="classes" property="credit" />
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <title>관리자 수업 추가 액션</title>
</head>
<body>
<%
    if(classes.getClass_id() == null || classes.getClass_no() == null || classes.getCourse_id() == null
            || classes.getName() == null || classes.getMajor_id() == null || classes.getYear() == null ||
            classes.getCredit() == null || classes.getLecturer_id() == null || classes.getPerson_max() == null
            || classes.getOpened() == null || classes.getRoom_id() == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alret('모든 칸을 채워주세요.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else{
        ClassesDao classesDao = new ClassesDao();
        int result = classesDao.addClass(classes);

        if(result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alret('이미 존재하는 수업이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('수업이 삭제되었습니다.')");
            script.println("location.href = 'admin_class.jsp'");
            script.println("</script>");
        }
    }
%>

</body>
</html>
