<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.button {
		/*수평 정렬*/
    	display: block;	float:left;
    	
    	background-image: url("GreenRoundedButton.png"); 
    	background-size: 100%; background-repeat: no-repeat;
    	/*크기 및 글자위치 지정*/
    	width: 100px;	height: 25px;
    	line-height: 25px;
    	text-align: center;
    	float: right;
    	 } 
.elementOfLabel {display: none;}
input#uploadingBtn { display: none; }
textarea#uploadcontent {
	width: 705px;
	height: 120px;
	border: 3px solid #cccccc;
	padding: 5px;
	font-family: Tahoma, sans-serif;
}
div#blankBlock {width: 500px; height: 25px;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
    <title>파일 업로드 폼</title>
</head>
 
<body>
<% request.setCharacterEncoding("utf-8"); %>
<% 	String userid = request.getParameter("userid");
		String nickname = request.getParameter("nickname");
%>
 
<form name="fileForm" id="fileForm" method="POST" action="imgup.jsp" enctype="multipart/form-data">
    <input type="hidden" name="userid" value="<%=userid%>">
    <input type="hidden" name="nickname" value="<%=nickname %>">
    <textarea id="uploadcontent" cols="10" rows="5" title="사진의 설명이나 뻐꾸기 자신의 생각을 지져겨주세요." name="content" id="content"></textarea>    
    <input type="file" name="uploadFile" id="uploadFile" class="elementOfLabel"> 
    <input class="elementOfLabel" id="uploadingBtn" type="submit" value="전송">
    <label for="uploadingBtn" class="button">게시물 등록</label>
    <label class="button" for="uploadFile">사진 선택</label>
</form>
<div id="blankBlock"></div>
</body>
</html>