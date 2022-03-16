<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
<!-- 팝업창 프로세스 처리 페이지 -->
<%
	String action = request.getParameter("action");
	String msg = null;
	
	switch (action) {
    case "CommentUpdate" :
    	boolean cresult = Bdao.CommentUpdate(Bdto);
    	msg = "다시 시도해주십시오.";
    	if(cresult){
    		msg = "댓글을 수정하였습니다.";
    	}
        break;
        
    case "BoardLineReply" :
    	boolean lresult = Bdao.BoardLineReply(Bdto);
    	msg = "다시 시도해주십시오.";
    	if(lresult){
    		msg = "답글을 작성하였습니다.";
    	}
        break;
        
    case "BoardLineUpdate" :
    	boolean lresult2 = Bdao.BoardLineUpdate(Bdto);
    	msg = "다시 시도해주십시오.";
    	if(lresult2){
    		msg = "댓글을 수정하였습니다.";
    	}
        break;
	}
%>

<script>
	alert("<%=msg%>");
	window.close();
	opener.location.reload();
</script>