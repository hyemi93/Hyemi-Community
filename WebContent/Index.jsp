<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<%@include file="LeftMenu.jsp" %>

<%
	ArrayList<BoardDTO> list = Bdao.BoardNewList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
</head>
<body>
<article>

<!-- 메인 이미지 -->
<img src="./css/main.png" class="img-fluid" alt="main" style="width: 800px; margin: 0 0 40px 100px;">

<h3>최신글목록</h3>
<table class="table table-hover" style="width: 950px;">
  <thead>
    <tr>
      <th scope="col" style="width: 10%;">게시판</th>
      <th scope="col" style="width: 45%; text-align: left;">글제목</th>
      <th scope="col" style="width: 10%;">글쓴이</th>
      <th scope="col" style="width: 15%;">작성일</th>
      <th scope="col" style="width: 10%;">조회수</th>
      <th scope="col" style="width: 10%;">댓글</th>
    </tr>
  </thead>
<tbody>

<!-- 게시판 글목록 -->
<%
	for (BoardDTO dto : list) {
%>
    <tr>
      <td><div id="title"><gray_little><%=dto.getCategory() %></gray_little></div></td>
      <td style="text-align: left;"><div style="padding-left: <%=dto.getDepth()*15%>px; color:#808080;"><%if(dto.getDepth()!=0){ %>└ <%}%>
      								<%if(dto.getCategory().equals("공지사항") || dto.getCategory().equals("인사말") || dto.getCategory().equals("자유게시판")){ %>
      								<a href="BoardView_Level1.jsp?bnum=<%=dto.getBnum()%>&category=<%=dto.getCategory()%><%=paging%>">
      								<%}else if(dto.getCategory().equals("중고거래") || dto.getCategory().equals("나눔거래") || dto.getCategory().equals("자유게시판　　")){ %>
      								<a href="BoardView_Level3.jsp?bnum=<%=dto.getBnum()%>&category=<%=dto.getCategory()%><%=paging%>">
      								<%}else{ %>
      								<a href="BoardView_Level2.jsp?bnum=<%=dto.getBnum()%>&category=<%=dto.getCategory()%><%=paging%>">
      								<%} %>
      								<%=dto.getTitle()%></div></a>
      </td>
      <td><%=dto.getNickname() %></td>
      <td><%=dto.getBdate() %></td>
      <td><%=dto.getHit() %></td>
      <td align="center">
      	<div id="comment_button">
      		<a href="#" onclick='window.open("CommentWindow.jsp?bnum=<%=dto.getBnum()%>&category=<%=dto.getCategory()%><%=paging%>","_blank","height=460px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>
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
</article>
</body>
<%@include file="Footer.jsp" %>
</html>