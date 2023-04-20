package com.kh.cinetalk.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.vo.Email;
import com.kh.cinetalk.member.model.vo.Member;

@Repository("mDAO")
public class MemberDAO {

	public Member login(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.login", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updatePwd", map);
	}

	public ArrayList<Hangout> searchList(SqlSessionTemplate sqlSession, String keyword) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchList", keyword);
	}

	public int countReview(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.countReview");
	}

	public int checkMember(SqlSessionTemplate sqlSession, Email email) {
		return sqlSession.selectOne("memberMapper.checkMember", email);
	}

	public String getId(SqlSessionTemplate sqlSession, Email email) {
		return sqlSession.selectOne("memberMapper.getId", email);
	}

	public int updateTempPwd(SqlSessionTemplate sqlSession, HashMap<String, String> param) {
		return sqlSession.update("memberMapper.updateTempPwd", param);
	}

	public int checkId(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("memberMapper.checkId", id);
	}

	public int checkNickName(SqlSessionTemplate sqlSession, String nickName) {
		return sqlSession.selectOne("memberMapper.checkNickName", nickName);
	}


	
}
