<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
    <%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String category = request.getParameter("category");
    BoardDTO dto = Bdao.BoardView(bnum, category);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardUpdate(일반게시판 내용 수정_브론즈)</title>
</head>
<body>
<article>
<form method="post" name="writeform" action="BoardProc.jsp">
<input type="hidden" name="action" value="BoardUpdate">
<input type="hidden" name="bnum" value="<%=bnum%>">
<input type="hidden" name="category" value="<%=category%>">
	<ul class="list-group">
		<li class="list-group-item">
		<div id="board_view">
			<div class="mb-3">
				<select name="categoryname">
					<option value="">게시판을 선택하세요.</option>
					<%if(ssaid != null){ %>
					<option value="공지사항" <c:if test="${param.category=='공지사항'}">selected</c:if>>공지사항</option>
					<%} %>
					<option value="인사말" <c:if test="${param.category=='인사말'}">selected</c:if>>인사말</option>
					<option value="자유게시판" <c:if test="${param.category=='자유게시판'}">selected</c:if>>자유게시판</option>
				</select>
					<div id="margin_top"></div>
				<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요." value="<%=dto.getTitle()%>">
			</div>
				<div id="margin_top"></div>
			<div class="mb-3">
				<textarea name="content" class="form-control" rows="20" placeholder="내용을 입력하세요."><%=dto.getContent()%></textarea>
			</div>
			
			<div id="top_menu">
				<input type="button" value="수정" class="btn btn-danger" onclick="write_check()">&nbsp;
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