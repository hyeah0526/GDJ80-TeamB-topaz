
package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.ApprovalService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class ApprovalRestController {

	@Autowired
	ApprovalService approvalService;
	
	/*
	 * 서비스명: setSign
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박혜아
	*/
	@PostMapping("/approval/signAdd")
	public int signAdd(@RequestParam("signImg") String signImg
						,HttpServletRequest httpServletRequest) throws Exception {
		
		log.debug(Debug.PHA + "approval Controller signImg--> " + signImg + Debug.END);
		
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "approval Controller empNo--> " + empNo + Debug.END);
		
		// 서명 등록하기(성공 == 2)
		int insertRow = approvalService.setSign(signImg, empNo);
		
		
		return insertRow;
	}
	
	
	/*
	 * 서비스명: modSign
	 * 시작 날짜: 2024-07-18
	 * 담당자: 박혜아
	*/
	@PostMapping("/approval/signMod")
	public int signMod(@RequestParam("signModImg") String signModImg
						,@RequestParam("oldSignFile") String oldSignFile
						,HttpServletRequest httpServletRequest) throws Exception {
		
		log.debug(Debug.PHA + "approval Controller signModImg--> " + signModImg + Debug.END);
		log.debug(Debug.PHA + "approval Controller oldSignFile--> " + oldSignFile + Debug.END);
		
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "approval Controller empNo--> " + empNo + Debug.END);
		
		// 서명 수정 하기(성공 == 2)
		int updateRow = approvalService.modSign(oldSignFile, signModImg, empNo);
		
		
		return updateRow;
	}


}
