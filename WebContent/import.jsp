<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
	<!-- 세션 정보 -->
<%
    request.setCharacterEncoding("UTF-8");
    String ssid = (String)session.getAttribute("sessionid");
    String ssnick = (String)session.getAttribute("sessionnickname");
    String ssgrade = (String)session.getAttribute("sessiongrade");
    String ssaid = (String)session.getAttribute("sessionadminid");
    String paging="&startpage=1&endpage=10";
    String paging2="&startpage=1&endpage=8";
    String paging3="startpage=1&endpage=10";
	pageContext.setAttribute("ssid", ssid);
	pageContext.setAttribute("ssaid", ssaid);
%>

    <!-- 자바 패키지 -->
<%@ page import="java.util.ArrayList,pkg.*"%>
    <jsp:useBean id="Udao" class="pkg.UserDAO" />
	<jsp:useBean id="Udto" class="pkg.UserDTO" />
	<jsp:setProperty property="*" name="Udto"/>
	
    <jsp:useBean id="Bdao" class="pkg.BoardDAO" />
	<jsp:useBean id="Bdto" class="pkg.BoardDTO" />
	<jsp:setProperty property="*" name="Bdto"/>

	<!-- jstl -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
	<sql:setDataSource var="ds" driver="oracle.jdbc.driver.OracleDriver" url="jdbc:oracle:thin:@localhost:1521:xe" user="hyemi" password="1234"/>

	<!-- 스타일시트 & 자바스크립트 -->
	<link href="./css/Community.css" rel="stylesheet" type="text/css">
	<link href="./css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="./js/Script.js"></script>