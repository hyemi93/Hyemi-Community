<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community</title>
</head>
<body>
<div id="main_header">
	<div id="top_menu">
		<%if (ssaid != null) {%>
		<font>관리자님</font> <a href="Logout.jsp">로그아웃</a>
		<%}else if(ssid==null){ %>
		<a href="#" onclick='window.open("Login.jsp","_blank","height=200,width=500,status=yes,toolbar=no,menubar=no,location=no");return false'>로그인</a>
		<%}else{ %>
		<font><%=ssnick%>(<%=ssid %>)님</font> <a href="Logout.jsp">로그아웃</a>
		<%} %>
		<a href="UserJoinTerm.jsp">회원가입</a> <%if(ssaid!=null){%><a href="AdminBoardList.jsp?<%=paging3%>">관리자 페이지</a><%}else {%>
		<a href="UserBoardList.jsp?<%=paging3%>">마이 페이지</a><%} %> <a href="Index.jsp">홈</a>
	</div>
</div>
</body>
</html>