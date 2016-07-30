<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
  /* 초기화 */
		 * { margin: 0; padding: 0; }
        body { font-family: 'Times New Roman', serif;  background-color: #008959; }
        img { border: 0; }
        
/* 중앙 정렬*/
	div {  padding: 5px; margin: 0 auto; position: relative; background-color: #f0fff0; width:1000px }
	#close {position: absolute;		right: 0;	top: 0;}
	
	table { width: 100%; }
	td.profile { width: 30%; }
	img.profile { width: 295px; height: 295px; }
	td.text { width: 30%; font-size: 50px;}
	img.gender { width: 140x; }
	td.btn { width : 15%; }
	
	font { font-size: 100px; }
</style>

</head>
<body>
<%@ page import="cuckoo.user.*" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<%
	String userid = request.getParameter("userid");
	if(request.getParameter("friendid")!=null){
	String friendid = request.getParameter("friendid");
	userdb.setFriendRequest(userid, friendid);
	response.sendRedirect("boardFriend.jsp?userid="+userid+"&frndid="+friendid);
	}
	%>
	<div>
		<font>한 나무 요청 목록</font>
	<%
	String[] frndRqst = userdb.getFrndRqstTo(userid);
	for(int i=0; i<frndRqst.length; i++){
		UserEntity whoRqst = userdb.getUserEntity(frndRqst[i]);
		%>
	<table>
		<tr>
			<td class="profile" rowspan="2"><img class="profile" src="<%=whoRqst.getProfilesrc()%>"></td>
			<td class="text"><%=whoRqst.getNickname() %>
			<%if(whoRqst.getSex().equals("man")) { %><img class="gender" alt="성별" src="gender_male.png" title="남자" >
			<%} else { %><img class="gender" alt="성별" src="gender_female.png" title="여자" ><%}%></td>
			<td class="btn" rowspan="2"><img class="btn" alt="친구수락" src="checkFrndRequest.png" title="요청수락" onclick="location.href='boardList.jsp?userid=<%=userid%>&rqstid=<%=frndRqst[i]%>&up=1&rqst=accept';"></td>
			<td class="btn" rowspan="2"><img class="btn" alt="친구거절" src="deny.png" title="요청거절" onclick="location.href='boardList.jsp?userid=<%=userid%>&rqstid=<%=frndRqst[i]%>&up=1&rqst=deny';"></td>
		</tr>
		<tr>
			<td class="text"><%=whoRqst.getBirthday() %></td>
		</tr>
	</table>
		<%
	}	
%>
	
	
	<input type="button" id="close" value="닫기" onclick="history.go(-1)"/>
	</div>
	
	

</body>
</html>