package cuckoo.news;

import java.sql.*;
import java.util.*;

import javax.sql.*;
import javax.naming.*;

public class NewsDBCP {

   //DB연결 변수 선언
   private Connection con = null;
   private PreparedStatement pstmt = null;
   private DataSource ds = null;
   
   //JDBC드라이버 로드 메소드
   public NewsDBCP() {
      try {
         InitialContext ctx = new InitialContext();
         ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
//         ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");	//oracle
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
   
   //news의 모든 레코드 반환 메소드
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
            //list에 추가
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
   
   //num으로 news 게시물 레코드를 반환하는 메소드
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
   
   //게시물 등록 메소드
   public boolean insertDB(NewsEntity news) {
      boolean success = false;
      connect();
      String sql = "insert into news values(0, ?, ?, ?, ?, sysdate(), ?, sysdate(), ?, sysdate())";
      //goodtime과 badtime에 초기값으로 등록시간과 같이 현재시간을 입력
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
   
   //게시물 수정 메소드
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
   
   //엄지척 추가 메소드
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
   
   //엄지척 취소 메소드
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
   
   //중지척 추가 메소드
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
   
   //중지척 취소 메소드
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
   
   //게시물 삭제 메소드
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