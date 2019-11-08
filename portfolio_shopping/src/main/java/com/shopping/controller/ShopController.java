package com.shopping.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shopping.domain.GoodsVO;
import com.shopping.domain.MemberVO;
import com.shopping.domain.ReplyVO;
import com.shopping.service.ShopService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/shop/*")
@Log4j
public class ShopController {

	@Autowired
	private ShopService shopService;
	
	@GetMapping("/list")
	public void getGoodsList(@RequestParam("category") int cateCode, @RequestParam("lev") int level, Model model) {
		log.info("get Goods List Page");
		List<GoodsVO> list = null;
		list = shopService.getGoodsList(cateCode, level);
		model.addAttribute("list", list);
	}
	
	@GetMapping("/view")
	public void getGoodsView(@RequestParam("num") int gdsNum, Model model) {
		log.info("Customer Goods View Page");
		GoodsVO view = shopService.getGoodsView(gdsNum);
		model.addAttribute("view", view);
		
//		List<ReplyVO> reply = shopService.getGoodsReply(gdsNum);
//		model.addAttribute("reply", reply);
	}
	
	@PostMapping("/view")
	public String registReply(ReplyVO vo, HttpSession session) {
		log.info("view Page Reply Register");
		MemberVO member = (MemberVO)session.getAttribute("member");
		vo.setUserId(member.getUserId());
		shopService.registReply(vo);
		return "redirect:/shop/view?num=" + vo.getGdsNum();
	}
	
	
	@GetMapping("/view/replyList")
	@ResponseBody
	public List<ReplyVO> getReplyList(@RequestParam("num") int gdsNum) {
		log.info("get Reply List : " + gdsNum);
		List<ReplyVO> reply = shopService.getGoodsReply(gdsNum);
		return reply;
	}
}
