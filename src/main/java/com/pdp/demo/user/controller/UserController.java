package com.pdp.demo.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {	
	
	@RequestMapping("/user")
	public String getUser(){
		return "users/user";
	}
}
