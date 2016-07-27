<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
</head>


<body>
<%@ page import="java.util.ArrayList, cuckoo.user.*, cuckoo.news.*, java.text.SimpleDateFormat" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />
<%
	String userid = request.getParameter("userid");

	UserEntity userInfo = userdb.getUserEntity(userid);
	String nickName = userInfo.getNickname();
%>

<jsp:include page="upload.jsp">
<jsp:param value="<%=userid %>" name="userid"/>
<jsp:param value="<%=nickName %>" name="nickname"/>
</jsp:include>
<%
//String imgSrc = savePath+ newFileName;
%>
<div id="myFeed" style="overflow: hidden;" >
	<%
				ArrayList<NewsEntity> newsList = newsdb.getFriendNewsList(userid);
				int counter = newsList.size();
				int row = 0;
				
				if(counter>0) {
				%>
				
					<table>
					<%
					//날짜시간 형태설정 및 게시물 레코드 반환 반복문 시작
					SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd-HH:mm:ss");
					for( NewsEntity news : newsList) {
					%>
						<tr>
						<td><a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid%>"><img  src="<%=news.getImgsrc() %>" width="150" height="150"></a></td>
						</tr>
						<tr>
							<td> <a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid%>"><%=news.getContent() %></a></td>
							<td><input type="button" value="modify" onclick="goUrl('boardModifyForm.jsp?num=<%=news.getNum()%>');" />
						</tr>
					<%
						}
					%>
					</table> 
				<%
				}
				%>
</div>

</body>
</html>