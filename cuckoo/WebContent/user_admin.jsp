<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>우선 테스트다 </title>

<script languge="javascript">
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
	
	ArrayList<UserEntity> list = userdb.getUserEntityList();
	int counter = list.size();
	if (counter > 0) {
%>
	<p><hr>조회된 회원 수가 <%=counter%>명 입니다.
	</br>
	<form name=form method=post action="processuser.jsp">
	<input type="hidden" name="menu" value="">
    <table width=100% border=2 cellpadding=1>
    
    <tr>
    	<td><input type="checkbox" name="all" onclick="check();"><br></td>
       <td align=center><b>아이디</b></td>
       <td align=center><b>이름</b></td>
       <td align=center><b>별명</b></td>
       <td align=center><b>성별</b></td>
       <td align=center><b>이메일</b></td>
       <td align=center><b>가입일</b></td>
       <td align=center><b>마지막로그인</b></td>
       <td align=center><b>매니저</b></td>
       <td align=center><b>비고</b></td>
       
    </tr>
<%
		for( UserEntity user : list ) {
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
		<input type="button" value="매니저로" onclick="updatemanagercheck()">&nbsp;&nbsp;
		<input type="button" value="매니저에서 빠이염" onclick="updatenomanagercheck()">&nbsp;&nbsp;
		<input type="button" value="삭제" onclick="deletecheck()">
	</table>
	
		
	</form>
<% 	}
%>

</center>



</body>
</html>
