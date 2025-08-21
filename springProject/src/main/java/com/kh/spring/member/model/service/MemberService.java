package com.kh.spring.member.model.service;

import com.kh.spring.member.model.vo.Member;

public interface MemberService {
	
	
	
	//1.로그인 서비스(select)
	Member loginMember(Member m);
	//2.회원가입 서비스(insert)
	int insertMember(Member m);
	//3.정보수정 서비스(update)
	int updateMember(Member m);	
	//4.회원삭제 서비스(update)
	int deleteMember(String userId);
	//5.아이디중복체크 서비스(select)
	int idCheck(String checkId);
	
}
