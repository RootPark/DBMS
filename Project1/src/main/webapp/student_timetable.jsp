<%@ page import="DB_struct.student.StudentDao" %>
<%@ page import="DB_struct.student.Student" %>
<%@ page import="DB_struct.time.Time" %>
<%@ page import="DB_struct.time.TimeDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>시간표</title>
</head>
<body>
<%
  StudentDao studentDao = new StudentDao();
  String student_id = request.getParameter("student_id");
  Student nowStudent = studentDao.show(student_id);

%>
<div>
  <h1> 시간표 </h1>
  <td>학번 : <%= nowStudent.getStudent_id()%></td>
  <td>이름 : <%= nowStudent.getName()%></td>
  <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>

</div>
<hr>
<div class="container">
  <div class="row">
    <table class="table" width ="750" style="text-align: center; border: 1px solid #dddddd">
      <thead>
      <tr>
        <th style="text-align: center;">         </th>
        <th style="text-align: center;">  수업 ID  </th>
        <th style="text-align: center;">  시작시간  </th>
        <th style="text-align: center;">  끝시간  </th>

      </tr>

      </thead>
      <%
        TimeDao timeDao = new TimeDao();
        ArrayList<Time> list = timeDao.timetable(student_id);

        for(int i=0;i<list.size();i++){
      %>
      <tr>
        <td>
        </td>
        <td><%= list.get(i).getClass_id()%></td>
        <td><%= list.get(i).getBegin()%></td>
        <td><%= list.get(i).getEnd()%></td>

      </tr>
      <%
        }
      %>

    </table>
  </div>
</div>
</body>
</html>
