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

import com.topaz.service.BpoService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class BpoRestController {
	
	@Autowired BpoService bpoService; 
	
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
	public List<Map<String, Object>> bpoList(Model model
											,@RequestParam(name="currentPage", defaultValue="1") int currentPage
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
		
		// 값 추가해주기
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("rowPerPage", rowPerPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchType", searchType);
		
		log.debug(Debug.PHA + "bpoList Restontroller model--> " + model + Debug.END);
		
		
		return list;
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
	 * 서비스명: getBpoListLastPage
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박혜아
	@RequestMapping("/bpo/bpoListPage")
	public List<Map<String, Object>> bpoListPage(@RequestParam(name="currentPage", defaultValue="1") int currentPage
												,@RequestParam(name="rowPerPage", defaultValue="3") int rowPerPage
												,@RequestParam(name="searchWord", defaultValue="") String searchWord
												,@RequestParam(name="searchType", defaultValue="") String searchType){
		// 마지막 페이지
		int lastPage = bpoService.getBpoListLastPage(rowPerPage, searchWord, searchType);
		log.debug(Debug.PHA + "bpoListPage Restontroller lastPage--> " + lastPage + Debug.END);
		
		// 값 추가해주기
		List<Map<String, Object>> PageList = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		map.put("lastPage", lastPage);
		map.put("rowPerPage", rowPerPage);
		map.put("searchWord", searchWord);
		map.put("searchType", searchType);
		map.put("currentPage", currentPage);
				
		// map에 추가한 값 list에 담아주기
		PageList.add(map);
		log.debug(Debug.PHA + "bpoListPage Restontroller PageList--> " + PageList + Debug.END);	
		
		return PageList;
		
	}
	
	*/
}
