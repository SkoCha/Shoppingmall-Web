package com.shopping.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopping.domain.Criteria;
import com.shopping.domain.MemberVO;
import com.shopping.domain.PageVO;
import com.shopping.domain.ReplyVO;
import com.shopping.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/login")
	public void login() {
		log.info("loginGET()");
	}	
	
	@PostMapping("/login")
	public String loginPOST(MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		log.info("loginPOST()" + vo);
		MemberVO loginMember = memberService.login(vo);
		HttpSession session = request.getSession();
		
		boolean passMatch = passwordEncoder.matches(vo.getUserPass(), loginMember.getUserPass());
		
		if(loginMember != null && passMatch) {
			session.setAttribute("member", loginMember);
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("result", false);
			return "redirect:/member/login";
		}
		
		return "redirect:/main";
	}
	
	@GetMapping("/logout")
	public String logoutGET(HttpSession session) {
		log.info("logoutGET()");
		memberService.logout(session);
		return "redirect:/member/login"; 
	}
	
	
	@GetMapping("/register")
	public String registerGET() {
		log.info("RegisterGET()");
		return "/member/register";
	}
	
	@PostMapping("/register")
	public String registerPOST(MemberVO vo) {
		log.info("RegisterPOST()");
		
		String rawPassword = vo.getUserPass();
		String EncryptPassword = passwordEncoder.encode(rawPassword);
		vo.setUserPass(EncryptPassword);		
		memberService.register(vo);
		return "/member/login";
	}
	
	// 내 상품평 목록 조회
	@GetMapping("/replyList")
	public void getAllReply(HttpSession session, Criteria cri, Model model) {
		log.info("My Reply List Page");
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		// 한 페이지에 10개씩 출력
		cri.setAmount(10);
		int total = memberService.getTotalReplyCount(userId);
		List<ReplyVO> replyList = memberService.replyList(userId, cri);
		model.addAttribute("replyList", replyList);
		model.addAttribute("pageMaker", new PageVO(cri, total));
		
	}
	
	// 내 상품평 삭제
	@DeleteMapping("/replyList/{repNum}")
	@ResponseBody
	public boolean deleteReply(HttpSession session, @PathVariable("repNum") Integer repNum) {
		log.info("My delete Reply : " + repNum);
		MemberVO member = (MemberVO)session.getAttribute("member");
		boolean result = false;
		
		if(member != null) {
			memberService.deleteReply(repNum);
			result = true;
		}
		return result;
	}
	
	// 회원 정보 페이지
	@GetMapping("/myAccount")
	public void getMyAccount(HttpSession session, Model model) {
		log.info("My Account Page");
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = member.getUserId();
		
		model.addAttribute("myInfo", memberService.getMyAccount(userId));
	}
	
	@PostMapping("/myAccount")
	public String myAccountUpdate(HttpSession session, MemberVO member) {
		log.info("My Account Update Post");
		
		String rawPassword = member.getUserPass();
		String EncryptPassword = passwordEncoder.encode(rawPassword);
		member.setUserPass(EncryptPassword);
		
		memberService.updateMyAccount(member);
		session.invalidate();
		return "redirect:/member/login";
	}
}

