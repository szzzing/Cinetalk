package com.kh.cinetalk.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.dao.MemberDAO;
import com.kh.cinetalk.member.model.vo.Email;
import com.kh.cinetalk.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member login(Member m) {
		return mDAO.login(sqlSession, m);
	}

	@Override
	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession, m);
	}

	@Override
	public int updatePwd(HashMap<String, String> map) {
		return mDAO.updatePwd(sqlSession, map);
	}

	@Override
	public ArrayList<Hangout> searchList(String keyword) {
		return mDAO.searchList(sqlSession, keyword);
	}

	@Override
	public int countReview() {
		return mDAO.countReview(sqlSession);
	}

	@Override
	public int checkMember(Email email) {
		return mDAO.checkMember(sqlSession, email);
	}

	@Override
	public String getId(Email email) {
		return mDAO.getId(sqlSession, email);
	}

	@Override
	public int updateTempPwd(HashMap<String, String> param) {
		return mDAO.updateTempPwd(sqlSession, param);
	}

	@Override
	public int checkId(String id) {
		return mDAO.checkId(sqlSession, id);
	}

	@Override
	public int checkNickName(String nickName) {
		return mDAO.checkNickName(sqlSession, nickName);
	}

	
	
	
}
