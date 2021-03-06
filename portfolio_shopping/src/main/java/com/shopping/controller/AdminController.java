package com.shopping.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;

import com.shopping.domain.CategoryVO;
import com.shopping.domain.Criteria;
import com.shopping.domain.GoodsVO;
import com.shopping.domain.MemberVO;
import com.shopping.domain.OrderListVO;
import com.shopping.domain.OrderVO;
import com.shopping.domain.PageVO;
import com.shopping.domain.ReplyVO;
import com.shopping.service.AdminService;
import com.shopping.utils.UploadFileUtils;

import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@GetMapping("/index")
	public void adminIndex() {
		log.info("adminIndex()");
	}

	@GetMapping("/goods/register")
	public void goodsRegisterGET(Model model) {
		log.info("goods Register Page");
		List<CategoryVO> category = null;
		category = adminService.getCategory();
		model.addAttribute("category", JSONArray.fromObject(category));
	}

	@PostMapping("/goods/register")
	public String goodsRegisterPOST(GoodsVO vo, MultipartFile file) throws IOException, Exception {
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {			
			// 첨부된 파일이 있을 경우
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			vo.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			vo.setGdsThumb(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			
		} else {			
			// 첨부된 파일 없을 경우 대체 이미지
			fileName = File.separator + "images" + File.separator + "none.png";
			vo.setGdsImg(fileName);
			vo.setGdsThumb(fileName);
		}
		adminService.goodsRegister(vo);
		return "redirect:/admin/index";
	}

	@GetMapping("/goods/list")
	public void goodsListGET(Model model) {
		log.info("goods List Page");
		List<GoodsVO> goodsList = adminService.getGoodsList();
		model.addAttribute("list", goodsList);
	}

	@GetMapping("/goods/view")
	public void goodsView(@RequestParam("num") int gdsNum, Model model) {
		log.info("goodsView Page");
		GoodsVO goods = adminService.getGoodsView(gdsNum);
		model.addAttribute("goods", goods);
	}

	@GetMapping("/goods/modify")
	public void goodsModifyGET(@RequestParam("num") int gdsNum, Model model) {
		log.info("goodsModify Page");
		GoodsVO goods = adminService.getGoodsView(gdsNum);
		model.addAttribute("goods", goods);

		List<CategoryVO> category = null;
		category = adminService.getCategory();
		model.addAttribute("category", JSONArray.fromObject(category));
	}

	@PostMapping("/goods/modify")
	public String goodsModifyPOST(GoodsVO vo, MultipartFile file, HttpServletRequest request) throws IOException, Exception {
		log.info("goodsModify Post : " + vo.getGdsNum());
		
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			new File(uploadPath + request.getParameter("gdsImg")).delete();
			new File(uploadPath + request.getParameter("gdsThumb")).delete();
			
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			
			vo.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			vo.setGdsThumb(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			
		} else {
			vo.setGdsImg(request.getParameter("gdsImg"));
			vo.setGdsThumb(request.getParameter("gdsThumb"));
		}
		adminService.goodsModify(vo);
		return "redirect:/admin/index";
	}
	
	@PostMapping("/goods/ckUpload")
	public void ckImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
		log.info("ckEditor image Upload");
		
		UUID uuid = UUID.randomUUID();
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8"); 
		
	}

	@PostMapping("/goods/remove")
	public String goodsRemove(@RequestParam("num") int gdsNum) {
		log.info("goodsRemove Post : " + gdsNum);
		adminService.goodsRemove(gdsNum);
		return "redirect:/admin/index";
	}

	@GetMapping("/memberList")
	public void adminMemberList() {
		log.info("admin Member List Page");
	}
	
	// 관리자 주문 목록 조회
	@GetMapping("/shop/orderList")
	public void getOrderList(Model model) {
		log.info("admin Order List Page");
		List<OrderVO> orderList = adminService.getOrderList();
		model.addAttribute("orderList", orderList);
	}
	
	// 관리자 특정 주문 목록 조회
	@GetMapping("/shop/orderView")
	public void getOrderView(@RequestParam("num") String orderId, OrderVO order, Model model) {
		log.info("admin Order view Page : " + orderId);
		order.setOrderId(orderId);
		List<OrderListVO> orderView = adminService.getOrderView(order);
		model.addAttribute("orderView", orderView);
	}
	
	// 관리자 배송 상태 변경
	@PostMapping("/shop/orderView")
	public String updateDelevery(OrderVO order) {
		log.info("admin delivery Update POST : " + order.getOrderId());
		adminService.updateDelivery(order);
		
		List<OrderListVO> orderView = adminService.getOrderView(order);
		GoodsVO goods = new GoodsVO();
		
		for(OrderListVO list : orderView) {
			goods.setGdsNum(list.getGdsNum());
			goods.setGdsStock(list.getCartStock());
			adminService.updateGoodsStock(goods);
		}
		return "redirect:/admin/shop/orderList";
	}
	
	// 모든 댓글 가져오기
	@GetMapping("/goods/replyList")
	public void getAllReply(Criteria cri, Model model) {
		log.info("Admin Reply Management Page");
		
		// 한 페이지에 10개씩 출력
		cri.setAmount(10);
		int total = adminService.getTotalReplyCount(cri);
		List<ReplyVO> replyList = adminService.getAllReply(cri);
		model.addAttribute("replyList", replyList);
		model.addAttribute("pageMaker", new PageVO(cri, total));
		
	}
	
	@DeleteMapping("/goods/replyList/{repNum}")
	@ResponseBody
	public boolean deleteReply(HttpSession session, @PathVariable("repNum") Integer repNum) {
		log.info("Admin delete Reply : " + repNum);
		MemberVO member = (MemberVO)session.getAttribute("member");
		boolean result = false;
		
		if(member != null) {
			adminService.deleteReply(repNum);
			result = true;
		}
		return result;
	}
	
	@DeleteMapping("/goods/list/{repNum}")
	@ResponseBody
	public boolean deleteGoods(HttpSession session, @PathVariable("repNum") Integer gdsNum) {
		log.info("Admin delete Goods : " + gdsNum);
		MemberVO member = (MemberVO)session.getAttribute("member");
		boolean result = false;
		
		if(member != null) {
			adminService.deleteGoods(gdsNum);
			result = true;
		}
		return result;
	}
	
	// 모든 회원수 조회
	@GetMapping("/member/management")
	public void getAllMember(Criteria cri, Model model) {
		log.info("Admin Member Management Page");
		
		// 한 페이지에 10개씩 출력
		cri.setAmount(10);
		int total = adminService.getMemberTotalCount(cri);
		List<MemberVO> memberList = adminService.getAllMember(cri);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageMaker", new PageVO(cri, total));
		
	}
}
