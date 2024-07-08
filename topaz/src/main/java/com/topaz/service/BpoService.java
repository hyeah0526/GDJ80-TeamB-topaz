package com.topaz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.mapper.BpoMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BpoService {
	
	@Autowired BpoMapper bpoMapper;
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 전체 예약일정 리스트
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoRsvnList(String inputState){
		log.debug(Debug.PHA + "getBpoRsvnList Service inputState--> " + inputState + Debug.END);
		
		// 스케줄 전체 리스트 (RestController)
		List<Map<String, Object>> bpoRsvnList = bpoMapper.selectBpoRsvnList(inputState);
		log.debug(Debug.PHA + "getBpoRsvnList Service--> " + bpoRsvnList + Debug.END);
		
		
		return bpoRsvnList;
	}
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 외주업체 전체 카테고리
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoCategory(){
		
		// 외주업체 전체 카테고리 리스트
		List<Map<String, Object>> bpoCategory = bpoMapper.selectBpoCategory();
		log.debug(Debug.PHA + "getBpoCategory Service--> " + bpoCategory + Debug.END);
		
		return bpoCategory;
	}
	
	

}
