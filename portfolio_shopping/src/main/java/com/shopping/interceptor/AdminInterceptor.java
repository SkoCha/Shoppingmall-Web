package com.shopping.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.shopping.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO)session.getAttribute("member");
		
		if(loginMember == null) {
			response.sendRedirect("/member/login");
			log.warn("Login Please With Admin Account");
			return false;
		}
		
		if(loginMember.getEnabled() != 1) {
			response.sendRedirect("/main");
			log.warn("Admin Page Access Denied");
			return false;
		}
		
		return true;
	}
	
}
