package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.ApprovalTemplate;
import com.topaz.service.ApprovalService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ApprovalController {
	
	@Autowired ApprovalService approvalService;
	
	/* 내 결재함 */
	@GetMapping("/groupware/approval/approvalList") 
	public String approvalList() {
		return "groupware/approval/approvalList"; 
	}
	
	
	/* 신규 결재 */
	@GetMapping("/groupware/approval/approvalAdd") 
	public String approvalAdd() {
		return "groupware/approval/approvalAdd"; 
	}
	
	
	
	
	@GetMapping("/groupware/approval/approvalSign")
	public String approvalSign() {
		return "groupware/approval/approvalSign"; 
	}
	
}