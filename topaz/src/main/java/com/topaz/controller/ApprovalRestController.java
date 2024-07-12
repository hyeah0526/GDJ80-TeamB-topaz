
package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.ApprovalService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class ApprovalRestController {

	@Autowired
	ApprovalService approvalService;
	
	
	/*
	 * @GetMapping("/groupware/approval/approvalSign") public
	 */
	
	
	/*
	 * 서비스명: - 담당자: 김지훈
	 */
	@PostMapping("/groupware/approval/approvalList")
	public Map<String, Object> approvalList(@RequestParam Map<String, Object> paramMap) throws Exception {
		// paramMap 디버깅
	    log.debug(Debug.KJH + " / Controller / approvalList / paramMap : " + paramMap);
		
	    // 페이징 기본값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    // 페이징을 위한 파라미터값 설정
	    if(paramMap.get("currentPage") != null) {
	    	currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }
	    if(paramMap.get("rowPerPage") != null) {
	    	rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    // 페이징을 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
	    
	    // 전체 템플릿 정보 가져오기
	    Map<String, Object> resultMap = approvalService.getApprovalList(paramMap);
	    List<Map<String, Object>> approvalList = (List<Map<String, Object>>) resultMap.get("approvalList");
	    int lastPage = (int) resultMap.get("lastPage");
	    
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("approvalList", approvalList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
		
		return response;
	}

	/*
	 * 서비스명: getNoticeList() 담당자: 김지훈
	 */

	@PostMapping("/groupware/approval/approvalTemplateList")
	public Map<String, Object> templateList(@RequestParam Map<String, Object> paramMap) throws Exception {
		// paramMap 디버깅
	    log.debug(Debug.KJH + " / Controller / templateList / paramMap : " + paramMap);
		
	    // 페이징 기본값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    // 페이징을 위한 파라미터값 설정
	    if(paramMap.get("currentPage") != null) {
	    	currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }
	    if(paramMap.get("rowPerPage") != null) {
	    	rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    // 페이징을 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
	    
	    // 전체 템플릿 정보 가져오기
	    Map<String, Object> resultMap = approvalService.getTemplateList(paramMap);
	    List<Map<String, Object>> templateList = (List<Map<String, Object>>) resultMap.get("templateList");
	    int lastPage = (int) resultMap.get("lastPage");
	    
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("templateList", templateList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
		
		return response;
	}

}
