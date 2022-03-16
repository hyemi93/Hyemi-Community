<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
    <%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String category = request.getParameter("category");
    int cnum = Integer.parseInt(request.getParameter("cnum"));
    BoardDTO dto = Bdao.CommentUpdateView(Bdto);
	%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CommentUpdate(댓글 내용 수정)</title>
</head>
<body>
	<ul class="list-group" style="width: 980px; margin-left: 5px;">
		<li class="list-group-item">
		<div id="comment_view">
			<div id="title">댓글 수정</div>
		<Br>
		<form method="post" name="commentform" action="BoardWindowProc.jsp">
			<input type="hidden" name="action" value="CommentUpdate">
			<input type="hidden" name="bnum" value="<%=bnum%>">
			<input type="hidden" name="category" value="<%=category%>">
			<input type="hidden" name="cnum" value="<%=cnum%>">
			
			<!-- 댓글 수정 폼 -->
			<div class="form-floating">
	  			<textarea name="ccomment" class="list-group-item" placeholder="댓글을 작성해주세요."style="width:870px;"><%=dto.getCcomment() %></textarea>
	  		<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: -45px; margin-left: 10px;">
	  			<input type="button" value="수정" class="btn btn-danger me-md-2 btn-sm" onclick="comment_check()">
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