<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="import.jsp" %>
<%
    String action = request.getParameter("action");
	String category = request.getParameter("category");
	String msg = null;
	String url = null;
    
    switch (action) {
    /* 일반게시판 */
    case "BoardWrite" :
    	Bdao.LocationUpdate(Bdto);
    	boolean result = Bdao.BoardWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result){
    		msg = "게시글을 작성하였습니다.";
    		url = "BoardList_Level1.jsp?category="+category+paging; 
    	}
        break;
    case "BoardWrite2" :
    	Bdao.LocationUpdate(Bdto);
    	boolean result2 = Bdao.BoardWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result2){
    		msg = "게시글을 작성하였습니다.";
    		url = "BoardList_Level2.jsp?category="+category+paging; 
    	}
        break;
    case "BoardWrite3" :
    	Bdao.LocationUpdate(Bdto);
    	boolean result3 = Bdao.BoardWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result3){
    		msg = "게시글을 작성하였습니다.";
    		url = "BoardList_Level3.jsp?category="+category+paging; 
    	}
        break;
        
    case "BoardReply" :
    	boolean result4 = Bdao.BoardReply(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result4){
    		msg = "답글을 작성하였습니다.";
    		url = "BoardList_Level1.jsp?category="+category+paging; 
    	}
        break;
    case "BoardReply2" :
    	boolean result5 = Bdao.BoardReply(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result5){
    		msg = "답글을 작성하였습니다.";
    		url = "BoardList_Level2.jsp?category="+category+paging; 
    	}
        break;
    case "BoardReply3" :
    	boolean result6 = Bdao.BoardReply(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result6){
    		msg = "답글을 작성하였습니다.";
    		url = "BoardList_Level3.jsp?category="+category+paging; 
    	}
        break;
        
    case "BoardUpdate" :
    	int bnum = Integer.parseInt(request.getParameter("bnum"));
    	boolean result7 = Bdao.BoardUpdate(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result7){
    		msg = "수정이 완료되었습니다.";
    		url = "BoardView_Level1.jsp?category="+category+"&bnum="+bnum+paging;
    	}
        break;
    case "BoardUpdate2" :
    	int bnum2 = Integer.parseInt(request.getParameter("bnum"));
    	boolean result8 = Bdao.BoardUpdate(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result8){
    		msg = "수정이 완료되었습니다.";
    		url = "BoardView_Level2.jsp?category="+category+"&bnum="+bnum2+paging;
    	}
        break;
    case "BoardUpdate3" :
    	int bnum3 = Integer.parseInt(request.getParameter("bnum"));
    	boolean result9 = Bdao.BoardUpdate(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result9){
    		msg = "수정이 완료되었습니다.";
    		url = "BoardView_Level3.jsp?category="+category+"&bnum="+bnum3+paging;
    	}
        break;
        
    case "BoardDelete" :
    	boolean result10 = Bdao.BoardDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result10){
    		msg = "삭제가 완료되었습니다.";
    		url = "BoardList_Level1.jsp?category="+category+paging;
    	}
        break;
    case "BoardDelete2" :
    	boolean result11 = Bdao.BoardDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result11){
    		msg = "삭제가 완료되었습니다.";
    		url = "BoardList_Level2.jsp?category="+category+paging;
    	}
        break;
    case "BoardDelete3" :
    	boolean result12 = Bdao.BoardDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(result12){
    		msg = "삭제가 완료되었습니다.";
    		url = "BoardList_Level3.jsp?category="+category+paging;
    	}
        break;
        
    /* 한줄게시판 */
    case "BoarLinedWrite" :
    	Bdao.LineLocationUpdate(Bdto);
    	boolean lresult = Bdao.BoardLineWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(lresult){
    		msg = "게시글을 작성하였습니다.";
    		url = "BoardLineList.jsp?category="+category+paging; 
    	}
        break;
        
    case "BoarLineReply" :
    	boolean lresult2 = Bdao.BoardLineReply(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(lresult2){
    		msg = "게시글을 작성하였습니다.";
    		url = "BoardLineList.jsp?category="+category+paging; 
    	}
        break;
        
    case "BoardLineDelete" :
    	boolean lresult3 = Bdao.BoardLineDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(lresult3){
    		msg = "삭제가 완료되었습니다.";
    		url = "BoardLineList.jsp?category="+category+paging;
    	}
        break;
        
    /* 사진게시판 */
    case "BoardPhotoUpdate" :
    	int bnum4 = Integer.parseInt(request.getParameter("bnum"));
    	boolean presult = Bdao.BoardPhotoUpdate(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(presult){
    		msg = "수정이 완료되었습니다.";
    		url = "BoardPhotoView.jsp?category="+category+"&bnum="+bnum4+paging;
    	}
        break;
        
    case "BoardPhotoDelete" :
    	boolean presult2 = Bdao.BoardPhotoDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(presult2){
    		msg = "삭제가 완료되었습니다.";
    		url = "BoardPhotoList.jsp?category="+category+paging2;
    	}
        break;

    /* 게시판 댓글 */
    case "CommentWrite" :
    	int bnum5 = Integer.parseInt(request.getParameter("bnum"));
    	boolean cresult = Bdao.CommentWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(cresult){
    		msg = "댓글을 작성하였습니다.";
    		url = "BoardView_Level1.jsp?category="+category+"&bnum="+bnum5+paging;
    	}
        break;
        
    case "CommentWrite2" :
    	int bnum6 = Integer.parseInt(request.getParameter("bnum"));
    	boolean cresult2 = Bdao.CommentWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(cresult2){
    		msg = "댓글을 작성하였습니다.";
    		url = "BoardView_Level2.jsp?category="+category+"&bnum="+bnum6+paging;
    	}
        break;
        
    case "CommentWrite3" :
    	int bnum7 = Integer.parseInt(request.getParameter("bnum"));
    	boolean cresult3 = Bdao.CommentWrite(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(cresult3){
    		msg = "댓글을 작성하였습니다.";
    		url = "BoardView_Level3.jsp?category="+category+"&bnum="+bnum7+paging;
    	}
        break;
        
    case "CommentDelete" :
    	int bnum8 = Integer.parseInt(request.getParameter("bnum"));
    	boolean cresult4 = Bdao.CommentDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(cresult4){
    		msg = "댓글을 삭제하였습니다.";
    		url = "BoardView_Level1.jsp?category="+category+"&bnum="+bnum8+paging;
    	}
        break;
        
    case "CommentDelete2" :
    	int bnum9 = Integer.parseInt(request.getParameter("bnum"));
    	boolean cresult5 = Bdao.CommentDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(cresult5){
    		msg = "댓글을 삭제하였습니다.";
    		url = "BoardView_Level2.jsp?category="+category+"&bnum="+bnum9+paging;
    	}
        break;
        
    case "CommentDelete3" :
    	int bnum10 = Integer.parseInt(request.getParameter("bnum"));
    	boolean cresult6 = Bdao.CommentDelete(Bdto);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(cresult6){
    		msg = "댓글을 삭제하였습니다.";
    		url = "BoardView_Level3.jsp?category="+category+"&bnum="+bnum10+paging;
    	}
        break;
        
     case "CommentWrite_Window" :
      	int bnum11 = Integer.parseInt(request.getParameter("bnum"));
       	boolean cresult7 = Bdao.CommentWrite(Bdto);
       	msg = "다시 시도해주십시오.";
       	url = "javascript:history.go(-1)";
       	if(cresult7){
       		msg = "댓글을 작성하였습니다.";
       		url = "CommentWindow.jsp?category="+category+"&bnum="+bnum11+paging;
       	}
        break;
        
     case "CommentDelete_Window" :
       	int bnum12 = Integer.parseInt(request.getParameter("bnum"));
       	boolean cresult8 = Bdao.CommentDelete(Bdto);
       	msg = "다시 시도해주십시오.";
       	url = "javascript:history.go(-1)";
       	if(cresult8){
       		msg = "댓글을 삭제하였습니다.";
       		url = "CommentWindow.jsp?category="+category+"&bnum="+bnum12+paging;
       	}
        break;       
}
%>
<script>
	alert("<%=msg%>");
	window.location="<%=url%>";
</script>