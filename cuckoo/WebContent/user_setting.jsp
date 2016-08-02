<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<style>
.button {
		/*수평 정렬*/
    	display: block;	float:left;
    	
    	background-image: url("GreenRoundedButton.png"); 
    	background-size: 100%; background-repeat: no-repeat;
    	/*크기 및 글자위치 지정*/
    	width: 100px;	height: 25px;
    	line-height: 25px;
    	text-align: center;
    	float: right;
    	 } 
.elementOfLabel {display: none;}
</style>
<script languge="javascript">
function deleteonecheck() {
	ok = confirm("둥지를 떠나겠습니까??");
	if (ok) {
		document.userform.menu.value='deleteone';
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
	if ( document.userform.email.value=="" ) {
		alert("이메일을 입력해 주세요.");
		document.userform.password.focus();
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
		String userid=(String)session.getAttribute("user_info_userid");
		
		user = userdb.getUserEntity(userid);
		
	%>


<h2 align="left">회원 정보 수정</h2>
<hr><p>

	
	<form name="userform" action="processuser.jsp" method=post>
	<input type="hidden" name="menu" value="insert">
	<input type="hidden" name="userid" value="<%=userid %>">
		<table width=100% border=0 cellspacing=0 cellpadding=7>
 <tr><td align=center>

   <table border=0>
	<tr> <td colspan=2>
		<table>
		    <tr>
		     <td>닉네임 : </td>
		     <td colspan=3>
				<input type=text name=nickname value="<%=user.getNickname() %>" size=30 maxlength=30></td>
		     
		    </tr>
		    <tr>
		    	<td>&nbsp;</td>
		    </tr>
		    <tr>
		    <td>이메일 :</td>
		     <td colspan=3>
				<input type=text name=email size=30 value="<%=user.getEmail() %>" maxlength=30></td>
		    </tr>	
		    <tr>
		    	<td>&nbsp;</td>
		    </tr>
			<tr >
		     <td width=100>비밀번호: </td>
		     <td colspan=3>
				<input type=text name=password size=30 value="<%=password %>" maxlength=30></td>
			</tr>
		</table>
	</td> </tr>

	<tr>
     <td colspan=2 height=5><hr size=2></td>
    </tr>
	<tr>
     <td colspan=2>
		  		<input class="elementOfLabel" id="settingModify" type=button value="수정완료" onClick="updatecheck()">
		  		<input class="elementOfLabel" id="quitMember" type=button value="회원탈퇴" onClick="deleteonecheck()">
		
      	<input class="elementOfLabel" id="cancel" type=reset value="취소"> 
      	
      	
		
		<label class="button" for="cancel">취소</label>
		<label class="button" for="quitMember">회원탈퇴</label>
		<label class="button" for="settingModify">수정완료</label>
	 </td>
    </tr> 
   </table>
  </td></tr>
</table>
	
	</form>




</body>
</html>
