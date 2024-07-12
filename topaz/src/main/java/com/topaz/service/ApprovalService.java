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
	
	public Map<String, Object> getApprovalList(Map<String, Object> paramMap) {
		// paramMap 디버깅
		log.debug(Debug.KJH + " / Service / getApprovalList / paramMap: " + paramMap);
		
		// template의 개수
		int approvalCnt = approvalMapper.approvalListCnt(paramMap);
		log.debug(Debug.KIS + " / Service / getApprovalList / approvalListCnt : " + approvalCnt);
		
		// 마지막 페이지 계산하기
		int rowPerPage = (int) paramMap.get("rowPerPage");
		int lastPage = (approvalCnt + rowPerPage - 1 ) / rowPerPage;
		log.debug(Debug.KJH + " / Service / getApprovalList / lastPage: " + lastPage);
		
		// 템플릿 리스트
		List<Map<String, Object>> approvalList = approvalMapper.selectApprovalHistory(paramMap);
		log.debug(Debug.KJH + " / service / getApprovalList" + approvalList);
		
		// 결과 맵에 담기
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("approvalList", approvalList);
		resultMap.put("lastPage", lastPage);
		
		return resultMap;
	
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
	
	public Map<String, Object> getTemplateList(Map<String, Object> paramMap) {
		// paramMap 디버깅
		log.debug(Debug.KJH + " / Service / getTemplateList / paramMap: " + paramMap);
		
		// template의 개수
		int templateCnt = approvalMapper.approvalTemplateListCnt(paramMap);
		log.debug(Debug.KIS + " / Service / getTemplateList / templateCnt : " + templateCnt);
		
		// 마지막 페이지 계산하기
		int rowPerPage = (int) paramMap.get("rowPerPage");
		int lastPage = (templateCnt + rowPerPage - 1 ) / rowPerPage;
		log.debug(Debug.KJH + " / Service / getTemplateList / lastPage: " + lastPage);
		
		// 템플릿 리스트
		List<Map<String, Object>> templateList = approvalMapper.selectTemplateList(paramMap);
		log.debug(Debug.KJH + " / service / getTemplate" + templateList);
		
		// 결과 맵에 담기
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("templateList", templateList);
		resultMap.put("lastPage", lastPage);
		
		return resultMap;
	}
}
