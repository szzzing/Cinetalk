package com.kh.cinetalk.hangout.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Hangout {
	private int boardId;
	private String boardTitle;
	private String boardWriter;
	private String nickName;
	private String boardContent;
	private int boardCount;
	private Date createDate;
	private Date modifyDate;
	private String status;
	private int hangoutNumber;
	private Integer movieId;
	private String gender;
	private String local;
	private String age;
	private int nowNumber;
	private String isClose;
}