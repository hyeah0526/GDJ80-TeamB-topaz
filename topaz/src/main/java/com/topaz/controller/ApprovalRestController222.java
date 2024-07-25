
package com.topaz.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.ApprovalService222;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class ApprovalRestController222 {

	@Autowired
	ApprovalService222 approvalService;
	
	
	/*
	 * 서비스명: getApprovalList
	 * 시작 날짜: 2024-07-24
	 * 담당자: 한은혜
	 */
	@GetMapping("/approval/approvalList")
	public Map<String, Object> approvalList(@RequestParam(name="currentPage", defaultValue="1") int currentPage,
			@RequestParam(name="rowPerPage", defaultValue="10") int rowPerPage,
			@RequestParam(name="searchDateStart", defaultValue="") String searchDateStart,
			@RequestParam(name="searchDateEnd", defaultValue="") String searchDateEnd,
			@RequestParam(name="approvalCategory", defaultValue="") String approvalCategory,
			@RequestParam(name="searchWord", defaultValue="") String searchWord ){
		
		// 매개값 디버깅
		log.debug(Debug.HEH + " approvalList currentPage : " + currentPage + Debug.END);
		log.debug(Debug.HEH + " approvalList rowPerPage : " + rowPerPage + Debug.END);
		log.debug(Debug.HEH + " approvalList searchDateStart : " + searchDateStart + Debug.END);
		log.debug(Debug.HEH + " approvalList searchDateEnd : " + searchDateEnd + Debug.END);
		log.debug(Debug.HEH + " approvalList approvalCategory : " + approvalCategory + Debug.END);
		log.debug(Debug.HEH + " approvalList searchWord : " + searchWord + Debug.END);
		
		String empNo = "Es1a1s2f5";
		
		List<Map<String, Object>> list = approvalService.getApprovalList(currentPage, rowPerPage, searchDateStart, searchDateEnd, approvalCategory, searchWord, empNo);
		log.debug(Debug.HEH + " approvalList list : " + list + Debug.END);
		// 마지막페이지 구하기
		int lastPage = approvalService.getApprovalListLastPage(rowPerPage, searchDateEnd, searchDateStart, approvalCategory, searchWord, empNo);
		log.debug(Debug.HEH + " approvalList lastPage : " + lastPage + Debug.END);

		// 값 담아주기
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("currentPage", currentPage);
		map.put("lastPage", lastPage);
		
		log.debug(Debug.HEH + " approvalList map : " + map + Debug.END);
		
		return map;
	}
	
}
