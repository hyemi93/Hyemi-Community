<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<%@include file="AdminLeftMenu.jsp" %>

<%
 	int start = Integer.parseInt(request.getParameter("startpage"));
	int end = Integer.parseInt(request.getParameter("endpage"));
	String grade=null;
	ArrayList<UserDTO> list = Udao.UserList(start, end);
%>

	<!-- 총 게시물 수 구하기 -->
	<sql:query var="rs" dataSource="${ds}">
	select count(*) as totalcnt from user_tbl
	</sql:query>
	
	<c:forEach var="rs1" items="${rs.rows}">
	<c:set var="totalcnt" value="${rs1.totalcnt}"/>
	</c:forEach>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminUserList(전체 회원 목록 확인)</title>
</head>
<body>
<article>
<ul class="list-group">
		<li class="list-group-item">
		<div id="comment_view">
			<div id="title" style="color:#ea868f;">회원 목록</div>

			<table width="920px" style="margin-top: 30px; color: #808080; font-weight:bold; font-size: 13px;">
				<tr>
					<td style="width: 15%;">아이디</td>
					<td style="width: 20%;">닉네임</td>
					<td style="width: 18%;">연락처</td>
					<td style="width: 27%;">이메일</td>
					<td style="width: 8%;">등급</td>
					<td style="width: 6%;">　</td>
					<td style="width: 6%;">　</td>
				</tr>					
			</table>
<%
	for (UserDTO dto : list) {
		
		/* 등급 문자로 변환 */
		if(dto.getGrade()==1) {
			grade="브론즈";
		} else if(dto.getGrade()==2){
			grade="실버";
		} else {
			grade="골드";
		}
%>
			<hr>
			<table width="920px">
				<tr>
					<td style="width: 15%;"><B><%=dto.getId() %></B></td>
					<td style="width: 20%;"><%=dto.getNickname() %></td>
					<td style="width: 18%;"><%=dto.getTel() %></td>
					<td style="width: 27%;"><%=dto.getEmail() %></td>
					<td style="width: 8%;"><%=grade %></td>
					<td style="width: 6%;">
						<a href="#" onclick='window.open("UserLevelUp.jsp?id=<%=dto.getId()%>","_blank","height=202px,width=402px,status=yes,toolbar=no,menubar=no,location=no");return false'>
						등업</a></td>
					<td style="width: 6%;">
						<a href="UserProc.jsp?action=UserDelete&id=<%=dto.getId()%>" onclick="return confirm('이 회원을 탈퇴시키겠습니까?');">
						탈퇴</a></td>
				</tr>					
			</table>
<%} %>

<!-- 페이징 처리 -->
<%
int totalcnt = Integer.parseInt(String.valueOf(pageContext.getAttribute("totalcnt"))); //jstl값 형변환
double totalcnt2=totalcnt; //총 게시물 수를 실수형으로 변환
int pagenum = 0; //페이지 넘버
int startpage = 1; 
int endpage = 10;

/*글 목록 10개 초과부터 페이징 사용 */
if(totalcnt>10) { %>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="UserBoardList.jsp?<%=paging3 %>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

	<!-- 페이징 -->
<%
for(pagenum=1; pagenum<=totalcnt2/10+0.9; pagenum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="UserBoardList.jsp?startpage=<%=startpage %>&endpage=<%=endpage%>"><%=pagenum %></a></li>	
<%startpage += 10;
  endpage += 10;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="UserBoardList.jsp?startpage=<%=startpage-10%>&endpage=<%=endpage-10%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<%} %>

		</div>
		</li>
	</ul>
</article>
</body>
<%@include file="Footer.jsp" %>
</html>