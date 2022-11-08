<%@ page import="DB_struct.classes.Classes" %>
<%@ page import="DB_struct.classes.ClassesDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_struct.lecturer.LecturerDao" %>
<%@ page import="DB_struct.building.BuildingDao" %>
<%@ page import="DB_struct.major.MajorDao" %>
<%@ page import="DB_struct.student.StudentDao" %>
<%@ page import="DB_struct.student.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="student" class="DB_struct.student.Student" scope="page" />
<jsp:useBean id="classes" class="DB_struct.classes.Classes" scope="page" />
<jsp:setProperty name="student" property="student_id" />
<jsp:setProperty name="classes" property="class_id" />
<jsp:setProperty name="classes" property="course_id" />
<jsp:setProperty name="classes" property="name" />


<html>
<head>
    <title>학생 수업 검색</title>
</head>
<body>
<%
    StudentDao studentDao = new StudentDao();
    Student nowStudent = studentDao.show((String)session.getAttribute("student_id"));

%>
<%
    ClassesDao classesDao = new ClassesDao();
    String class_id = request.getParameter("class_id");
    String course_id = request.getParameter("course_id");
    String name = request.getParameter("name");

    ArrayList<Classes> list = classesDao.searchClass(class_id,course_id,name);


%>
<div>
    <h2> 검색 수업 목록 </h2>
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
                    <th style="text-align: center;">  전공 </th>
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
                    LecturerDao lecturerDao = new LecturerDao();
                    BuildingDao buildingDao = new BuildingDao();
                    MajorDao majorDao = new MajorDao();

                    for(int i=0;i<list.size();i++){
                %>
                <tr>

                    <div>
                        <td>
                            <button onclick="location='student_enrolmentAction.jsp?enrollClassId=<%=list.get(i).getClass_id()%>&student_id=<%=nowStudent.getStudent_id()%>&courseId=<%=list.get(i).getCourse_id()%>'">신청</button>
                        </td>
                        <td><%= list.get(i).getClass_id()%></td>
                        <td><%= list.get(i).getClass_no()%></td>
                        <td><%= list.get(i).getCourse_id()%></td>
                        <td><%= list.get(i).getName()%></td>
                        <td><%= majorDao.findMajorName(list.get(i).getMajor_id())%></td>
                        <td><%= list.get(i).getYear()%></td>
                        <td><%= list.get(i).getCredit()%></td>
                        <td><%= lecturerDao.findLecturerName(list.get(i).getLecturer_id()) %></td>
                        <td><%= list.get(i).getPerson_max()%></td>
                        <td><%= list.get(i).getOpened()%></td>
                        <td><%= buildingDao.findBuildingName(list.get(i).getRoom_id())%></td>
                        <td><%= list.get(i).getRoom_id()%></td>

                        </form>


                    </div>
                </tr>
                <%
                    }
                %>

            </table>
        </div>
    </div>
</div>

</body>
</html>
