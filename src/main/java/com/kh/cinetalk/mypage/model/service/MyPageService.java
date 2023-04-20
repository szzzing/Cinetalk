package com.kh.cinetalk.mypage.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cinetalk.common.PageInfo;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.mypage.model.dao.MyPageDAO;
import com.kh.cinetalk.mypage.model.vo.Comments;
import com.kh.cinetalk.review.model.vo.Review;

@Service("myService")
public class MyPageService {
	@Autowired
	private MyPageDAO myDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Review> reviewList(String id) {
		return myDAO.reviewList(sqlSession, id);
	}

	public ArrayList<Review> reviewLikeList(String id) {
		return myDAO.reviewLikeList(sqlSession, id);
	}

	public ArrayList<Comments> commentList(String id) {
		return myDAO.commentList(sqlSession, id);
	}

	public ArrayList<Hangout> hangoutList(String id) {
		return myDAO.hangoutList(sqlSession, id);
	}

	public ArrayList<Hangout> interestHangoutList(String id) {
		return myDAO.interestHangoutList(sqlSession, id);
	}

	public ArrayList<Hangout> joinHangoutList(String id) {
		return myDAO.joinHangoutList(sqlSession, id);
	}

	public int getListCount(String id) {
		return myDAO.getListCount(sqlSession, id);
	}

	public ArrayList<Hangout> selectHangoutList(PageInfo pi, String id) {
		return myDAO.selectHangoutList(sqlSession, pi, id);
	}
	
	public int getReviewListCount(String id) {
		return myDAO.getReviewListCount(sqlSession, id);
	}
	
	public ArrayList<Review> selectReviewList(PageInfo pi, String id) {
		return myDAO.selectReviewList(sqlSession, pi, id);
	}
	
	public int getCommentListCount(String id) {
		return myDAO.getCommentListCount(sqlSession, id);
	}
	
	public ArrayList<Comments> selectCommentList(PageInfo pi, String id) {

		return myDAO.selectCommentList(sqlSession,pi,id);
	}

	public int allLikeCounts(int boardId) {
		return myDAO.allLikeCounts(sqlSession, boardId);
	}

	public int allCommentsCounts(int boardId) {
		return myDAO.allCommentsCounts(sqlSession, boardId);
	}
}
