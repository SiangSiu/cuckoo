package cuckoo.news;

import java.util.Date;

public class NewsEntity {
   
   private int num;
   private String userid;
   private String nickname;
   private String imgsrc;
   private String content;
   private Date regtime;
   private int good;
   private Date goodtime;
   private int bad;
   private Date badtime;
   
   
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
   }
   public String getUserid() {
      return userid;
   }
   public void setUserid(String userid) {
      this.userid = userid;
   }
   public String getNickname() {
      return nickname;
   }
   public void setNickname(String nickname) {
      this.nickname = nickname;
   }
   public String getImgsrc() {
      return imgsrc;
   }
   public void setImgsrc(String imgsrc) {
      this.imgsrc = imgsrc;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public Date getRegtime() {
      return regtime;
   }
   public void setRegtime(Date regtime) {
      this.regtime = regtime;
   }
   public int getGood() {
      return good;
   }
   public void setGood(int good) {
      this.good = good;
   }
   public Date getGoodtime() {
      return goodtime;
   }
   public void setGoodtime(Date goodtime) {
      this.goodtime = goodtime;
   }
   public int getBad() {
      return bad;
   }
   public void setBad(int bad) {
      this.bad = bad;
   }
   public Date getBadtime() {
      return badtime;
   }
   public void setBadtime(Date badtime) {
      this.badtime = badtime;
   }
   
}
