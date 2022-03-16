/*회원가입 유효성 */
function join_check() {
	var ck = document.joinform;
	if(ck.id.value=="") {
		alert("아이디를 입력하세요.");
		ck.id.focus();
		return;
	}
	var idtype = /^[a-zA-z0-9]{5,}$/;
    if (!idtype.test(ck.id.value)) {
        alert("아이디는 5자 이상의 영문이나 숫자만 입력 가능합니다.");
        ck.id.focus();
        return;
    }
	if(ck.nickname.value=="") {
		alert("닉네임을 입력하세요.");
		ck.nickname.focus();
		return;
	}
	if(ck.pw.value=="") {
		alert("비밀번호를 입력하세요.");
		ck.pw.focus();
		return;
	}
	var pwtype = /^[a-zA-z0-9~!@#$%^&*+=]{10,16}$/;
    if (!pwtype.test(ck.pw.value)) {
        alert("비밀번호는 문자, 숫자, 특수문자(~!@#$%^&*+=)의 조합 10 ~ 16 자리만 입력 가능합니다.");
        ck.pw.focus();
        return;
    }
	if(ck.repw.value=="") {
		alert("비밀번호를 다시 한번 입력하세요.");
		ck.repw.focus();
		return;
	}
	if(ck.pw.value!=ck.repw.value) {
		alert("비밀번호가 일치하지 않습니다.");
		ck.repw.focus();
		return;
	}
	if(ck.tel1.value=="") {
		alert("연락처를 입력하세요.");
		ck.tel1.focus();
		return;
	}
	if(ck.tel2.value=="") {
		alert("연락처를 입력하세요.");
		ck.tel2.focus();
		return;
	}
	if(ck.tel3.value=="") {
		alert("연락처를 입력하세요.");
		ck.tel3.focus();
		return;
	}
	if(ck.eid.value=="") {
		alert("이메일을 입력하세요.");
		ck.eid.focus();
		return;
	}
	if(ck.eaddress.value=="") {
		alert("이메일 주소를 선택하세요.");
		ck.eaddress.focus();
		return;
	}
	ck.submit();
}

/*로그인 유효성 */
function login_check() {
	var ck = document.loginform;
	if(ck.id.value==""){
		alert("아이디를 입력해주세요.");
		ck.id.focus();
		return;
	}
	if(ck.pw.value==""){
		alert("비밀번호를 입력해주세요.");
		ck.pw.focus();
		return;
	}
	ck.submit();
}

/*회원 정보 수정 전 비밀번호 체크 유효성 */
function pw_check() {
	var ck = document.pwcheckform;
	if(ck.pw.value==""){
		alert("비밀번호를 입력해주세요.");
		ck.pw.focus();
		return;
	}
	ck.submit();
}

function close_check() {
	window.close();
}

/*관리자 로그인 유효성 */
function adminlogin_check() {
	var ck = document.adminloginform;
	if(ck.aid.value==""){
		alert("아이디를 입력해주세요.");
		ck.aid.focus();
		return;
	}
	if(ck.apw.value==""){
		alert("비밀번호를 입력해주세요.");
		ck.apw.focus();
		return;
	}
	ck.submit();
}

/*뒤로가기 후 새로고침*/
function backrefresh() {
	window.location = document.referrer;
}

/*일반게시판 글 작성 및 수정 유효성*/
function write_check() {
	var ck = document.writeform;
	if(ck.category.value=="") {
		alert("게시판을 선택하세요.");
		ck.category.focus();
		return;
	}
	if(ck.title.value=="") {
		alert("제목이 작성되지 않았습니다.");
		ck.title.focus();
		return;
	}
	if(ck.content.value=="") {
		alert("내용이 작성되지 않았습니다.");
		ck.content.focus();
		return;
	}
	ck.submit();
}

/*한줄게시판 답글 작성 및 수정 유효성*/
function linewrite_check(){
	var ck = document.linewriteform;
	if(ck.content.value=="") {
	alert("내용을 작성해주세요.");
	ck.content.focus();
	return;
	}
	ck.submit();
}

/*사진게시판 글 작성 유효성 */
function photowrite_check(){
	var ck = document.photowriteform;
	var filecheck = document.getElementById("photoimg").value;
	if(ck.category.value=="") {
		alert("게시판을 선택하세요.");
		ck.category.focus();
		return;
	}
	if(ck.title.value=="") {
		alert("제목이 작성되지 않았습니다.");
		ck.title.focus();
		return;
	}
	if(ck.content.value=="") {
		alert("내용이 작성되지 않았습니다.");
		ck.content.focus();
		return;
	}
	if(!filecheck){
		alert("사진을 첨부해주세요.");
		ck.photoimg.focus();
		return false;
	}
	ck.submit();
}

/*사진게시판 글 수정 유효성 */
function photoupdate_check(){
	var ck = document.photoupdateform;
	if(ck.category.value=="") {
		alert("게시판을 선택하세요.");
		ck.category.focus();
		return;
	}
	if(ck.title.value=="") {
		alert("제목이 작성되지 않았습니다.");
		ck.title.focus();
		return;
	}
	if(ck.content.value=="") {
		alert("내용이 작성되지 않았습니다.");
		ck.content.focus();
		return;
	}
	ck.submit();
}

/*댓글 작성 및 수정 유효성*/
function comment_check(){
	var ck = document.commentform;
	if(ck.ccomment.value=="") {
	alert("댓글을 작성해주세요.");
	ck.ccomment.focus();
	return;
	}
	ck.submit();
}