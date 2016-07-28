package cuckoo.clickable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ClickableDBCP {
	
		//DB연결 변수 선언
		private Connection con = null;
		private PreparedStatement pstmt = null;
		private DataSource ds = null;
		
		//JDBC드라이버 로드 메소드
		public ClickableDBCP() {
			try {
				InitialContext ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//DB연결 메소드
		public void connect(){
			try {
				con = ds.getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//DB연결 해제 메소드
		public void disconnect(){
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		//num, userid로 clickable 레코드를 반환하는 메소드
		public ClickableEntity getClick(int num, String userid) {
			connect();
			String sql = "select * from clickable where num = ? and userid=?";
			ClickableEntity click = new ClickableEntity();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, userid);
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				click.setNum(rs.getInt("num"));
				click.setUserid(rs.getString("userid"));
				click.setGoodclick(rs.getString("goodclick"));
				click.setBadclick(rs.getString("badclick"));
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
			return click;
		}
		
		//등록 메소드
		public boolean insertDB(ClickableEntity click) {
			boolean success = false;
			connect();
			String sql = "insert into clickable values(?, ?, ?, ?)";
				try {
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, click.getNum());
					pstmt.setString(2, click.getUserid());
					pstmt.setString(3, click.getGoodclick());
					pstmt.setString(4, click.getBadclick());
					pstmt.executeUpdate();
					success = true;
				} catch (SQLException e) {
					e.printStackTrace();
					return success;
				} finally {
					disconnect();
				}
				return success;
		}
		
		//게시물 수정 메소드
		public boolean updateDB(ClickableEntity click) {
			boolean success = false;
			connect();
			String sql = "update clickable set goodclick=?, badclick=? where num=? and userid=?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, click.getGoodclick());
				pstmt.setString(2, click.getBadclick());
				pstmt.setInt(3, click.getNum());
				pstmt.setString(4, click.getUserid());
				int rowUdt = pstmt.executeUpdate();
				if (rowUdt == 1)	success = true;
			} catch (SQLException e) {
				e.printStackTrace();
				return success;
			} finally {
				disconnect();
			}
			return success;
		}
		
		public boolean deleteDB(int num) {
			boolean success = false;
			connect();
			String sql = "delete from clickable where num = ?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				success = true;
			} catch (SQLException e) {
				e.printStackTrace();
				return success;
			} finally {
				disconnect();
			}
			return success;
		}
		
}
