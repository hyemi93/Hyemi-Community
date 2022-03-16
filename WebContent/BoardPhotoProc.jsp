<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="import.jsp"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%
	/* 사진 업로드 */
	MultipartRequest mr = new MultipartRequest(request, "C:/JavaWorks/커뮤니티_허혜미/WebContent/uploadimg", 800*800*800, "UTF-8", new DefaultFileRenamePolicy());
	
	String id = mr.getParameter("id");
	String nickname = mr.getParameter("nickname");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String photoimg = mr.getFilesystemName("photoimg");
	String category = mr.getParameter("category");
	
	String msg = null;
	String url = null;

    	boolean presult = Bdao.BoardPhotoWrite(id, nickname, title, content, photoimg, category);
    	msg = "다시 시도해주십시오.";
    	url = "javascript:history.go(-1)";
    	if(presult){
    		msg = "게시글을 작성하였습니다.";
    		url = "BoardPhotoList.jsp?category="+category+paging2; 
		}
%>

<script>
	alert("<%=msg%>");
	window.location="<%=url%>";
</script>