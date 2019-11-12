package com.shopping.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shopping.domain.CartListVO;
import com.shopping.domain.CartVO;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.MemberVO;
import com.shopping.domain.OrderDetailsVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
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
	public void getGoodsView(@RequestParam("num") int gdsNum, Model model, HttpSession session) {
		log.info("Customer Goods View Page");
		MemberVO member = (MemberVO)session.getAttribute("member");
		GoodsVO view = shopService.getGoodsView(gdsNum);
		model.addAttribute("view", view);
		model.addAttribute("member", member);
		
//		List<ReplyVO> reply = shopService.getGoodsReply(gdsNum);
//		model.addAttribute("reply", reply);
	}
	
	/* 댓글 등록 ***
	@PostMapping("/view")
	public String registReply(ReplyVO vo, HttpSession session) {
		log.info("view Page Reply Register");
		MemberVO member = (MemberVO)session.getAttribute("member");
		vo.setUserId(member.getUserId());
		shopService.registReply(vo);
		return "redirect:/shop/view?num=" + vo.getGdsNum();
	}
	*/
	
	@GetMapping("/view/replyList")
	@ResponseBody
	public List<ReplyVO> getReplyList(@RequestParam("num") int gdsNum) {
		log.info("get Reply List : " + gdsNum);
		List<ReplyVO> reply = shopService.getGoodsReply(gdsNum);
		return reply;
	}
	
	@PostMapping("/view/replyRegist")
	@ResponseBody
	public void replyRegist(ReplyVO vo, HttpSession session) {
		log.info("view Page Reply Register With Ajax");
		MemberVO member = (MemberVO)session.getAttribute("member");
		vo.setUserId(member.getUserId());
		shopService.registReply(vo);
	}
	
	@PostMapping("/view/replyDelete")
	@ResponseBody
	public int replyDelete(ReplyVO reply, HttpSession session) {
		log.info("view Page Reply Delete With Ajax");
		int result = 0;
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = shopService.getUserId(reply.getRepNum());
		
		if(member.getUserId().equals(userId)) {
			reply.setUserId(member.getUserId());
			shopService.deleteReply(reply);			
			result = 1;
		}
		return result;
	}
	
	@PostMapping("/view/replyModify")
	@ResponseBody
	public int replyModify(ReplyVO reply, HttpSession session) {
		log.info("view Page Reply Update With Ajax");
		int result = 0;
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = shopService.getUserId(reply.getRepNum());
		
		if(member.getUserId().equals(userId)) {
			reply.setUserId(member.getUserId());
			shopService.modifyReply(reply);
			result = 1;
		}
		return result;
	}
	
	@PostMapping("/view/addCart")
	@ResponseBody
	public int addCart(CartVO cart, HttpSession session) {
		log.info("Goods add Cart With Ajax");
		int result = 0;
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		if(member != null) {
			cart.setUserId(member.getUserId());
			shopService.addCart(cart);
			result = 1;
		}
		return result;
	}
	
	@GetMapping("/myCart")
	public void myCart(HttpSession session, Model model) {
		log.info("myCart page");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		List<CartListVO> cartList = shopService.myCartList(userId);
		model.addAttribute("cartList", cartList);
	}
	
	@DeleteMapping("/myCart/{cartNum}")
	@ResponseBody
	public boolean cartDelete(HttpSession session, @PathVariable("cartNum") Integer cartNum) {
		log.info("delete Cart");
		MemberVO member = (MemberVO)session.getAttribute("member");
		boolean result = false;
		
		if(member != null) {
			shopService.cartDelete(cartNum);
			result = true;
		}
		return result;
	}
	
	@PostMapping("/myCart")
	public String order(HttpSession session, OrderVO order, OrderDetailsVO orderDetails) {
		log.info("carList Order Post");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		
		for(int i=1; i<=6; i++) {
			subNum += (int)(Math.random() * 10);
		}
		
		String orderId = ymd + "_" + subNum;
		
		order.setOrderId(orderId);
		order.setUserId(userId);
		shopService.orderInfo(order);
		
		orderDetails.setOrderId(orderId);
		shopService.orderInfoDetails(orderDetails);
		
		// 주문 성공 후 장바구니 내역 삭제
		shopService.myCartDelete(userId);
		
		return "redirect:/shop/myOrder";
	}
	
	@GetMapping("myOrder")
	public void myOrder(HttpSession session, OrderVO order, Model model) {
		log.info("myOrder List Page");
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		order.setUserId(userId);
		List<OrderVO> orderList = shopService.getMyOrderList(order);
		model.addAttribute("orderList", orderList);
	}
	
	@GetMapping("myOrderView")
	public void myOrderView(HttpSession session, @RequestParam("num") String orderId, OrderVO order, Model model) {
		log.info("myOrder List View Page : " + orderId);
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		order.setUserId(userId);
		order.setOrderId(orderId);
		
		List<OrderListVO> orderView = shopService.getMyOrderView(order);
		model.addAttribute("orderView", orderView);
	}
}
