package com.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.domain.GoodsVO;
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
	public List<GoodsVO> allGoodsList() {
		return mapper.allGoodsList();
	}

}
