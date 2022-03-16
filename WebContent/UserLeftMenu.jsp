<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserLeftMenu(마이 페이지 메뉴바)</title>
</head>
<body>
<div id="left_menu">
<form method="post" name="loginform" action="UserProc.jsp">
<input type="hidden" name="action" value="UserLogin">
	<ul class="list-group">
		<!--로그인 박스-->
		<%if(ssid==null) { %>
			<li class="list-group-item">
			<label for="floatingInput">아이디</label>
			<input type="text" name="id" placeholder="아이디를 입력하세요" class="form-control">
			<div id="margin_top"></div>
			<label for="floatingInput">비밀번호</label>
			<input type="password" name="pw" placeholder="비밀번호를 입력하세요" class="form-control">
			<div style="margin: 5px 0 0 130px;">
			<input type="button" value="로그인" class="btn btn-danger" onclick="login_check()">
			</div>
			</li>
		<!--회원 정보 박스-->
		<%}else {%>
			<li class="list-group-item">
			<div id="login_box">
			<B>🌼환영합니다🌼</B><Br>
			<B><%=ssnick %></B>님 <font>(<%=ssgrade %> 등급)</font><Br>
			<a href="UserUpdate.jsp">회원정보 수정</a> <a href="UserBoardList.jsp?<%=paging3%>">작성글 확인</a>
			</div>
			</li>
		<%} %>
	</ul>
</form>
	<!-- 마이 페이지 메뉴바 -->
	<ul class="list-group">
		<li class="list-group-item"><div id="subject">마이페이지</div></li>
		<li class="list-group-item"><a href="UserBoardList.jsp?<%=paging3%>">작성글 확인</a></li>
		<li class="list-group-item"><a href="UserPwCheck.jsp">회원정보 수정</a></li>
	</ul>
</div>
</body>
</html>