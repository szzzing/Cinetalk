package com.kh.cinetalk.hangout.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cinetalk.common.PageInfo;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.hangout.model.vo.Hcomment;
import com.kh.cinetalk.report.model.vo.Report;

@Repository("hDAO")
public class HangoutDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("hangoutMapper.getListCount");
	}

	public ArrayList<Hangout> selectAllHangoutList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("hangoutMapper.selectAllHangoutList",null, rowBounds);
	}

	public int insertHangout(SqlSessionTemplate sqlSession, Hangout h) {
		return sqlSession.insert("hangoutMapper.insertHangout", h);
	}

	public Hangout selectHangout(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("hangoutMapper.selectHangout", boardId);
	}

	public int updateHangout(SqlSessionTemplate sqlSession, Hangout h) {
		return 
			sqlSession.update("hangoutMapper.updateBoard", h)
			+ sqlSession.update("hangoutMapper.updateHangout", h);
	}

	public int deleteHangout(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("hangoutMapper.deleteHangout", boardId);
	}

	public Object updateHangoutCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("hangoutMapper.updateHangoutCount", boardId);
	}

	public int isInterest(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("hangoutMapper.isInterest", map);
	}

	public int insertInterest(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.insert("hangoutMapper.insertInterest", map);
	}

	public int deleteInterest(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.delete("hangoutMapper.deleteInterest", map);
	}

	public int isJoin(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("hangoutMapper.isJoin", map);
	}

	public int insertJoin(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.insert("hangoutMapper.insertJoin", map);
	}

	public int deleteJoin(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.delete("hangoutMapper.deleteJoin", map);
	}

	public int insertComment(SqlSessionTemplate sqlSession, Hcomment c) {
		return sqlSession.insert("hangoutMapper.insertComment", c);
	}

	public ArrayList<Hcomment> selectAllCommentList(SqlSessionTemplate sqlSession, int boardId) {
		return (ArrayList)sqlSession.selectList("hangoutMapper.selectAllCommentList", boardId);
	}

	public ArrayList<Hcomment> selectParentComment(SqlSessionTemplate sqlSession, int boardId) {
		return (ArrayList)sqlSession.selectList("hangoutMapper.selectParentComment", boardId);
	}

	public ArrayList<Hcomment> selectChildComment(SqlSessionTemplate sqlSession, int commentCId) {
		return (ArrayList)sqlSession.selectList("hangoutMapper.selectChildComment", commentCId);
	}

	public void deleteAllInterest(SqlSessionTemplate sqlSession, int boardId) {
		sqlSession.delete("hangoutMapper.deleteAllInterest", boardId);
	}

	public void deleteAllJoin(SqlSessionTemplate sqlSession, int boardId) {
		sqlSession.delete("hangoutMapper.deleteAllJoin", boardId);
	}

	public void deleteAllComment(SqlSessionTemplate sqlSession, int boardId) {
		sqlSession.update("hangoutMapper.deleteAllComment", boardId);
	}

	public Hcomment selectComment(SqlSessionTemplate sqlSession, int commentId) {
		return sqlSession.selectOne("hangoutMapper.selectComment", commentId);
	}

	public int selectLastCommentId(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("hangoutMapper.selectLastCommentId");
	}

	public int updateComment(SqlSessionTemplate sqlSession, Hcomment c) {
		return sqlSession.update("hangoutMapper.updateComment", c);
	}

	public int deleteComment(SqlSessionTemplate sqlSession, int commentId) {
		return sqlSession.update("hangoutMapper.deleteComment", commentId);
	}

	public int selectInterestCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("hangoutMapper.selectInterestCount", boardId);
	}

	public int selectJoinCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("hangoutMapper.selectJoinCount", boardId);
	}

	public ArrayList<Hangout> searchHangout(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("hangoutMapper.searchHangout", searchMap, rowBounds);
	}

	public int getSearchHangoutResultCount(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap) {
		return sqlSession.selectOne("hangoutMapper.getSearchHangoutResultCount", searchMap);
	}
	
	// 김이현 신고 상태 확인
	public int reportCount(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.selectOne("hangoutMapper.reportCount", report);
	}
}