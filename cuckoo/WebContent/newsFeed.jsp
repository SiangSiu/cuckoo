<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
</head>
<body>

    		<form name="searchForm" action="boardList.jsp" method="get" onsubmit="return searchCheck();">
	    		
				    		<select name="searchType">
								<option value="ALL" selected="selected">All</option>
								<option value="WRITER" >Writer</option>
								<option value="CONTENTS" >Contents</option>
							</select>
						
							<input class="search" type="text" name="searchText"  />
						
							<input class="search" type="submit" value="Search" />
							<input type="button" value="write" onclick="goUrl('boardWriteForm.jsp');"  />
						
			</form>
			<article class="main_article">
				<h1><%="김동민" %></h1>
				<div>
					<table>
						<tr>
						<td><img alt="" src="http://intro-webdesign.com/images/HTML5_1Color_Black.png" width="50" height="50"></td>
							<td> 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세</td>
							<td><input type="button" value="modify" onclick="goUrl('boardModifyForm.jsp');" />
						</tr>
						<tr>
							<td><img alt="" src="http://intro-webdesign.com/images/HTML5_1Color_Black.png" width="50" height="50"></td>
							<td>찾아라 드래곤볼 세상에서 제일 가는 비밀~</td>
						</tr>
					
					</table> 
				</div>
			</article>
			<article class="main_article">
				<h1><%="한상우" %></h1>
				<div>
					<table>
						<tr>
						<td><img alt="" src="http://intro-webdesign.com/images/HTML5_1Color_Black.png" width="50" height="50"></td>
							<td> 아침먹고 땡 점심먹고 땡 창문을 열어보니 비가 오더라 </td>
						</tr>
						<tr>
							<td><img alt="" src="http://intro-webdesign.com/images/HTML5_1Color_Black.png" width="50" height="50"></td>
							<td>아무생각이 없다 왜냐하면 아무생각이 없기 때문이다.</td>
						</tr>
					
					</table> 
				</div>
			</article>
			<article class="main_article">
				<h1><%="박상수" %></h1>
				<div>
					<table>
						<tr>
						<td><img alt="" src="http://intro-webdesign.com/images/HTML5_1Color_Black.png" width="50" height="50"></td>
							<td> Mmmmm! but I wake up and act like nothing's wrong
					Just get ready fi Read more: Rihanna - Work Lyrics | MetroLyrics</td>
						</tr>
						<tr>
							<td><img alt="" src="http://intro-webdesign.com/images/HTML5_1Color_Black.png" width="50" height="50"></td>
							<td>여행을 떠나요 신나는 마음으로~</td>
						</tr>
					
					</table> 
				</div>
			</article>
</body>
</html>