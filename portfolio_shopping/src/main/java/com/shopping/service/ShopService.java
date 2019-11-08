package com.shopping.service;

import java.util.List;

import com.shopping.domain.GoodsVO;
import com.shopping.domain.ReplyVO;

public interface ShopService {

	public List<GoodsVO> allGoodsList();
	
	public List<GoodsVO> getGoodsList(int cateCode, int level);
	
	public GoodsVO getGoodsView(int gdsNum);
	
	public void registReply(ReplyVO vo);
	
	public List<ReplyVO> getGoodsReply(int gdsNum);
}
