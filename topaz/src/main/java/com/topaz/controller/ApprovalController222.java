package com.topaz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ApprovalController222 {
	
	/*
	 * 서비스명: approvalList
	 * 시작 날짜 : 2024-07-24
	 * 담당자: 한은혜
	 */
	@GetMapping("/groupware/approval/approvalList")
	public String approvalList() {
		
		return "/groupware/approval/approvalList";
	}
	
	
}