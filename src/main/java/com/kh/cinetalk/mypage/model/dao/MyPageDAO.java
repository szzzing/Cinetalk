package com.kh.cinetalk.mypage.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cinetalk.common.PageInfo;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.mypage.model.vo.Comments;
import com.kh.cinetalk.review.model.vo.Review;

@Repository("myDAO")
public class MyPageDAO {

	public ArrayList<Review> reviewList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mypageMapper.commentList", id);
	}

	public ArrayList<Review> reviewLikeList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mypageMapper.likeList", id);
	}

	public ArrayList<Comments> commentList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mypageMapper.commentAll", id);
	}

	public ArrayList<Hangout> hangoutList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mypageMapper.hangoutList", id);
	}

	public ArrayList<Hangout> interestHangoutList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mypageMapper.interestHangoutList", id);
	}

	public ArrayList<Hangout> joinHangoutList(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("mypageMapper.joinHangoutList", id);
	}

	public int getListCount(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("mypageMapper.getHangoutListCount", id);
	}

	public ArrayList<Hangout> selectHangoutList(SqlSessionTemplate sqlSession, PageInfo pi, String id) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mypageMapper.selectHangoutList", id, rowBounds);
	}
	public int getReviewListCount(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("mypageMapper.getReviewListCount", id);
	}

	public ArrayList<Review> selectReviewList(SqlSessionTemplate sqlSession, PageInfo pi, String id) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("mypageMapper.selectReviewList", id, rowBounds);
	}

	public ArrayList<Comments> selectCommentList(SqlSessionTemplate sqlSession, PageInfo pi, String id) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("mypageMapper.selectCommentList", id, rowBounds);
	}

	public int getCommentListCount(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("mypageMapper.getCommentListCount", id);
	}

	public int allLikeCounts(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("mypageMapper.likeListCount", boardId);
	}

	public int allCommentsCounts(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("mypageMapper.commentListCount", boardId);
	}
}
