package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Outsourcing;
import com.topaz.service.BpoService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BpoController {
	
	@Autowired BpoService bpoService;
	
	/*
	 * 서비스명: getBpoCategory
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/bpo/bpoMainIn")
	public String bpoMainIn(Model model) {
		
		// 외주업체 전체 카테고리 목록
		List<Map<String, Object>> bpoCategory = bpoService.getBpoCategory();
		log.debug(Debug.PHA + "bpoMainIn Controller bpoCategory--> " + bpoCategory + Debug.END);
		
		// '예약'받는 모든 외주업체 영업상태 확인
		List<Map<String, Object>> bpoStateChk = bpoService.getBpoState();
		log.debug(Debug.PHA + "bpoMainIn Controller bpoStateChk--> " + bpoStateChk + Debug.END);
		
		// 오늘의 일정 목록
		List<Map<String, Object>> bpoRsvnToday = bpoService.getBpoRsvnToday();
		log.debug(Debug.PHA + "bpoMainIn Controller bpoRsvnToday--> " + bpoRsvnToday + Debug.END);
		
		// model담기
		model.addAttribute("bpoCategory", bpoCategory);
		model.addAttribute("bpoStateChk", bpoStateChk);
		model.addAttribute("bpoRsvnToday", bpoRsvnToday);
		
		return "groupware/bpo/bpoMainIn";
	}
	
	
	/*
	 * 서비스명: getBpoList
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/bpo/bpoList")
	public String bpoList(Model model
							,@RequestParam(name="currentPage", defaultValue="1") int currentPage
							,@RequestParam(name="rowPerPage", defaultValue="3") int rowPerPage
							,@RequestParam(name="searchWord", defaultValue="") String searchWord
							,@RequestParam(name="searchType", defaultValue="") String searchType) {
		
		// 전체 외주업체 리스트
		List<Map<String, Object>> outsourcingList = bpoService.getBpoList(currentPage, rowPerPage, searchWord, searchType);
		log.debug(Debug.PHA + "bpoList Controller outsourcing--> " + outsourcingList + Debug.END);
		
		// 전체 외주업체 리스트 총 카운트
		int lastPage = bpoService.getBpoListLastPage(rowPerPage, searchWord, searchType);
		
		// model담기
		model.addAttribute("outsourcingList", outsourcingList);
		model.addAttribute("lastPage", lastPage); // 마지막 페이지
		model.addAttribute("rowPerPage", rowPerPage);	// 한페이지당 보여줄 수
		model.addAttribute("currentPage", currentPage);	// 최근 페이지
		model.addAttribute("searchWord", searchWord);	// 검색어
		
		
		return "groupware/bpo/bpoList";
	}
	
	
	
	
	
	@GetMapping("/groupware/bpo/bpoAdd")
	public String bpoAdd() {

		return "groupware/bpo/bpoAdd";
	}
	
	@GetMapping("/groupware/bpo/bpoMainOut")
	public String bpoMainOut() {

		return "groupware/bpo/bpoMainOut";
	}

}
