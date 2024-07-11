package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.dto.ApprovalTemplate;
import com.topaz.mapper.ApprovalMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {

	@Autowired ApprovalMapper approvalMapper;
	@Autowired UploadFileService uploadFileService;
	
	
	/*
	 * 분류 번호: #11 - 결재 리스트
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김지훈
	*/
	public int getLastPageApprovalList(int rowPerPage, String searchWord) {
		
		log.debug(Debug.KJH + "/ service / getLastPageApprovalList rowPerPage: " + rowPerPage);
		log.debug(Debug.KJH + "/ service / getLastPageApprovalList searchWord: " + searchWord);
		
		int cnt = approvalMapper.approvalListCnt();
		int lastPage = cnt / rowPerPage;
		if((cnt % rowPerPage) != 0) {
			lastPage += 1;
		}
		return lastPage;
	}
	
	/*
	 * 분류 번호: #11 - 결재 리스트
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김지훈
	*/
	
	public List<Map<String, Object>> getApprovalList(int currentPage, int rowPerPage, String searchWord) {
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", (currentPage-1) * rowPerPage);
		paramMap.put("searchWord", searchWord);
		
		List<Map<String, Object>> approvalList = approvalMapper.selectApprovalHistory(paramMap);
		
		log.debug(Debug.KJH + " / service / getApprovalList" + approvalList.toString());
		
		return approvalList;
	}
	
	
	/*
	 * 분류 번호: #11 - 결재 리스트
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김지훈
	*/
	public int addTemplate(ApprovalTemplate appTemplate) {
		log.debug(Debug.KJH + " / service / addTemplate :" + appTemplate);
		return approvalMapper.insertTemplate(appTemplate);
	}
	
	
	
	/*
	 * 분류 번호: #11 - 템플릿 상세 + 수정
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김지훈
	*/
	public Map<String, Object> getTemplateDetail(String templateNo) {
		log.debug(Debug.KJH + " / Service / getTemplateDetail tempateNo" + templateNo);
		Map<String, Object> templateDetail = approvalMapper.selectTemplateDetail(templateNo);
		return templateDetail;
	}
	
	/*
	 * 분류 번호: #11 - 템플릿 리스트
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김지훈
	*/
	
	public List<Map<String, Object>> getTemplateList() {
		Map<String, Object> paramMap = new HashMap<>();
		List<Map<String, Object>> templateList = approvalMapper.selectTemplateList(paramMap);
		log.debug(Debug.KJH + " / service / getTemplate" + templateList.toString());
		return templateList;
	}
}
