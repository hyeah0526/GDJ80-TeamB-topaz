package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.topaz.dto.Guest;
import com.topaz.dto.GuestRequest;
import com.topaz.service.CustomerService;
import com.topaz.service.GuestService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@GetMapping("/customer/gstLogin")
	public String gstLogin() {
		
		return "/customer/gstLogin";
	}

	@GetMapping("/customer/gstMain")
	public String gstMain() {
		
		return "/customer/gstMain";
	}

	@GetMapping("/customer/infoCompany")
	public String infoCompany() {
		
		return "/customer/infoCompany";
	}

	@GetMapping("/customer/infoPrograms")
	public String infoPrograms() {
		
		return "/customer/infoPrograms";
	}

	@GetMapping("/customer/infoRegident")
	public String infoRegident() {
		
		return "/customer/infoRegident";
	}

	@GetMapping("/customer/infoRegidentA")
	public String infoRegidentA() {
		
		return "/customer/infoRegidentA";
	}

	@GetMapping("/customer/newsDetail")
	public String newDetail() {
		
		return "/customer/newsDetail";
	}

	@GetMapping("/customer/newsList")
	public String newsList() {
		
		return "/customer/newsList";
	}

	@GetMapping("/customer/volunteerRqAdd")
	public String volunteerRqAdd() {
		
		return "/customer/volunteerRqAdd";
	}
	
	@GetMapping("/customer/signUp")
	public String signUp() {
		
		return "/customer/signUp";
	}
	
	/*
	 * 서비스명: signUp 
	 * 시작 날짜: 2024-07-10
	 * 담당자: 한은혜
	*/
	@PostMapping("/customer/signUpPost")
	public String signUpPost(GuestRequest guestRequest) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller signUp guestRequest : " + guestRequest.toString() + Debug.END);
		
		customerService.signUp(guestRequest);
		
		return "/customer/gstLogin";
	}
	
	
	
}
