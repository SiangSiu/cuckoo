<%@ page info="logout" language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.io.*,java.text.*"%>
<%
	session = request.getSession(false);
	session.invalidate();
	//���ǰ��� ����
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	parent.location.href="index.html";
	// response.sendRedirect()�� Ư�� �������� �̵� ���� ������찡 �ִٰ� �ؼ� �ڹ� ��ũ��Ʈ�� ����
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>C U Again</title>
</head>
<body>

</body>
</html>