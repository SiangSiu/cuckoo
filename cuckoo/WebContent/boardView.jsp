<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- 초기화 -->
    <style>
        * { margin: 0; padding: 0; }
        body { font-family: 'Times New Roman', serif; }
        li { list-style: none; }
        a { text-decoration: none; }
        img { border: 0; }
    </style>

<style type="text/css">
/* 중앙 정렬*/
	div { width: 960px; margin: 0 auto; position: relative; }
	#good { display: none; }
	#bad { display: none; }
	#close {position: absolute;		right: 0;	bottom: 0;}
</style>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

function addLike(){
		document.detailview.goodclick.value='checked';
		alert("엄지척!을 하셨습니다.");
		document.detailview.submit();		
}

function subLike(){
	document.detailview.goodclick.value='unchecked';
	alert("엄지척을 취소하셨습니다.")
	document.detailview.submit();
}

function addHate(){
		document.detailview.badclick.value='checked';
		alert("중지척!을 하셨습니다.");
		document.detailview.submit();

		
}

function subHate(){
	document.detailview.badclick.value='unchecked';
	alert("중지척을 취소하셨습니다.");
	document.detailview.submit();
}
</script>
<body>
<%@ page import="java.util.ArrayList, cuckoo.user.*, cuckoo.news.*, java.text.SimpleDateFormat, java.util.Enumeration, cuckoo.reply.*,cuckoo.clickable.*" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />
<jsp:useBean id="rpdb" class="cuckoo.reply.ReplyDBCP" scope="page" />
<jsp:useBean id="clickdb" class="cuckoo.clickable.ClickableDBCP" scope="page" />
<%
	request.setCharacterEncoding("UTF-8");
	String num =request.getParameter("num");
	NewsEntity news = newsdb.getNews(Integer.parseInt(num));
	
	 
	 String userid = request.getParameter("userid");

	ClickableEntity click = clickdb.getClick(Integer.parseInt(num), userid);
	
	
	
	 if(click.getGoodclick()==null){
			click.setNum(Integer.parseInt(num));
			click.setUserid(userid);
			click.setGoodclick("unchecked");
			click.setBadclick("unchecked");
			clickdb.insertDB(click);
			response.sendRedirect("boardView.jsp?num="+click.getNum()+"&userid="+click.getUserid());
	 }
	
%>
<div>
<h2><%=news.getNickname() %></h2>

<form action="boardProcess.jsp" name="detailview" id="frm" method="post">
<input type="hidden" name="num" value="<%= num%>">
<input type="hidden" name="userid" value="<%=userid%>">
<input type="hidden" name="goodclick">
<input type="hidden" name="badclick">
<table>
	<tr>
		<td colspan="6"><img  src="<%=news.getImgsrc() %>" width="500" height="500"></td>
	</tr>
	<tr>
		<td colspan="6"><%=news.getContent() %></td>
	</tr>
	<tr>
	<%
			
			if(click.getGoodclick().equals("checked")){
	%>
		<td><input type="button" id="good" onclick="subLike()"><label for="good">엄지척 취소</label>
		</td>
		<%} else  { %>
		<td><input type="button" id="good" onclick="addLike()"><label for="good">엄지척!</label>
		</td>
		<% } %>
		<td><%=news.getGood()-1 %></td>
		<%	if(click.getBadclick().equals("checked")){ %>
		<td><input type="button" id="bad" onclick="subHate()"><label for="bad">중지척 취소</label>
		</td>
		<%}else{ %>
		<td><input type="checkbox" id="bad" onclick="addHate()"><label for="bad">중지척!</label>
		</td>
		<%} %>
		<td><%=news.getBad()-1 %></td>
		<td><input type="text" name="reply"></td>
		<td><input type="submit" value="댓글달기" ></td>
	</tr>
	<%
		ArrayList<ReplyEntity> rpList = rpdb.getReplyList(Integer.parseInt(num));
		int counter = rpList.size();
		int row = 0;
		
		if(counter>0) {
			ArrayList<UserEntity>userList = userdb.getUserEntityList();
			for(int i=0; i<rpList.size(); i++) {
				if(rpList.get(i).getRpparent()==0){
					for(UserEntity user : userList){
						if(rpList.get(i).getUserid().equals(user.getUserid())){
							%>
							<tr>
								<td colspan="6"><b><%=user.getUsername() %></b>
							<%
						}
					}
				%>
					<%=rpList.get(i).getReply() %></td>
				</tr>
				<%for(int j=0; j<rpList.size(); j++){
						if(rpList.get(j).getRpparent()==rpList.get(i).getRpnum()&&rpList.get(j).getRpparent()!=0){
							for(UserEntity user : userList){
								if(rpList.get(i).getUserid().equals(user.getUserid())){
									%>
									<tr>
										<td colspan="6">☞ <b><%=user.getUsername() %></b>
									<%
								}
							}
						%>
							<%=rpList.get(j).getReply() %> </td>
						</tr>
						<%
						}
					}
				%>
					<tr>
						<td><input type="text" name="reply2">
						<input type="hidden" name="rpparent" value="<%=rpList.get(i).getRpnum() %>"></td>
						<td><input type="submit" value="댓글달기" ></td>
					</tr>
				<%
				}
			}
		}
	%>
	
</table>
</form>
<form action="boardList.jsp" method="post">
<input type="hidden" name="num" value="<%= num%>">
<input type="hidden" name="userid" value="<%=userid%>">
<%if(news.getUserid().equals(userid)){%>
<input type="hidden" name="up" value="1"/>
<% }%>
<input type="submit" value="닫기" id="close"/>
</form>
</div>
</body>
</html>