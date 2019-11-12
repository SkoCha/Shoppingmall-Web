package com.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.domain.CartListVO;
import com.shopping.domain.CartVO;
import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.OrderDetailsVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
import com.shopping.domain.ReplyVO;
import com.shopping.mapper.ShopMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ShopServiceImpl implements ShopService{

	@Autowired
	private ShopMapper mapper;

	@Override
	public List<GoodsVO> getGoodsList(int cateCode, int level) {
		
		int cateCodeRef = 0;
		
		if(level == 1) {
			cateCodeRef = cateCode;
		}
		return mapper.getGoodsList(cateCode, cateCodeRef);
	}

	@Override
	public GoodsVO getGoodsView(int gdsNum) {
		return mapper.getGoodsView(gdsNum);
	}

	@Override
	public void registReply(ReplyVO vo) {
		mapper.registReply(vo);
	}

	@Override
	public List<ReplyVO> getGoodsReply(int gdsNum) {
		return mapper.getGoodsReply(gdsNum);
	}

	@Override
	public List<GoodsVO> allGoodsList(Criteria cri) {
		return mapper.allGoodsList(cri);
	}

	@Override
	public String getUserId(int repNum) {
		return mapper.getUserId(repNum);
	}

	@Override
	public void deleteReply(ReplyVO vo) {
		mapper.deleteReply(vo);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.modifyReply(vo);
	}

	@Override
	public void addCart(CartVO cart) {
		mapper.addCart(cart);
	}

	@Override
	public List<CartListVO> myCartList(String userId) {
		return mapper.myCartList(userId);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public void cartDelete(int cartNum) {
		mapper.cartDelete(cartNum);
	}

	@Override
	public void orderInfo(OrderVO order) {
		mapper.orderInfo(order);
	}

	@Override
	public void orderInfoDetails(OrderDetailsVO orderDetails) {
		mapper.orderInfoDetails(orderDetails);
	}

	@Override
	public void myCartDelete(String userId) {
		mapper.myCartDelete(userId);
	}

	@Override
	public List<OrderVO> getMyOrderList(OrderVO order) {
		return mapper.getMyOrderList(order);
	}

	@Override
	public List<OrderListVO> getMyOrderView(OrderVO order) {
		return mapper.getMyOrderView(order);
	}

}
