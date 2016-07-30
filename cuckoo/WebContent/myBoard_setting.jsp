<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
	table { width: 100%; }
	td { max-width: 0; white-space:nowrap; overflow:hidden; text-overflow: ellipsis; }
	


	.mypage {	float: left; margin: 10px; width:216px; 	
	
	background: rgba(249,249,249, 0.6);
	}
</style>

</head>
<body>
<%@ page import="java.util.ArrayList, cuckoo.user.*" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />



<h2>배경화면 설정</h2>
<hr><P>
<% 
	String userid = (String)session.getAttribute("user_info_userid");
	ArrayList<String> imgsrcArr =  newsdb.searchImg(userid); 
	%>
	
		
	<% for(int i=0; i<imgsrcArr.size(); i++){ %>
	<div class=mypage>
	<table>
		<tr>
			<td colspan=4><a href="boardList.jsp?backg=<%=imgsrcArr.get(i)%>&up=3"><img src="<%=imgsrcArr.get(i)%>" width="150" height="150"></a></td>
		</tr>
	</table>
	
	</div>
	<%}
	%>
	<div style="clear: left;">
	</div>
	
	

</body>
</html>