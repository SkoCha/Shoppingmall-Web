package com.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.domain.CategoryVO;
import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.MemberVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
import com.shopping.domain.ReplyVO;
import com.shopping.mapper.AdminMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public List<CategoryVO> getCategory() {
		return adminMapper.getCategory();
	}

	@Override
	public void goodsRegister(GoodsVO vo) {
		adminMapper.goodsRegister(vo);
	}

	@Override
	public List<GoodsVO> getGoodsList() {
		return adminMapper.getGoodsList();
	}

	@Override
	public GoodsVO getGoodsView(int gdsNum) {
		return adminMapper.getGoodsView(gdsNum);
	}

	@Override
	public void goodsModify(GoodsVO vo) {
		adminMapper.goodsModify(vo);
	}

	@Override
	public void goodsRemove(int gdsNum) {
		adminMapper.goodsRemove(gdsNum);
	}

	@Override
	public List<OrderVO> getOrderList() {
		return adminMapper.getOrderList();
	}

	@Override
	public List<OrderListVO> getOrderView(OrderVO order) {
		return adminMapper.getOrderView(order);
	}

	@Override
	public void updateDelivery(OrderVO order) {
		adminMapper.updateDelivery(order);
	}

	@Override
	public void updateGoodsStock(GoodsVO goods) {
		adminMapper.updateGoodsStock(goods);
	}

	@Override
	public List<ReplyVO> getAllReply(Criteria cri) {
		return adminMapper.getAllReply(cri);
	}

	@Override
	public void deleteReply(int repNum) {
		adminMapper.deleteReply(repNum);
	}

	@Override
	public int getTotalReplyCount(Criteria cri) {
		return adminMapper.getTotalReplyCount(cri);
	}

	@Override
	public void deleteGoods(int gdsNum) {
		adminMapper.deleteGoods(gdsNum);
	}

	@Override
	public List<MemberVO> getAllMember(Criteria cri) {
		return adminMapper.getAllMember(cri);
	}

	@Override
	public int getMemberTotalCount(Criteria cri) {
		return adminMapper.getMemberTotalCount(cri);
	}

}
