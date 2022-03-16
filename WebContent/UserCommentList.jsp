<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<%@include file="UserLeftMenu.jsp" %>

<%
	int start = Integer.parseInt(request.getParameter("startpage"));
	int end = Integer.parseInt(request.getParameter("endpage"));
	ArrayList<BoardDTO> list = Bdao.CommentUserList(ssid, start, end);
%>

	<!-- 총 게시물 수 구하기 -->
	<sql:query var="rs" dataSource="${ds}">
	select count(*) as totalcnt from comment_tbl where id=?
	<sql:param value="${ssid}"/>
	</sql:query>
	
	<c:forEach var="rs1" items="${rs.rows}">
	<c:set var="totalcnt" value="${rs1.totalcnt}"/>
	</c:forEach>

	<!-- 로그인 한 사용자만 이용할 수 있음 -->
    <%if (ssid != null || ssaid != null) {%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserCommentList(회원 댓글목록)</title>
</head>
<body>
<article>
<!--글 & 댓글 목록 탭-->
<ul class="nav nav-tabs">
  <li class="nav-item">
     <a class="nav-link" style="color: #ea868f;" href="UserBoardList.jsp?<%=paging3%>">작성글 목록</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" href="UserCommentList.jsp?<%=paging3%>">작성 댓글 목록</a>
  </li>
</ul>

<table class="table table-hover" style="width: 950px;">
  <thead>
    <tr>
      <th scope="col" style="width: 10%;">게시판</th>
      <th scope="col" style="width: 65%; text-align: left;">글제목</th>
      <th scope="col" style="width: 10%;">글쓴이</th>
      <th scope="col" style="width: 15%;">작성일</th>
    </tr>
  </thead>
<tbody>

<!-- 회원 댓글 목록 -->
<%
	for (BoardDTO dto : list) {
%>
    <tr>
      <th><div id="title"><gray_little><%=dto.getCategory() %></gray_little></div></th>
      <td style="text-align: left;"><%if(dto.getCategory().equals("사진게시판")){ %><a href="BoardPhotoView.jsp?bnum=<%=dto.getBnum()%>&category=<%=dto.getCategory()%><%=paging%>">
      				<%}else {%>
      				<a href="BoardView.jsp?bnum=<%=dto.getBnum()%>&category=<%=dto.getCategory()%><%=paging%>">
      				<%} %>
      								<%=dto.getCcomment()%></a>
      </td>
      <td><%=dto.getNickname() %></td>
      <td><%=dto.getCdate() %></td>
    </tr>
<%
}
%>
</tbody>
</table>

<!-- 페이징 처리 -->
<%
int totalcnt = Integer.parseInt(String.valueOf(pageContext.getAttribute("totalcnt"))); //jstl값 형변환
double totalcnt2=totalcnt; //총 게시물 수를 실수형으로 변환
int pagenum = 0; //페이지 넘버
int startpage = 1; 
int endpage = 10;

/*댓글 목록 10개 초과부터 페이징 사용 */
if(totalcnt>10) {%>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="UserCommentList.jsp?<%=paging3%>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

	<!-- 페이징 -->
<%
for(pagenum=1; pagenum<=totalcnt2/10+0.9; pagenum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="UserCommentList.jsp?startpage=<%=startpage %>&endpage=<%=endpage%>"><%=pagenum %></a></li>	
<%startpage += 10;
  endpage += 10;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="UserCommentList.jsp?startpage=<%=startpage-10%>&endpage=<%=endpage-10%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<%} %>

</article>
</body>
<%@include file="Footer.jsp" %>
</html>
<!-- 로그인한 사용자가 아니면 팝업 후 홈으로 이동 -->
<%}else{%>
    <script>alert("로그인이 필요한 서비스입니다.");
    location.href="Index.jsp";
    </script>
<%}%>