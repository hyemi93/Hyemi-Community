<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="UserLeftMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserPwCheck(비밀번호 체크 페이지)</title>
</head>
<body>
<article>
<form class="row g-3" method="post" name="pwcheckform" action="UserProc.jsp">
<input type="hidden" name="action" value="UserPwCheck">
<input type="hidden" name="id" value="<%=ssid%>">

<!-- 비밀번호 입력 폼 -->
<div class="card" style="margin-left: 150px; width: 600px; text-align: center;">
	<div class="card-header">
	<gray_little>비밀번호를 한 번 더 입력해주세요.</gray_little>
	</div>
	<div class="col-md-6">
		<input type="password" name="pw" class="form-control" style="margin:20px 0 0 150px;">
	</div>
	<div style="margin: 20px 0 10px 20px;">
		<input type="button" value="확인" class="btn btn-danger" onclick="pw_check()">
	</div>
</div>
</form>
</article>
</body>
<%@include file="Footer.jsp" %>
</html>