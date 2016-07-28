<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
    <title>파일 업로드 폼</title>
</head>
 
<body>
<% request.setCharacterEncoding("utf-8"); %>
<% 	String userid = request.getParameter("userid");
		String nickname = request.getParameter("nickname");
%>
 
<form name="fileForm" id="fileForm" method="POST" action="imgup.jsp" enctype="multipart/form-data">
    <input type="file" name="uploadFile" id="uploadFile"> 
    <input type="hidden" name="userid" value="<%=userid%>">
    <input type="hidden" name="nickname" value="<%=nickname %>">
    <textarea cols="20" rows="5" title="사진의 설명이나 뻐꾸기 자신의 생각을 지져겨주세요." name="content" id="content"></textarea>
    <input type="submit" value="전송">
</form>
</body>
</html>