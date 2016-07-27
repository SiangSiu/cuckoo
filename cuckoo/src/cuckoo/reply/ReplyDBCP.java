package cuckoo.reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReplyDBCP {
	
	//DB연결 변수 선언
		private Connection con = null;
		private PreparedStatement pstmt = null;
		private DataSource ds = null;
		
		//JDBC드라이버 로드 메소드
		public ReplyDBCP() {
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
		
		//댓글목록 반환 메소드
		public ArrayList<ReplyEntity>getReplyList(int num) {
			connect();
			ArrayList<ReplyEntity>list = new ArrayList<ReplyEntity>();
			
			String sql = "select * from reply where num=? order by rpnum, rpparent, replytime";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReplyEntity rp = new ReplyEntity();
					rp.setNum(rs.getInt("num"));
					rp.setReply(rs.getString("reply"));
					rp.setRpnum(rs.getInt("rpnum"));
					rp.setRpparent(rs.getInt("rpparent"));
					rp.setReplytime(rs.getTimestamp("replytime"));
					rp.setUserid(rs.getString("userid"));
					//list에 추가
					list.add(rp);
				}
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
			return list;
		}
		
		//댓글 등록 메소드
		public boolean insertDB(int num, String reply, String userid) {
			boolean success = false;
			connect();
			String sql = "insert into reply values(?, ?, 0, 0, sysdate(), ?)";
			
				try {
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, reply);
					pstmt.setString(3, userid);
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
		
		//댓글 등록 메소드
		public boolean insertDB(int num, String reply, int rpparent, String userid) {
			boolean success = false;
			connect();
			String sql = "insert into reply values(?, ?, 0, ?, sysdate(), ?)";
			
				try {
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, reply);
					pstmt.setInt(3, rpparent);
					pstmt.setString(4, userid);
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

		
		//댓글 수정 메소드
		public boolean updateDB(int rpnum, String newReply) {
			boolean success = false;
			connect();
			String sql = "update reply set reply = ? where rpnum = ?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, newReply);
				pstmt.setInt(2, rpnum);
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
		
		//댓글 수정 메소드2
		public boolean updateDB(int rpnum, String newReply, int rpparent) {
			boolean success = false;
			connect();
			String sql = "update reply set reply = ?, rpparent=? where rpnum = ?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, newReply);
				pstmt.setInt(2, rpparent);
				pstmt.setInt(3, rpnum);
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
		
}
