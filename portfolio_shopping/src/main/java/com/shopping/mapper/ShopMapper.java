package com.shopping.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.domain.CartListVO;
import com.shopping.domain.CartVO;
import com.shopping.domain.CategoryVO;
import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.OrderDetailsVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
import com.shopping.domain.ReplyVO;

@Mapper
public interface ShopMapper {

	// 모든 상품 가져오기
	public List<GoodsVO> allGoodsList(Criteria cri);
	
	// 페이지 처리에 위한 모든 상품 개수 가져오기
	public int getTotalCount(Criteria cri);
	
	// 카테고리 별 상품 목록 가져오기
	public List<GoodsVO> getGoodsList(@Param("cateCode") int cateCode, @Param("cateCodeRef") int cateCodeRef);
	
	// 상품 상세 조회
	public GoodsVO getGoodsView(int gdsNum);
	
	// 상품평 작성
	public void registReply(ReplyVO vo);
	
	// 상품 댓글 리스트 조회
	public List<ReplyVO> getGoodsReply(int gdsNum);
	
	// 해당 상품의 작성자 ID 조회(String)
	public String getUserId(int repNum);
	
	// 상품평 삭제
	public void deleteReply(ReplyVO reply);
	
	// 상품평 수정
	public void modifyReply(ReplyVO reply);
	
	// 상품 장바구니에 추가
	public void addCart(CartVO cart);
	
	// 내 장바구니 리스트 조회
	public List<CartListVO> myCartList(String userId);
	
	// 장바구니 리스트에서 해당 상품 삭제
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
