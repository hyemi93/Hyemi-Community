<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserJoin(회원가입)</title>
</head>
<body>
<section>
<h2>회원가입</h2>
<form class="row g-3" method="post" name="joinform" action="UserProc.jsp">
<input type="hidden" name="action" value="UserJoin">
	<div class="col-md-6">
		<label for="inputEmail4" class="form-label">아이디<font>*</font></label>
		<input type="text" name="id" class="form-control" placeholder="5자 이상의 영문이나 숫자로 입력이 가능합니다.">
	</div>
	
	<div class="col-md-6">
		<label for="inputPassword4" class="form-label">닉네임<font>*</font></label>
		<input type="text" name="nickname" class="form-control">
	</div>
	
	<div class="col-md-6">
		<label for="inputEmail4" class="form-label">비밀번호<font>*</font></label>
		<input type="password" name="pw" class="form-control" placeholder="문자, 숫자, 특수문자의 조합 10 ~ 16 자리로 입력이 가능합니다.">
	</div>
	
	<div class="col-md-6">
		<label for="inputPassword4" class="form-label">비밀번호 확인<font>*</font></label>
		<input type="password" name="repw" class="form-control" placeholder="다시 한번 입력해주세요.">
	</div>

	<div class="col-md-4">
		<label for="inputState" class="form-label">연락처<font>*</font></label>
		<input type="text" name="tel1" class="form-control" placeholder="010">
	</div>
	
	<div class="col-md-4">
		<label for="inputState" class="form-label">　</label>
		<input type="text" name="tel2" class="form-control" placeholder="1234">
	</div>
	
	<div class="col-md-4">
		<label for="inputState" class="form-label">　</label>
		<input type="text" name="tel3" class="form-control" placeholder="5678">
	</div>
	
	<div class="col-md-6">
		<label for="inputState" class="form-label">이메일<font>*</font></label>
		<input type="text" name="eid" class="form-control">
	</div>
	
	<div class="col-md-6">
		<label for="inputState" class="form-label">주소 선택</label>
		<select name="eaddress" class="form-select">
			<option value="">선택하세요</option>
			<option value="@naver.com">@naver.com</option>
			<option value="@kakao.com">@kakao.com</option>
			<option value="@hanmail.net">@hanmail.net</option>
			<option value="@nate.com">@nate.com</option>
		</select>
	</div>
	<div style="margin: 30px 0 0 250px;">
		<input type="button" value="회원가입" class="btn btn-danger" onclick="join_check()">
		<input type="reset" value="다시쓰기" class="btn btn-light">
	</div>
</form>
</section>
</body>
<%@include file="Footer.jsp" %>
</html>