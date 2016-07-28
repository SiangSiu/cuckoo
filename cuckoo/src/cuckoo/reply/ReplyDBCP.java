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
		
		//댓글번호로 댓글 반환 메소드
		public ReplyEntity getReply(int rpnum) {
			connect();
			ReplyEntity rp = new ReplyEntity();
			
			String sql = "select * from reply where rpnum=?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rpnum);
				ResultSet rs = pstmt.executeQuery();	
				rs.next();
				rp.setNum(rs.getInt("num"));
				rp.setReply(rs.getString("reply"));
				rp.setRpnum(rs.getInt("rpnum"));
				rp.setRpparent(rs.getInt("rpparent"));
				rp.setReplytime(rs.getTimestamp("replytime"));
				rp.setUserid(rs.getString("userid"));
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
			return rp;
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
		
		//rpnum을 이용한 댓글 삭제
		public boolean deleteDB(int rpnum) {
			boolean success = false;
			connect();
			String sql = "delete from reply where rpnum = ? or rpparent=?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rpnum);
				pstmt.setInt(2, rpnum);
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
		
		//num을 이용한 댓글삭제(게시물삭제에 의한 댓글 삭제)
		public boolean deleteDBByNews(int num) {
			boolean success = false;
			connect();
			String sql = "delete from reply where num = ?";
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
