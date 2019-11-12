package com.shopping.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.domain.Criteria;
import com.shopping.domain.MemberVO;
import com.shopping.domain.ReplyVO;
import com.shopping.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public void register(MemberVO vo) {
		mapper.regist(vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public List<ReplyVO> replyList(String userId, Criteria cri) {
		return mapper.getAllReply(userId, cri);
	}
	
	@Override
	public int getTotalReplyCount(String userId) {
		return mapper.getTotalReplyCount(userId);
	}
	
	@Override
	public void deleteReply(int repNum) {
		mapper.deleteReply(repNum);
	}

	@Override
	public MemberVO getMyAccount(String userId) {
		return mapper.getMyAccount(userId);
	}

	@Override
	public void updateMyAccount(MemberVO member) {
		mapper.updateMyAccount(member);
	}


}
