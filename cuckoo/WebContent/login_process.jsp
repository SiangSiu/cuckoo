<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*,java.io.*,java.text.*,java.net.*,java.util.*"%>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<%
	String userid = request.getParameter("id");
	String password = request.getParameter("pw"); 
	String manager = userdb.getManager(userid);
			
	
	boolean bLogin = false;
	
	bLogin = userdb.idpw_check(userid, password);
	userdb.updateLastConn(userid);
	
	if(bLogin){
		session.setAttribute("user_info_userid", userid);
		session.setAttribute("user_info_password", password);
		session.setAttribute("user_info_manager", manager);
		response.sendRedirect("login_success.jsp");
	}else{
		out.println("<script>alert('아이디와 비밀번호를 확인하세요'); history.back();</script>");
	}
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
</body>
</html>