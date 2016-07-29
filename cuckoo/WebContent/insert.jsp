<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.sql.*,java.text.*,java.util.*"%>
    <%request.setCharacterEncoding("utf-8"); %>
    
    <jsp:useBean id="user" class="cuckoo.user.UserEntity" scope="page" />
	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
    
<%
	//HTML에서 받아오는 변수 DBCP를 이용하여 초기화	
	user.setUserid(request.getParameter("userid"));
	user.setPassword(request.getParameter("password"));
	user.setUsername(request.getParameter("username"));
	user.setNickname(request.getParameter("nickname"));
	user.setEmail(request.getParameter("email"));
	user.setBirthday(request.getParameter("birthday"));
	user.setSex(request.getParameter("sex"));
	
	userdb.setUserEntityList(user);	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>가입완료</title>
</head>
<body>
가입을 축하 드립니다.
정보 확인
아이디 : <%=user.getUserid() %><br>
이  름 : <%=user.getUsername() %><br>
닉네임 : <%=user.getNickname() %><br>
이메일 : <%=user.getEmail() %><br>
성별   : <%=user.getSex() %><br>
생일 : <%=user.getBirthday() %><br>
<input type="button" onClick="location='index.html'" value="가입 완료">
<input type="reset" value="취소">
</body>
</html>