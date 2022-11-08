<%@ page import="DB_struct.administrator.AdministratorDao" %>
<%@ page import="DB_struct.administrator.Administrator" %>
<%@ page import="DB_struct.student.StudentDao" %>
<%@ page import="DB_struct.student.Student" %>
<%@ page import="DB_struct.enrolledClass.EnrolledClassDao" %>
<%@ page import="DB_struct.classes.Classes" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_struct.credits.CreditsDao" %>
<%@ page import="DB_struct.credits.Credits" %>
<%@ page import="DB_struct.course.CourseDao" %>
<%@ page import="DB_struct.lecturer.LecturerDao" %>
<%@ page import="DB_struct.major.MajorDao" %>
<%@ page import="DB_struct.building.BuildingDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 학생 관리 조회 </title>
</head>
<body>
<%
    AdministratorDao administratorDao = new AdministratorDao();
    Administrator nowAdministrator = administratorDao.showAll((String)session.getAttribute("administrator_id"));


%>

<div>
    <h1>
        학생 관리 조회
    </h1>
    <td>관리자 ID : <%= nowAdministrator.getAdministrator_id()%></td>
    <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>
</div>
<hr>
<h2> 학생 정보 </h2>
<div class="container">
    <div class="row">
        <table class="table" width ="750" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="...">  학번  </th>
                <th style="text-align: center;">  비밀번호  </th>
                <th style="text-align: center;">  이름  </th>
                <th style="text-align: center;">  성별  </th>
                <th style="text-align: center;">  전공 </th>
                <th style="text-align: center;">  담당교수 </th>
                <th style="text-align: center;">  학년 </th>
                <th style="text-align: center;">  이수 학점 </th>
                <th style="text-align: center;">  평균 평점 </th>

            </tr>

            </thead>
            <tbody>
            <%
                StudentDao studentDao = new StudentDao();
                String student_id = request.getParameter("student_id");

                Student nowStudent = studentDao.show(student_id);

                CreditsDao creditsDao = new CreditsDao();
                ArrayList<Credits> creditsArrayList = creditsDao.showAll(nowStudent.getStudent_id());
                double countCredit = 0;
                double allGrade = 0;
                for(int i=0;i<creditsArrayList.size();i++){
                    countCredit+=Double.parseDouble(creditsArrayList.get(i).getStudent_id());
                    double grade = 0;
                    if(creditsArrayList.get(i).getGrade().equals("A+")){
                        grade = 4.5;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("A0")){
                        grade = 4.0;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("B+")){
                        grade = 3.5;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("B0")){
                        grade = 3.0;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("C+")){
                        grade = 2.5;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("C0")){
                        grade = 2.0;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("D+")){
                        grade = 1.5;
                    }
                    else if(creditsArrayList.get(i).getGrade().equals("D0")){
                        grade = 1.0;
                    }
                    else{
                        grade = 0.0;
                    }
                    allGrade+=grade*Integer.parseInt(creditsArrayList.get(i).getStudent_id());
                }
// 과목 성적 평균 계산 부분

            %>

            <tr>

                <td><%= nowStudent.getStudent_id()%></td>
                <td><%= nowStudent.getPassword()%></td>
                <td><%= nowStudent.getName()%></td>
                <td><%= nowStudent.getSex()%></td>
                <td><%= nowStudent.getMajor_id()%></td>
                <td><%= nowStudent.getLecturer_id()%></td>
                <td><%= nowStudent.getYear()%></td>
                <td><%= countCredit%></td>
                <td><%= String.format("%.2f",allGrade/countCredit)%></td>


            </tr>

            </tbody>
        </table>
    </div>
</div>



<hr>
<h2> 수강 신청 정보 </h2>

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
                <th style="text-align: center;">  전공 번호  </th>
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
                MajorDao majorDao = new MajorDao();
                BuildingDao buildingDao = new BuildingDao();

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
<h2> 성적 </h2>

<div class="container">
    <div class="row">
        <table class="table" width ="750" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="text-align: center;">  과목 ID  </th>
                <th style="text-align: center;">  수업 이름  </th>
                <th style="text-align: center;">  개설  </th>
                <th style="text-align: center;">  학점  </th>
                <th style="text-align: center;">  성적  </th>
                <th style="text-align: center;">  과목 평균 평점  </th>
            </tr>

            </thead>
            <%
                CourseDao courseDao = new CourseDao();

                for(int i=0;i<creditsArrayList.size();i++){
            %>
            <tr>
                <td><%= creditsArrayList.get(i).getCourse_id()%></td>
                <td><%= creditsArrayList.get(i).getCredits_id()%></td>
                <!--수업 이름으로 대용-->
                <td><%= creditsArrayList.get(i).getYear()%></td>
                <td><%= creditsArrayList.get(i).getStudent_id()%></td>
                <!--학점으로 대용-->
                <td><%= creditsArrayList.get(i).getGrade()%></td>
                <td><%= courseDao.avgCourseGrade(creditsArrayList.get(i).getCourse_id())%></td>


            </tr>
            <%
                }
            %>

        </table>
    </div>
</div>
<hr>
<button type="button" class="navyBtn" onClick="location.href='student_timetable.jsp?student_id=<%=nowStudent.getStudent_id()%>'">시간표 생성</button>


</body>
</html>
