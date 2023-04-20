package com.kh.cinetalk.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.vo.Email;
import com.kh.cinetalk.member.model.vo.Member;

public interface MemberService {

	Member login(Member m);

	int insertMember(Member m);

	int updateMember(Member m);

	int updatePwd(HashMap<String, String> map);

	ArrayList<Hangout> searchList(String keyword);

	int countReview();

	int checkMember(Email email);

	String getId(Email email);

	int updateTempPwd(HashMap<String, String> param);

	int checkId(String id);

	int checkNickName(String nickName);


}
