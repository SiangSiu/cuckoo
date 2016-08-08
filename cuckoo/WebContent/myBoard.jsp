<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
    <% request.setCharacterEncoding("utf-8"); %>
    <%@ page import="java.util.ArrayList, cuckoo.user.*, cuckoo.news.*, java.text.SimpleDateFormat" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />
<%
	String userid = request.getParameter("userid");
	
	
	String background=""; 
	

	UserEntity userInfo = userdb.getUserEntity(userid);
	
	if(userdb.checkBackground(userInfo.getUserid())){  
			background = userdb.getBackground(userInfo.getUserid());  
	}  


//String imgSrc = savePath+ newFileName;
%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
    /* 초기화 */
		 * { margin: 0; padding: 0; }
        body { font-family: 'Times New Roman', serif;  background-color: #008959; }
        li { list-style: none; }
        a { text-decoration: none; }
        img { border: 0; }



	#profilebox { float: left; width: 710px; background-color:rgba(255, 255, 255, 0.7);
						color: white;
						text-shadow: -1px 0 #0f0, 0 1px #0f0, 1px 0 #0f0, 0 -1px #0f0;
						-moz-text-shadow: -1px 0 #0f0, 0 1px #0f0, 1px 0 #0f0, 0 -1px #0f0;
						-webkit-text-shadow: -1px 0 #0f0, 0 1px #0f0, 1px 0 #0f0, 0 -1px #0f0;
						padding: 5px;
	 }
	td#profileImg {width:40%;}
	td#profileImg > img {width: 280px; height: 280px;}
	td#profileName { font-size: 3em; width: 60%; }
	td#gender { font-size: 4em; }
	td#gender > img { width: 80px; height: 80px; vertical-align: top; }
	td#email { font-size: 1.5em; }
	td#friendbutton {}
	td#friendbutton > font { font-size: 3em;}
	td#friendbutton > img { width: 50px; height: 50px; }
	
	#myback{
		background-image: url("<%=background%>");
		background-size:100%;
		border: 1px solid gray;	border-top-color: white;
		padding: 15px;
		border-radius: 0 0 3px 3px;
		width: 900px; height:1000px; 
	}
	
	.myFeed {	float: left; margin: 10px; width:210px; 
		background: rgba(249,249,249, 0.6);	}
	table { width: 100%; }
	tr { padding: 0; }
	td { padding: 0; max-width: 0; white-space:nowrap; overflow:hidden; text-overflow: ellipsis; }
	td.imgContent {	width: 80%;		}
	td.btn { width: 20%;}
	td.td1 { width: 30%;}
	td.td2 { width: 20%;}
	td.td3 { width: 30%;}
	td.td4 { width: 20%;}
	
	.Button {
		/*수평 정렬*/
    	display: block;	float:left;
    	
    	background-image: url("GreenSquareButton.png"); 
    	background-size: 100%; background-repeat: no-repeat;
    	/*크기 및 글자위치 지정*/
    	width: 40px;	height: 22px;
    	line-height: 24px;
    	text-align: center;
    	 } 
    #modifyBtn {display: none;}
	
</style>


<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
</head>


<body>

<div id="myback">
<div id="profilebox">
	<table>
		<tr>
			<td id="profileImg" rowspan="4"><img alt="프로필 사진" src="<%=userInfo.getProfilesrc()%>" ></td>
			<td id="profileName"><b><%=userInfo.getUsername()+"("+userInfo.getNickname()+")" %></b></td>
		</tr>
		<tr>
			<td id="email">E-mail : <%=userInfo.getEmail() %></td>
		</tr>
		<tr>
	    <!-- 	성별 -->
			<td id="gender"><%if(userInfo.getSex().equals("man")) { %><img alt="성별" src="gender_male.png" title="남자" >
			<%} else { %><img alt="성별" src="gender_female.png" title="여자" ><%}%>
			<!-- 생일 -->
			<font><%=userInfo.getBirthday() %></font>
			</td>
		</tr>
		<tr>
		<!-- 친구요청 -->
			<td id="friendbutton" colspan="2">
				<font><%
							String[] frndRqst = userdb.getFrndRqstTo(userid);
							int rqstNum = frndRqst.length;
							out.print(rqstNum);
						%>명의 요청
				</font>
				<img alt="친구확인" src="checkFrndRequest.png" title="한 나무 요청 확인"  onclick="location.href='friendProcess.jsp?userid=<%=userid%>';">
				</td>
			</tr>
			
	</table>
</div>
<jsp:include page="upload.jsp">
<jsp:param value="<%=userid %>" name="userid"/>
<jsp:param value="<%=userInfo.getNickname() %>" name="nickname"/>
</jsp:include>

<div>
	<%

				ArrayList<NewsEntity> newsList = newsdb.getFriendNewsList(userInfo.getUserid());
				int counter = newsList.size();
				int row = 0;
				
				if(counter>0) {
				%>
				
					<%
					//날짜시간 형태설정 및 게시물 레코드 반환 반복문 시작
					SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd-HH:mm:ss");
					for( int i=newsList.size()-1;  i>=0; i-- ) {
						NewsEntity news = newsList.get(i);
					%>
					<div class="myFeed" >
					<table>
						<tr>
						<td colspan="4"><a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid%>"><img  src="<%=news.getImgsrc() %>" width="210" height="210"></a></td>
						</tr>
						<tr>
							<td class="td1"><img alt="엄지척" src="good_icon.png" width="15px">엄지척</td>
							<td class="td2"><%=news.getGood() %></td>
							<td class="td3"><img alt="중지척" src="bad_icon.png" width="15px">중지척</td>
							<td class="td4"><%=news.getBad() %></td>
						</tr>
						<tr>
							<td class="imgContent" colspan="3"> <a href="boardView.jsp?num=<%=news.getNum()%>&userid=<%=userid%>"><%=news.getContent() %></a></td>
							<td class="btn"><input id="modifyBtn" type="button" value="수정" onclick="location.href='boardModifyForm.jsp?num=<%=news.getNum()%>&userid=<%=userid %>';" />
							<label class="Button" for="modifyBtn">수정</label>
							</td>
						</tr>
						</table> 
					</div>
					<%
						}
					%>
					
				<%
				}
				%>

</div>
</div>

</body>
</html>