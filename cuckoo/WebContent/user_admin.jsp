<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">


<script language="javascript">
function deletecheck() {
	
	ok = confirm("삭제하시겠습니까?");
	if (ok) {
		document.form.menu.value='delete';
		document.form.submit();
	} else {
		return;
	}			
}


function updatemanagercheck() {
	ok = confirm("매니저로 변경하시겠습니까?");
	if (ok) {
		document.form.menu.value='updatemanager';
		document.form.submit();
	} else {
		return;
	}			
}

function updatenomanagercheck() {
	ok = confirm("매니저로 제외 하시겠습니까 ?");
	if (ok) {
		document.form.menu.value='updatenomanager';
		document.form.submit();
	} else {
		return;
	}			
}

function check(){
    cbox = form.users;
    if(cbox.length) {  // 여러 개일 경우
        for(var i = 0; i<cbox.length;i++) {
            cbox[i].checked=form.all.checked;
        }
    } else { // 한 개일 경우
        cbox.checked=form.all.checked;
    }
}

</script>

</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.util.ArrayList, cuckoo.user.UserEntity" %>


<h2 align="left">회원 관리</h2>

	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<%
	//페이징 
	int where = 1;
	int totalgroup=0;
	int maxpages=5;
	int startpage=1;
	int endpage=startpage+maxpages-1;
	int wheregroup=1;
	
	if(request.getParameter("go")!=null && !request.getParameter("go").equals("")){
		where = Integer.parseInt(request.getParameter("go"));
		wheregroup = (where-1)/maxpages + 1;
		startpage=(wheregroup-1) * maxpages + 1;
		endpage = startpage + maxpages-1;
	} else if(request.getParameter("gogroup")!=null && !request.getParameter("gogroup").equals("")){
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
		startpage=(wheregroup-1) * maxpages+1;
		where = startpage;
		endpage=startpage + maxpages-1;
	}
	int nextgroup = wheregroup +1;
	int priorgroup = wheregroup-1;
	
	int nextpage=where+1;
	int priorpage = where-1;
	int startrow=0;
	int endrow=0;
	int maxrows=10;
	int totalrows=0;
	int totalpages = 0;
	String orderby ="lastconn";
	int desc = 0;
	
	if( request.getParameter("orderby")!=null && !request.getParameter("orderby").equals("")) {
		orderby = (String)request.getParameter("orderby");
	}
	
	if(request.getParameter("desc")!=null && !request.getParameter("desc").equals("")){
		desc = Integer.parseInt(request.getParameter("desc"));
		if(desc==1)
			desc = 0;
		else if(desc==0)
			desc = 1;
		
	}
	
	
	String field = request.getParameter("field");
	String value = request.getParameter("value");
	
	
	ArrayList<UserEntity> list = null;
	if(userdb.getUserEntityList(orderby,desc,field,value)!=null){
		list = userdb.getUserEntityList(orderby,desc,field,value);
	}
	int counter = list.size();
	totalrows = list.size();
	totalpages = (totalrows-1)/maxrows+1;
	startrow = (where-1) * maxrows;
	endrow = startrow+maxrows-1;
	if(endrow >= totalrows)
		endrow=totalrows-1;
	
	totalgroup = (totalpages-1)/ maxpages+1;
	if(endpage> totalpages)
		endpage=totalpages;
	
	
	if (counter > 0) {
%>
	<p><hr><h4 align="center">조회된 회원 수가 <%=counter%>명 입니다.</h3>
	<br>
	<form name=form method=post action="processuser.jsp">
	<input type="hidden" name="menu" value="">
    <table width=100% border=2 cellpadding=1>
    
    <tr>
    	<td><input type="checkbox" name="all" onclick="check();"><br></td>
       <td align=center><b><a href=boardList.jsp?orderby=userid&desc=<%=desc %>&up=3>아이디</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=username&desc=<%=desc %>&up=3>이름</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=nickname&desc=<%=desc %>&up=3>별명</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=sex&desc=<%=desc %>&up=3>성별</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=email&desc=<%=desc %>&up=3>이메일</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=birthday&desc=<%=desc %>&up=3>생년월일</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=regdate&desc=<%=desc %>&up=3>가입일</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=lastconn&desc=<%=desc %>&up=3>마지막로그인</a></b></td>
       <td align=center><b><a href=boardList.jsp?orderby=manager&desc=<%=desc %>&up=3>매니저</a></b></td>
       
    </tr>
<%
		for(int i = startrow; i<=endrow; i++ ) {
			UserEntity user = list.get(i);
%>
    <tr>
    	<td><input type="checkbox" name="users" value="<%=user.getUserid() %>"></td>
       <td align=center><%= user.getUserid() %></td>
       <td align=center><%= user.getUsername() %></td>
       <td align=center><%= user.getNickname() %></td>
       <td align=center><%= user.getSex() %></td>
       <td align=center><%= user.getEmail() %></td>
       <td align=center><%= user.getBirthday() %></td>
       <td align=center><%= user.getRegdate() %></td>
       <td align=center><%= user.getLastconn() %></td>
       <td align=center><%= user.getManager() %></td>
       
    </tr>
<%
	    }
%>
	</table>
	<table>
	<tr>
		<td>
		<input type="button" value="매니저로" onclick="updatemanagercheck()">&nbsp;&nbsp;
		<input type="button" value="매니저에서 빠이염" onclick="updatenomanagercheck()">&nbsp;&nbsp;
		<input type="button" value="삭제" onclick="deletecheck()">
		</td>
		<td>
		<%if (wheregroup >1) { 	%>
			[<a href=boardList.jsp?gogroup=1&up=3>처음</a>]
			[<a href=boardList.jsp?gogroup=&up=3<%=priorgroup %>>이전</a>]
		<% }else{ %>
			[처음]
			[이전]
		<%}
		if(list.size() !=0) {
			for(int j=startpage; j<=endpage; j++){
				if(j==where){
					out.println("["+j+"]");
				}else{
					out.println("[<a href=boardList.jsp?go="+j+">"+j+"</a>]");
				}
					
			}
		}
		if(wheregroup < totalgroup) { %>
			[<a href=boardList.jsp?up=3&gogroup=<%=nextgroup %>>다음</a>]
			[<a href=boardList.jsp?up=3&gogroup=<%=totalgroup %>>마지막</a>]
		<% 
		} else {%>
		[다음]
		[마지막]
	<%}
			%>
			</td>
			</tr>
				
	</table>
	
		
	</form>
	<form name=searchform action="boardList.jsp" method=post>
		<select name="field">
			<option value="username">아름</option>
			<option value="userid">아이디</option>
		</select>
		<input type="hidden" name="up" value="3">
		<input type="text" name="value">
		<input type="submit" value="검색">
	
	</form>
<% 	}
%>





</body>
</html>
