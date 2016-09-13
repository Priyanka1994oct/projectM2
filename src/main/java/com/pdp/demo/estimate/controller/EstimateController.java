package com.pdp.demo.estimate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EstimateController {

	@RequestMapping("/estimates")
	public String  getEstimatePage(){
	//return "estimates/estimates1";
		return "estimates/estimates2";
	}
}