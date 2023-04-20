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
public class Hcomment{
	private int commentId;
	private String commentContent;
	private String status;
	private String userId;
	private String nickName;
	private String boardId;
	private int commentCId;
	private Date commentCreateDate;
	private Date commentModifyDate;
}