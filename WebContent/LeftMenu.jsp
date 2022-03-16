<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LeftMenu(메인페이지 메뉴바)</title>
</head>
<body>
<div id="left_menu">
<form method="post" name="loginform" action="UserProc.jsp">
<input type="hidden" name="action" value="UserLogin">
	<ul class="list-group" style="min-width: 165px;">
		<!-- 관리자 정보 박스 -->
		<%if(ssaid!=null) { %>
			<li class="list-group-item">
			<div id="login_box">
			<B>🌼환영합니다🌼</B><Br>
			<B>관리자</B>님<Br>
			<a href="AdminBoardList.jsp?<%=paging3%>">관리자 페이지</a>
			</div>
			</li>
		<!-- 로그인 박스 -->
		<%} else if(ssid==null) { %>
			<li class="list-group-item">
			<label for="floatingInput">아이디</label>
			<input type="text" name="id" placeholder="아이디를 입력하세요" class="form-control">
			<div id="margin_top"></div>
			<label for="floatingInput">비밀번호</label>
			<input type="password" name="pw" placeholder="비밀번호를 입력하세요" class="form-control">
			<div style="margin: 5px 0 0 130px;">
			<input type="button" value="로그인" class="btn btn-danger" onclick="login_check()">
			</div>
			</li>
		<!-- 회원 정보 박스 -->
		<%}else {%>
			<li class="list-group-item">
			<div id="login_box">
			<B>🌼환영합니다🌼</B><Br>
			<B><%=ssnick %></B>님 <font>(<%=ssgrade %> 등급)</font><Br>
			<a href="UserPwCheck.jsp">회원정보 수정</a> <a href="UserBoardList.jsp?<%=paging3%>">작성글 확인</a>
			</div>
			</li>
		<%} %>
	</ul>
</form>
	<!-- 메인페이지 메뉴바 -->
	<ul class="list-group">
		<li class="list-group-item"><div id="subject">--브론즈 등급--</div></li>
		<li class="list-group-item"><a href="BoardList_Level1.jsp?category=공지사항<%=paging%>">공지사항</a></li>
		<li class="list-group-item"><a href="BoardList_Level1.jsp?category=인사말<%=paging%>">인사말</a></li>
		<li class="list-group-item"><a href="BoardLineList.jsp?category=등업신청<%=paging%>">등업신청</a></li>
		<li class="list-group-item"><a href="BoardList_Level1.jsp?category=자유게시판<%=paging%>">자유게시판</a></li>
		
		<li class="list-group-item"><div id="subject">--실버 등급--</div></li>
		<li class="list-group-item"><a href="BoardList_Level2.jsp?category=맛집추천<%=paging%>">맛집추천</a></li>
		<li class="list-group-item"><a href="BoardList_Level2.jsp?category=창업정보<%=paging%>">창업정보</a></li>
		<li class="list-group-item"><a href="BoardList_Level2.jsp?category=여행정보<%=paging%>">여행정보</a></li>
		<li class="list-group-item"><a href="BoardPhotoList.jsp?category=갤러리<%=paging2%>">갤러리</a></li>
		<li class="list-group-item"><a href="BoardList_Level2.jsp?category=자유게시판　<%=paging%>">자유게시판</a></li>
		
		<li class="list-group-item"><div id="subject">--골드 등급--</div></li>
		<li class="list-group-item"><a href="BoardList_Level3.jsp?category=중고거래<%=paging%>">중고거래</a></li>
		<li class="list-group-item"><a href="BoardList_Level3.jsp?category=나눔거래<%=paging%>">나눔거래</a></li>
		<li class="list-group-item"><a href="BoardList_Level3.jsp?category=자유게시판　　<%=paging%>">자유게시판</a></li>
	</ul>
</div>
</body>
</html>