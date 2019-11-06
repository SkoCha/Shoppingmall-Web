package com.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.domain.CategoryVO;
import com.shopping.domain.GoodsVO;
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

}
