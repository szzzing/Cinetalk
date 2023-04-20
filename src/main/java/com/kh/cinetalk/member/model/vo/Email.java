package com.kh.cinetalk.member.model.vo;

import lombok.Data;


public class Email {

	private String name;
	private String email;
	
	public Email() {}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Email [name=" + name + ", email=" + email + "]";
	}
	
	
	
}
