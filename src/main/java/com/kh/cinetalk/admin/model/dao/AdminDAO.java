package com.kh.cinetalk.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.vo.Review;

@Repository("aDAO")
public class AdminDAO {

	public ArrayList<Member> selectNewMember(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectNewMember");
	}

	public int selectNewMemberCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMapper.selectNewMemberCount");
	}

	public ArrayList<Review> selectNewReview(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectNewReview");
	}

	public int selectNewReviewCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMapper.selectNewReviewCount");
	}

	public ArrayList<Member> selectAllMember(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectAllMember");
	}

	public int selectReviewCount(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("adminMapper.selectReviewCount", id);
	}

	public ArrayList<Review> selectAllReview(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectAllReview");
	}

	public ArrayList<Member> searchMember(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("adminMapper.searchMember", map);
	}

	public ArrayList<Review> searchReview(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("adminMapper.searchReview", map);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.update("adminMapper.deleteMember", id);
	}

	public ArrayList<Review> selectAllHangout(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectAllHangout");
	}

	public int deleteMovieReview(SqlSessionTemplate sqlSession, String boardId) {
		return sqlSession.update("adminMapper.deleteMovieReview", boardId);
	}

	public int deleteHangout(SqlSessionTemplate sqlSession, String boardId) {
		return sqlSession.update("adminMapper.deleteHangout", boardId);
	}

	public ArrayList<Hangout> searchHangout(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("adminMapper.searchHangout", map);
	}

	public ArrayList<Report> selectAllReport(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectAllReport");
	}

	public ArrayList<String> selectRpedList(SqlSessionTemplate sqlSession, int bId) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectRpedList", bId);
	}

	public ArrayList<Report> selectAllReviewReport(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectAllReviewReport");
	}

	public ArrayList<Report> selectAllHangoutReport(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectAllHangoutReport");
	}

	public Review selectReview(SqlSessionTemplate sqlSession, int reportContentId) {
		return sqlSession.selectOne("adminMapper.selectReview", reportContentId);
	}

	public Hangout selectHangout(SqlSessionTemplate sqlSession, int reportContentId) {
		return sqlSession.selectOne("adminMapper.selectHangout", reportContentId);
	}

	public int deleteReportBoard(SqlSessionTemplate sqlSession, String bId) {
		return sqlSession.update("adminMapper.deleteReportBoard", bId);
	}
	
}
