<%@ page import="DB_struct.administrator.Administrator" %>
<%@ page import="DB_struct.administrator.AdministratorDao" %>
<%@ page import="DB_struct.student.Student" %>
<%@ page import="DB_struct.student.StudentDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_struct.lecturer.LecturerDao" %>
<%@ page import="DB_struct.major.MajorDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <meta name="viewport" content="width=devoce-width", initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title> 학생 관리 </title>
</head>
<body>
<%
    AdministratorDao administratorDao = new AdministratorDao();
    Administrator nowAdministrator = administratorDao.showAll((String)session.getAttribute("administrator_id"));
%>

<div>
    <h1>
        학생 관리
    </h1>
    <td>관리자 ID : <%= nowAdministrator.getAdministrator_id()%></td>
    <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>
</div>

<hr>
<h2 style="test-align: center;">모든 학생 정보</h2>
<div class="container">
    <div class="row">
        <table class="table" width ="750" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="text-align: center;">         </th>
                <th style="...">  학번  </th>
                <th style="text-align: center;">  비밀번호  </th>
                <th style="text-align: center;">  이름  </th>
                <th style="text-align: center;">  성별  </th>
                <th style="text-align: center;">  전공 </th>
                <th style="text-align: center;">  담당교수 </th>
                <th style="text-align: center;">  학년 </th>
                <th style="text-align: center;">    </th>

            </tr>

            </thead>
            <tbody>
            <%
                StudentDao studentDao = new StudentDao();
                ArrayList<Student> list = studentDao.showAll();
                LecturerDao lecturerDao = new LecturerDao();
                MajorDao majorDao = new MajorDao();

                for(int i = 0; i < list.size(); i++) {
            %>

            <tr>
                <td>
                    <button onclick="location='admin_deleteStudentAction.jsp?student_id=<%=list.get(i).getStudent_id()%>'">삭제</button>
                </td>
                <td><%= list.get(i).getStudent_id()%></td>
                <td><%= list.get(i).getPassword()%></td>
                <td><%= list.get(i).getName()%></td>
                <td><%= list.get(i).getSex()%></td>
                <td><%= majorDao.findMajorName(list.get(i).getMajor_id())%></td>
                <td><%= lecturerDao.findLecturerName(list.get(i).getLecturer_id())%></td>
                <td><%= list.get(i).getYear()%></td>
                <td>
                    <button onclick="location='admin_manageStudent.jsp?student_id=<%=list.get(i).getStudent_id()%>'">조회</button>
                </td>

            </tr>

            <%
                }
            %>

            </tbody>
        </table>
    </div>

</div>


</body>
</html>
