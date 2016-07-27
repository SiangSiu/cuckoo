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
<%	String userid = request.getParameter("userid"); %>

    		<form name="searchForm" action="boardList.jsp" method="get" onsubmit="return searchCheck();">
	    		
				    		<select name="searchType">
								<option value="ALL" selected="selected">All</option>
								<option value="WRITER" >Writer</option>
								<option value="CONTENTS" >Contents</option>
							</select>
						
							<input class="search" type="text" name="searchText"  />
						
							<input class="search" type="submit" value="Search" />
							<input type="button" value="write" onclick="goUrl('boardWriteForm.jsp');"  />
						
			</form>
			
			<%
			//친구목록을 반환해서 친구별로 블록 생성
			String[] frndList = userdb.getFrndList(userid);
			
					for(int i=0; i<frndList.length; i++) {
			%>
			
			<div class="friend_block">
			<%UserEntity userfrnd = userdb.getUserEntity(frndList[i]); %>
				<h1><%=userfrnd.getUsername() %></h1>
				<%
				ArrayList<NewsEntity> newsList = newsdb.getFriendNewsList(userfrnd.getUserid());
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
						<td><a href="boardView.jsp?num=<%=news.getNum()%>"><img  src="<%=news.getImgsrc() %>" width="50" height="50"></a></td>
							<td> <a href="boardView.jsp?num=<%=news.getNum()%>"><%=news.getContent() %></a></td>
							<!-- <td><input type="button" value="modify" onclick="goUrl('boardModifyForm.jsp');" /> -->
						</tr>
					<%
						}
					%>
					</table> 
				<%
				}
				%>
			</div>
			<%
			} 
			
			%>
			
</body>
</html>