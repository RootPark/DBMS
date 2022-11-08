<%@ page import="DB_struct.administrator.Administrator" %>
<%@ page import="DB_struct.administrator.AdministratorDao" %>
<%@ page import="DB_struct.classes.ClassesDao" %>
<%@ page import="DB_struct.classes.Classes" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_struct.lecturer.LecturerDao" %>
<%@ page import="DB_struct.building.BuildingDao" %>
<%@ page import="DB_struct.major.MajorDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <meta name="viewport" content="width=devoce-width", initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <% request.setCharacterEncoding("UTF-8"); %>

    <title> 수업 관리 </title>
</head>
<body>
<%
    AdministratorDao administratorDao = new AdministratorDao();
    Administrator nowAdministrator = administratorDao.showAll((String)session.getAttribute("administrator_id"));
%>

<div>
    <h1>
        수업 관리
    </h1>
    <td>관리자 ID : <%= nowAdministrator.getAdministrator_id()%></td>
    <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>
</div>
<hr>
<h2> 수업 개설 </h2>

<div>
    <form action="admin_addClassAction.jsp" method="post">
        <input type="text" name="class_id" placeholder="수업 ID">
        <input type="text" name="class_no" placeholder="수업 번호">
        <input type="text" name="course_id" placeholder="과목 ID">
        <input type="text" name="name" placeholder="이름">
        <input type="text" name="major_id" placeholder="전공 번호">
        <input type="text" name="year" placeholder="학년">
        <input type="text" name="credit" placeholder="학점">
        <input type="text" name="lecturer_id" placeholder="교강사 번호">
        <input type="text" name="person_max" placeholder="정원">
        <input type="text" name="opened" placeholder="개설">
        <input type="text" name="room_id" placeholder="강의실">

        <button type="submit">수업 추가</button>
    </form>
    <td></td>
</div>


<hr>
<h2>
    전체 수업 목록
</h2>

<div class="container">
    <div class="row">
        <table class="table" width ="750" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="text-align: center;">         </th>
                <th style="text-align: center;">  수업 ID  </th>
                <th style="text-align: center;">  수업 번호  </th>
                <th style="text-align: center;">  과목 ID  </th>
                <th style="text-align: center;">  이름  </th>
                <th style="text-align: center;">  전공  </th>
                <th style="text-align: center;">  학년 </th>
                <th style="text-align: center;">  학점 </th>
                <th style="text-align: center;">  교강사 이름 </th>
                <th style="text-align: center;">  정원 </th>
                <th style="text-align: center;">  개설 </th>
                <th style="text-align: center;">  건물 </th>
                <th style="text-align: center;">  강의실 </th>
            </tr>

            </thead>
            <%
                ClassesDao classesDao = new ClassesDao();
                ArrayList<Classes> list= classesDao.showAll();

                LecturerDao lecturerDao = new LecturerDao();
                BuildingDao buildingDao = new BuildingDao();
                MajorDao majorDao = new MajorDao();

                for(int i=0;i<list.size();i++){
            %>
            <tr>

                <td>
                    <button onclick="location='admin_deleteClassAction.jsp?class_id=<%=list.get(i).getClass_id()%>'">삭제</button>
                </td>
                <td><%= list.get(i).getClass_id()%></td>
                <td><%= list.get(i).getClass_no()%></td>
                <td><%= list.get(i).getCourse_id()%></td>
                <td><%= list.get(i).getName()%></td>
                <td><%= majorDao.findMajorName(list.get(i).getMajor_id())%></td>
                <td><%= list.get(i).getYear()%></td>
                <td><%= list.get(i).getCredit()%></td>
                <td><%= lecturerDao.findLecturerName(list.get(i).getLecturer_id())%></td>
                <td><%= list.get(i).getPerson_max()%></td>
                <td><%= list.get(i).getOpened()%></td>
                <td><%= buildingDao.findBuildingName(list.get(i).getRoom_id())%></td>
                <td><%= list.get(i).getRoom_id()%></td>

            </tr>
            <%
                }
            %>

        </table>
    </div>
</div>

</body>

</html>
