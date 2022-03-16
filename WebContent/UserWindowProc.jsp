<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
<!-- 팝업창 프로세스 처리 페이지 -->
<%
	String action = request.getParameter("action");
	String msg = null;
	
	switch (action) {
	case "UserLogin" :%>
		<!-- 등급 문자로 변환 -->
		<sql:query var="rs" dataSource="${ds }">
		select nickname, decode(grade, '1', '브론즈', '2', '실버', '골드') as grade from user_tbl where id=? and pw=?
		<sql:param value="${param.id}"/>
		<sql:param value="${param.pw}"/>
		</sql:query>
		
		<c:forEach var="rs1" items="${rs.rows }">
		<c:set var="nickname" value="${rs1.nickname }"/>
		<c:set var="grade" value="${rs1.grade }"/>
		</c:forEach>	
<%
		boolean result = Udao.UserLogin(Udto);
		msg = "다시 시도해주십시오.";
		if(result){
			msg = "방문을 환영합니다.";
%>
    	<c:set var="sessionid" value="${param.id}" scope="session"/>
    	<c:set var="sessionnickname" value="${nickname}" scope="session"/>
    	<c:set var="sessiongrade" value="${grade}" scope="session"/>
<%
		}
    break;
    
	case "AdminLogin" :
		String aid = request.getParameter("aid");
	    	boolean result2 = Udao.AdminLogin(Udto);
	    	msg = "로그인에 실패하였습니다.";
	    	if(result2){
	    		session.setAttribute("sessionadminid", aid);
	    		session.setAttribute("sessiongrade", "admin");
	    		msg = "관리자로 로그인하였습니다.";
	    	}
	    break;
	    
	case "UserLevelUp" :
	    	boolean result3 = Udao.UserGradeUpdate(Udto);
	    	msg = "다시 시도해주십시오.";
	    	if(result3){
	    		msg = "회원 등급이 변경되었습니다.";
	    	}
	    break;
	}
%>

<script>
	alert("<%=msg%>");
	window.close();
	opener.location.reload();
</script>