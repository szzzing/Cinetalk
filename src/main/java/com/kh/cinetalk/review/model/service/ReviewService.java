package com.kh.cinetalk.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.dao.ReviewDAO;
import com.kh.cinetalk.review.model.vo.Like;
import com.kh.cinetalk.review.model.vo.MovieLike;
import com.kh.cinetalk.review.model.vo.Rcomment;
import com.kh.cinetalk.review.model.vo.Review;

@Service("rService")
public class ReviewService {

	@Autowired
	private ReviewDAO rDAO;

	@Autowired
	private SqlSessionTemplate sqlSession;

//	이현님
	public int insertMovieReview(Review r) {
		return rDAO.insertMovieReview(sqlSession, r);
	}

//	이현님
	public ArrayList<Review> movieReviewList(int movieId) {
		return rDAO.movieReviewList(sqlSession, movieId);
	}

//	이현님
	public Review reviewRating(int movieId) {
		return rDAO.reviewRating(sqlSession, movieId);
	}

//	세진 : 영화에 삽입된 리뷰 개수 반환
	public int selectReviewCount(int movieId) {
		return rDAO.selectReviewCount(sqlSession, movieId);
	}

//	세진 : 영화에 삽입된 리뷰 평균 별점 반환
	public double selectAvgRating(int movieId) {
		return rDAO.selectAvgRating(sqlSession, movieId);
	}

//	세진 : 전체 리뷰 개수 반환
	public int selectAllReviewCount() {
		return rDAO.selectAllReviewCount(sqlSession);
	}

// 김이현 영화 리뷰 보기 - 작성자일 경우 조회수 증가x
	public Review movieReviewDetail(int boardId, boolean yn) {
	int result = 0; 
		
		if(yn) {
			result = rDAO.addCount(sqlSession, boardId);
		}
		
		Review r = rDAO.movieReviewDetail(sqlSession, boardId);

		return r;
	}


	// 김이현 영화 리뷰 수정
	public int updateMovieReview(Review r) {
		return rDAO.updateMovieReview(sqlSession,r);
	}

	// 김이현 영화 리뷰 삭제
	public int deleteMovieReview(int boardId) {
		return rDAO.deleteMovieReview(sqlSession, boardId);
	}
	
	// 김이현 영화 리뷰에 댓글 작성
	public int insertRcomment(Rcomment rc) {
		return rDAO.insertRcomment(sqlSession, rc);
	}
	
	// 김이현 영화 리뷰에 댓글 조회
	public ArrayList<Rcomment> selectRcomment(int boardId) {
		return rDAO.selectRcomment(sqlSession, boardId);
	}
	// 김이현 영화 리뷰에 댓글 수정
	public int updateRcomment(Rcomment rc) {
		return rDAO.updateRcomment(sqlSession, rc);
	}
	// 김이현 영화 리뷰에 댓글 삭제
	public int deleteRcomment(int commentId) {
		return rDAO.deleteRcomment(sqlSession, commentId);
	}

	// 김이현 영화 리뷰에 댓글 수 -> 1이면 댓글 더이상 작성 못하게
	public int rCommentAlready(Rcomment rc) {
		return rDAO.rCommentAlready(sqlSession, rc);
	}

	// 김이현 영화 리뷰 좋아요 버튼 누름
	public int insertMovieLike(MovieLike ml) {
		return rDAO.insertMovieLike(sqlSession, ml);
	}

	// 김이현 영화 리뷰 좋아요 버튼 카운트 확인 (1인 경우 좋아요 클릭 상태)
	public int movieLikeCount(MovieLike ml) {
		return rDAO.movieLikeCount(sqlSession, ml);
	}
	
	// 김이현 영화 리뷰 좋아요 취소
	public int deleteMovieLike(MovieLike ml) {
		return rDAO.deleteMovieLike(sqlSession, ml);
	}
	// 김이현 영화에 달린 총 좋아요 개수
	public int allHeartCount(int movieId) {
		return rDAO.allHeartCount(sqlSession, movieId);
	}
	// 김이현 리뷰에 달린 좋아요 삽입
	public int insertLike(Like like) {
		return rDAO.insertLike(sqlSession, like);
	}
	// 김이현 리뷰에 달린 좋아요 취소
	public int deleteLike(Like like) {
		return rDAO.deleteLike(sqlSession, like);
	}
	// 김이현 리뷰에 달린 좋아요 상태 (1이면 눌린상태)
	public int likeCount(Like like) {
		return rDAO.likeCount(sqlSession, like);
	}
	// 김이현 리뷰에 달린 좋아요 총 개수
	public int allLikeCount(int boardId) {
		return rDAO.allLikeCount(sqlSession, boardId);
	}
	// 김이현 리뷰에 달린 댓글 총 개수
	public int allCommentCount(int boardId) {
		return rDAO.allCommentCount(sqlSession, boardId);
	}
	
	
	public int reportCount(Report report) {
		return  rDAO.reportCount(sqlSession, report);
	}
	
	public int commentReportCount(Report report) {
		return rDAO.commentReportCount(sqlSession, report);
	}


}