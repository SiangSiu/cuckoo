<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*,java.io.*,java.text.*,java.net.*,java.util.*"%>

<%
	String userid = request.getParameter("id");
	String password = request.getParameter("pw"); 
	
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
	String query = new String();
	String name = new String();
	String email = new String();
	PreparedStatement pstmt = null;
	
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}
	
	try{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_info?useUnicode=true&characterEncoding=euckr","root","1234");
		st = conn.createStatement();
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	boolean bLogin = false;
	
	try{
		query = "select * from user_info where userid = '" + userid + "'";
		query = query + " and password = '" + password + "'";
		rs = st.executeQuery(query);
		
		if(rs.next()){
			name = rs.getString("username");
			email = rs.getString("email");
			bLogin = true;
		}else{
			bLogin = false;			
		}
		rs.close();
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		conn.close();
	}
	
	if(bLogin){
		session.setAttribute("user_info_userid", userid);
		session.setAttribute("user_info_password", password);
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