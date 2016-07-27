package cuckoo.news;

import java.sql.*;
import java.util.*;

import javax.sql.*;
import javax.naming.*;

public class NewsDBCP {

   //DB���� ���� ����
   private Connection con = null;
   private PreparedStatement pstmt = null;
   private DataSource ds = null;
   
   //JDBC����̹� �ε� �޼ҵ�
   public NewsDBCP() {
      try {
         InitialContext ctx = new InitialContext();
         ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
//         ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");	//oracle
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   //DB���� �޼ҵ�
   public void connect(){
      try {
         con = ds.getConnection();
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   //DB���� ���� �޼ҵ�
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
   
   //news�� ��� ���ڵ� ��ȯ �޼ҵ�
   public ArrayList<NewsEntity>getNewsList() {
      connect();
      ArrayList<NewsEntity>list = new ArrayList<NewsEntity>();
      
      String sql = "select * from news";
      try {
         pstmt = con.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery();
         
         while(rs.next()) {
            NewsEntity nws = new NewsEntity();
            nws.setNum(rs.getInt("num"));
            nws.setUserid(rs.getString("userid"));
            nws.setNickname(rs.getString("nickname"));
            nws.setImgsrc(rs.getString("imgsrc"));
            nws.setContent(rs.getString("content"));
            nws.setRegtime(rs.getTimestamp("regtime"));
            nws.setGood(rs.getInt("good"));
            nws.setGoodtime(rs.getTimestamp("goodtime"));
            nws.setBad(rs.getInt("bad"));
            nws.setBadtime(rs.getTimestamp("badtime"));
            //list�� �߰�
            list.add(nws);
         }
         rs.close();
      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         disconnect();
      }
      return list;
   }
   
	public ArrayList<NewsEntity>getFriendNewsList(String frinedId) {
		connect();
		ArrayList<NewsEntity>list = new ArrayList<NewsEntity>();
		
		String sql = "select * from news where userid = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, frinedId);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NewsEntity nws = new NewsEntity();
				nws.setNum(rs.getInt("num"));
				nws.setUserid(rs.getString("userid"));
				nws.setNickname(rs.getString("nickname"));
				nws.setImgsrc(rs.getString("imgsrc"));
				nws.setContent(rs.getString("content"));
				nws.setRegtime(rs.getTimestamp("regtime"));
				nws.setGood(rs.getInt("good"));
				nws.setGoodtime(rs.getTimestamp("goodtime"));
				nws.setBad(rs.getInt("bad"));
				nws.setBadtime(rs.getTimestamp("badtime"));
				//list�� �߰�
				list.add(nws);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;
	}
   //num���� news �Խù� ���ڵ带 ��ȯ�ϴ� �޼ҵ�
   public NewsEntity getNews(int num) {
      connect();
      String sql = "select * from news where num = ?";
      NewsEntity nws = new NewsEntity();
      
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         ResultSet rs = pstmt.executeQuery();
         rs.next();
         nws.setNum(rs.getInt("num"));
         nws.setUserid(rs.getString("userid"));
         nws.setNickname(rs.getString("nickname"));
         nws.setImgsrc(rs.getString("imgsrc"));
         nws.setContent(rs.getString("content"));
         nws.setRegtime(rs.getTimestamp("regtime"));
         nws.setGood(rs.getInt("good"));
         nws.setGoodtime(rs.getTimestamp("goodtime"));
         nws.setBad(rs.getInt("bad"));
         nws.setBadtime(rs.getTimestamp("badtime"));
         rs.close();
      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         disconnect();
      }
      return nws;
   }
   
   //�Խù� ��� �޼ҵ�
   public boolean insertDB(NewsEntity news) {
      boolean success = false;
      connect();
      String sql = "insert into news values(0, ?, ?, ?, ?, sysdate(), ?, sysdate(), ?, sysdate())";
      //goodtime�� badtime�� �ʱⰪ���� ��Ͻð��� ���� ����ð��� �Է�
         try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, news.getUserid());
            pstmt.setString(2, news.getNickname());
            pstmt.setString(3, news.getImgsrc());
            pstmt.setString(4, news.getContent());
            pstmt.setInt(5, 0);
            pstmt.setInt(6, 0);
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
   
   //�Խù� ���� �޼ҵ�
   public boolean updateDB(NewsEntity news) {
      boolean success = false;
      connect();
      String sql = "update news set content = ? where num = ?";
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, news.getContent());
         pstmt.setInt(2, news.getNum());
         int rowUdt = pstmt.executeUpdate();
         if (rowUdt == 1)   success = true;
      } catch (SQLException e) {
         e.printStackTrace();
         return success;
      } finally {
         disconnect();
      }
      return success;
   }
   
   //����ô �߰� �޼ҵ�
   public boolean addGood(int num) {
      boolean success = false;
      NewsEntity nws = getNews(num);
      connect();
      String sql = "update news set good = ?, goodtime = sysdate() where num = ?";
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, nws.getGood()+1);
         pstmt.setInt(2, num);
         int rowUdt = pstmt.executeUpdate();
         if (rowUdt == 1)   success = true;
      } catch (SQLException e) {
         e.printStackTrace();
         return success;
      } finally {
         disconnect();
      }
      return success;
   }
   
   //����ô ��� �޼ҵ�
   public boolean subGood(int num) {
      boolean success = false;
      NewsEntity nws = getNews(num);
      connect();
      String sql = "update news set good = ?, goodtime = sysdate() where num = ?";
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, nws.getGood()-1);
         pstmt.setInt(2, num);
         int rowUdt = pstmt.executeUpdate();
         if (rowUdt == 1)   success = true;
      } catch (SQLException e) {
         e.printStackTrace();
         return success;
      } finally {
         disconnect();
      }
      return success;
   }
   
   //����ô �߰� �޼ҵ�
   public boolean addBad(int num) {
      boolean success = false;
      NewsEntity nws = getNews(num);
      connect();
      String sql = "update news set bad = ?, badtime = sysdate() where num = ?";
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, nws.getBad()+1);
         pstmt.setInt(2, num);
         int rowUdt = pstmt.executeUpdate();
         if (rowUdt == 1)   success = true;
      } catch (SQLException e) {
         e.printStackTrace();
         return success;
      } finally {
         disconnect();
      }
      return success;
   }
   
   //����ô ��� �޼ҵ�
   public boolean subBad(int num) {
      boolean success = false;
      NewsEntity nws = getNews(num);
      connect();
      String sql = "update news set bad = ?, badtime = sysdate() where num = ?";
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, nws.getBad()-1);
         pstmt.setInt(2, num);
         int rowUdt = pstmt.executeUpdate();
         if (rowUdt == 1)   success = true;
      } catch (SQLException e) {
         e.printStackTrace();
         return success;
      } finally {
         disconnect();
      }
      return success;
   }
   
   //�Խù� ���� �޼ҵ�
   public boolean deleteDB(int num) {
      boolean success = false;
      connect();
      String sql = "delete from news where num = ?";
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
