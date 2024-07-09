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
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 예약받는 외주업체 영업상태(영업중, 영업종료)
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoState(){
		
		// outsourcing_type이 W002-2(예약)인 모든 외주업체들의 영업상태
		List<Map<String, Object>> bpoStateChk = bpoMapper.selectBpoState();
		log.debug(Debug.PHA + "getBpoState Service--> " + bpoStateChk + Debug.END);
		
		
		return bpoStateChk;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 오늘의 예약 일정
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoRsvnToday(){
		
		// 오늘의 예약 일정 리스트
		List<Map<String, Object>> bpoRsvnToday = bpoMapper.selectBpoRsvnToday();
		log.debug(Debug.PHA + "getBpoState Service--> " + bpoRsvnToday + Debug.END);
		
		
		return bpoRsvnToday;
	}
	
	

}
