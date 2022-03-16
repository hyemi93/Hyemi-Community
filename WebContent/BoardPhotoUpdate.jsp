<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
    
    <%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String category = request.getParameter("category");
    BoardDTO dto = Bdao.BoardPhotoView(bnum, category);
	%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardPhotoUpdate(사진게시판 글수정)</title>
</head>
<body>
<article>
<form method="post" name="photoupdateform" action="BoardProc.jsp">
<input type="hidden" name="action" value="BoardPhotoUpdate">
<input type="hidden" name="bnum" value="<%=bnum%>">

	<ul class="list-group">
		<li class="list-group-item">
		<div id="board_view">
			<div class="mb-3">
				<select name="category">
					<option value="">게시판을 선택하세요.</option>
					<option value="공지사항" <c:if test="${param.category=='공지사항'}">selected</c:if>>공지사항</option>
					<option value="사진게시판" <c:if test="${param.category=='사진게시판'}">selected</c:if>>사진게시판</option>
					<option value="등업신청" <c:if test="${param.category=='등업신청'}">selected</c:if>>등업신청</option>
				</select>
					<div id="margin_top"></div>
				<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요." value="<%=dto.getTitle()%>">
			</div>
				<div id="margin_top"></div>
			<div class="mb-3">
				<textarea name="content" class="form-control" rows="20" placeholder="내용을 입력하세요."><%=dto.getContent()%></textarea>
			</div>
			
			<label for="formFileSm" class="form-label">사진은 수정할 수 없습니다.</label>
			<div class="input-group mb-3">
				<span class="input-group-text" id="inputGroup-sizing-sm" style="font-size: 12px;">파일 선택</span>
				<input type="text" class="form-control form-control-sm" style="font-size: 12px;" value="<%=dto.getPhotoimg()%>" disabled>
			</div>
			
			<div id="top_menu">
				<input type="button" value="수정" class="btn btn-danger" onclick="photoupdate_check()">&nbsp;
				<input type="button" value="취소" class="btn btn-light" onclick="javascript:history.go(-1)">
			</div>
		</div>
		</li>
	</ul>
</form>
</article>
</body>
<%@include file="Footer.jsp" %>
</html>