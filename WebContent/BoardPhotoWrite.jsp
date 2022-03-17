<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardPhotoWrite(사진게시판 글작성)</title>
</head>
<body>
<article>
<form method="post" name="photowriteform" action="BoardPhotoProc.jsp" encType="multipart/form-data">
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
					<option value="갤러리" <c:if test="${param.category=='갤러리'}">selected</c:if>>갤러리</option>
				</select>
					<div id="margin_top"></div>
				<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요.">
			</div>
				<div id="margin_top"></div>
			<div class="mb-3">
				<textarea name="content" class="form-control" rows="20" placeholder="내용을 입력하세요."></textarea>
			</div>
			
			<div class="mb-3">
				<label for="formFileSm" class="form-label">사진을 선택하세요.</label>
				<input type="file" name="photoimg" id="photoimg" class="form-control form-control-sm" accept="image/jpeg, image/png, image/jpg">
			</div>
			
			<div id="top_menu">
				<input type="button" value="작성" class="btn btn-danger" onclick="photowrite_check()">&nbsp;
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
