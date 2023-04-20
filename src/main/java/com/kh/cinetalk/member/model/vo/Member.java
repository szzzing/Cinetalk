package com.kh.cinetalk.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

public class Member {
	private String id;
	private String pwd;
	private String name;
	private String nickName;
	private String email;
	private Date birthDay;
	private String gender;
	private String phone;
	private Date enrollDate;
	private Date updateDate;
	private String status;
	private String isAdmin;
	
	public Member() {}

	public Member(String id, String pwd, String name, String nickName, String email, Date birthDay, String gender,
			String phone, Date enrollDate, Date updateDate, String status, String isAdmin) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.nickName = nickName;
		this.email = email;
		this.birthDay = birthDay;
		this.gender = gender;
		this.phone = phone;
		this.enrollDate = enrollDate;
		this.updateDate = updateDate;
		this.status = status;
		this.isAdmin = isAdmin;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", pwd=" + pwd + ", name=" + name + ", nickName=" + nickName + ", email=" + email
				+ ", birthDay=" + birthDay + ", gender=" + gender + ", phone=" + phone + ", enrollDate=" + enrollDate
				+ ", updateDate=" + updateDate + ", status=" + status + ", isAdmin=" + isAdmin + "]";
	}
	
	
}