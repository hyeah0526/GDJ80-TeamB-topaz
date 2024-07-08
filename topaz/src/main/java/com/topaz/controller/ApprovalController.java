package com.topaz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApprovalController {
	@GetMapping("/groupware/approval/approvalTemplateList")
	public String approvalList() {
		return "groupware/approval/approvalTemplateList";
	}
	
}
