package com.shopping.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {

	@GetMapping("/index")
	public void adminIndex() {
		log.info("adminIndex()");
	}
	
	@GetMapping("/depart")
	public void adminDepart() {
		log.info("admin depart manage");
	}
}
