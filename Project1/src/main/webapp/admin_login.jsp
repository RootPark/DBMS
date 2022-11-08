<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="stylesheet" href="css/bootstrap.css">
  <title>관리자 로그인</title>
</head>
<body>
  <%
    String ID = null;
    if(session.getAttribute("administrator_id")!=null){
      ID = (String) session.getAttribute("administrator_id");
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
        <form method="post" action="admin_loginAction.jsp">
          <h2>로그인</h2>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="아이디" name="administrator_id" maxlength="10">
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="비밀번호" name="password" maxlength="30">
          </div>
          <input type="submit" class="btn btn-primary form-control" value="관리자 로그인">
        </form>
      </div>
    </div>
    <div class="col-lg-4"></div>
  </div>
  <%
    }
    else{
  %>
  <button type="button" class="navyBtn" onClick="location.href='logoutAction.jsp'">로그아웃</button>
  <%
    }
  %>
</body>
</html>
