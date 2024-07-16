package com.topaz.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.mapper.BpoMapper;
import com.topaz.service.BpoService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class BpoRestController {
	
	@Autowired BpoService bpoService; 
	@Autowired BpoMapper bpoMapper;
	
	/*
	 * 서비스명: getBpoList
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@GetMapping("/bpo/bpoRsvnCalList")
	public List<Map<String, Object>> bpoRsvnCalList(String inputState) {
		log.debug(Debug.PHA + "bpoMainIn controller inputState--> " + inputState + Debug.END);
		
		// 캐린더 전체 목록 조회
		List<Map<String, Object>> list = bpoService.getBpoRsvnList(inputState);
		log.debug(Debug.PHA + "bpoMainIn controller list--> " + list + Debug.END);
		
		return list;
	}
	
	
	
	/*
	 * 서비스명: getBpoList
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박혜아
	*/
	@RequestMapping("/bpo/bpoList")
	public Map<String, Object> bpoList(@RequestParam(name="currentPage", defaultValue="1") int currentPage
										,@RequestParam(name="rowPerPage", defaultValue="5") int rowPerPage
										,@RequestParam(name="searchWord", defaultValue="") String searchWord
										,@RequestParam(name="searchType", defaultValue="") String searchType){
		// 가져온 값 디버깅
		log.debug(Debug.PHA + "bpoList Restcontroller currentPage--> " + currentPage + Debug.END);
		log.debug(Debug.PHA + "bpoList Restcontroller rowPerPage--> " + rowPerPage + Debug.END);
		log.debug(Debug.PHA + "bpoList Restcontroller searchWord--> " + searchWord + Debug.END);
		log.debug(Debug.PHA + "bpoList Restcontroller searchType--> " + searchType + Debug.END);
		
		// 전체 조회 
		List<Map<String, Object>> list = bpoService.getBpoList(currentPage, rowPerPage, searchWord, searchType);
		log.debug(Debug.PHA + "bpoList Restontroller list--> " + list + Debug.END);
		
		// 마지막 페이지
		int lastPage = bpoService.getBpoListLastPage(rowPerPage, searchWord, searchType);
		log.debug(Debug.PHA + "bpoList Restontroller lastPage--> " + lastPage + Debug.END);
		
		int minPage = (((currentPage - 1) / rowPerPage) * rowPerPage) + 1;
		int maxPage = minPage + (rowPerPage - 1);
		// 최대 페이지가 마지막페이지를 넘어가지 못하도록 제한
		if (maxPage > lastPage) {
			maxPage = lastPage;
		}
		
		// 값 추가해주기
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("list", list);
		resultMap.put("currentPage", currentPage);
		resultMap.put("lastPage", lastPage);
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		
		log.debug(Debug.PHA + "bpoList Restontroller resultMap--> " + resultMap + Debug.END);
		
		
		return resultMap;
	}
	
	
	/*
	 * 서비스명: getGstChk
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박혜아
	*/
	@RequestMapping("/bpo/bpoGstChk")
	public List<Map<String, Object>> bpoGstChk(String gstName){
		log.debug(Debug.PHA + "bpoGstChk Restcontroller gstName--> " + gstName + Debug.END);
		
		// 고객이름 검색 받은 후 해당 값을 현재 입주중인 고객과 비교하여 조회
		List<Map<String, Object>> list = bpoService.getGstChk(gstName);
		
		return list;
	}
	
	
	
	/*
	 * 서비스명: getEmpChk
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/bpo/bpoEmpChk")
	public List<Map<String, Object>> bpoEmpChk(String empName){
		log.debug(Debug.PHA + "bpoEmpChk Restcontroller gstName--> " + empName + Debug.END);
		
		// 직원 이름으로 검색
		List<Map<String, Object>> list = bpoService.getEmpChk(empName);
		
		return list;
	}
	
	
	
	/*
	 * 서비스명: getBpoIdChk
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/bpo/bpoIdChk")
	public boolean bpoIdChk(String OutsourcingIdAll){
		log.debug(Debug.PHA + "bpoIdChk Restcontroller gstName--> " + OutsourcingIdAll + Debug.END);
		
		// 외주업체 아이디 사용가능여부 확인
		boolean idChk = bpoService.getBpoIdChk(OutsourcingIdAll);
		log.debug(Debug.PHA + "bpoIdChk Restcontroller idChk--> " + idChk + Debug.END);
		
		// false 사용가능, true 사용불가능
		return idChk;
	}
	
	
	
	/*
	 * 서비스명: getBpoRsvnList
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박혜아
	*/
	@GetMapping("/bpo/bpoOutList")
	public List<Map<String, Object>> bpoOutList(HttpServletRequest  httpServletRequest) {
		
		// 로그인 한 아이디 가져오기
		HttpSession session = httpServletRequest.getSession();
		String outsourcingNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "bpoOutList Controller 로그인 아이디확인--> "+ outsourcingNo + Debug.END);
		
		
		// 캐린더 전체 목록 조회
		List<Map<String, Object>> list = bpoService.getbpoOutList(outsourcingNo);
		log.debug(Debug.PHA + "bpoOutList controller list--> " + list + Debug.END);
		
		return list;
	}
	
	
	
	/*
	 * 서비스명: getBpoOutNoticeDetail
	 * 시작 날짜: 2024-07-16
	 * 담당자: 박혜아
	*/
	@GetMapping("/bpo/bpoOutNoticeDetail")
	public Map<String, Object> bpoOutNoticeDetail(String newsNo) {
		log.debug(Debug.PHA + "bpoOutNoticeDetail controller newsNo--> " + newsNo + Debug.END);
		
		// 공지사항 상세보기
		Map<String, Object> map = bpoService.getBpoOutNoticeDetail(newsNo);
		log.debug(Debug.PHA + "bpoOutNoticeDetail controller map--> " + map + Debug.END);
		
		return map;
	}
	
	
	
	/*
	 * 서비스명: setBpoActiveChange
	 * 시작 날짜: 2024-07-16
	 * 담당자: 박혜아
	*/
	@RequestMapping("/bpo/bpoActiveChange")
	public int bpoActiveChange(String outsourcingNo, String useYn) {
		log.debug(Debug.PHA + "bpoActiveChange controller outsourcingNo--> " + outsourcingNo + Debug.END);
		log.debug(Debug.PHA + "bpoActiveChange controller useYn--> " + useYn + Debug.END);
		
		String useYnChange = "";
		if(useYn.equals("Y")) {
			useYnChange = "N";
		}else {
			useYnChange = "Y";
		}
		
		int updateRow = bpoMapper.updateBpoActive(outsourcingNo, useYnChange);
		
		return updateRow;
	}
	
	
	
	/*
	 * 매퍼명: updateBpoOutPw
	 * 시작 날짜: 2024-07-16
	 * 담당자: 박혜아
	*/
	@RequestMapping("/bpo/bpoOutChangePw")
	public int bpoOutChangePw(String outsourcingNo, String newPw, String oldPw) {
		
		log.debug(Debug.PHA + "bpoOutChangePw Controller outsourcingNo--> " + outsourcingNo + Debug.END);
		log.debug(Debug.PHA + "bpoOutChangePw Controller newPw--> " + newPw + Debug.END);
		log.debug(Debug.PHA + "bpoOutChangePw Controller oldPw--> " + oldPw + Debug.END);
		
		int updateRow = bpoMapper.updateBpoOutPw(outsourcingNo, newPw, oldPw);
		
		return updateRow;
	}
	
}
