<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원 등록 수정 삭제 처리</title>
</head>
<body>

	<!-- 게시의 등록, 수정, 삭제를 위한 자바빈즈 이용 선언-->
	<jsp:useBean id="user" class="cuckoo.user.UserEntity" scope="page" />
	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />

	<% 
		//한글 처리를 위해 문자인코딩 지정
		request.setCharacterEncoding("utf-8");
		
		String menu = request.getParameter("menu");
		
		
		
			if(menu.equals("update")){
	%>
					<!-- 수정 시 BoardEntity에 지정해야 하는 필드 id -->
					<jsp:setProperty name="user" property="userid" />
					<jsp:setProperty name="user" property="nickname" />
					<jsp:setProperty name="user" property="email" />
					<jsp:setProperty name="user" property="password" />
	<%		
					//수정를 위해 데이터베이스 자바빈즈에 구현된 메소드 updateDB() 실행 			
					userdb.updateDB(user);
				
				//기능 수행 후 다시 게시 목록 보기로 이동
				response.sendRedirect("usertest.jsp");		
			} else if(menu.equals("delete")) {
				String[] ids = request.getParameterValues("users");
			
				
				for(int i=0; i<ids.length; i++){
					
					userdb.deleteDB(ids[i]);
					
				}
				
				response.sendRedirect("user_admin.jsp");	
			} else if(menu.equals("updatemanager")) {
				String[] ids = request.getParameterValues("users");
			
				
				for(int i=0; i<ids.length; i++){
					
					userdb.updateManager(ids[i]);
					
				}
				response.sendRedirect("user_admin.jsp");	
				
			} else if(menu.equals("updatenomanager")) {
				String[] ids = request.getParameterValues("users");
			
				
				for(int i=0; i<ids.length; i++){
					
					userdb.updateNoManager(ids[i]);
					
				}
				response.sendRedirect("user_admin.jsp");	
				
			}
				
			
			
	%>

</body>
</html>