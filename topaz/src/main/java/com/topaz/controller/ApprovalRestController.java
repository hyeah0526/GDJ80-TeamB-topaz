
package com.topaz.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.dto.ApprovalDocModify;
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
	
	
	/*
	 * 서비스명: getFirstApprovalList
	 * 시작 날짜: 2024-07-19
	 * 담당자: 박혜아
	*/
	@GetMapping("/approval/firstApprovalSelect")
	public List<Map<String, Object>> firstApprovalSelect(@RequestParam("approvalType") String approvalType
														,@RequestParam("empGrade") String empGrade){
		
		log.debug(Debug.PHA + "firstApprovalSelect REstController approvalType--> " + approvalType + Debug.END);
		log.debug(Debug.PHA + "firstApprovalSelect REstController empGrade--> " + empGrade + Debug.END);
		
		
		List<Map<String, Object>> list = approvalService.getFirstApprovalList(approvalType, empGrade);
		log.debug(Debug.PHA + "firstApprovalSelect REstController list--> " + list + Debug.END);
		
		return list;
	}
	
	
	/*
	 * 서비스명: 
	 * 시작 날짜: 2024-07-23
	 * 담당자: 박혜아
	*/
	@PostMapping("/approval/approvalStateModify") 
	public String approvalStateModify(ApprovalDocModify approvalDocModify
										, HttpServletRequest httpServletRequest) {
		
		// 세션가져와서 세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "approvalStateModify Controller empNo--> " + empNo + Debug.END);
		
		approvalDocModify.setModId(empNo);
		log.debug(Debug.PHA + "approvalStateModify Controller approvalDocModify--> " + approvalDocModify + Debug.END);
		// 상태변경하기
		int updateRow = approvalService.modApprovalState(approvalDocModify);
		log.debug(Debug.PHA + "approvalStateModify Controller updateRow--> " + updateRow + Debug.END);
		
		String updateState = "";
		if(approvalDocModify.getApprovalNewState().equals("1")) {
			updateState = "결재 취소에 성공하였습니다.";
			
		}else if(approvalDocModify.getApprovalNewState().equals("5") 
					|| approvalDocModify.getApprovalNewState().equals("4")) {
			updateState = "결재를 승인하였습니다.";
			
		}else if(approvalDocModify.getApprovalNewState().equals("2")) {
			updateState = "결재를 반려하였습니다.";
		}
		
		return updateState;
	}

}
