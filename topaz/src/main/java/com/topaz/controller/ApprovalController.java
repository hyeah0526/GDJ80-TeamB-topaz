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
	
	/*
	 * 서비스명: - 담당자: 김지훈
	 */
	
	
	 @GetMapping("groupware/approval/approvalList") 
	 public String approvalList() {
	 return "groupware/approval/approvalList"; 
	 }
	

	@GetMapping("groupware/approval/approvalTemplateModify")
	public String templateDetail(Model model,
		@RequestParam(name = "templateNo") String templateNo) {
		log.debug(Debug.KJH + " / Controller approvalTemplateDetail: " + templateNo);
		
		Map<String, Object> templateDetail = approvalService.getTemplateDetail(templateNo);
		log.debug(Debug.KJH + "/ Controller approvalTemplateDetail: " + templateDetail);
		model.addAttribute("templateDetail",templateDetail);
		return "groupware/approval/approvalTemplateModify";
	}
	
	
	/*
	 * 서비스명: addTemplate() - 템플릿 등록 폼 담당자: 김지훈
	 */
	
	@PostMapping("groupware/approval/approvalTemplateAdd")
	public String approvalTemplateAdd(ApprovalTemplate appTemplate) throws Exception {
		
		log.debug(Debug.KJH + "/ Controller <POST> approvalTemplateAdd: " + appTemplate);
		approvalService.addTemplate(appTemplate);
		return "redirect:/groupware/approval/approvalTemplateList";
	}
	
	/*
	 * 서비스명: - 등록 폼 담당자: 김지훈
	 */
	
	@GetMapping("/groupware/approval/approvalTemplateAdd")
	public String approvalTemplateAdd() throws Exception {
		return "groupware/approval/approvalTemplateAdd";
	}
	
	/*
	 * 서비스명: getNoticeList() 담당자: 김지훈
	 */
	
	
	@GetMapping("/groupware/approval/approvalTemplateList") 
	public String approvalTemplateList() throws Exception {
	  
			return "groupware/approval/approvalTemplateList";
	}
}