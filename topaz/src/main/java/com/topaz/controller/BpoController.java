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
	public String bpoList() {
		
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
	
	@GetMapping("/groupware/bpo/bpoDetail")
	public String bpoDetail() {

		return "groupware/bpo/bpoDetail";
	}

}
