<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*,java.text.*,java.util.*"%>
    <%request.setCharacterEncoding("utf-8"); %>
    
    <jsp:useBean id="user" class="cuckoo.user.UserEntity" scope="page" />
	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
    
<%
	//HTML���� �޾ƿ��� ���� DBCP�� �̿��Ͽ� �ʱ�ȭ	
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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���ԿϷ�</title>
</head>
<body>
������ ���� �帳�ϴ�.
���� Ȯ��
���̵� : <%=user.getUserid() %><br>
��  �� : <%=user.getUsername() %><br>
�г��� : <%=user.getNickname() %><br>
�̸��� : <%=user.getEmail() %><br>
����   : <%=user.getSex() %><br>
���� : <%=user.getBirthday() %><br>
<input type="button" onClick="location='index.html'" value="���� �Ϸ�">
<input type="reset" value="���">
</body>
</html>