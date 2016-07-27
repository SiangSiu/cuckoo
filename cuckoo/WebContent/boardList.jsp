<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html>
<html>
<head>
    <title>뻐꾸기</title>
    <!-- 본문에서는 다루지 않은 코드입니다. 부록 A에서 살펴보는 플러그인입니다. -->
    <!-- 구 버전의 인터넷 익스플로러에서 HTML5 태그를 인식하게 합니다. -->
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- 초기화 -->
    <link href='https://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
    <!-- 초기화 -->
    <style>
        * { margin: 0; padding: 0; }
        body { font-family: 'Times New Roman', serif; }
        li { list-style: none; }
        a { text-decoration: none; }
        img { border: 0; }
    </style>
    <!-- 헤더 -->
    <style>
        #main_header {
            /* 중앙 정렬*/
            width: 960px; margin: 0 auto;
            
            /* 절대 좌표 */
            height: 100px;
            position: relative;
            
           
        }
        #main_header > #title {
            position: absolute;
            left: 20px; top: 30px;
        }


    </style>
    <!-- 타이틀 -->
    <style>
        #title {
        	height:70px;
            font-family: 'Lobster', cursive; 
            background-image:url('logo.jpg');
            background-size: 100% 100%;
            background-repeat: no-repeat;
        }
        #title > h2 { color: white; }
    </style>
    
       
   
    <!-- 콘텐츠 -->
    <style>
       #content {
       	width: 960px;	margin: 0 auto;	overflow: hidden;
       	background-color: black;
       }
       #content > #main_section {
       	width: 750px; height:800px; 	float: left;	overflow: auto;
       }
       
       
       #content > #main_aside {
       	width: 200px; height: 800px;	float: right;
       }
    </style>
    <!-- 본문 -->
    <style>
       
       #main_section > h1 {color: white;}
      
       
        /*본문 첫번째 탭*/
     #firstTab {display: none;}
      input:nth-of-type(1) ~ div:nth-of-type(1) {display: none;}
      input:nth-of-type(1):checked ~ div:nth-of-type(1) {
      	display: block;	
      	background: rgb(254,254,254); /* Old browsers */
		background: -moz-linear-gradient(top, rgba(254,254,254,1) 71%, rgba(209,209,209,1) 99%); /* FF3.6-15 */
		background: -webkit-linear-gradient(top, rgba(254,254,254,1) 71%,rgba(209,209,209,1) 99%); /* Chrome10-25,Safari5.1-6 */
		background: linear-gradient(to bottom, rgba(254,254,254,1) 71%,rgba(209,209,209,1) 99%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fefefe', endColorstr='#d1d1d1',GradientType=0 ); /* IE6-9 */
		padding: 15px;
		border-radius: 0 0 3px 3px;
      	}
      	
      	 /*본문 두번째 탭*/
     #secondTab {display: none;}
     #secondTab ~ div:nth-of-type(2) {display: none;}
      #secondTab:checked ~ div:nth-of-type(2) {
      	display: block;	border: 1px solid gray;	border-top-color: white;
      	background: rgb(254,254,254); /* Old browsers */
		background: -moz-linear-gradient(top, rgba(254,254,254,1) 71%, rgba(209,209,209,1) 99%); /* FF3.6-15 */
		background: -webkit-linear-gradient(top, rgba(254,254,254,1) 71%,rgba(209,209,209,1) 99%); /* Chrome10-25,Safari5.1-6 */
		background: linear-gradient(to bottom, rgba(254,254,254,1) 71%,rgba(209,209,209,1) 99%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fefefe', endColorstr='#d1d1d1',GradientType=0 ); /* IE6-9 */
		padding: 15px;
		border-radius: 0 0 3px 3px;
      	}
       
       
        /*본문 세번째 탭*/
     #thirdTab {display: none;}
     #thirdTab ~ div:nth-of-type(3) {display: none;}
      #thirdTab:checked ~ div:nth-of-type(3) {
      	display: block;	border: 1px solid gray;	border-top-color: white;
      	background: rgb(254,254,254); /* Old browsers */
		background: -moz-linear-gradient(top, rgba(254,254,254,1) 71%, rgba(209,209,209,1) 99%); /* FF3.6-15 */
		background: -webkit-linear-gradient(top, rgba(254,254,254,1) 71%,rgba(209,209,209,1) 99%); /* Chrome10-25,Safari5.1-6 */
		background: linear-gradient(to bottom, rgba(254,254,254,1) 71%,rgba(209,209,209,1) 99%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fefefe', endColorstr='#d1d1d1',GradientType=0 ); /* IE6-9 */
		padding: 15px;
		border-radius: 0 0 3px 3px;
      	}
       
    
     /*탭모양 구성*/
    section.buttons {overflow: hidden;}
    section.buttons > label {
    	/*수평 정렬*/
    	display: block;	float: left;
    	
    	/*크기 및 글자위치 지정*/
    	width: 100px;	height: 30px;
    	line-height: 30px;
    	text-align: center;
    	
    	/*테두리 지정*/
 
    	
    	/*색상 지정*/
    	background: gray;
    	color: white;
    }
    
    input:nth-of-type(1):checked ~ section.buttons > label:nth-of-type(1) {
    	background: rgb(254,254,254); /* Old browsers */
    	color: black;
    	border-radius: 0 3px 0 0;
    }
    input:nth-of-type(1) ~ section.buttons {border-radius: 0 3px 0 0;}
    
    input:nth-of-type(2):checked ~ section.buttons > label:nth-of-type(2) {
    	background: white;
    	color: black;
    	border-radius: 0 3px 0 0;
    }
    input:nth-of-type(2) ~ section.buttons {border-radius: 0 3px 0 0;}
    
    input:nth-of-type(3):checked ~ section.buttons > label:nth-of-type(3) {
    	background: white;
    	color: black;
    	border-radius: 0 3px 0 0;
    }
    input:nth-of-type(3) ~ section.buttons {border-radius: 0 3px 0 0;}
    
    .tab_item { overflow :hidden; }
    </style>
    <!-- 목록 -->
    <style>
        .item {
        	overflow: hidden;	padding-top: 10px;
        }
        
        .thumbnail {float: left;}
        
        
        .description {float: left; margin-left: 10px;}
        .description > strong {
        	display:block;	width: 100px;	
        	white-space: nowrap;	overflow: hidden;	text-overflow: ellipsis;
        }
    </style>
    <!-- 푸터 -->
    <style>
       #main_footer {
       	/*중앙 정렬*/
       	width: 960px;	margin: 0 auto;
       	margin-bottom: 10px;
       	
       	background-image: url('http://clipartix.com/wp-content/uploads/2016/05/Waves-repin-image-blue-wave-border-clip-art-on.png');
        background-size: 100% 55px;
        background-repeat: no-repeat;
       	/*글자 정렬*/
       	text-align: center;
       }
       
       address {color: rgb(200, 200, 200);}
       
    </style>
    

    
</head>


<body>
<%@ page import="java.util.ArrayList, cuckoo.user.*" %>
<jsp:useBean id="userdb" class="cuckoo.user.UserDBCP" scope="page" />


<% String userid =  request.getParameter("userid");
	 userid = "musha666";
	 String up = request.getParameter("up");
	
	
	
	//접속 user info 확보
	UserEntity userInfo = userdb.getUserEntity(userid);
	
	%>


    <header id="main_header">
        <div id="title">
            
            <h2><%=userInfo.getNickname() %></h2>
        </div>
        
    </header>
    
    
    <div id="content">
    	
    	<!-- Main Section -->
    	<section id="main_section">
    	<% if (up != null){ %>
    		<input id="firstTab" type="radio" name="tab" />
    		<input id="secondTab" type="radio" name="tab" checked="checked"/>
    		<input id="thirdTab" type="radio" name="tab" />
    		<% } else { %>
    		<input id="firstTab" type="radio" name="tab" checked="checked"/>
    		<input id="secondTab" type="radio" name="tab" />
    		<input id="thirdTab" type="radio" name="tab" />
    		<%} %>
    		<section class="buttons">
    			<label for="firstTab">한 가지 소식</label>
    			<label for="secondTab">내 둥지</label>
    			<label for="thirdTab">설정</label>
    		</section>
    		<div class="tab_item">
    			<jsp:include page="newsFeed.jsp" flush="false">
    				<jsp:param name="userid" value="<%=userInfo.getUserid() %>"/>
    			</jsp:include>
    		</div>
    		<div  class="tab_item" >
    			<jsp:include page="myBoard.jsp" flush="false">
    				<jsp:param name="userid" value="<%=userInfo.getUserid() %>"/>
    			</jsp:include>
    		</div>
    		<div class="tab_item">
    			
    		</div>
    	</section>
    	
    	<!-- Main Aside -->
    	<aside id="main_aside">
    		
    	</aside>
    </div>
    
    <!-- Footer -->
    <footer id="main_footer">
    	<h3>HTML5 + CSS3 Basic</h3>
    	<address>Website Layout Basic</address>
    </footer>
   
</body>
</html>