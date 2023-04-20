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
public class Movie {
	private int movieId;
	private String movieImg;
	private String movieTitle;
	private String releaseDate; // 개봉일
	private String genre; // 장르
//	private double rating; // 기본적으로 있는 별점
	private double pRating; // 회원이 리뷰에 등록하는 별점
	private String overview; // 줄거리
	private String director; // 감독
	private String producer; // 연출
	private String actor; // 출연 배우
	private long runtime;


}