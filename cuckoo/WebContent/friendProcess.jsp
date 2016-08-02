<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
  /* �ʱ�ȭ */
		 * { margin: 0; padding: 0; }
        body { font-family: 'Times New Roman', serif;  background-color: #008959; }
        img { border: 0; }
        
/* �߾� ����*/
	div {  padding: 5px; margin: 0 auto; position: relative; background-color: #f0fff0; width:1000px }
	#close {position: absolute;		right: 0;	top: 0;
				/*ũ�� �� ������ġ ����*/
		    	width: 90px;	height: 25px;
		    	line-height: 25px;
		    	text-align: center;
		    	
		    	background-image: url("GreenRoundedButton.png"); 
		    	background-size: 100%; background-repeat: no-repeat;
		    	background-color: rgba(0,0,0,0);
	}
	
	table { width: 100%; background-color: rgba(100,200,100,0.5); }
	td.profile { width: 30%; }
	img.profile { width: 250px; height: 250px; }
	td.text { width: 30%; font-size: 50px; vertical-align: top;}
	img.gender { vertical-align: top; }
	td.btn { vertical-align: center; }
	
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
		<font>�� ���� ��û ���</font>
	<%
	String[] frndRqst = userdb.getFrndRqstTo(userid);
	for(int i=0; i<frndRqst.length; i++){
		UserEntity whoRqst = userdb.getUserEntity(frndRqst[i]);
		%>
	<table>
		<tr>
			<td class="profile" rowspan="2"><img class="profile" src="<%=whoRqst.getProfilesrc()%>"></td>
			<td class="text"><%=whoRqst.getNickname() %>
			<%if(whoRqst.getSex().equals("man")) { %><img class="gender" alt="����" src="gender_male.png" title="����"  width="80px">
			<%} else { %><img class="gender" alt="����" src="gender_female.png" title="����" ><%}%></td>
			<td class="btn" rowspan="2"><img class="btn" alt="ģ������" src="checkFrndRequest.png" title="��û����" width="150px" onclick="location.href='boardList.jsp?userid=<%=userid%>&rqstid=<%=frndRqst[i]%>&up=1&rqst=accept';"></td>
			<td class="btn" rowspan="2"><img class="btn" alt="ģ������" src="deny.png" title="��û����" width="150px" onclick="location.href='boardList.jsp?userid=<%=userid%>&rqstid=<%=frndRqst[i]%>&up=1&rqst=deny';"></td>
		</tr>
		<tr>
			<td class="text"><%=whoRqst.getBirthday() %></td>
		</tr>
	</table>
		<%
	}	
%>
	
	
	<input type="button" id="close" value="�ݱ�" onclick="history.go(-1)"/>
	</div>
	
	

</body>
</html>