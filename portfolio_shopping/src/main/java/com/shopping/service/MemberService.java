package com.shopping.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.shopping.domain.Criteria;
import com.shopping.domain.MemberVO;
import com.shopping.domain.ReplyVO;

public interface MemberService {

	public void register(MemberVO vo);
	
	public MemberVO login(MemberVO vo);
	
	public void logout(HttpSession session);
	
	public List<ReplyVO> replyList(String userId, Criteria cri);
	
	public int getTotalReplyCount(String userId);
	
	public void deleteReply(int repNum);
	
	// 회원 정보 조회
	public MemberVO getMyAccount(String userId);
	
	// 회원 정보 수정
	public void updateMyAccount(MemberVO member);
}
