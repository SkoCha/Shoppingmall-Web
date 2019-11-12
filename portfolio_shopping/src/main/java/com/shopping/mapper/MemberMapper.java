package com.shopping.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.domain.Criteria;
import com.shopping.domain.MemberVO;
import com.shopping.domain.ReplyVO;

@Mapper
public interface MemberMapper {

	// 회원 가입
	public void regist(MemberVO vo);
	
	// 로그인
	public MemberVO login(MemberVO vo);
	
	// 작성한 상품평 리스트
	public List<ReplyVO> getAllReply(@Param("userId") String userId, @Param("cri") Criteria cri);
	
	// 작성한 상품평 수 조회
	public int getTotalReplyCount(String userId);
	
	// 작성한 상품평 삭제
	public void deleteReply(int repNum);
	
	// 회원 정보 조회
	public MemberVO getMyAccount(String userId);
	
	// 회원 정보 수정
	public void updateMyAccount(MemberVO member);
}
