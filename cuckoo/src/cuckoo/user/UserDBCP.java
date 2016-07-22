package cuckoo.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;



public class UserDBCP {
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	
	public UserDBCP(){
		try {
			InitialContext ctx = new InitialContext();
//			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");  // mysql
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");	//oracle
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	void connect() {
		try {
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	void disconnect(){
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	
	// 전체 회원 정보를 가져오기.
	public ArrayList<UserEntity> getUserEntityList() {
		connect();
		 ArrayList<UserEntity> list = new ArrayList<UserEntity>();
		 
		 String SQL = "select * from User_Info";
		 try {
				pstmt = con.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery();

				while (rs.next()) {		
					
					UserEntity user = new UserEntity();

					user.setUserid(rs.getString("userid"));
					user.setUsername(rs.getString("username"));
					user.setNickname(rs.getString("nickname"));
					user.setPassword(rs.getString("password"));
					user.setSex(rs.getString("sex"));
					user.setEmail(rs.getString("email"));
					user.setRegdate(rs.getTimestamp("regdate"));
					user.setLastconn(rs.getTimestamp("lastConn"));
					user.setManager(rs.getString("manager"));
					user.setTemp(rs.getString("temp"));
					
					list.add(user);
				}
				rs.close();			
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
		 
		 return list;
	}
	
	
	//user 정보
	public UserEntity getUserEntity(String userid) {
		connect();
		
		 UserEntity user = new UserEntity();
		 
		 String SQL = "select * from User_Info where USERID ='"+userid+"'";
		 try {
				pstmt = con.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery();

				 
				rs.next();
					
				user.setUserid(rs.getString("userid"));
				user.setUsername(rs.getString("username"));
				user.setNickname(rs.getString("nickname"));
				user.setPassword(rs.getString("password"));
				user.setSex(rs.getString("sex"));
				user.setEmail(rs.getString("email"));
				user.setRegdate(rs.getTimestamp("regdate"));
				user.setLastconn(rs.getTimestamp("lastConn"));
				user.setManager(rs.getString("manager"));
				user.setTemp(rs.getString("temp"));
					
			
				rs.close();			
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
		 
		 return user;
	}
	
	//메인 페이지에서 친구 블럭 수를 결정하기위해 친구목록을 불러오는 메소드
	public String[] getFrndList(String userid) {
		connect();
		String[] frndList = null;
		int frndNum = 0;
		String sql = "select FRIENDID from friend_list where USERID = "+userid;
		
		try {
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				frndNum++;
			}
			rs.beforeFirst();
			frndList = new String[frndNum];
			for(int i=0; rs.next(); i++) {
				frndList[i] = rs.getString("FRIENDID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return frndList;
		} finally {
			disconnect();
		}
		return frndList;
	}
	
	
	//친구목록 불러오기
	public ArrayList<UserEntity> getUser_FriendList(String userid) {
		connect();
		 ArrayList<UserEntity> list = new ArrayList<UserEntity>();
		 
		 String SQL = "SELECT FRIENDID FROM friend_list";
		 SQL = SQL + " WHERE USERID = (select USERID FROM UserEntity WHERE USERID='"+userid+"')";
		 try {
				pstmt = con.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery();


				while (rs.next()) {		
					UserEntity user = new UserEntity();
					String friendid=rs.getString("FRIENDID");
					
					SQL = "SELECT * FROM UserEntity where userid='"+friendid+"'";
					pstmt = con.prepareStatement(SQL);
					ResultSet rs2 = pstmt.executeQuery();
					rs2.next();
				
					user.setUserid(rs2.getString("userid"));
					user.setUsername(rs2.getString("username"));
					list.add(user);
					rs2.close();
				}
				rs.close();			
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
		 
		 return list;
	}
	
	// 친구 추가 메소드
	public void setUserFriendList(String userid, String friendid) {

		connect();
		 
		 String SQL = "insert into table friend_list(USERID, friendid) ";
		 SQL = SQL + "values('"+userid+"', '"+ friendid+"')";
		 
		 String SQL2 = "insert into table friend_list(USERID, friendid) ";
		 SQL2 = SQL2 + "values('"+friendid+"', '"+ userid +"')";
		 try {
				pstmt = con.prepareStatement(SQL);
				pstmt.executeQuery();
				pstmt = con.prepareStatement(SQL2);
				pstmt.executeQuery();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}

	

	}
	
	// 회원 등록 메소드
	public void setUserEntityList(UserEntity user) {
		connect();
		 
		 String SQL = "insert into table User_Info(USERID, USERNAME, NICKNAME, PASSWORD, SEX, EMAIL, REGDATE, LASTCONN, MANAGER, TEMP) ";
		 SQL = SQL + "values(?, ?, ?, ?, ?, ?, sysdate, sysdate, ?, 0)";
		 try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, user.getUserid());
				pstmt.setString(2, user.getUsername());
				pstmt.setString(3, user.getNickname());
				pstmt.setString(4, user.getPassword());
				pstmt.setString(5, user.getSex());
				pstmt.setString(6, user.getEmail());
				pstmt.setString(7, user.getManager());
				pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
	}
	
	// 회원 로그인 했을 때 마지막 로그인 업데이트
	public void updateLastConn(UserEntity user) {
		connect();
		 
		 String SQL = "update user_info set lastconn=sysdate";
		 SQL = SQL + " where userid=?";
		 try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, user.getUserid());
				pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
	}
	
	// 매니저로~
	public void updateManager(String userid){
		connect();
		 
		 String SQL = "update user_info set manager='Y'";
		 SQL = SQL + " where userid=?";
		 try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, userid);
				pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
	}
	
	// 매니저에서 강등... ㅠ
		public void updateNoManager(String userid){
			connect();
			 
			 String SQL = "update user_info set manager='N'";
			 SQL = SQL + " where userid=?";
			 try {
					pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, userid);
					pstmt.executeUpdate();
						
				} catch (SQLException e) {
					e.printStackTrace();
				} 
				finally {
					disconnect();
				}
		}
	
	// 회원 수정
	public boolean updateDB(UserEntity user) {
		boolean success = false; 
		connect();		
		String sql ="update user_info set nickname=?, password=?, email=? where userid=?";	
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getNickname());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getUserid());
			int rowUdt = pstmt.executeUpdate();
			if (rowUdt == 1) success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		}
		finally {
			disconnect();
		}
		return success;
	}
	
	
	// 회원 삭제
	public boolean deleteDB(String userid) {
		boolean success = false; 
		connect();		
		String sql ="delete from user_info where userid=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.executeUpdate();
			success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		}
		finally {
			disconnect();
		}
		return success;
	}

	
}
