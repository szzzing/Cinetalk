package com.kh.cinetalk.hangout.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cinetalk.common.PageInfo;
import com.kh.cinetalk.hangout.model.dao.HangoutDAO;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.hangout.model.vo.Hcomment;
import com.kh.cinetalk.report.model.vo.Report;

@Service("hService")
public class HangoutService {
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private HangoutDAO hDAO;
	
	public int getListCount () {
		return hDAO.getListCount(sqlSession);
	}

	public ArrayList<Hangout> selectAllHangoutList(PageInfo pi) {
		return hDAO.selectAllHangoutList(sqlSession, pi);
	}

	public int insertHangout(Hangout h) {
		return hDAO.insertHangout(sqlSession, h);
	}

	public Hangout selectHangout(int boardId) {
		return hDAO.selectHangout(sqlSession, boardId);
	}

	public int updateHangout(Hangout h) {
		return hDAO.updateHangout(sqlSession, h);
	}

	public int deleteHangout(int boardId) {
		return hDAO.deleteHangout(sqlSession, boardId);
	}

	public void updateHangoutCount(int boardId) {
		hDAO.updateHangoutCount(sqlSession, boardId);
	}


	public int isInterest(HashMap<String, String> map) {
		return hDAO.isInterest(sqlSession, map);
	}

	public int insertInterest(HashMap<String, String> map) {
		return hDAO.insertInterest(sqlSession, map);
	}

	public int deleteInterest(HashMap<String, String> map) {
		return hDAO.deleteInterest(sqlSession, map);
	}

	public int isJoin(HashMap<String, String> map) {
		return hDAO.isJoin(sqlSession, map);
	}

	public int insertJoin(HashMap<String, String> map) {
		return hDAO.insertJoin(sqlSession, map);
	}

	public int deleteJoin(HashMap<String, String> map) {
		return hDAO.deleteJoin(sqlSession, map);
	}

	public int insertComment(Hcomment c) {
		return hDAO.insertComment(sqlSession, c);
	}

	public ArrayList<Hcomment> selectAllCommentList(int boardId) {
		return hDAO.selectAllCommentList(sqlSession, boardId);
	}

	public ArrayList<Hcomment> selectParentComment(int boardId) {
		return hDAO.selectParentComment(sqlSession, boardId);
	}

	public ArrayList<Hcomment> selectChildComment(int commentCId) {
		return hDAO.selectChildComment(sqlSession, commentCId);
	}

	public void deleteAllInterest(int boardId) {
		hDAO.deleteAllInterest(sqlSession, boardId);
	}

	public void deleteAllJoin(int boardId) {
		hDAO.deleteAllJoin(sqlSession, boardId);
	}

	public void deleteAllComment(int boardId) {
		hDAO.deleteAllComment(sqlSession, boardId);
	}

	public Hcomment selectComment(int commentId) {
		return hDAO.selectComment(sqlSession, commentId);
	}

	public int selectLastCommentId() {
		return hDAO.selectLastCommentId(sqlSession);
	}

	public int updateComment(Hcomment c) {
		return hDAO.updateComment(sqlSession, c);
	}

	public int deleteComment(int commentId) {
		return hDAO.deleteComment(sqlSession, commentId);
	}

	public int selectInterestCount(int boardId) {
		return hDAO.selectInterestCount(sqlSession, boardId);
	}

	public int selectJoinCount(int boardId) {
		return hDAO.selectJoinCount(sqlSession, boardId);
	}

	public ArrayList<Hangout> searchHangout(HashMap<String, String> searchMap, PageInfo pi) {
		return hDAO.searchHangout(sqlSession, searchMap, pi);
	}

	public int getSearchHangoutResultCount(HashMap<String, String> searchMap) {
		return hDAO.getSearchHangoutResultCount(sqlSession, searchMap);
	}
	// 김이현 신고 상태 확인
	public int reportCount(Report report) {
		return hDAO.reportCount(sqlSession, report);
	}
}