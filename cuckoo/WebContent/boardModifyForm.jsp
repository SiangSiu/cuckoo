<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- 초기화 -->
    <style>
        * { margin: 0; padding: 0; }
        body { font-family: 'Times New Roman', serif;		background-color: #008959; }
        li { list-style: none; }
        a { text-decoration: none; }
        img { border: 0; }
    </style>

<style type="text/css">
/* 중앙 정렬*/
	div { width: 960px;  padding: 5px; margin: 0 auto; position: relative; background-color: #f0fff0; }
	#good { display: none; }
	#bad { display: none; }
	#close {position: absolute;		right: 0;	top: 0;}
	/* 좋싫 버튼 */
	.imgBtn { height: 50px;		width: 50px; }
	/*좋싫 숫자*/
	.btnRate { font-size: 3.5em; }
	#img { height: 955px;	width: 955px; }
	#contentText { font-size: 2em; }
	.submit { position: relative; left: 100px; }
	tr { background-color: #f0fff0; }
</style>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function modify(){
	document.detailview.editContent.value='modify';
	alert("게시물을 수정합니다.");
	document.detailview.submit();
}

function removeNews(){
	document.detailview.deleteNews.value='delete';
	alert("게시물을 삭제합니다.");
	document.detailview.submit();
}

function setProfile(){
	if(confirm("프로필 사진으로 지정하시겠습니까?")){
		document.detailview.setprofile.value='set';
		document.detailview.submit();
	}
	
	
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
<input type="hidden" name="deleteNews">
<input type="hidden" name="editContent">
<input type="hidden" name="profileSrc" value="<%=news.getImgsrc()%>">
<input type="hidden" name="setprofile">
<table>
	<tr>
		<td colspan="6"><img id="img"  src="<%=news.getImgsrc() %>" onclick="setProfile()" ></td>
	</tr>
	<tr>
		<td colspan="6" id="contentText" >
		<textarea style="width:99%" cols="20" rows="5" title="게시물의 내용을 수정하세요." name="content" id="content"><%=news.getContent() %></textarea>
		</td>
	</tr>
	<tr>
		<td width="50px"><img class="imgBtn"  src="good_icon.png">
		</td>
		<td class="btnRate" width="50px"><%=news.getGood() %></td>
		<td width="50px"><img class="imgBtn" src="bad_icon.png">
		</td>
		<td class="btnRate" width="50px"><%=news.getBad() %></td>
		<td><input type="button" id="modifyBtn" onclick="modify()"><label for="modifyBtn">수정</label></td>
		<td><input type="button" id="deleteBtn" onclick="removeNews()"><label for="deleteBtn">삭제</label></td>
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
					<%=rpList.get(i).getReply() %>
					<input type="button" id="Button<%=i %>" onclick="location.href='boardProcess.jsp?num=<%=num%>&userid=<%=userid%>&rpnum=<%=rpList.get(i).getRpnum()%>&edit=<%="deleteRp"%>';">
					<label for="Button<%=i %>">삭제</label>
					</td>
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
							<%=rpList.get(j).getReply() %>
							<input type="button" id="btn<%=j %>" onclick="location.href='boardProcess.jsp?num=<%=num%>&userid=<%=userid%>&rpnum=<%=rpList.get(j).getRpnum()%>&edit=<%="deleteRp"%>';">
							<label for="btn<%=j %>">삭제</label>
							</td>
						</tr>
						<%
						}
					}
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