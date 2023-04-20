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
public class Review {
	private int boardId;
	private String boardTitle;
	private String boardWriter;
	private String nickName;
	private String boardContent;
	private int boardCount;
	private Date createDate;
	private Date modifyDate;
	private String status;
	private int movieId;
	private double movieRating;
	private int likeCount;
	private int commentCount;
}