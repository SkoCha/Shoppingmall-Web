package com.shopping.utils;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	@ExceptionHandler(Exception.class)
	public String except(Exception ex) {
		
		// 잘못된 요청으로 인한 예외 발생, 에러 페이지 리턴
		log.error("Exception causing" + ex.getMessage());
		return "/error/error500";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String error404(NoHandlerFoundException ex) {
		
		// 존재 하지 않는 페이지 요청, 에러 페이지 리턴
		log.error("Exception causing" + ex.getMessage());
		return "/error/error404";
	}
	
}
