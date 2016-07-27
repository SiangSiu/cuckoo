package cuckoo.reply;

import java.util.Date;

public class ReplyEntity {
	private int num;
	private String reply;
	private int rpnum;
	private int rpparent;
	private Date replytime;
	private String userid;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public int getRpnum() {
		return rpnum;
	}
	public void setRpnum(int rpnum) {
		this.rpnum = rpnum;
	}
	public int getRpparent() {
		return rpparent;
	}
	public void setRpparent(int rpparent) {
		this.rpparent = rpparent;
	}
	public Date getReplytime() {
		return replytime;
	}
	public void setReplytime(Date replytime) {
		this.replytime = replytime;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
