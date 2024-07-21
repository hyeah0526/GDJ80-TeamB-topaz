package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.NoticeService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class NoticeRestController {

	@Autowired
	NoticeService noticeService;
	
	
	/*
	 * 서비스명: getNoticeList ( 공지사항 조회 )
	 * 시작 날짜: 2024-07-21
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/notice/noticeList")
	public Map<String, Object> approvalList(@RequestParam Map<String, Object> paramMap) throws Exception {
		// paramMap 디버깅
	    log.debug(Debug.KJH + " / Controller / noticeList / paramMap : " + paramMap);
		
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
	    Map<String, Object> resultMap = noticeService.getNoticeList(paramMap);
	    List<Map<String, Object>> noticeList = (List<Map<String, Object>>) resultMap.get("noticeList");
	    int lastPage = (int) resultMap.get("lastPage");
	    
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("noticeList", noticeList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
		
		return response;
	}

}