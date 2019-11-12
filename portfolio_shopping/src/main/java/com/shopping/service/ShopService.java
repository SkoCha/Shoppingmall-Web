package com.shopping.service;

import java.util.List;

import com.shopping.domain.CartListVO;
import com.shopping.domain.CartVO;
import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.OrderDetailsVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
import com.shopping.domain.ReplyVO;

public interface ShopService {

	public List<GoodsVO> allGoodsList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<GoodsVO> getGoodsList(int cateCode, int level);
	
	public GoodsVO getGoodsView(int gdsNum);
	
	public void registReply(ReplyVO vo);
	
	public List<ReplyVO> getGoodsReply(int gdsNum);
	
	public String getUserId(int repNum);
	
	public void deleteReply(ReplyVO vo);
	
	public void modifyReply(ReplyVO vo);
	
	public void addCart(CartVO cart);
	
	public List<CartListVO> myCartList(String userId);
	
	public void cartDelete(int cartNum);
	
	// 주문 정보 입력
	public void orderInfo(OrderVO order);
		
	// 주문 상세 정보 입력
	public void orderInfoDetails(OrderDetailsVO orderDetails);
	
	// 주문 성공 시 장바구니 내역 삭제
	public void myCartDelete(String userId);
	
	// 내 주문 목록 조회
	public List<OrderVO> getMyOrderList(OrderVO order);
	
	// 내 주문 상세 목록 조회
	public List<OrderListVO> getMyOrderView(OrderVO order);
}
