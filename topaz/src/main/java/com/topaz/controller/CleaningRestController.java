package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.mapper.CleaningMapper;
import com.topaz.service.CleaningService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j

public class CleaningRestController {
	@Autowired
	CleaningService cleaningService;
	@Autowired
	CleaningMapper cleaningMapper;
	
	/*
	 * 서비스명: getCleaningRate
	 * 시작 날짜: 2024-07-13
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/room/roomMakeUpChk")
	public List<Map<String,Object>> selectCleaningRate() {
	    
		return cleaningMapper.selectCleaningRate();
	}
}
