package com.topaz.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.mapper.ApprovalMapper222;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService222 {
	
	@Autowired
	ApprovalMapper222 approvalMapper;
	
	
	
	/*
	 * 분류번호: #11 - 결재 리스트 : 결재 전체 리스트
	 * 시작 날짜: 2024-07-24
	 * 담당자: 한은혜 
	 */
	public List<Map<String, Object>> getApprovalList(int currentPage, int rowPerPage, 
													String searchDateStart, String searchDateEnd, String searchWord) {
		// 매개값 디버깅
		log.debug(Debug.HEH + " getApprovalList currentPage : " + currentPage + Debug.END);
		log.debug(Debug.HEH + " getApprovalList rowPerPage : " + rowPerPage + Debug.END);
		log.debug(Debug.HEH + " getApprovalList searchDateStart : " + searchDateStart + Debug.END);
		log.debug(Debug.HEH + " getApprovalList searchDateEnd : " + searchDateEnd + Debug.END);
		log.debug(Debug.HEH + " getApprovalList searchWord : " + searchWord + Debug.END);
		
		// beginRow 계산하기
		int beginRow = (currentPage - 1) * rowPerPage;
		
		List<Map<String, Object>> approvalList = approvalMapper.selectApprovalList(beginRow, rowPerPage, searchDateStart, searchDateEnd, searchWord);
		log.debug(Debug.HEH + " getApprovalList approvalList : " + approvalList + Debug.END);
		
		return approvalList;
	}


	/*
	 * 분류번호: #11 - 결재 리스트 : 결재 전체 리스트 행 수 구하기
	 * 시작 날짜: 2024-07-24
	 * 담당자: 한은혜 
	 */
	public int getApprovalListLastPage(int rowPerPage, String searchDateEnd, String searchDateStart, String searchWord) {
		// 전체 행 수
		int totalRow = approvalMapper.selectApprovalListTotalRow(searchDateEnd, searchDateStart, searchWord);
		log.debug(Debug.HEH + " getApprovalListLastPage totalRow : " + totalRow + Debug.END);
		// 마지막 페이지 계산
		int lastPage = totalRow /rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
		
		log.debug(Debug.HEH + " getApprovalListLastPage lastPage : " + lastPage + Debug.END);
		
		return lastPage;
	}

	
	
}
