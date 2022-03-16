<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="Header.jsp" %>
    <%@include file="LeftMenu.jsp" %>
    <%
    String category = request.getParameter("category");
    ArrayList<BoardDTO> list = Bdao.BoardLineView(Bdto);
	%>
	
	<!-- 총 게시물 수 구하기 -->
	<sql:query var="rs" dataSource="${ds}">
	select count(*) as totalcnt from lineboard_tbl where category=?
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
<title>BoardLineList(한줄게시판)</title>
</head>
<body>
<article>
<h2><%=category%></h2>
	<ul class="list-group">
	<li class="list-group-item">
		<div id="margin_top"></div>
		<form method="post" name="linewriteform" action="BoardProc.jsp">
		<input type="hidden" name="action" value="BoarLinedWrite">
		<input type="hidden" name="category" value="<%=category%>">
		
		<!-- 로그인 한 사용자에 따라 값 전송 -->
		<%if(ssaid == null){ %>
			<input type="hidden" name="id" value="<%=ssid%>">
			<input type="hidden" name="nickname" value="<%=ssnick%>">
			<%} else if(ssid == null){ %>
			<input type="hidden" name="id" value="<%=ssaid%>">
			<input type="hidden" name="nickname" value="관리자">
			<%} %>
			
			<!-- 한줄 글작성 폼 -->
			<div class="form-floating">
	  			<textarea name="content" class="list-group-item" placeholder="한 줄 메세지를 남겨주세요."style="width:870px;"></textarea>
	  			<div id="secret_button"><input type="checkbox" name="secretyn" value="Y">비밀글</div>
	  		<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: -40px;">
	  			<input type="button" value="작성" class="btn btn-danger me-md-2 btn-sm" onclick="linewrite_check()">
			</div>
			</div>
		</form>
		</li>
		<!-- 한줄 게시판 리스트 -->
		<li class="list-group-item">
		<div id="comment_view">
		<%if(category.equals("등업신청")){ %>
			<div id="title">등업신청<gray_little>※등업조건 : 브론즈(가입 즉시), 실버(글  : 5개, 댓글  : 10개), 골드(글 : 50개, 댓글 : 100개)※</gray_little></div>
			<div>게시글은 비밀글로 작성해주세요.</div>
			<%}else { %>
			<div id="title"><%=category%></div>
			<%} %>
<%
	for (BoardDTO dto : list) {
%>
			<hr>
			<table width="940px">
				<tr>
				<!-- 관리자이거나 작성자이거나 비밀글로 체크하지 않은 경우에만 확인 가능 -->
				<%if (ssaid != null || ssid.equals(dto.getId()) || dto.getSecretyn()==null){ %>
					<td style="width: 10%; padding-left: <%=dto.getDepth()*15%>px; color:#808080;"><%if(dto.getDepth()!=0){ %>└ <%}%><B><%=dto.getNickname() %></B></td>
					<td style="width: 60%;"><%if(dto.getSecretyn()!=null){%><gray>🔒 </gray><%}%><%=dto.getContent() %></td>
					<td style="width: 10%;"><%=dto.getBdate() %></td>
					<td style="width: 5%;">
						<a href="#" onclick='window.open("BoardLineReply.jsp?bnum=<%=dto.getBnum()%>&category=<%=category%>&depth=<%=dto.getDepth()%>&location=<%=dto.getLocation()%>",
						"_blank","height=310px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>
						답글</a></td>
				<!-- 관리자이거나 작성자만 수정 및 삭제가 가능 -->
				<%if(ssaid != null || ssid.equals(dto.getId())){ %>
					<td style="width: 5%;">
						<a href="#" onclick='window.open("UserLevelUp.jsp?id=<%=dto.getId()%>","_blank","height=202px,width=402px,status=yes,toolbar=no,menubar=no,location=no");return false'>
						등업</a></td>
					<td style="width: 5%;">
						<a href="#" onclick='window.open("BoardLineUpdate.jsp?bnum=<%=dto.getBnum()%>&category=<%=category%>","_blank","height=310px,width=990px,status=yes,toolbar=no,menubar=no,location=no");return false'>
						수정</a></td>
					<td style="width: 5%;">
						<a href="BoardProc.jsp?action=BoardLineDelete&bnum=<%=dto.getBnum()%>&category=<%=category%>" onclick="return confirm('댓글을 삭제하시겠습니까?');">
						삭제</a></td>
				<%}
				}else{ %>
					<td> 🔒 비밀글은 작성자와 관리자만 확인할 수 있습니다.</td>
				<%}%>
				</tr>					
			</table>
<%} %>
<!-- 페이징 처리 -->
<%
int totalcommcnt = Integer.parseInt(String.valueOf(pageContext.getAttribute("totalcnt")));
double totalcommcnt2=totalcommcnt; //총 글 수를 실수형으로 변환
int commnum = 0; //글 페이지 넘버
int startpage = 1; 
int endpage = 10;

/*글 목록 10개 초과부터 페이징 사용 */
if(totalcommcnt>10) {%>
<nav aria-label="Page navigation example" style="display: flex; justify-content: center;">
<ul class="pagination pagination-sm">
  <li class="page-item">
  	<!-- 처음 페이지 -->
    <a class="page-link" style="color: #ea868f;" href="BoardLineList.jsp?category=<%=category%><%=paging%>" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>
  </li>

<!-- 페이징 -->
<%
for(commnum=1; commnum<=totalcommcnt2/10+0.9; commnum++) {%>
	<li class="page-item"><a class="page-link" style="color: #ea868f;" href="BoardLineList.jsp?category=<%=category%>&startpage=<%=startpage %>&endpage=<%=endpage%>"><%=commnum %></a></li>	
<%startpage += 10;
  endpage += 10;
} %>

    <li class="page-item">
    <!-- 마지막 페이지 -->
      <a class="page-link" style="color: #ea868f;" href="BoardLineList.jsp?category=<%=category%>&startpage=<%=startpage-10%>&endpage=<%=endpage-10%>" aria-label="Next">
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
<!-- 로그인 한 사용자가 아니면 팝업 후 홈으로 이동 -->
<%}else{%>
    <script>alert("로그인이 필요한 서비스입니다.");
    location.href="Index.jsp";
    </script>
<%}%>