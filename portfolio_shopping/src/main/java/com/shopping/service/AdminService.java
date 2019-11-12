package com.shopping.service;

import java.util.List;

import com.shopping.domain.CategoryVO;
import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.MemberVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
import com.shopping.domain.ReplyVO;

public interface AdminService {

	// 카테고리 가져오기
	public List<CategoryVO> getCategory();
	
	// 관리자 상품 등록
	public void goodsRegister(GoodsVO vo);
	
	// 관리자 상품 목록 가져오기
	public List<GoodsVO> getGoodsList();
	
	// 관리자 상품 상세 조회
	public GoodsVO getGoodsView(int gdsNum);
	
	// 관리자 상품 수정
	public void goodsModify(GoodsVO vo);
	
	// 관리자 상품 삭제
	public void goodsRemove(int gdsNum);
	
	// 관리자 주문 목록 조회
	public List<OrderVO> getOrderList();
	
	// 관리자 특정 주문 목록 조회
	public List<OrderListVO> getOrderView(OrderVO order);
	
	// 관리자 배송 상태 수정
	public void updateDelivery(OrderVO order);
	
	// 배송 완료 상품 수량 조절
	public void updateGoodsStock(GoodsVO goods);
	
	// 모든 댓글 가져오기
	public List<ReplyVO> getAllReply(Criteria cri);
	
	// 모든 댓글 수 조회
	public int getTotalReplyCount(Criteria cri);
	
	// 댓글 삭제
	public void deleteReply(int repNum);
	
	// 관리자 상품 리스트 상품 삭제
	public void deleteGoods(int gdsNum);
	
	// 관리자 전체 회원 수 조회
	public List<MemberVO> getAllMember(Criteria cri);
	
	// 모든 댓글 수 조회
	public int getMemberTotalCount(Criteria cri);
}
