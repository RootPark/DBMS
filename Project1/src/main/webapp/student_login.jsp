<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="stylesheet" href="css/bootstrap.css">
  <title>HYU 수강신청 사이트</title>
</head>
<body>
  <%
    String ID = null;
    if(session.getAttribute("student_id")!=null){
      ID = (String) session.getAttribute("student_id");
    }
    else if(session.getAttribute("administrator_id")!=null){
      ID = (String) session.getAttribute("administrator_id");
    }
  %>
  <h1> HYU 수강신청 (DBMS-Project1) </h1>
  <%
    if(ID == null){
  %>
  <div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
      <div class="jumbotron" style="padding-top: 20px;">
        <form method="post" action="student_loginAction.jsp">
          <h2 style="test-align: center;">학생 로그인</h2>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="학번" name="student_id" maxlength="10">
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="비밀번호" name="password" maxlength="30">
          </div>
          <input type="submit" class="btn btn-primary form-control" value="학생 로그인">
          <button type="button" class="navyBtn" onClick="location.href='admin_login.jsp'">관리자 로그인</button>
        </form>
      </div>
    </div>
    <div class="col-lg-4"></div>
  </div>
  <%
    }
    else{

  %>
  <div>
    <button type="button" class="navyBtn" onClick="location.href='student_main.jsp'">수강신청 페이지</button>
  </div>
  <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>
  <button type="button" class="navyBtn" onClick="location.href='show.jsp'">사용자 정보</button>
  <%
    }
  %>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</body>
</html>
