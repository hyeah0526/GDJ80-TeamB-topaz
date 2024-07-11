package com.topaz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Outsourcing;
import com.topaz.dto.OutsourcingRsvn;
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
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 목록 페이지(bpoList.jsp) :: 외주업체 전체 리스트
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoList(int currentPage, int rowPerPage, String searchWord, String searchType){
		
		// beginRow구하기
		int beginRow = (currentPage-1)*rowPerPage;
		
		// 외주 업체 전체 조회 (사용여부 N (계약종료)까지 전부)
		List<Map<String, Object>> outsourcingList = bpoMapper.selectBpoList(beginRow, rowPerPage, searchWord, searchType);
		log.debug(Debug.PHA + "getBpoList Service--> " + outsourcingList + Debug.END);
		
		return outsourcingList;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 목록 페이지(bpoList.jsp) :: 외주업체 전체 리스트 총 행의 개수
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public int getBpoListLastPage(int rowPerPage, String searchWord, String searchType) {
		
		// 외주업체 전체 리스트 총 행의 개수
		int totalRow = bpoMapper.selectBpoListTotalRow(searchWord, searchType);
		log.debug(Debug.PHA + "getBpoListTotalRow Service totalRow--> " + totalRow + Debug.END);
		
		// 총 행의 개수로 나머지 계산하기
		int lastPage = totalRow / rowPerPage;
		if(totalRow%rowPerPage != 0) {
			lastPage = lastPage+1;
		}
		log.debug(Debug.PHA + "getBpoListTotalRow Service lastPage--> " + lastPage + Debug.END);
		
		return lastPage;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 고객 이름으로 현재 입주중인 고객 조회
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getGstChk(String gstName){
		log.debug(Debug.PHA + "getGstChk Service gstName--> " + gstName + Debug.END);
		
		// 고객 이름으로 현재 입주중인 고객 조회
		List<Map<String, Object>> gstChkList = bpoMapper.selectGstChkList(gstName);
		log.debug(Debug.PHA + "getGstChk Service gstChkList--> " + gstChkList + Debug.END);
		
		
		return gstChkList;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 신규 예약 등록
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public int setBpoRsvn(OutsourcingRsvn outsourcingRsvn) {
		log.debug(Debug.PHA + "setBpoRsvn Service outsourcingRsvn--> " + outsourcingRsvn + Debug.END);
		
		// 신규 예약 등록
		int insertRow = bpoMapper.insertBpoRsvn(outsourcingRsvn);
		if(insertRow == 1) {
			log.debug(Debug.PHA + "setBpoRsvn Service outsourcingRsvn--> 등록성공! " + Debug.END);
		}
		
		return insertRow;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 상세 페이지(bpoRsvnDetail.jsp) :: 상세보기
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public Map<String, Object> getBpoRsvnDetail(String rsvnNo){
		
		// 상세 예약일정 조회
		Map<String, Object> bpoRsvnDetail = bpoMapper.selectBpoRsvnOne(rsvnNo);
		log.debug(Debug.PHA + "getBpoRsvnDetail Service bpoRsvnDetail--> "+ bpoRsvnDetail + Debug.END);
		
		
		return bpoRsvnDetail;
		
	}
	
	
	public int modBpoRsvn(OutsourcingRsvn outsourcingRsvn) {
		log.debug(Debug.PHA + "modBpoRsvn Service bpoRsvnDetail--> "+ outsourcingRsvn + Debug.END);
		
		// 예약일정 수정하기
		int updateRow = bpoMapper.updateBpoRsvn(outsourcingRsvn);
		if(updateRow == 1) {
			log.debug(Debug.PHA + "modBpoRsvn Service outsourcingRsvn--> 수정성공! " + Debug.END);
		}
		
		return updateRow;
	}

}
