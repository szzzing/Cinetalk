package com.kh.cinetalk.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSessionManager;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cinetalk.admin.model.dao.AdminDAO;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.vo.Review;

@Service("aService")
public class AdminService {
	@Autowired
	AdminDAO aDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Member> selectNewMember() {
		return aDAO.selectNewMember(sqlSession);
	}

	public int selectNewMemberCount() {
		return aDAO.selectNewMemberCount(sqlSession);
	}

	public ArrayList<Review> selectNewReview() {
		return aDAO.selectNewReview(sqlSession);
	}

	public int selectNewReviewCount() {
		return aDAO.selectNewReviewCount(sqlSession);
	}

	public ArrayList<Member> selectAllMember() {
		return aDAO.selectAllMember(sqlSession);
	}
	
	// 한 회원이 작성한 리뷰글 개수
	public int selectReviewCount(String id) {
		return aDAO.selectReviewCount(sqlSession, id);
	}

	public ArrayList<Review> selectAllReview() {
		return aDAO.selectAllReview(sqlSession);
	}
	
	public ArrayList<Member> searchMember(HashMap<String, String> map) {
		return aDAO.searchMember(sqlSession, map);
	}

	public ArrayList<Review> searchReview(HashMap<String, String> map) {
		return aDAO.searchReview(sqlSession, map);
	}

	public int deleteMember(String id) {
		return aDAO.deleteMember(sqlSession, id);
	}

	public ArrayList<Review> selectAllHangout() {
		return aDAO.selectAllHangout(sqlSession);
	}

	public int deleteMovieReview(String boardId) {
		return aDAO.deleteMovieReview(sqlSession, boardId);
	}

	public int deleteHangout(String boardId) {
		return aDAO.deleteHangout(sqlSession, boardId);
	}

	public ArrayList<Hangout> searchHangout(HashMap<String, String> map) {
		return aDAO.searchHangout(sqlSession, map);
	}

	public ArrayList<Report> selectAllReport() {
		return aDAO.selectAllReport(sqlSession);
	}


	public ArrayList<String> selectRpedList(int bId) {
		return aDAO.selectRpedList(sqlSession, bId);
	}

	public ArrayList<Report> selectAllReviewReport() {
		return aDAO.selectAllReviewReport(sqlSession);
	}

	public ArrayList<Report> selectAllHangoutReport() {
		return aDAO.selectAllHangoutReport(sqlSession);
	}

	public Review selectReview(int reportContentId) {
		return aDAO.selectReview(sqlSession, reportContentId);
	}

	public Hangout selectHangout(int reportContentId) {
		return aDAO.selectHangout(sqlSession, reportContentId);
	}

	public int deleteReportBoard(String bId) {
		return aDAO.deleteReportBoard(sqlSession, bId);
	}
}
