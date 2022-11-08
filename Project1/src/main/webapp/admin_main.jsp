<%@ page import="DB_struct.administrator.Administrator" %>
<%@ page import="DB_struct.administrator.AdministratorDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 메인</title>
</head>
<body>
<%
    AdministratorDao administratorDao = new AdministratorDao();
    Administrator nowAdministrator = administratorDao.showAll((String)session.getAttribute("administrator_id"));
%>
<h1> 관리자 메인 페이지 </h1>
<td>관리자 ID : <%= nowAdministrator.getAdministrator_id()%></td>
<button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>
</div>
<hr>

<div>
    <button type="button" class="navyBtn" onClick="location.href='admin_student.jsp'">학생 관리</button>
    <button type="button" class="navyBtn" onClick="location.href='admin_class.jsp'">수업 관리</button>

</div>

<button type="button" class="navyBtn" onClick="location.href='admin_statistics.jsp'">통계 정보</button>

</body>
</html>
