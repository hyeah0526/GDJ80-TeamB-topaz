package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.ScheduleService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class ScheduleRestController {
	
	@Autowired ScheduleService scheduleService;
	
	/*
	 * 서비스명: getScheduleList
	 * 시작 날짜: 2024-07-05
	 * 담당자: 박혜아
	*/
	@GetMapping("/schedule/scheduleCalList")
	public List<Map<String, Object>> scheduleList(String inputState) {
		
		log.debug(Debug.PHA + "inputState controller--> " + inputState + Debug.END);
		// 캘린더 일정 전체리스트 출력
		List<Map<String, Object>> list = scheduleService.getScheduleList(inputState);
		log.debug(Debug.PHA + "getScheduleList controller--> " + list + Debug.END);

		return list;
	}

	
	/*
	 * 서비스명: getScheduleList
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박혜아
	*/
	@PostMapping("/schedule/scheduleChart")
	public List<Map<String, Object>> scheduleChart() {
		
		// chart 통계 (현재 달 통계)
		List<Map<String, Object>> chart = scheduleService.getScheduleChart();
		
		return chart;
		
	}
	
}
