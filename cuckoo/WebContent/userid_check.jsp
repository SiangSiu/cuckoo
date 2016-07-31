<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*"%>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />
<%
	String userid = request.getParameter("userid");

	int check_count = 0;
	boolean bJoin = false;

	check_count = userdb.sameid_check(userid);
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	function checkEnd(){
		var form = document.id_check;
		opener.join.userid.value= form.userid.value;
		opener.join.userid_check2.value=form.check_count.value;
		self.close();
	}
	
	function doCheck(){
		var form = document.id_check;
		if(!checkValue(form.userid,'아이디',5,16)){
			return;
		}
		form.submit();
	}
	
	function checkValue(target,cmt,lmin,lmax){
		var Alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		var Digit = '1234657890';
		var astr = Alpha+Digit;
		var i;
		var tValue = target.value;
		if(tValue.length < lmin || tValue.length > lmax){
			if(lmin==lmax) alert(cmt+'는' + lmin + 'byte이어야 합니다.');
			else alert(cmt+'는' + lmin + '~' + lmax + 'Byte이내로 입력하셔야 합니다.')
			target.focus();
			return false;
		}
		if(astr.length>1){
			for(i=0 ; i<tValue.length;i++){
				if(astr.indexOf(tValue.substring(i,i+1))<0){
					alert(cmt+'에 허용할 수 없는 문자가 입력 되었습니다.');
					target.focus();
					return false;
				}
			}
		}
		return true;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<form name="id_check" method=post action=userid_check.jsp>
	<input type="hidden" name="check_count" value="<%=check_count%>">
		<div>
			원하는 아이디를 입력 하세요 <input type="text" name="userid" value="<%=userid%>"
				onFocus="this.value=''" maxlength=16 size=16> <input
				type="button" value="중복확인" onClick="doCheck()">
		</div>
		<div>
			<%
				if (check_count > 0) {
			%>
			[<%=userid%>]는(은) 등록되어 있는 아이디 입니다.<br>다시시도 플리즈
			<%
				} else {
			%>
			[<%=userid%>]는(은) 사용가능한 아이디 입니다.<br>
			<%
				}
			%>
			<input type="button" value="확인" onClick="checkEnd()">

		</div>
	</form>

</body>
</html>