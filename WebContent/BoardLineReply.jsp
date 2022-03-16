<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
    <%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String category = request.getParameter("category");
    int depth = Integer.parseInt(request.getParameter("depth"));
    int location = Integer.parseInt(request.getParameter("location"));
	%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardLineReply(한줄게시판 답글 작성)</title>
</head>
<body>
	<ul class="list-group" style="width: 980px; margin-left: 5px;">
		<li class="list-group-item">
		<div id="comment_view">
			<div id="title">답글 작성</div>
		<Br>
		<form method="post" name="linewriteform" action="BoardWindowProc.jsp">
			<input type="hidden" name="action" value="BoardLineReply">
			
			<!-- 로그인 한 사용자에 따라 값 전송 -->
			<%if(ssaid == null){ %>
			<input type="hidden" name="id" value="<%=ssid%>">
			<input type="hidden" name="nickname" value="<%=ssnick%>">
			<%} else if(ssid == null){ %>
			<input type="hidden" name="id" value="<%=ssaid%>">
			<input type="hidden" name="nickname" value="관리자">
			<%} %>
			
			<input type="hidden" name="rebnum" value="<%=bnum%>">
			<input type="hidden" name="category" value="<%=category%>">
			<input type="hidden" name="depth" value="<%=depth%>">
			<input type="hidden" name="location" value="<%=location%>">
			
			<!-- 한줄게시판 답글 작성 폼 -->
			<div class="form-floating">
	  			<textarea name="content" class="list-group-item" placeholder="한 줄 메세지를 남겨주세요."style="width:870px;"></textarea>
	  			<div id="secret_button_window"><input type="checkbox" name="secretyn" value="Y">비밀글</div>
	  		<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: -40px;">
	  			<input type="button" value="작성" class="btn btn-danger me-md-2 btn-sm" onclick="linewrite_check()">
			</div>
			</div>
		</form>
			<div id="margin_top"></div>
		</div>
		</li>
	</ul>
		<div style="margin: 5px 0 0 450px;">
		<input type="button" value="닫기" class="btn btn-light" onclick="close_check()">
		</div>
</body>
</html>