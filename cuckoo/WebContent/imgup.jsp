<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
    <title>파일 업로드 폼</title>
</head>
<body>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="cuckoo.news.NewsEntity" %>
 <jsp:useBean id="newsdb" class="cuckoo.news.NewsDBCP" scope="page" />
 <jsp:useBean id="news" class="cuckoo.news.NewsEntity" scope="page" />

 
<%
	
	NewsEntity nws = new NewsEntity();
    request.setCharacterEncoding("UTF-8");
 
    // 10Mbyte 제한
    int maxSize  = 1024*1024*10;    

    // 웹 컨텐츠 경로
    String absolutePath = System.getProperty("user.dir")+"/workspace"+request.getContextPath()+"/WebContent/Img";
   // String root = request.getScheme() + "://" + request.getServerName() +":"+request.getServerPort()+request.getContextPath();
 
    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
    String savePath = "../Img";
 
    // 업로드 파일명
    String uploadFile = "";
 
    // 실제 저장할 파일명
    String newFileName = "";
 
    // 전송받은 parameter의 한글깨짐 방지
    String content;

    String userid;

    String nickname;
 
    int read = 0;
    byte[] buf = new byte[1024];
    FileInputStream fin = null;
    FileOutputStream fout = null;
    long currentTime = System.currentTimeMillis();  
    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmssSSS");  
 
   try{
 
        MultipartRequest multi = new MultipartRequest(request, absolutePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
         
        // 전송받은 parameter의 한글깨짐 방지
        content = multi.getParameter("content");

        userid = multi.getParameter("userid");

        nickname = multi.getParameter("nickname");

        
 
        // 파일업로드
        uploadFile = multi.getFilesystemName("uploadFile");
 
        // 실제 저장할 파일명(ex : 20140819151221.zip)
        newFileName = simDf.format(new Date(currentTime)) +"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
 
         
        // 업로드된 파일 객체 생성
        File oldFile = new File(absolutePath +"/"+ uploadFile);
 
         
        // 실제 저장될 파일 객체 생성
        File newFile = new File(absolutePath +"/"+ newFileName);
         
        // DB저장
        String imgSrc = savePath +"/"+ newFileName;
        nws.setUserid(userid);
        nws.setNickname(nickname);
        nws.setImgsrc(imgSrc);
        nws.setContent(content);
        newsdb.insertDB(nws);
        
        
 
        // 파일명 rename
        if(!oldFile.renameTo(newFile)){
 
            // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
 
            buf = new byte[1024];
            fin = new FileInputStream(oldFile);
            fout = new FileOutputStream(newFile);
            read = 0;
            while((read=fin.read(buf,0,buf.length))!=-1){
                fout.write(buf, 0, read);
            }
             
            fin.close();
            fout.close();
            oldFile.delete();
        }   
 
   }catch(Exception e){
        e.printStackTrace();
   }finally {
	   response.sendRedirect("boardList.jsp?userid="+nws.getUserid()+"&up=1");
   }
 
%>

</body>
</html>