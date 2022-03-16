<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
	<%
		String id = request.getParameter("id");
		UserDTO dto = Udao.UserUpdateView(id);
	%>
	<!-- 회원별 작성글, 댓글 수 구하기 -->
	<sql:query var="rs" dataSource="${ds}">
		select (select count(*) from userboard_tbl where id=?)bcnt, (select COUNT(*) from comment_tbl where id=?)ccnt from dual
	<sql:param value="${param.id}"/>
	<sql:param value="${param.id}"/>
	</sql:query>
	
	<c:forEach var="rs1" items="${rs.rows}">
	<c:set var="bcnt" value="${rs1.bcnt}"/>
	<c:set var="ccnt" value="${rs1.ccnt}"/>
	</c:forEach>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserLevelUp(회원 등급 변경)</title>
</head>
<body>
<div class="card" style="width: 400px; height: 200px; text-align: center;">
	<div class="card-header"><gray>${param.id}님의 작성글 정보입니다.</gray></div>
		<div class="card-body">
			<form method="post" action="UserWindowProc.jsp">
			<input type="hidden" name="action" value="UserLevelUp">
			<input type="hidden" name="id" value="<%=id%>">
			<div id="margin_top"></div>
			* 작성글 수 : ${bcnt}<Br>
			* 작성 댓글 수 : ${ccnt}<Br>
			<div id="margin_top"></div>
			<%if(ssaid!=null){ %>
			등급 : <select name="grade">
				<option value="1" <%if(dto.getGrade()==1){%>selected<%}%>>브론즈</option>
				<option value="2" <%if(dto.getGrade()==2){%>selected<%}%>>실버</option>
				<option value="3" <%if(dto.getGrade()==3){%>selected<%}%>>골드</option>
			   </select>

			<input type="submit" value="등업" class="btn btn-danger me-md-2 btn-sm" style="width: 38px; height: 25px; font-size: 12px;">
			<%}%>
		<div style="margin-top: 10px;">
		<input type="button" value="닫기" class="btn btn-light" onclick="close_check()" style="width: 50px; height: 35px; font-size: 14px;">
		</div>
			</form>
		</div>
</div>
</body>
</html>