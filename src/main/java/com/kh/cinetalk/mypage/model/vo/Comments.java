package com.kh.cinetalk.mypage.model.vo;

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
public class Comments {
	private int commentId;
	private String commentContent, status, userId;
	private int boardId, commentCid;
	private Date commentCreateDate, commentModifyDate;
	private String boardTitle;
}
