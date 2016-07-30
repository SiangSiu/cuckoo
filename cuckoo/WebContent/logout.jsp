<%@ page info="logout" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.io.*,java.text.*"%>
<%
	session = request.getSession(false);
	session.invalidate();
	//세션값을 삭제
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	parent.location.href="index.html";
	// response.sendRedirect()는 특정 프레임이 이동 되지 않을경우가 있다고 해서 자바 스크립트를 씀ㅋ
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>C U Again</title>
</head>
<body>

</body>
</html>