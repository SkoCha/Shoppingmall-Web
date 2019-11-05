package com.shopping.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopping.domain.MemberVO;
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
	
}
