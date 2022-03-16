package pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "hyemi";
	private String password = "1234";

	public UserDAO() throws ClassNotFoundException {
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
	
	//회원가입
	public boolean UserJoin (UserDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="insert into user_tbl values(?, ?, ?, ?, ?, 3)";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setString(1, dto.getId());
			   pstmt.setString(2, dto.getNickname());
			   pstmt.setString(3, dto.getPw());
			   pstmt.setString(4, dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3());
			   pstmt.setString(5, dto.getEid()+dto.getEaddress());
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

	//회원 로그인
	public boolean UserLogin (UserDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   ResultSet rs = null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="select id from user_tbl where id=? and pw=?";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setString(1, dto.getId());
			   pstmt.setString(2, dto.getPw());
			   rs = pstmt.executeQuery();
		         flag = rs.next();
		      } catch (Exception e) {
		         e.printStackTrace();
		         System.out.print(e);
		      } finally {
		    	  closeAll(rs, pstmt, con);
		      }
		      return flag;
		   }
	
	//전체 회원 목록
	public ArrayList<UserDTO>UserList(int startpage, int endpage) throws SQLException {
			  Connection con=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      UserDTO dto=null;
		      ArrayList<UserDTO> list = new ArrayList<>();
		      try {
		         con=DriverManager.getConnection(url, user, password);
		         String sql="select * from user_tbl where rownum between ? and ?";
		         pstmt=con.prepareStatement(sql);
		         pstmt.setInt(1, startpage);
		         pstmt.setInt(2, endpage);
		         rs = pstmt.executeQuery();
		         while(rs.next()){
		        	dto = new UserDTO();
		        	dto.setId(rs.getString("id"));
		        	dto.setNickname(rs.getString("nickname"));
		        	dto.setPw(rs.getString("pw"));
		        	dto.setTel(rs.getString("tel"));
		        	dto.setEmail(rs.getString("email"));
		        	dto.setGrade(rs.getInt("grade"));
		            list.add(dto);
		         }
		      		} catch (Exception e) {
		      			e.printStackTrace();
		      		} finally {
		      			closeAll(rs, pstmt, con);
		      		}
		       return list;
		    }
	
	//회원정보 수정용 뷰
	public UserDTO UserUpdateView(String ssid) throws SQLException {
		   Connection con=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      UserDTO dto=null;
		      try {
		         con=DriverManager.getConnection(url, user, password);
		         String sql="select id, nickname, pw, substr(tel, 1, 3) as tel1, substr(tel, 5, 4) as tel2, substr(tel, -4) as tel3, " + 
		         		"substr(email, 0, instr(email, '@') -1) as eid, substr(email, instr(email, '@')) as eaddress, grade from user_tbl where id=?";
		         pstmt=con.prepareStatement(sql);
		         pstmt.setString(1, ssid);
		         rs = pstmt.executeQuery();
		         while (rs.next()) {
		        	dto = new UserDTO();
		        	dto.setId(rs.getString("id"));
		        	dto.setNickname(rs.getString("nickname"));
		        	dto.setPw(rs.getString("pw"));
		        	dto.setTel1(rs.getString("tel1"));
		        	dto.setTel2(rs.getString("tel2"));
		        	dto.setTel3(rs.getString("tel3"));
		        	dto.setEid(rs.getString("eid"));
		        	dto.setEaddress(rs.getString("eaddress"));
		        	dto.setGrade(rs.getInt("grade"));
		         }
		      		} catch (Exception e) {
		      			e.printStackTrace();
		      		} finally {
		      			closeAll(rs, pstmt, con);
		      		}
		       return dto;
		    }
	
	//회원 정보 수정
	public boolean UserUpdate (UserDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="update user_tbl set nickname=?, pw=?, tel=?, email=? where id=?";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setString(1, dto.getNickname());
			   pstmt.setString(2, dto.getPw());
			   pstmt.setString(3, dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3());
			   pstmt.setString(4, dto.getEid()+dto.getEaddress());
			   pstmt.setString(5, dto.getId());
			   if (pstmt.executeUpdate()==1)
		         flag = true;
		      } catch (Exception e) {
		         e.printStackTrace();
		         System.out.print(e);
		      } finally {
		    	  closeSome(pstmt, con);
		      }
		      return flag;
		   }
	
	//회원 등급 수정
	public boolean UserGradeUpdate (UserDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="update user_tbl set grade=? where id=?";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setInt(1, dto.getGrade());
			   pstmt.setString(2, dto.getId());
			   if (pstmt.executeUpdate()==1)
		         flag = true;
		      } catch (Exception e) {
		         e.printStackTrace();
		         System.out.print(e);
		      } finally {
		    	  closeSome(pstmt, con);
		      }
		      return flag;
		   }
	
	//회원 탈퇴
	public boolean UserDelete (UserDTO dto) throws SQLException {
		   Connection con=null;
		   PreparedStatement pstmt=null;
		   PreparedStatement pstmt2=null;
		   PreparedStatement pstmt3=null;
		   PreparedStatement pstmt4=null;
		   PreparedStatement pstmt5=null;
		   boolean flag=false;
		   try {
			   con=DriverManager.getConnection(url, user, password);
			   String sql="delete from user_tbl where id=?";
			   String sql2="delete from board_tbl where id=?";
			   String sql3="delete from lineboard_tbl where id=?";
			   String sql4="delete from photoboard_tbl where id=?";
			   String sql5="delete from comment_tbl where id=?";
			   pstmt=con.prepareStatement(sql);
			   pstmt.setString(1, dto.getId());
			   
			   pstmt2=con.prepareStatement(sql2);
			   pstmt2.setString(1, dto.getId());
			   pstmt2.executeUpdate();
			   
			   pstmt3=con.prepareStatement(sql3);
			   pstmt3.setString(1, dto.getId());
			   pstmt3.executeUpdate();
			   
			   pstmt4=con.prepareStatement(sql4);
			   pstmt4.setString(1, dto.getId());
			   pstmt4.executeUpdate();
			   
			   pstmt5=con.prepareStatement(sql5);
			   pstmt5.setString(1, dto.getId());
			   pstmt5.executeUpdate();
			   if (pstmt.executeUpdate()==1)
		         flag = true;
		      } catch (Exception e) {
		         e.printStackTrace();
		         System.out.print(e);
		      } finally {
		    	  closeSome(pstmt, con);
		      }
		      return flag;
		   }

	//관리자 로그인
		public boolean AdminLogin (UserDTO dto) throws SQLException {
			   Connection con=null;
			   PreparedStatement pstmt=null;
			   ResultSet rs = null;
			   boolean flag=false;
			   try {
				   con=DriverManager.getConnection(url, user, password);
				   String sql="select aid from admin_tbl where aid=? and apw=?";
				   pstmt=con.prepareStatement(sql);
				   pstmt.setString(1, dto.getAid());
				   pstmt.setString(2, dto.getApw());
				   rs = pstmt.executeQuery();
			         flag = rs.next();
			      } catch (Exception e) {
			         e.printStackTrace();
			         System.out.print(e);
			      } finally {
			    	  closeAll(rs, pstmt, con);
			      }
			      return flag;
			   }
	}