<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin_Login(관리자 로그인)</title>
</head>
<body>
<form method="post" name="adminloginform" action="UserWindowProc.jsp">
<input type="hidden" name="action" value="AdminLogin">
	<ul class="list-group">
		<li class="list-group-item">
			<label for="floatingInput">관리자 아이디</label>
			<input type="text" name="aid" placeholder="아이디를 입력하세요" class="form-control">
			
		<div id="margin_top"></div>
		
			<label for="floatingInput">관리자 비밀번호</label>
			<input type="password" name="apw" placeholder="비밀번호를 입력하세요" class="form-control">
			
		<div style="margin: 5px 0 0 130px;">
		<input type="button" value="로그인" class="btn btn-danger" onclick="adminlogin_check()">
		<input type="button" value="닫기" class="btn btn-light" onclick="close_check()">
		</div>
		</li>
	</ul>
</form>
</body>
</html>