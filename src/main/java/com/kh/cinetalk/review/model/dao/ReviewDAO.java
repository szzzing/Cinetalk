package com.kh.cinetalk.review.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.vo.Like;
import com.kh.cinetalk.review.model.vo.MovieLike;
import com.kh.cinetalk.review.model.vo.Rcomment;
import com.kh.cinetalk.review.model.vo.Review;

@Repository("rDAO")
public class ReviewDAO {
	public int insertMovieReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.insert("reviewMapper.insertMovieReview", r);
	}

	public ArrayList<Review> movieReviewList(SqlSessionTemplate sqlSession, int movieId) {
		return (ArrayList)sqlSession.selectList("reviewMapper.movieReviewList", movieId);
	}

	public Review reviewRating(SqlSessionTemplate sqlSession, int movieId) {
		return sqlSession.selectOne("reviewMapper.reviewRating", movieId);
	}

// 세진
	public int selectReviewCount(SqlSessionTemplate sqlSession, int movieId) {
		return sqlSession.selectOne("reviewMapper.selectReviewCount", movieId);
	}
//세진
	public double selectAvgRating(SqlSessionTemplate sqlSession, int movieId) {
		return sqlSession.selectOne("reviewMapper.selectAvgRating", movieId);
	}
//세진
	public int selectAllReviewCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reviewMapper.selectAllReviewCount");
	}

	// 조회수 증가 김이현
	public int addCount(SqlSessionTemplate sqlSession, int boardId) {
		
		return sqlSession.update("reviewMapper.addCount", boardId);
	}
	
	// 영화 리뷰 조회 김이현
	public Review movieReviewDetail(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("reviewMapper.movieReviewDetail", boardId);
	}

	// 영화 리뷰 수정 김이현
	public int updateMovieReview(SqlSessionTemplate sqlSession, Review r) {
		int result = 0;
		result += sqlSession.update("reviewMapper.updateMovieReview", r);
		result += sqlSession.update("reviewMapper.updateMovieRating", r);
		return result;
	}

	// 영화 리뷰 삭제 김이현
	public int deleteMovieReview(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("reviewMapper.deleteMovieReview", boardId);
	}
	
	// 영화 리뷰에 댓글 작성 김이현
	public int insertRcomment(SqlSessionTemplate sqlSession, Rcomment rc) {
		return sqlSession.insert("reviewMapper.insertRcomment", rc);
	}
	
	// 영화 리뷰에 댓글 조회 김이현
	public ArrayList<Rcomment> selectRcomment(SqlSessionTemplate sqlSession, int boardId) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectRcomment", boardId);
	}
	
	// 영화 리뷰에 댓글 수정 김이현
	public int updateRcomment(SqlSessionTemplate sqlSession, Rcomment rc) {
		return sqlSession.update("reviewMapper.updateRcomment", rc);
	}

	// 영화 리뷰에 댓글 삭제 김이현
	public int deleteRcomment(SqlSessionTemplate sqlSession, int commentId) {
		return sqlSession.update("reviewMapper.deleteRcomment", commentId);
	}
	
	// 영화 리뷰에 댓글 이미 작성하면 1반환 김이현
	public int rCommentAlready(SqlSessionTemplate sqlSession, Rcomment rc) {
		return sqlSession.selectOne("reviewMapper.rCommentAlready", rc);
	}
	
	// 영화 리뷰 좋아요 김이현
	public int insertMovieLike(SqlSessionTemplate sqlSession, MovieLike ml) {
		return sqlSession.insert("reviewMapper.insertMovieLike", ml);
	}
	// 영화 리뷰 좋아요 카운트
	public int movieLikeCount(SqlSessionTemplate sqlSession, MovieLike ml) {
		return sqlSession.selectOne("reviewMapper.movieLikeCount", ml);
	}
	// 영화 리뷰 좋아요 삭제
	public int deleteMovieLike(SqlSessionTemplate sqlSession, MovieLike ml) {
		return sqlSession.delete("reviewMapper.deleteMovieLike", ml);
	}
	// 영화 리뷰에 총 좋아요 수
	public int allHeartCount(SqlSessionTemplate sqlSession, int movieId) {
		return sqlSession.selectOne("reviewMapper.allHeartCount", movieId);
	}
	// 영화 리뷰에 댓글 좋아요 넣기
	public int insertLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.insert("reviewMapper.insertLike", like);
	}
	// 영화 리뷰에 댓글 좋아요 삭제
	public int deleteLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.delete("reviewMapper.deleteLike", like);
	}
	// 영화 리뷰에 댓글 좋아요 눌린 상태확인
	public int likeCount(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.selectOne("reviewMapper.likeCount", like);
	}
	// 영화 리뷰에 댓글 총 좋아요 수
	public int allLikeCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("reviewMapper.allLikeCount", boardId);
	}
	// 영화 리뷰에 달린 댓글 개수
	public int allCommentCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("reviewMapper.allCommentCount", boardId);
	}
	

	public int reportCount(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.selectOne("reviewMapper.reportCount", report);
	}


	public int commentReportCount(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.selectOne("reviewMapper.commentReportCount", report);
	}


	
	
	
	
	
	
	
	
}