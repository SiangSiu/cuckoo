<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
	.myFeed {	float: left; margin: 10px; width:216px; 	}
	table { width: 100%; }
	td { max-width: 0; white-space:nowrap; overflow:hidden; text-overflow: ellipsis; }
	td.imgContent {	width: 80%;		}
	td.btn { width: 20%;}
	td.td1 { width: 30%;}
	td.td2 { width: 20%;}
	td.td3 { width: 30%;}
	td.td4 { width: 20%;}
</style>


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

//String imgSrc = savePath+ newFileName;
%>
<jsp:include page="upload.jsp">
<jsp:param value="<%=userid %>" name="userid"/>
<jsp:param value="<%=nickName %>" name="nickname"/>
</jsp:include>


	<%
				ArrayList<NewsEntity> newsList = newsdb.getFriendNewsList(userid);
				int counter = newsList.size();
				int row = 0;
				
				if(counter>0) {
				%>
				
					<%
					//날짜시간 형태설정 및 게시물 레코드 반환 반복문 시작
					SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd-HH:mm:ss");
					for( NewsEntity news : newsList) {
					%>
					<div class="myFeed" >
					<table>
						<tr>
						<td colspan="4"><a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid%>"><img  src="<%=news.getImgsrc() %>" width="212" height="212"></a></td>
						</tr>
						<tr>
							<td class="td1"><img alt="엄지척" src="good_icon.png" width="15px">엄지척</td>
							<td class="td2"><%=news.getGood() %></td>
							<td class="td3"><img alt="중지척" src="bad_icon.png" width="15px">중지척</td>
							<td class="td4"><%=news.getBad() %></td>
						</tr>
						<tr>
							<td class="imgContent" colspan="3"> <a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid%>"><%=news.getContent() %></a></td>
							<td class="btn"><input type="button" value="modify" onclick="location.href='boardModifyForm.jsp?num=<%=news.getNum()%>&userid=<%=userid %>';" />
						</tr>
						</table> 
					</div>
					<%
						}
					%>
					
				<%
				}
				%>


</body>
</html>