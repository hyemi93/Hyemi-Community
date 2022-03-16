package pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "hyemi";
	private String password = "1234";

	public BoardDAO() throws ClassNotFoundException {
		Class.forName(driver);
	}
	
	public void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}
	
	public void closeSome(PreparedStatement pstmt, Connection con) throws SQLException {
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}
	
	//최신글목록
		public ArrayList<BoardDTO>BoardNewList() throws SQLException {
				  Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      ArrayList<BoardDTO> list = new ArrayList<>();
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select * from new_tbl";
			         pstmt=con.prepareStatement(sql);
			         rs = pstmt.executeQuery();
			         while(rs.next()){
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setTitle(rs.getString("title"));
			        	dto.setBdate(rs.getString("bdate"));
			        	dto.setHit(rs.getInt("hit"));
			        	dto.setCategory(rs.getString("category"));
			            list.add(dto);
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return list;
			    }
		
	//회원별 작성글목록
		public ArrayList<BoardDTO>BoardUserList(String ssid, int startpage, int endpage) throws SQLException {
				  Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      ArrayList<BoardDTO> list = new ArrayList<>();
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select * from (select bnum, id, nickname, title, bdate, hit, category, rownum as rnum from userboard_tbl where id=?) " + 
			         		"where rnum between ? and ?";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setString(1, ssid);
			         pstmt.setInt(2, startpage);
			         pstmt.setInt(3, endpage);
			         rs = pstmt.executeQuery();
			         while(rs.next()){
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setTitle(rs.getString("title"));
			        	dto.setBdate(rs.getString("bdate"));
			        	dto.setHit(rs.getInt("hit"));
			        	dto.setCategory(rs.getString("category"));
			            list.add(dto);
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return list;
			    }
	//회원별 작성 댓글목록
		public ArrayList<BoardDTO>CommentUserList(String ssid, int startpage, int endpage) throws SQLException {
				  Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      ArrayList<BoardDTO> list = new ArrayList<>();
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select * from (select bnum, category, nickname, ccomment, to_char(cdate, 'yyyy-mm-dd') as cdate, " + 
			         		"rownum as rnum from comment_tbl where id=? order by cdate desc) where rnum between ? and ?";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setString(1, ssid);
			         pstmt.setInt(2, startpage);
			         pstmt.setInt(3, endpage);
			         rs = pstmt.executeQuery();
			         while(rs.next()){
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setCcomment(rs.getString("ccomment"));
			        	dto.setCdate(rs.getString("cdate"));
			        	dto.setCategory(rs.getString("category"));
			            list.add(dto);
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return list;
			    }
		
	//일반게시판 글목록
		public ArrayList<BoardDTO>BoardList(BoardDTO bdto) throws SQLException {
				  Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      ArrayList<BoardDTO> list = new ArrayList<>();
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select * from (select bnum, rebnum, id, nickname, title, content, to_char(bdate, 'yyyy-mm-dd') as bdate, " + 
			         		"hit, depth, location, commnum, category, rownum as rnum from board_tbl where category=? order by bnum desc) " + 
			         		"where rnum between ? and ? start with rebnum is null connect by prior bnum=rebnum order siblings by location asc";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setString(1, bdto.getCategory());
			         pstmt.setInt(2, bdto.getStartpage());
			         pstmt.setInt(3, bdto.getEndpage());
			         rs = pstmt.executeQuery();
			         while(rs.next()){
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setRebnum(rs.getInt("rebnum"));
			        	dto.setId(rs.getString("id"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setTitle(rs.getString("title"));
			        	dto.setContent(rs.getString("content"));
			        	dto.setBdate(rs.getString("bdate"));
			        	dto.setHit(rs.getInt("hit"));
			        	dto.setDepth(rs.getInt("depth"));
			        	dto.setLocation(rs.getInt("location"));
			        	dto.setCommnum(rs.getInt("commnum"));
			        	dto.setCategory(rs.getString("category"));
			            list.add(dto);
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return list;
			    }
	
	//일반게시판 글 뷰
		public BoardDTO BoardView(int bnum, String category) throws SQLException {
			   Connection con=null;
			      PreparedStatement pstmt=null;
			      PreparedStatement pstmt2=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select id, nickname, title, content, to_char(bdate, 'yyyy-mm-dd') as bdate, hit, depth, location, commnum, category " + 
				         		"from board_tbl where bnum=? and category=?";
			         String sql2="update board_tbl set hit=hit+1 where bnum=? and category=?";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setInt(1, bnum);
			         pstmt.setString(2, category);
			         
			         pstmt2=con.prepareStatement(sql2);
			         pstmt2.setInt(1, bnum);
			         pstmt2.setString(2, category);
			         pstmt2.executeUpdate();
			         rs = pstmt.executeQuery();
			         while (rs.next()) {
			        	dto = new BoardDTO();
			        	dto.setId(rs.getString("id"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setTitle(rs.getString("title"));
			        	dto.setContent(rs.getString("content"));
			        	dto.setBdate(rs.getString("bdate"));
			        	dto.setHit(rs.getInt("hit"));
			        	dto.setDepth(rs.getInt("depth"));
			        	dto.setLocation(rs.getInt("location"));
			        	dto.setCommnum(rs.getInt("commnum"));
			        	dto.setCategory(rs.getString("category"));
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return dto;
			    }
	
	//공지글 뷰
	public ArrayList<BoardDTO>NoticeView() throws SQLException {
		   Connection con=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      BoardDTO dto=null;
		      ArrayList<BoardDTO> list = new ArrayList<>();
		      try {
		         con=DriverManager.getConnection(url, user, password);
		         String sql="select * from notice_tbl";
		         pstmt=con.prepareStatement(sql);
		         rs = pstmt.executeQuery();
		         while(rs.next()){
		        	dto = new BoardDTO();
		        	dto.setBnum(rs.getInt("bnum"));
		        	dto.setTitle(rs.getString("title"));
		        	dto.setNickname(rs.getString("nickname"));		        	
		        	dto.setBdate(rs.getString("bdate"));
		        	dto.setHit(rs.getInt("hit"));
		        	dto.setDepth(rs.getInt("depth"));
		        	dto.setLocation(rs.getInt("location"));
		        	dto.setCommnum(rs.getInt("commnum"));
		        	dto.setCategory(rs.getString("category"));	
		            list.add(dto);
		         }
		      		} catch (Exception e) {
		      			e.printStackTrace();
		      		} finally {
		      			closeAll(rs, pstmt, con);
		      		}
		       return list;
		    }
	

	//일반게시판 글 작성	
	public boolean BoardWrite(BoardDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="insert into board_tbl values"
			   		+ "((select NVL(MAX(bnum), 0)+1 from board_tbl where category=?), null, ?, ?, ?, ?, sysdate, 0, 0, 1, 0, ?)";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setString(1, dto.getCategory());
			   pstmt.setString(2, dto.getId());
			   pstmt.setString(3, dto.getNickname());
			   pstmt.setString(4, dto.getTitle());
			   pstmt.setString(5, dto.getContent());
			   pstmt.setString(6, dto.getCategory());
			   if (pstmt.executeUpdate()==1)
		            flag=true;
		      } catch (Exception e) {
		         e.printStackTrace();
		         System.out.print(e);
		      } finally {
		    	  closeSome(pstmt, con);
		      }
		      return flag;
		   }
	
	//일반게시판 글 위치 변수 조정
	public BoardDTO LocationUpdate(BoardDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		      try {
		         con=DriverManager.getConnection(url, user, password);
		         String sql="update board_tbl set location=location+1 where category=? and location >=1 and rebnum is null";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setString(1, dto.getCategory());
				 pstmt.executeUpdate();
		      		} catch (Exception e) {
		      			e.printStackTrace();
		      		} finally {
		      			closeSome(pstmt, con);
		      		}
		       return dto;
		    }
	
	//일반게시판 답글 작성
	public boolean BoardReply(BoardDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="insert into board_tbl values((select NVL(MAX(bnum), 0)+1 from board_tbl where category=?), ?, ?, ?, ?, ?, sysdate, 0, ?, ?, 0, ?)";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setString(1, dto.getCategory());
			   pstmt.setInt(2, dto.getRebnum()); //부모글 bnum 받아와서 넣어줌
			   pstmt.setString(3, dto.getId());
			   pstmt.setString(4, dto.getNickname());
			   pstmt.setString(5, dto.getTitle());
			   pstmt.setString(6, dto.getContent());
			   pstmt.setInt(7, dto.getDepth()+1); //들여쓰기는 부모글+1
			   pstmt.setInt(8, dto.getLocation());
			   pstmt.setString(9, dto.getCategory());	   
			   if (pstmt.executeUpdate()==1)
		            flag=true;
		      } catch (Exception e) {
		         e.printStackTrace();
		         System.out.print(e);
		      } finally {
		    	  closeSome(pstmt, con);
		      }
		      return flag;
		   }
	
	//일반게시판 글 수정
		public boolean BoardUpdate(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="update board_tbl set title=?, content=? where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, dto.getTitle());
				   pstmt.setString(2, dto.getContent());
				   pstmt.setInt(3, dto.getBnum());
				   pstmt.setString(4, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
	//일반게시판 글 삭제
		public boolean BoardDelete(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="delete from board_tbl where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setInt(1, dto.getBnum());
				   pstmt.setString(2, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }

	//한줄게시판 글 뷰
		public ArrayList<BoardDTO>BoardLineView(BoardDTO bdto) throws SQLException {
				  Connection con=null;
				  PreparedStatement pstmt=null;
				  ResultSet rs=null;
				  BoardDTO dto=null;
				  ArrayList<BoardDTO> list = new ArrayList<>();
				  try {
				       con=DriverManager.getConnection(url, user, password);
				       String sql="select * from (select bnum, rebnum, id, nickname, content, depth, location, to_char(bdate, 'yyyy-mm-dd') as bdate, "
				            		+ "secretyn, category, rownum as rnum from lineboard_tbl where category=? "
					         		+ "start with rebnum is null connect by prior bnum=rebnum order siblings by location asc) where rnum between ? and ?";
				       pstmt=con.prepareStatement(sql);
		  	           pstmt.setString(1, bdto.getCategory());
			           pstmt.setInt(2, bdto.getStartpage());
			           pstmt.setInt(3, bdto.getEndpage());
			           rs = pstmt.executeQuery();
				         while(rs.next()){
				        	dto = new BoardDTO();
				        	dto.setBnum(rs.getInt("bnum"));
				        	dto.setRebnum(rs.getInt("rebnum"));
				        	dto.setId(rs.getString("id"));
				        	dto.setNickname(rs.getString("nickname"));
				        	dto.setContent(rs.getString("content"));
				        	dto.setDepth(rs.getInt("depth"));
				        	dto.setLocation(rs.getInt("location"));
				        	dto.setBdate(rs.getString("bdate"));
				        	dto.setSecretyn(rs.getString("secretyn"));
				        	dto.setCategory(rs.getString("category"));
				            list.add(dto);
				         }
				      		} catch (Exception e) {
				      			e.printStackTrace();
				      		} finally {
				      			closeAll(rs, pstmt, con);
				      		}
					       return list;
					    }
		
	//한줄게시판 글 작성
		public boolean BoardLineWrite(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="insert into lineboard_tbl values(lineboard_seq.nextval, null, ?, ?, ?, 0, 1, sysdate, ?, ?)";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, dto.getId());
				   pstmt.setString(2, dto.getNickname());
				   pstmt.setString(3, dto.getContent());
				   pstmt.setString(4, dto.getSecretyn());
				   pstmt.setString(5, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
	//한줄게시판 위치 변수 조정
		public BoardDTO LineLocationUpdate(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="update lineboard_tbl set location=location+1 where category=? and location >=1 and rebnum is null";
					 pstmt=con.prepareStatement(sql);
					 pstmt.setString(1, dto.getCategory());
					 pstmt.executeUpdate();
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeSome(pstmt, con);
			      		}
			       return dto;
			    }
		
	//한줄게시판 답글 작성
		public boolean BoardLineReply(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="insert into lineboard_tbl values(lineboard_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, ?, ?)";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setInt(1, dto.getRebnum()); //부모글 bnum 받아와서 넣어줌
				   pstmt.setString(2, dto.getId());
				   pstmt.setString(3, dto.getNickname());
				   pstmt.setString(4, dto.getContent());
				   pstmt.setInt(5, dto.getDepth()+1); //들여쓰기는 부모글+1
				   pstmt.setInt(6, dto.getLocation());
				   pstmt.setString(7, dto.getSecretyn());	
				   pstmt.setString(8, dto.getCategory());	   
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
	//한줄게시판 수정용 뷰
		public BoardDTO BoardLineUpdateView(BoardDTO dto) throws SQLException {
			   Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select content, secretyn from lineboard_tbl where bnum=? and category=?";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setInt(1, dto.getBnum());
			         pstmt.setString(2, dto.getCategory());
			         rs = pstmt.executeQuery();
			         while (rs.next()) {
			        	dto = new BoardDTO();
			        	dto.setContent(rs.getString("content"));
			        	dto.setSecretyn(rs.getString("secretyn"));
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return dto;
			    }
		
	//한줄게시판 글 수정
		public boolean BoardLineUpdate(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="update lineboard_tbl set content=?, secretyn=? where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, dto.getContent());
				   pstmt.setString(2, dto.getSecretyn());
				   pstmt.setInt(3, dto.getBnum());
				   pstmt.setString(4, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
	//한줄게시판 글 삭제
		public boolean BoardLineDelete(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="delete from lineboard_tbl where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setInt(1, dto.getBnum());
				   pstmt.setString(2, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
	//사진게시판 글목록
		public ArrayList<BoardDTO>BoardPhotoList(BoardDTO bdto) throws SQLException {
			  Connection con=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      BoardDTO dto=null;
		      ArrayList<BoardDTO> list = new ArrayList<>();
		      try {
		         con=DriverManager.getConnection(url, user, password);
		         String sql="select * from (select bnum, id, nickname, title, content, photoimg, hit, to_char(bdate, 'yyyy-mm-dd') as bdate, " + 
		         		"category, rownum as rnum from photoboard_tbl where category=? order by bnum desc) where rnum between ? and ?";
		         pstmt=con.prepareStatement(sql);
		         pstmt.setString(1, bdto.getCategory());
		         pstmt.setInt(2, bdto.getStartpage());
		         pstmt.setInt(3, bdto.getEndpage());
		         rs = pstmt.executeQuery();
		         while(rs.next()){
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setId(rs.getString("id"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setTitle(rs.getString("title"));
			        	dto.setContent(rs.getString("content"));
			        	dto.setPhotoimg(rs.getString("photoimg"));
			        	dto.setHit(rs.getInt("hit"));
			        	dto.setBdate(rs.getString("bdate"));
			        	dto.setCategory(rs.getString("category"));
		            list.add(dto);
		         }
		      		} catch (Exception e) {
		      			e.printStackTrace();
		      		} finally {
		      			closeAll(rs, pstmt, con);
		      		}
		       return list;
		    }
		
	//사진게시판 글 작성
		public boolean BoardPhotoWrite(String id, String nickname, String title, String content, String photoimg, String category) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="insert into photoboard_tbl values(photoboard_seq.nextval, ?, ?, ?, ?, ?, 0, sysdate, ?)";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, id);
				   pstmt.setString(2, nickname);
				   pstmt.setString(3, title);
				   pstmt.setString(4, content);
				   pstmt.setString(5, photoimg);
				   pstmt.setString(6, category);
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
		//사진게시판 글 뷰
		public BoardDTO BoardPhotoView(int bnum, String category) throws SQLException {
			   Connection con=null;
			      PreparedStatement pstmt=null;
			      PreparedStatement pstmt2=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select bnum, id, nickname, title, content, photoimg, hit, to_char(bdate, 'yyyy-mm-dd') as bdate, category " + 
				         		"from photoboard_tbl where bnum=? and category=?";
			         String sql2="update photoboard_tbl set hit=hit+1 where bnum=? and category=?";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setInt(1, bnum);
			         pstmt.setString(2, category);
			         
			         pstmt2=con.prepareStatement(sql2);
			         pstmt2.setInt(1, bnum);
			         pstmt2.setString(2, category);
			         pstmt2.executeUpdate();
			         rs = pstmt.executeQuery();
			         while (rs.next()) {
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setId(rs.getString("id"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setTitle(rs.getString("title"));
			        	dto.setContent(rs.getString("content"));
			        	dto.setPhotoimg(rs.getString("photoimg"));
			        	dto.setHit(rs.getInt("hit"));
			        	dto.setBdate(rs.getString("bdate"));
			        	dto.setCategory(rs.getString("category"));
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return dto;
			    }
		
	//사진게시판 글 수정
		public boolean BoardPhotoUpdate(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="update photoboard_tbl set title=?, content=? where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, dto.getTitle());
				   pstmt.setString(2, dto.getContent());
				   pstmt.setInt(3, dto.getBnum());
				   pstmt.setString(4, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
	//사진게시판 글 삭제
		public boolean BoardPhotoDelete(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="delete from photoboard_tbl where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setInt(1, dto.getBnum());
				   pstmt.setString(2, dto.getCategory());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
		//댓글 뷰
		public ArrayList<BoardDTO>CommentView(BoardDTO bdto) throws SQLException {
			   Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      BoardDTO dto=null;
			      ArrayList<BoardDTO> list = new ArrayList<>();
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select * from (select bnum, category, cnum, id, nickname, ccomment, " + 
			         		"to_char(cdate, 'yyyy-mm-dd') as cdate, rownum as rnum from comment_tbl where bnum=? and category=?) where rnum between ? and ?"
			         		+ "order by cnum desc";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setInt(1, bdto.getBnum());
			         pstmt.setString(2, bdto.getCategory());
			         pstmt.setInt(3, bdto.getStartpage());
			         pstmt.setInt(4, bdto.getEndpage());
			         rs = pstmt.executeQuery();
			         while(rs.next()){
			        	dto = new BoardDTO();
			        	dto.setBnum(rs.getInt("bnum"));
			        	dto.setCategory(rs.getString("category"));
			        	dto.setCnum(rs.getInt("cnum"));
			        	dto.setId(rs.getString("id"));
			        	dto.setNickname(rs.getString("nickname"));
			        	dto.setCcomment(rs.getString("ccomment"));
			        	dto.setCdate(rs.getString("cdate"));
			            list.add(dto);
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return list;
			    }
	
		//댓글 작성
		public boolean CommentWrite(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   PreparedStatement pstmt2=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="insert into comment_tbl values(?, ?, comment_seq.nextval, ?, ?, ?, sysdate)";
				   String sql2="update board_tbl set commnum=commnum+1 where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setInt(1, dto.getBnum());
				   pstmt.setString(2, dto.getCategory());
				   pstmt.setString(3, dto.getId());
				   pstmt.setString(4, dto.getNickname());
				   pstmt.setString(5, dto.getCcomment());
				   
				   pstmt2=con.prepareStatement(sql2);
				   pstmt2.setInt(1, dto.getBnum());
				   pstmt2.setString(2, dto.getCategory());
				   if (pstmt.executeUpdate()==1 && pstmt2.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
		//댓글 수정용 뷰
		public BoardDTO CommentUpdateView(BoardDTO dto) throws SQLException {
			   Connection con=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      try {
			         con=DriverManager.getConnection(url, user, password);
			         String sql="select ccomment from comment_tbl where bnum=? and category=? and cnum=?";
			         pstmt=con.prepareStatement(sql);
			         pstmt.setInt(1, dto.getBnum());
			         pstmt.setString(2, dto.getCategory());
			         pstmt.setInt(3, dto.getCnum());
			         rs = pstmt.executeQuery();
			         while (rs.next()) {
			        	dto = new BoardDTO();
			        	dto.setCcomment(rs.getString("ccomment"));
			         }
			      		} catch (Exception e) {
			      			e.printStackTrace();
			      		} finally {
			      			closeAll(rs, pstmt, con);
			      		}
			       return dto;
			    }
		
		//댓글 수정
		public boolean CommentUpdate(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="update comment_tbl set ccomment=? where bnum=? and category=? and cnum=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, dto.getCcomment());
				   pstmt.setInt(2, dto.getBnum());
				   pstmt.setString(3, dto.getCategory());
				   pstmt.setInt(4, dto.getCnum());
				   if (pstmt.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
		
		//댓글 삭제
		public boolean CommentDelete(BoardDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   PreparedStatement pstmt2=null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="delete from comment_tbl where bnum=? and category=? and cnum=?";
				   String sql2="update board_tbl set commnum=commnum-1 where bnum=? and category=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setInt(1, dto.getBnum());
				   pstmt.setString(2, dto.getCategory());
				   pstmt.setInt(3, dto.getCnum());
					   
				   pstmt2=con.prepareStatement(sql2);
				   pstmt2.setInt(1, dto.getBnum());
				   pstmt2.setString(2, dto.getCategory());
				   if (pstmt.executeUpdate()==1 && pstmt2.executeUpdate()==1)
			            flag=true;
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeSome(pstmt, con);
			      }
			      return flag;
			   }
}
