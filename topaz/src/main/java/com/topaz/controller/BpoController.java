package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.topaz.service.BpoService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BpoController {
	
	@Autowired BpoService bpoService;
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/bpo/bpoMainIn")
	public String bpoMainIn(Model model) {
		
		// 외주업체 전체 카테고리 목록
		List<Map<String, Object>> bpoCategory = bpoService.getBpoCategory();
		model.addAttribute("bpoCategory", bpoCategory);
		log.debug(Debug.PHA + "bpoMainIn Controller bpoCategory--> " + bpoCategory + Debug.END);
		
		return "groupware/bpo/bpoMainIn";
	}
	
	
	
	
	
	
	
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

}
