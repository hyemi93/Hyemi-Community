<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login(회원 로그인)</title>
</head>
<body>
<form method="post" name="loginform" action="UserWindowProc.jsp">
<input type="hidden" name="action" value="UserLogin">
	<ul class="list-group">
		<li class="list-group-item">
			<label for="floatingInput">아이디</label>
			<input type="text" name="id" placeholder="아이디를 입력하세요" class="form-control">
			
		<div id="margin_top"></div>
		
			<label for="floatingInput">비밀번호</label>
			<input type="password" name="pw" placeholder="비밀번호를 입력하세요" class="form-control">
			
		<div style="margin: 5px 0 0 130px;">
		<input type="button" value="로그인" class="btn btn-danger" onclick="login_check()">
		<input type="button" value="닫기" class="btn btn-light" onclick="close_check()">
		</div>
		</li>
	</ul>
</form>
</body>
</html>