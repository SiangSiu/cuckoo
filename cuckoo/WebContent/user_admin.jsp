<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>우선 테스트다 </title>

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

<%@ page import="java.util.ArrayList, cuckoo.user.UserEntity" %>

<hr><center>
<h2>회원 관리</h2>

	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<%
	//페이징 
	int where = 1;
	int totalgroup=0;
	int maxpages=5;
	int startpage=1;
	int endpage=startpage+maxpages-1;
	int wheregroup=1;
	
	if(request.getParameter("go")!=null){
		where = Integer.parseInt(request.getParameter("go"));
		wheregroup = (where-1)/maxpages + 1;
		startpage=(wheregroup-1) * maxpages + 1;
		endpage = startpage + maxpages-1;
	} else if(request.getParameter("gogroup")!=null){
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
	
	if( request.getParameter("orderby")!=null) {
		orderby = (String)request.getParameter("orderby");
	}
	
	if(request.getParameter("desc")!=null){
		desc = Integer.parseInt(request.getParameter("desc"));
		if(desc==1)
			desc = 0;
		else if(desc==0)
			desc = 1;
		
	}
	
	
	ArrayList<UserEntity> list = userdb.getUserEntityList(orderby,desc);
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
	<p><hr>조회된 회원 수가 <%=counter%>명 입니다.
	</br>
	<form name=form method=post action="processuser.jsp">
	<input type="hidden" name="menu" value="">
    <table width=100% border=2 cellpadding=1>
    
    <tr>
    	<td><input type="checkbox" name="all" onclick="check();"><br></td>
       <td align=center><b><a href=user_admin.jsp?orderby=userid&desc=<%=desc %>>아이디</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=username&desc=<%=desc %>>이름</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=nickname&desc=<%=desc %>>별명</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=sex&desc=<%=desc %>>성별</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=email&desc=<%=desc %>>이메일</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=regdate&desc=<%=desc %>>가입일</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=lastconn&desc=<%=desc %>>마지막로그인</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=manager&desc=<%=desc %>>매니저</a></b></td>
       <td align=center><b><a href=user_admin.jsp?orderby=temp&desc=<%=desc %>>비고</a></b></td>
       
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
       <td align=center><%= user.getRegdate() %></td>
       <td align=center><%= user.getLastconn() %></td>
       <td align=center><%= user.getManager() %></td>
       <td align=center><%= user.getTemp() %></td>
       
    </tr>
<%
	    }
%>
	</table>
	<table>
	<tr>
		<td align=left >
		<input type="button" value="매니저로" onclick="updatemanagercheck()">&nbsp;&nbsp;
		<input type="button" value="매니저에서 빠이염" onclick="updatenomanagercheck()">&nbsp;&nbsp;
		<input type="button" value="삭제" onclick="deletecheck()">
		</td>
		<td align=center>
		<%if (wheregroup >1) { 	%>
			[<a href=user_admin.jsp?gogroup=1>처음</a>]
			[<a href=user_admin.jsp?gogroup=<%=priorgroup %>>이전</a>]
		<% }else{ %>
			[처음]
			[이전]
		<%}
		if(list.size() !=0) {
			for(int j=startpage; j<=endpage; j++){
				if(j==where){
					out.println("["+j+"]");
				}else{
					out.println("[<a href=user_admin.jsp?go="+j+">"+j+"</a>]");
				}
					
			}
		}
		if(wheregroup < totalgroup) { %>
			[<a href=user_admin.jsp?gogroup=<%=nextgroup %>>다음</a>]
			[<a href=user_admin.jsp?gogroup=<%=totalgroup %>>마지막</a>]
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
<% 	}
%>

</center>



</body>
</html>
