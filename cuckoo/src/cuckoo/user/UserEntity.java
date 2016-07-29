package cuckoo.user;

import java.util.Date;

public class UserEntity {
	private String userid;
	private String username;
	private String nickname;
	private String password;
	private String sex;
	private String email;
	private String birthday;
	private Date regdate;
	private Date lastconn;
	private String manager;
	private String temp;
	private String profilesrc;
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getLastconn() {
		return lastconn;
	}

	public void setLastconn(Date lastconn) {
		this.lastconn = lastconn;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getProfilesrc() {
		return profilesrc;
	}
	public void setProfilesrc(String profilesrc) {
		this.profilesrc = profilesrc;
	}
	
	
	
}
