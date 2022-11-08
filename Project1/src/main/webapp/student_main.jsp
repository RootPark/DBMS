<%@ page import="DB_struct.student.StudentDao" %>
<%@ page import="DB_struct.student.Student" %>
<%@ page import="DB_struct.enrolledClass.EnrolledClassDao" %>
<%@ page import="DB_struct.classes.Classes" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_struct.lecturer.LecturerDao" %>
<%@ page import="DB_struct.building.BuildingDao" %>
<%@ page import="DB_struct.major.MajorDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>학생 메인 페이지</title>
</head>
<body>
<%
    StudentDao studentDao = new StudentDao();
    Student nowStudent = studentDao.show((String)session.getAttribute("student_id"));

%>
<div>
    <h1> 학생 메인 페이지 </h1>
    <td>학번 : <%= nowStudent.getStudent_id()%></td>
    <td>이름 : <%= nowStudent.getName()%></td>
    <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>

</div>
<hr>
    <h2> 수강 신청 내역 </h2>

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
                EnrolledClassDao enrolledClassDao = new EnrolledClassDao();
                ArrayList<Classes> list = enrolledClassDao.showAll(nowStudent.getStudent_id());

                LecturerDao lecturerDao = new LecturerDao();
                BuildingDao buildingDao = new BuildingDao();
                MajorDao majorDao = new MajorDao();

                for(int i=0;i<list.size();i++){
            %>
            <tr>
                <td>
                    <button onclick="location='student_deleteClassAction.jsp?deletedId=<%=list.get(i).getClass_id()%>&student_id=<%=nowStudent.getStudent_id()%>'">취소</button>
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
<hr>

<button type="button" class="navyBtn" onClick="location.href='student_enrolment.jsp'">수강 신청</button>
<button type="button" class="navyBtn" onClick="location.href='student_timetable.jsp?student_id=<%=nowStudent.getStudent_id()%>'">시간표 생성</button>

</body>
</html>
