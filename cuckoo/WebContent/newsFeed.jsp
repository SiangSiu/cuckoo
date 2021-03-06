<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">

	input.search {
		/*크기 및 글자위치 지정*/
    	width: 90px;	height: 25px;
    	line-height: 25px;
    	text-align: center;
    	
    	background-image: url("GreenRoundedButton.png"); 
    	background-size: 100%; background-repeat: no-repeat;
    	background-color: rgba(0,0,0,0);
	}



	.friend_block {	float: left; width:690px; background-color: rgba(10,100,10,0.15); padding: 10px;	
							margin-top: 15px; 
	}
	table { width: 100%; 
				background-color: rgba(255,255,255,0.5);
	}
	td { max-width: 0; white-space:nowrap; overflow:hidden; text-overflow: ellipsis; }
	td.thumbnail {	width: 8%;		}
	td.context { width: 92%;}
	
	div#newsFeedName {heigt: 40px; width:685px;}
	img.frndImg { height: 45px; vertical-align: top; }
	b.frndName { font-size: 35px; color: white;
						text-shadow: -1px 0 #0f0, 0 1px #0f0, 1px 0 #0f0, 0 -1px #0f0;
						-moz-text-shadow: -1px 0 #0f0, 0 1px #0f0, 1px 0 #0f0, 0 -1px #0f0;
						-webkit-text-shadow: -1px 0 #0f0, 0 1px #0f0, 1px 0 #0f0, 0 -1px #0f0;
	}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
</head>
<body>


<%@ page import="java.util.ArrayList, cuckoo.user.*, cuckoo.news.*, java.text.SimpleDateFormat" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />
<%	String userid = (String)session.getAttribute("user_info_userid");
String searchType="";
String searchText="";

if(request.getParameter("searchType")!=null){
	searchType = request.getParameter("searchType");
}
if(request.getParameter("searchText")!=null){
	searchText = request.getParameter("searchText");
}



%>

    		<form name="searchForm" action="boardList.jsp" method="get" onsubmit="return searchCheck();">
	    		
				    		<select name="searchType">
								<option value="ALL" selected="selected">All</option>
								<option value="username" >이름</option>
								<option value="userid" >아이디</option>
							</select>
						
							<input  type="text" name="searchText"  />
						
							<input class="search" type="submit" value="검색" />
							
						
			</form>
			
			<%
			String[] frndList=null;
			//친구목록을 반환해서 친구별로 블록 생성
			if(searchType==null || searchType.equals("")){
				frndList = userdb.getFrndList(userid);
			} else if(searchType.equals("ALL")){
				frndList = userdb.getFindList_all(searchText);
			} else if(searchType.equals("userid")){
				frndList = userdb.getFindList_userid(searchText);
			} else if(searchType.equals("username")){
				frndList = userdb.getFindList_username(searchText);
			}
				if(frndList.length>0){
					for(int i=0; i<frndList.length; i++) {
			%>
			<%UserEntity userfrnd = userdb.getUserEntity(frndList[i]); %>
			<div class="friend_block" style="background-image: url('<%=userfrnd.getTemp()%>');">
				<div id="newsFeedName">
				
					<img class="frndImg" id="fImg" alt="친구프사" src="<%=userfrnd.getProfilesrc()%>" onclick="location.href='boardFriend.jsp?userid=<%=userid%>&frndid=<%=userfrnd.getUserid()%>';">
					<b class="frndName" onclick="location.href='boardFriend.jsp?userid=<%=userid%>&frndid=<%=userfrnd.getUserid()%>';"><%=userfrnd.getUsername() %></b>
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
		}
			
			%>
			
</body>
</html>