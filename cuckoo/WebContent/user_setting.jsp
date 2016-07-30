<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">


<script languge="javascript">
function deletecheck() {
	if ( document.userform.password.value=="" ) {
		alert("암호를 입력해 주세요.");
		document.userform.password.focus();
		return;
	}		

	ok = confirm("삭제하시겠습니까?");
	if (ok) {
		document.userform.menu.value='delete';
		document.userform.submit();
	} else {
		return;
	}			
}


function updatecheck() {
	if ( document.userform.nickname.value=="" ) {
		alert("이름을 입력해 주세요.");
		document.userform.nickname.focus();
		return;
	}
	if ( document.userform.password.value=="" ) {
		alert("암호를 입력해 주세요.");
		document.userform.password.focus();
		return;
	}
	document.userform.menu.value='update';
	document.userform.submit();			
}
</script>
</head>
<body>

<%@ page import="java.util.ArrayList, cuckoo.user.*" %>
<jsp:useBean id="user" class="cuckoo.user.UserEntity" scope="page" />
	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />

	<%
		
		String nickname= "";
		String email = ""; 
		String password = "";
		String headline = "수정";
		String userid="";
		
		String id = request.getParameter("id");
		String[] ids = request.getParameterValues("users");
		
		
		for(int i=0; i<ids.length; i++){
			//등록이 아닌 경우, 출력을 위해 선택한 게시의 각 필드 내용을 저장 
			userid = id;
			userdb.deleteDB(ids[i]);
			
		}
		
		user = userdb.getUserEntity(userid);
		
	%>


<h2>학생정보 수정 </h2>

	
	<form name="userform" action="processuser.jsp" method=post>
	<input type="hidden" name="menu" value="insert">
	<input type="hidden" name="userid" value="<%=userid %>">
		<table width=100% border=0 cellspacing=0 cellpadding=7>
 <tr><td align=center>

   <table border=0>
	<tr> <td colspan=2>
		<table>
		    <tr>
		     <td width=50>닉네임 : </td>
		     <td width=100>
				<input type=text name=nickname value="<%=nickname %>" size=30 maxlength=20><%=user.getNickname() %></td>
		     <td width=50>전자메일 :</td>
		     <td width=100>
				<input type=text name=email size=30 value="<%=email %>" maxlength=30><%=user.getEmail() %></td>
		    </tr>	
			<tr >
		     <td width=50>비밀번호: </td>
		     <td colspan=3>
				<input type=text name=password size=80 value="<%=password %>" maxlength=100></td>
			</tr>
		</table>
	</td> </tr>

	<tr>
     <td colspan=2 height=5><hr size=2></td>
    </tr>
	<tr>
     <td colspan=2>
		  		<input type=button value="수정완료" onClick="updatecheck()">
		  		<input type=button value="삭제" onClick="deletecheck()">
		
      	<input type=reset value="취소"> 
	 </td>
    </tr> 
   </table>
  </td></tr>
</table>
	
	</form>




</body>
</html>
