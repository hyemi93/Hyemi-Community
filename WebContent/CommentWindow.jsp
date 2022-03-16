<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
    <%
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String category = request.getParameter("category");
    ArrayList<BoardDTO> list = Bdao.CommentView(Bdto);
    BoardDTO dto = Bdao.BoardView(bnum, category);
	%>
	
	<!-- 메인에서 로그인하지 않은 사용자의 이용을 방지 -->
    <%if (ssid != null || ssaid != null) {%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CommentWindow(댓글 목록 팝업창)</title>
</head>
<body>
	<ul class="list-group" style="width: 980px; margin-left: 5px;">
		<li class="list-group-item">
		<div id="comment_view">
			<div id="title">댓글</div>
			<hr>
		<!-- 댓글 내용 -->
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
						<a href="#" onclick='window.open("CommentUpdate.jsp?bnum=<%=bnum%>&category=<%=category%>&cnum=<%=cto.getCnum()%>","_blank","height=310px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>수정</a></td>
					<td style="width: 5%;">
						<a href="BoardProc.jsp?action=CommentDelete_Window&bnum=<%=bnum%>&category=<%=category%>&cnum=<%=cto.getCnum()%>" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</a>
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

/*댓글 목록 10개 초과부터 페이징 사용 */
if(totalcommcnt>10) {%>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination pagination-sm">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="BoardComment.jsp?bnum=<%=bnum%>&category=<%=category%><%=paging%>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

<!-- 페이징 -->
<%
for(commnum=1; commnum<=totalcommcnt2/10+0.9; commnum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="BoardComment.jsp?bnum=<%=bnum%>&category=<%=category%>&startpage=<%=startpage %>&endpage=<%=endpage%>"><%=commnum %></a></li>	
<%startpage += 10;
  endpage += 10;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="BoardComment.jsp?bnum=<%=bnum%>&category=<%=category%>&startpage=<%=startpage-10%>&endpage=<%=endpage-10%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<%} %>


		<!-- 댓글작성 폼 -->
		<Br>
		<form method="get" name="commentform" action="BoardProc.jsp">
			<input type="hidden" name="action" value="CommentWrite_Window">
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
		<div style="margin: 5px 0 0 450px;">
		<input type="button" value="닫기" class="btn btn-light" onclick="close_check()">
		</div>
</body>
</html>
<%}else{%>
    <script>alert("로그인이 필요한 서비스입니다.");
    window.close();
	opener.location.reload();
    </script>
<%}%>