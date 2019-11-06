package com.shopping.service;

import java.util.List;

import com.shopping.domain.CategoryVO;
import com.shopping.domain.GoodsVO;

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
}
