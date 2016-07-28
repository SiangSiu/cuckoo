<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="user" class="cuckoo.user.UserEntity" scope="page" />
	<%
		out.println("로그인은 어찌어찌 하였건만...오늘은 여기까지..더 진도가 안나가네..<br>");
		String userid = (String)session.getAttribute("user_info_userid");
		String password = (String)session.getAttribute("user_info_password");
		String manager = (String)session.getAttribute("user_info_manager");
		
		out.println("userid = " + userid+"<br>");
		out.println("password = " + password+"<br>");
		out.println("manager = " + manager+"<br>");
		/* String id = request.getParameter("id");

		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String query = "select * from user_info where id=?";

		try {
			Class.forName("org.gjt.mm.mysql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/user_info?useUnicode=true&characterEnding=euckr", "root", "1234");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			pst = conn.prepareStatement(query);
			pst.setString(1, id);
			rs = pst.executeQuery();
			out.println("회원 아이디 :" + rs.getString("userid"));

			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} */
	%>
</body>
</html>