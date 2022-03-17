<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
    <%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String category = request.getParameter("category");
    BoardDTO dto = Bdao.BoardPhotoView(bnum, category);
    ArrayList<BoardDTO> list = Bdao.CommentView(Bdto);
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardPhotoView(사진게시판 글 뷰)</title>
</head>
<body>
<article>
	<ul class="list-group">
	
		<!-- 글 내용 -->
		<li class="list-group-item">
		<div id="board_view">
			<div id="title"><Gray>[<%=dto.getCategory()%>]</Gray><%=dto.getTitle() %></div><Br>
			작성자 <B><%=dto.getNickname() %></B> 작성일 <B><%=dto.getBdate() %></B> 조회수 <B><%=dto.getHit() %></B>
		<!-- 관리자이거나 작성자만 수정 및 삭제가 가능 -->
		<%if(ssaid != null || ssid.equals(dto.getId())){ %>
			<a href="BoardProc.jsp?action=BoardPhotoDelete&bnum=<%=bnum%>&category=<%=category%>" onclick="return confirm('글을 삭제하시겠습니까?');">삭제</a>
			<a href="BoardPhotoUpdate.jsp?bnum=<%=bnum%>&category=<%=category%>">수정</a>
		<%} %>
			<Br>
			<hr>
			<div id="subject"><img src="./uploadimg/<%=dto.getPhotoimg() %>"></div><Br>
			<div id="margin_top"></div>
			<%=dto.getContent() %>
		</div>
		</li>
	</ul>
	
	<div id="margin_top"></div>
	<ul class="list-group">
	
		<!-- 댓글 내용 -->
		<li class="list-group-item">
		<div id="comment_view">
			<div id="title">댓글</div>
			<hr>
			<table width="940px">
<%
	for (BoardDTO cto : list) {
%>
				<tr>
					<td style="width: 10%;"><B><%=cto.getNickname() %></B></td>
					<td style="width: 70%;"><%=cto.getCcomment() %></td>
					<td style="width: 10%;"><%=cto.getCdate() %></td>
				<!-- 관리자이거나 작성자만 수정 및 삭제가 가능 -->
				<%if(ssaid != null || ssid.equals(cto.getId())){ %>
					<td style="width: 5%;">
						<a href="#" onclick='window.open("CommentUpdate.jsp?bnum=<%=bnum%>&category=<%=category%>&cnum=<%=cto.getCnum()%>","_blank","height=310px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>
						수정</a></td>
					<td style="width: 5%;">
						<a href="BoardProc.jsp?action=CommentDelete&bnum=<%=bnum%>&category=<%=category%>&cnum=<%=cto.getCnum()%>" onclick="return confirm('댓글을 삭제하시겠습니까?');">
						삭제</a></td>
				<%} %>
				</tr>
<%
	}
%>
			</table>

<!-- 페이징 처리 -->
<%
int totalcommcnt = dto.getCommnum(); //총 댓글 수 가져오기
double totalcommcnt2=totalcommcnt; //총 댓글 수를 실수형으로 변환
int commnum = 0; //댓글 페이지 넘버
int startpage = 1; 
int endpage = 10;

if(totalcommcnt>10) {%>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination pagination-sm">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="BoardView.jsp?bnum=<%=bnum%>&category=<%=category%><%=paging%>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

<!-- 페이징 -->
<%
for(commnum=1; commnum<=totalcommcnt2/10+0.9; commnum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="BoardView.jsp?bnum=<%=bnum%>&category=<%=category%>&startpage=<%=startpage %>&endpage=<%=endpage%>"><%=commnum %></a></li>	
<%startpage += 10;
  endpage += 10;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="BoardView.jsp?bnum=<%=bnum%>&category=<%=category%>&startpage=<%=startpage-10%>&endpage=<%=endpage-10%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<%} %>


		<!-- 댓글작성 폼 -->
		<Br>
		<form method="post" name="commentform" action="BoardProc.jsp">
			<input type="hidden" name="action" value="CommentWrite">
			<%if(ssaid == null){ %>
			<input type="hidden" name="id" value="<%=ssid%>">
			<input type="hidden" name="nickname" value="<%=ssnick%>">
			<%} else if(ssid == null){ %>
			<input type="hidden" name="id" value="<%=ssaid%>">
			<input type="hidden" name="nickname" value="관리자">
			<%} %>
			<input type="hidden" name="bnum" value="<%=bnum%>">
			<input type="hidden" name="category" value="<%=category%>">
			
			<div class="form-floating">
	  			<textarea name="ccomment" class="list-group-item" placeholder="댓글을 작성해주세요."style="width:870px;"></textarea>
	  		<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: -45px; margin-left: 10px;">
	  			<input type="button" value="작성" class="btn btn-danger me-md-2 btn-sm" onclick="comment_check()">
			</div>
			</div>
		</form>
			<div id="margin_top"></div>
		</div>
		</li>
	</ul>
	<div id="margin_top"></div>
	<div id="top_menu">
	<input type="button" value="목록" class="btn btn-light" onclick="location.href='BoardPhotoList.jsp?category=<%=category%><%=paging2%>'">
	</div>
</article>
</body>
<%@include file="Footer.jsp" %>
</html>
