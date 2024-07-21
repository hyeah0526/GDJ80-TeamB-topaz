package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.topaz.dto.ApprovalDoc;
import com.topaz.dto.ApprovalDocRequest;
import com.topaz.dto.ApprovalTemplate;
import com.topaz.mapper.ApprovalMapper;
import com.topaz.service.ApprovalService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ApprovalController {
	
	@Autowired ApprovalService approvalService;
	@Autowired ApprovalMapper approvalMapper;
	
	/*
	 * 서비스명: approvalService
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/approval/approvalAdd") 
	public String approvalAdd(Model model
								,HttpServletRequest httpServletRequest) {
		
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "approval Controller empNo--> " + empNo + Debug.END);
		
		// 서명 등록 여부 가져오기
		Map<String, Object> empSign = approvalService.getEmpSign(empNo);
		log.debug(Debug.PHA + "approval Controller empSign--> " + empSign + Debug.END);
		
		// 부서 리스트 가져오기
		List<Map<String, Object>> deptList = approvalMapper.selectDeptList();
		log.debug(Debug.PHA + "approval Controller deptList--> " + deptList + Debug.END);
		
		// 값 담기
		model.addAttribute("empSign", empSign);
		model.addAttribute("deptList", deptList);
		
		
		return "groupware/approval/approvalAdd"; 
	}
	
	
	
	@PostMapping("/groupware/approval/approvalAdd")
	public String approvalAdd(ApprovalDocRequest approvalDocRequest
								,HttpServletRequest httpServletRequest) throws Exception {
		
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "approval Controller empNo--> " + empNo + Debug.END);
		approvalDocRequest.setEmpNo(empNo);
		log.debug(Debug.PHA + "approvalAdd Controller approvalDoc--> " + approvalDocRequest + Debug.END);
		
		// 결재 문서 등록하기
		String insertApprovalDocNo = approvalService.setApprovalDoc(approvalDocRequest);
		log.debug(Debug.PHA + "approvalAdd Controller insertApprovalDocNo--> " + insertApprovalDocNo + Debug.END);
		
		return "redirect:/groupware/approval/approvalAdd";
	}
	
	
	

}