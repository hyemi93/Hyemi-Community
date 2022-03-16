<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
    <%
    String category = request.getParameter("category");
    ArrayList<BoardDTO> list = Bdao.BoardPhotoList(Bdto);
	%>
	
	<!-- 총 게시물 수 구하기 -->
	<sql:query var="rs" dataSource="${ds}">
	select count(*) as totalcnt from photoboard_tbl where category=?
	<sql:param value="${param.category}"/>
	</sql:query>
	
	<c:forEach var="rs1" items="${rs.rows}">
	<c:set var="totalcnt" value="${rs1.totalcnt}"/>
	</c:forEach>
	
	<!-- 로그인 한 사용자만 게시판을 이용할 수 있음 -->
    <%if (ssid == null && ssaid==null) {%>
    <script>alert("로그인이 필요한 서비스입니다.");
    location.href="Index.jsp";
    </script>
    <!-- 등급 별 게시글 접근 제한 -->
    <%}else if(ssgrade.equals("실버") || ssgrade.equals("골드") || ssgrade.equals("admin")){%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardPhotoList(사진게시판)</title>
</head>
<body>
<article>
<h2><%=category%></h2>
<div id="photo_container">
<%
		for(BoardDTO dto : list) {

%>
<div id="photo_element">
	<a href="BoardPhotoView.jsp?bnum=<%=dto.getBnum()%>&category=<%=category%>">
			<img src="./uploadimg/<%=dto.getPhotoimg() %>" class="img-thumbnail" style="width: 200px; height: 200px;"><Br>
			<div id="title"><%=dto.getTitle() %><Br><gray_little><%=dto.getNickname() %></gray_little></div>
	</a>
</div>
<%
}
%>
</div>

<!-- 페이징 처리 -->
<%
int totalcnt = Integer.parseInt(String.valueOf(pageContext.getAttribute("totalcnt"))); //jstl값 형변환
double totalcnt2=totalcnt; //총 게시물 수를 실수형으로 변환
int pagenum = 0; //페이지 넘버
int startpage = 1; 
int endpage = 8;

/*사진 목록 8개 초과부터 페이징 사용 */
if(totalcnt>8) {%>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="BoardPhotoList.jsp?category=<%=category%><%=paging%>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

	<!-- 페이징 -->
<%
for(pagenum=1; pagenum<=totalcnt2/8+0.9; pagenum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="BoardPhotoList.jsp?category=<%=category%>&startpage=<%=startpage %>&endpage=<%=endpage%>"><%=pagenum %></a></li>	
<%startpage += 8;
  endpage += 8;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="BoardPhotoList.jsp?category=<%=category%>&startpage=<%=startpage-8%>&endpage=<%=endpage-8%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<%} %>

<a href="BoardPhotoWrite.jsp?category=<%=category%>"><input type="button" value="글쓰기" class="btn btn-danger" style="float: right;"></a>

</article>
</body>
<%@include file="Footer.jsp" %>
</html>
<!-- 읽기 권한이 없으면 안내 메세지 출력 후 홈으로 이동 -->
<%}else{%>
    <script>alert("읽을 수 있는 권한이 없습니다.");
    location.href="Index.jsp";
    </script>
<%}%>