package com.pdp.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("/")
	public String estimate(){
		return "welcome";
	}
	
	@RequestMapping("/")
	public String estimate2(){
		return "welcome";
	}
	
}
