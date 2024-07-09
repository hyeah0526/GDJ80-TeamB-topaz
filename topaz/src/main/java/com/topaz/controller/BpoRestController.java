package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
}
