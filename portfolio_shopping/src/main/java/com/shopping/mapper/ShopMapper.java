package com.shopping.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shopping.domain.CategoryVO;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.ReplyVO;

@Mapper
public interface ShopMapper {

	// 모든 상품 가져오기
	public List<GoodsVO> allGoodsList();
	
	// 카테고리 별 상품 목록 가져오기
	public List<GoodsVO> getGoodsList(@Param("cateCode") int cateCode, @Param("cateCodeRef") int cateCodeRef);
	
	// 상품 상세 조회
	public GoodsVO getGoodsView(int gdsNum);
	
	// 상품평 작성
	public void registReply(ReplyVO vo);
	
	// 상품 댓글 리스트 조회
	public List<ReplyVO> getGoodsReply(int gdsNum);
}
