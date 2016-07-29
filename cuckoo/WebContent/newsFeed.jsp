<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
	.friend_block {	float: left; margin: 10px; width:690px; border-width:thin; border-style:solid; border-color:green;	}
	table { width: 100%; }
	td { max-width: 0; white-space:nowrap; overflow:hidden; text-overflow: ellipsis; }
	td.thumbnail {	width: 8%;		}
	td.context { width: 92%;}
	
	div#newsFeedName {heigt: 40px;}
	img.frndImg { height: 45px; vertical-align: top; }
	b.frndName { font-size: 35px; }
</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
</head>
<body>


<%@ page import="java.util.ArrayList, cuckoo.user.*, cuckoo.news.*, java.text.SimpleDateFormat" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />
<%	String userid = (String)session.getAttribute("user_info_userid"); %>

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
				<div id="newsFeedName">
				<%UserEntity userfrnd = userdb.getUserEntity(frndList[i]); %>
					<img class="frndImg" id="fImg" alt="친구프사" src="<%=userfrnd.getProfilesrc()%>">
					<b class="frndName"><%=userfrnd.getUsername() %></b>
					</div>
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
					 NewsEntity news = new NewsEntity();
					 int g=5;
					 if(newsList.size()<5){
						 g=newsList.size();
					 }
					for(int k=0; k<g; k++) {
						news = newsList.get(k);
					%>
						<tr>
						<td class="thumbnail" rowspan="2"><a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid %>"><img  src="<%=news.getImgsrc() %>" width="50" height="50"></a></td>
							<td class="context" > <a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid %>"><%=news.getContent() %></a></td>
						</tr>
						<tr>
							<td class="td1">
							<img alt="엄지척" src="good_icon.png" width="25px">
							<%=news.getGood() %>
							<img alt="중지척" src="bad_icon.png" width="25px">
							<%=news.getBad() %></td>
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