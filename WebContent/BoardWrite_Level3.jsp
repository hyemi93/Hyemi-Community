<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardWrite(게시판 글작성)</title>
</head>
<body>
<article>
<form method="post" name="writeform" action="BoardProc.jsp">
<input type="hidden" name="action" value="BoardWrite3">

<!-- 로그인한 사용자에 맞게 작성자 정보 넘겨줌 -->
<%if(ssaid == null){ %>
<input type="hidden" name="id" value="<%=ssid%>">
<input type="hidden" name="nickname" value="<%=ssnick%>">
<%} else if(ssid == null){ %>
<input type="hidden" name="id" value="<%=ssaid%>">
<input type="hidden" name="nickname" value="관리자">
<%} %>
	<ul class="list-group">
		<li class="list-group-item">
		<div id="board_view">
			<div class="mb-3">
				<select name="category">
					<option value="">게시판을 선택하세요.</option>
					<option value="중고거래" <c:if test="${param.category=='중고거래'}">selected</c:if>>중고거래</option>
					<option value="나눔거래" <c:if test="${param.category=='나눔거래'}">selected</c:if>>나눔거래</option>
					<option value="자유게시판　　" <c:if test="${param.category=='자유게시판　　'}">selected</c:if>>자유게시판</option>
				</select>
					<div id="margin_top"></div>
				<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요.">
			</div>
				<div id="margin_top"></div>
			<div class="mb-3">
				<textarea name="content" class="form-control" rows="20" placeholder="내용을 입력하세요."></textarea>
			</div>
			
			<div id="top_menu">
				<input type="button" value="작성" class="btn btn-danger" onclick="write_check()">&nbsp;
				<input type="button" value="목록" class="btn btn-light" onclick="javascript:history.go(-1)">
			</div>
		</div>
		</li>
	</ul>
</form>
</article>
</body>
<%@include file="Footer.jsp" %>
</html>