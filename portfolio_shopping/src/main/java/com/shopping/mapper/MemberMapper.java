package com.shopping.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.shopping.domain.MemberVO;

@Mapper
public interface MemberMapper {

	// 회원 가입
	public void regist(MemberVO vo);
	
	// 로그인
	public MemberVO login(MemberVO vo);
}
