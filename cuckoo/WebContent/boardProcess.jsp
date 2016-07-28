<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
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
	
	Enumeration<String> params = request.getParameterNames();
	 
	 String userid = request.getParameter("userid");
	 
	 ReplyEntity rp = new ReplyEntity();
	  
	 boolean pass = true;
	 
	ClickableEntity click = clickdb.getClick(Integer.parseInt(num), userid);
	
	if(request.getParameter("goodclick")!=null){
		
		if(request.getParameter("goodclick").equals("checked")) {
			click.setGoodclick(request.getParameter("goodclick"));
			clickdb.updateDB(click);
			newsdb.addGood(Integer.parseInt(num));
			response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
		} else if(request.getParameter("goodclick").equals("unchecked")) {
			click.setGoodclick(request.getParameter("goodclick"));
			clickdb.updateDB(click);
			newsdb.subGood(Integer.parseInt(num));
			response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
		}
	} 

	if (request.getParameter("badclick")!=null){
		
		if(request.getParameter("badclick").equals("checked")){
			click.setBadclick(request.getParameter("badclick"));
			clickdb.updateDB(click);
			newsdb.addBad(Integer.parseInt(num));
			response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
		} else if(request.getParameter("badclick").equals("unchecked")) {
			click.setBadclick(request.getParameter("badclick"));
			clickdb.updateDB(click);
			newsdb.subBad(Integer.parseInt(num));
			response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
		}
	}
	 
	%>
	 <div>
	 <form action="boardProcess.jsp" method="post">
	 <input type="hidden" name="num" value="<%= num%>">
	 <input type="hidden" name="userid" value="<%=userid%>">
	 <%
	 if (request.getParameter("edit")!=null){
				
		 String edit = request.getParameter("edit");
		 if(edit.equals("modifyRp")) {
			 String rpnum = request.getParameter("rpnum");
			 rp = rpdb.getReply(Integer.parseInt(rpnum)); 
		 }
	 }
		 
		 %>
		  <input type="hidden" name="rpnum" value="<%=rp.getRpnum() %>">
		  <textarea name="modifiedReply" rows="1" cols="10"><%=rp.getReply() %></textarea>
		 <input type="submit" value="수정">
	 </form>
	 </div>
		 
		 <%
		 if (request.getParameter("edit")!=null){
				
			 String edit = request.getParameter("edit");
			 if(edit.equals("deleteRp")) {
				 String rpnum = request.getParameter("rpnum");
				 rpdb.deleteDB(Integer.parseInt(rpnum));
				 response.sendRedirect("boardModifyForm.jsp?num="+num+"&userid="+userid);
			 }
		 }
	 	
	 while(params.hasMoreElements()){
	  String names = (String)params.nextElement();
	 if(names.equals("reply")){
		 if(request.getParameter("reply")!=""){
		 String reply = request.getParameter("reply");
		 rpdb.insertDB(Integer.parseInt(num), reply, userid);
		 response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
		 }
	 	} else if(names.equals("reply2")) {
		 String[] reply2 = request.getParameterValues("reply2");
		 String[] rpparents = request.getParameterValues("rpparent");
		 for(int i=0; i<reply2.length; i++){
			 if(reply2[i]!=""){
		 		String reply = reply2[i];
		 		String rpparent = rpparents[i];
				 rpdb.insertDB(Integer.parseInt(num), reply, Integer.parseInt(rpparent), userid);
				 response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
		 		}
		 	}	
	 	} else if(names.equals("modifiedReply")) {
	 		int rpnum = Integer.parseInt(request.getParameter("rpnum"));
	 		rpdb.updateDB(rpnum, request.getParameter("modifiedReply"));
			response.sendRedirect("boardView.jsp?num="+num+"&userid="+userid);
	 	} else if(names.equals("editContent")) {
	 		String modi = request.getParameter("editContent");
	 		if(modi.equals("modify")) {
	 			String content = request.getParameter("content");
	 			newsdb.updateDB(Integer.parseInt(num), content);
	 			response.sendRedirect("boardList.jsp?num="+num+"&userid="+userid+"&up=1");
	 		}
	 	} else if(names.equals("deleteNews")) {
	 		if(request.getParameter("deleteNews").equals("delete")) {
	 			newsdb.deleteDB(Integer.parseInt(num));
	 			rpdb.deleteDBByNews(Integer.parseInt(num));
	 			clickdb.deleteDB(Integer.parseInt(num));
	 			response.sendRedirect("boardList.jsp?num="+num+"&userid="+userid+"&up=1");
	 		}
	 	}
	 }
	 
%>

</body>
</html>