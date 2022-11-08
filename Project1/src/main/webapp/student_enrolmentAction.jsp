<%@ page import="DB_struct.enrolledClass.EnrolledClassDao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생 수강신청 액션</title>
</head>
<body>
<%
    String studentID = request.getParameter("student_id");
    String enrollID = request.getParameter("enrollClassId");
    String courseID = request.getParameter("courseId");
%>
<%
    EnrolledClassDao enrolledClassDao = new EnrolledClassDao();
    int result = enrolledClassDao.enrollClass(studentID,enrollID,courseID);

    if(result == -1){
        PrintWriter script = response.getWriter();

        script.println("<script>");
        script.println("alert('같은 수업을 수강할 수 없습니다.')");
        script.println("location.href = 'student_enrolment.jsp'");
        script.println("</script>");
    }
    if(result == -2){
        PrintWriter script = response.getWriter();

        script.println("<script>");
        script.println("alert('동일 과목에서 B0 이상의 성적을 취득한 적이 있습니다.')");
        script.println("location.href = 'student_enrolment.jsp'");
        script.println("</script>");
    }
    if(result == -3){
        PrintWriter script = response.getWriter();

        script.println("<script>");
        script.println("alert('수강 정원이 가득 찼습니다.')");
        script.println("location.href = 'student_enrolment.jsp'");
        script.println("</script>");
    }
    if(result == -4){
        PrintWriter script = response.getWriter();

        script.println("<script>");
        script.println("alert('18학점 이상은 수강이 불가합니다.')");
        script.println("location.href = 'student_enrolment.jsp'");
        script.println("</script>");
    }
    if(result == -5){
        PrintWriter script = response.getWriter();

        script.println("<script>");
        script.println("alert('기존 수업과 시간이 겹칩니다.')");
        script.println("location.href = 'student_enrolment.jsp'");
        script.println("</script>");
    }


    else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강 신청이 완료되었습니다.')");
        script.println("location.href = 'student_main.jsp'");
        script.println("</script>");
    }
%>
</body>
</html>
