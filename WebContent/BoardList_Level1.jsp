<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
    <%
    String category = request.getParameter("category");
    ArrayList<BoardDTO> list = Bdao.BoardList(Bdto);
    ArrayList<BoardDTO> list2 = Bdao.NoticeView();
	%>
	
	<!-- 총 게시물 수 구하기 -->
	<sql:query var="rs" dataSource="${ds}">
	select count(*) as totalcnt from board_tbl where category=?
	<sql:param value="${param.category}"/>
	</sql:query>
	
	<c:forEach var="rs1" items="${rs.rows}">
	<c:set var="totalcnt" value="${rs1.totalcnt}"/>
	</c:forEach>
	
	<!-- 로그인 한 사용자만 게시판을 이용할 수 있음 -->
    <%if (ssid != null || ssaid != null) {%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardList(일반게시판_브론즈)</title>
</head>
<body>
<article>
<h2><%=category%></h2>
<table class="table table-hover" style="width: 950px;">
  <thead>
    <tr>
      <th scope="col" style="width: 10%;">글번호</th>
      <th scope="col" style="width: 45%; text-align: left;">글제목</th>
      <th scope="col" style="width: 10%;">글쓴이</th>
      <th scope="col" style="width: 15%;">작성일</th>
      <th scope="col" style="width: 10%;">조회수</th>
      <th scope="col" style="width: 10%;">댓글</th>
    </tr>
  </thead>
<tbody>

<!-- 공지 글목록 -->
<%
	for (BoardDTO ndto : list2) {
%>
    <tr class="table-active"> 
      <th scope="row">공지</th>
      <td style="text-align: left;"><a href="BoardView_Level1.jsp?bnum=<%=ndto.getBnum()%>&category=<%=category%><%=paging%>"><%=ndto.getTitle()%></a></td>
      <td><%=ndto.getNickname() %></td>
      <td><%=ndto.getBdate() %></td>
      <td><%=ndto.getHit() %></td>
      <td align="center">
      	<div id="comment_button">
      		<a href="#" onclick='window.open("CommentWindow.jsp?bnum=<%=ndto.getBnum()%>&category=공지사항<%=paging%>","_blank","height=460px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>
      		<%=ndto.getCommnum() %></a>
      	</div>
      </td>
    </tr>
<%
}
%>

<!-- 게시판 글목록 -->
<%
	for (BoardDTO dto : list) {
%>
    <tr>
      <th scope="row"><%=dto.getBnum() %></th>
      <td style="text-align: left;"><div style="padding-left: <%=dto.getDepth()*15%>px; color:#808080;"><%if(dto.getDepth()!=0){ %>└ <%}%>
      								<a href="BoardView_Level1.jsp?bnum=<%=dto.getBnum()%>&category=<%=category%><%=paging%>">
      								<%=dto.getTitle()%></div></a>
      </td>
      <td><%=dto.getNickname() %></td>
      <td><%=dto.getBdate() %></td>
      <td><%=dto.getHit() %></td>
      <td align="center">
      	<div id="comment_button">
      		<a href="#" onclick='window.open("CommentWindow.jsp?bnum=<%=dto.getBnum()%>&category=<%=category%><%=paging%>","_blank","height=460px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>
      			<%=dto.getCommnum() %>
      		</a>
      	</div>
      </td>
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

/*글 목록 10개 초과부터 페이징 사용 */
if(totalcnt>10) {%>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="BoardList_Level1.jsp?category=<%=category%><%=paging%>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

	<!-- 페이징 -->
<%
for(pagenum=1; pagenum<=totalcnt2/10+0.9; pagenum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="BoardList_Level1.jsp?category=<%=category%>&startpage=<%=startpage %>&endpage=<%=endpage%>"><%=pagenum %></a></li>	
<%startpage += 10;
  endpage += 10;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="BoardList_Level1.jsp?category=<%=category%>&startpage=<%=startpage-10%>&endpage=<%=endpage-10%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<%} %>

<!-- 공지 게시판은 관리자만 글쓰기가 가능 -->
<%if(ssaid==null && category.equals("공지사항")){ %>
<%} else{ %>
<a href="BoardWrite_Level1.jsp?category=<%=category%>"><input type="button" value="글쓰기" class="btn btn-danger" style="float: right;"></a>
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