<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ȸ�� ��� ���� ���� ó��</title>
</head>
<body>

	<!-- �Խ��� ���, ����, ������ ���� �ڹٺ��� �̿� ����-->
	<jsp:useBean id="user" class="cuckoo.user.UserEntity" scope="page" />
	<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />

	<% 
		//�ѱ� ó���� ���� �������ڵ� ����
		request.setCharacterEncoding("utf-8");
		
		String menu = request.getParameter("menu");
		
		
		
			if(menu.equals("update")){
	%>
					<!-- ���� �� BoardEntity�� �����ؾ� �ϴ� �ʵ� id -->
					<jsp:setProperty name="user" property="userid" />
					<jsp:setProperty name="user" property="nickname" />
					<jsp:setProperty name="user" property="email" />
					<jsp:setProperty name="user" property="password" />
	<%		
					//������ ���� �����ͺ��̽� �ڹٺ�� ������ �޼ҵ� updateDB() ���� 			
					userdb.updateDB(user);
				
				//��� ���� �� �ٽ� �Խ� ��� ����� �̵�
				response.sendRedirect("usertest.jsp");		
			} else if(menu.equals("delete")) {
				String[] ids = request.getParameterValues("users");
			
				
				for(int i=0; i<ids.length; i++){
					
					userdb.deleteDB(ids[i]);
					
				}
				
				response.sendRedirect("boardList.jsp?up=3");	
			} else if(menu.equals("updatemanager")) {
				String[] ids = request.getParameterValues("users");
			
				
				for(int i=0; i<ids.length; i++){
					
					userdb.updateManager(ids[i]);
					
				}
				response.sendRedirect("boardList.jsp?up=3");	
				
			} else if(menu.equals("updatenomanager")) {
				String[] ids = request.getParameterValues("users");
			
				
				for(int i=0; i<ids.length; i++){
					
					userdb.updateNoManager(ids[i]);
					
				}
				response.sendRedirect("boardList.jsp?up=3");	
				
			}
				
			
			
	%>

</body>
</html>