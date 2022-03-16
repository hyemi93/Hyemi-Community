<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminLeftMenu(관리자 페이지 메뉴바)</title>
</head>
<body>
<div id="left_menu">
<form method="post" name="loginform" action="UserProc.jsp">
<input type="hidden" name="action" value="UserLogin">
	<ul class="list-group" style="min-width: 165px;">
		<!--관리자 정보 박스-->
		<%if(ssaid!=null) { %>
			<li class="list-group-item">
			<div id="login_box">
			<B>🌼환영합니다🌼</B><Br>
			<B>관리자</B>님<Br>
			<a href="AdminBoardList.jsp?<%=paging3%>">관리자 페이지</a>
			</div>
			</li>
		<%} %>
	</ul>
</form>
	<!-- 관리자 페이지 메뉴바 -->
	<ul class="list-group">
		<li class="list-group-item"><div id="subject">관리자 페이지</div></li>
		<li class="list-group-item"><a href="AdminBoardList.jsp?<%=paging3%>">작성글 확인</a></li>
		<li class="list-group-item"><a href="AdminUserList.jsp?<%=paging3%>">회원관리</a></li>
	</ul>
</div>
</body>
</html>