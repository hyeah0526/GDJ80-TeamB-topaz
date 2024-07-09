package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.topaz.service.ApprovalService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ApprovalController {
	
	@Autowired ApprovalService approvalService;
	
	@GetMapping("/groupware/approval/approvalTemplateAdd")
	public String approvalTemplateAdd() throws Exception {
		
		return "groupware/approval/approvalTemplateAdd";
	}
	
	
	@GetMapping("/groupware/approval/approvalTemplateList")
	public String approvalTemplateList(Model model) throws Exception {
		List<Map<String, Object>> approvalTemplateList = approvalService.getTemplate();
		log.debug(Debug.KJH + " / Controller / approvalTemplateList: " + approvalTemplateList);
		
		model.addAttribute(approvalTemplateList);
		return "groupware/approval/approvalTemplateList";
	}
	
}
