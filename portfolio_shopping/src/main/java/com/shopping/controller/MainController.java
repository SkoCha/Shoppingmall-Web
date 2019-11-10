package com.shopping.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.PageVO;
import com.shopping.service.ShopService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@Autowired
	private ShopService shopService;
	
	@GetMapping("/main")
	public void mainPage(Criteria cri, Model model) {
		log.info("Main Page");
		List<GoodsVO> list = shopService.allGoodsList(cri);
		int total = shopService.getTotalCount(cri);
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageVO(cri, total));
	}
	
}
