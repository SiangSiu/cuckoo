package cuckoo.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;



public class UserDBCP {
	/*private static final String JDBC_DRIVER_ORACLE = "oracle.jdbc.driver.OracleDriver";
	private static final String JDBC_URL_ORACLE="jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER_ORACLE = "hr";
	private static final String PASSWD_ORACLE = "1234";
	
	private static final String JDBC_DRIVER_MYSQL = "org.gjt.mm.mysql.Driver";
	private static final String JDBC_URL_MYSQL="jdbc:mysql://localhost:3306/cuckoo?useUnicode=true&characterEncoding=utf-8";
	private static final String USER_MYSQL = "root";
	private static final String PASSWD_MYSQL = "apmsetup";*/
	
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

				//ResultSet의 결과에서 모든 행을 각각의 StudentEntity 객체에 저장  
				while (rs.next()) {		
					//한 행의 학생정보를 저장할 학생을 위한 빈즈 객체 생성  
					UserEntity user = new UserEntity();

					//한 행의 학생정보를 자바 빈즈 객체에 저장  				
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
	
	// 매개변수  userid 의  친구 리스트 가져오기 
	public ArrayList<UserEntity> getUser_FriendList(String userid) {
		connect();
		 ArrayList<UserEntity> list = new ArrayList<UserEntity>();
		 
		 String SQL = "SELECT FRIENDID FROM friend_list";
		 SQL = SQL + " WHERE USERID = (select USERID FROM UserEntity WHERE USERID='"+userid+"')";
		 try {
				pstmt = con.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery();
//				ResultSet rs2 =null;

				//ResultSet의 결과에서 모든 행을 각각의 StudentEntity 객체에 저장  
				while (rs.next()) {		
					//한 행의 학생정보를 저장할 학생을 위한 빈즈 객체 생성  
					UserEntity user = new UserEntity();
					String friendid=rs.getString("FRIENDID");
					
					SQL = "SELECT * FROM UserEntity where userid='"+friendid+"'";
					pstmt = con.prepareStatement(SQL);
					ResultSet rs2 = pstmt.executeQuery();
					rs2.next();

					//한 행의 학생정보를 자바 빈즈 객체에 저장  				
					user.setUserid(rs2.getString("userid"));
					user.setUsername(rs2.getString("username"));
					//ArrayList에 학생정보 StudentEntity 객체를 추가
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
	
}
