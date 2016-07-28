package cuckoo.user;

import java.sql.Connection;
import java.sql.Date;
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
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");  // mysql
//			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");	//oracle
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
	
	
	// 전체 회원 정보를 가져오기.(매개변수 4개)
			public ArrayList<UserEntity> getUserEntityList(String orderby, int desc, String field, String value) {
				connect();
				
				String str = "";
				
				if(desc==1)
					str="asc";
				if(desc==0)
					str="desc";
				
				 ArrayList<UserEntity> list = new ArrayList<UserEntity>();
				 
				 String SQL1 = "select * from User_Info order by "+orderby+ " "+str;
				 String SQL2 = "select * from User_Info where "+ field + " like ? order by "+orderby+ " "+str;
				 try {
					 if(value==null || value==""){
						  //키워드(value)가 있나 없나 체크합니다. 없다면
						  pstmt = con.prepareStatement(SQL1);
						  }else{
						  //키워드가 있다면
						  pstmt = con.prepareStatement(SQL2);
						  pstmt.setString(1, "%"+value+"%"); 
						  }


					 	
						ResultSet rs = pstmt.executeQuery();

						while (rs.next()) {		
							
							UserEntity user = new UserEntity();

							user.setUserid(rs.getString("userid"));
							user.setUsername(rs.getString("username"));
							user.setNickname(rs.getString("nickname"));
							user.setPassword(rs.getString("password"));
							user.setSex(rs.getString("sex"));
							user.setEmail(rs.getString("email"));
							user.setBirthday(rs.getString("birthday"));
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
	
	
	// 전체 회원 정보를 가져오기.   ( 매개변수 없는 것 )
		public ArrayList<UserEntity> getUserEntityList() {
			connect();
			
			String str = "";
			
			 ArrayList<UserEntity> list = new ArrayList<UserEntity>();
			 
			 String SQL1 = "select * from User_Info";
			 try {
					pstmt = con.prepareStatement(SQL1);
					ResultSet rs = pstmt.executeQuery();

					while (rs.next()) {		
						
						UserEntity user = new UserEntity();

						user.setUserid(rs.getString("userid"));
						user.setUsername(rs.getString("username"));
						user.setNickname(rs.getString("nickname"));
						user.setPassword(rs.getString("password"));
						user.setSex(rs.getString("sex"));
						user.setEmail(rs.getString("email"));
						user.setBirthday(rs.getString("birthday"));
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
		 
		 String SQL = "select * from user_info where USERID = ?";
		 try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, userid);
				ResultSet rs = pstmt.executeQuery();

				 
				rs.next();
					
				user.setUserid(rs.getString("USERID"));
				user.setUsername(rs.getString("USERNAME"));
				user.setNickname(rs.getString("NICKNAME"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setSex(rs.getString("SEX"));
				user.setEmail(rs.getString("EMAIL"));
				user.setRegdate(rs.getTimestamp("REGDATE"));
				user.setLastconn(rs.getTimestamp("LASTCONN"));
				user.setManager(rs.getString("MANAGER"));
				user.setTemp(rs.getString("TEMP"));
					
			
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
		String sql = "select FRIENDID from friend_list where USERID = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
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
		 
		 String SQL = "insert into User_Info(USERID, USERNAME, NICKNAME, PASSWORD, SEX, EMAIL, BIRTHDAY, REGDATE, LASTCONN, MANAGER, TEMP) ";
		 SQL = SQL + "values(?, ?, ?, ?, ?, ?, ?, sysdate(), sysdate(), 'N', 0)";
		 try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, user.getUserid());
				pstmt.setString(2, user.getUsername());
				pstmt.setString(3, user.getNickname());
				pstmt.setString(4, user.getPassword());
				pstmt.setString(5, user.getSex());
				pstmt.setString(6, user.getEmail());
				pstmt.setString(7, user.getBirthday());				
				pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
	}
	
	// 회원 로그인 했을 때 마지막 로그인 업데이트
	public void updateLastConn(String userid) {
		connect();
		 
		 String SQL = "update user_info set lastconn=now()";
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
		// 매니저로~
		public String getManager(String userid){
			connect();
			
			String manager="";
			 
			 String SQL = "select manager from user_info";
			 SQL = SQL + " where userid=?";
			 try {
					pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, userid);
					ResultSet rs = pstmt.executeQuery();
					
					rs.next();
					manager = rs.getString("manager");
					
					rs.close();
						
				} catch (SQLException e) {
					e.printStackTrace();
				} 
				finally {
					disconnect();
				}
			 return manager;
			 
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
	
	//id check
		public boolean idpw_check(String userid, String password) {
			connect();
			
			 UserEntity user = new UserEntity();
			 boolean check=false;
			 
			 String SQL = "select userid from user_info where USERID =? and password =?";
			 try {
					pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, userid);
					pstmt.setString(2, password);
					ResultSet rs = pstmt.executeQuery();
	 
					rs.next();
						
					user.setUserid(rs.getString("USERID"));
						
					check=true;
					rs.close();			
				} catch (SQLException e) {
					check=false;
				} 
				finally {
					disconnect();
				}
			 
			 return check;
		}
}
