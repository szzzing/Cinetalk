package com.kh.cinetalk.review.model.vo;

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
public class Rcomment{
		private int commentId;
		private String commentContent;
		private String status;
		private String userId;
		private String nickName;
		private int boardId;
		private String commentCId;
		private Date commentCreateDate;
		private Date commentModifyDate;
		private String commentStatus;
		private int reportCount;
		
	}