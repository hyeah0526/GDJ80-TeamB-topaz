package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.topaz.dto.Schedule;
import com.topaz.service.ScheduleService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ScheduleController {
	
	@Autowired ScheduleService scheduleService;
	
	/*
	 * 서비스명: getScheduleTodayList
	 * 시작 날짜: 2024-07-06
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/schedule/scheduleList")
	public String ScheduleTodayList(Model model) {
		
		// 오늘의 일정 리스트 출력
		List<Map<String, Object>> list = scheduleService.getScheduleTodayList();
		//log.debug(Debug.PHA + "scheduleTodayList controller--> " + list + Debug.END);
		
		model.addAttribute("todayList", list);

		return "groupware/schedule/scheduleList";
	}
	
	
	/*
	 * 서비스명: 
	 * 시작 날짜: 2024-07-07
	 * 담당자: 박혜아
	*/
	@PostMapping("/groupware/schedule/scheduleList")
	public String ScheduleAdd(Schedule schedule) {
		log.debug(Debug.PHA + "ScheduleAdd controller--> " + schedule + Debug.END);

		return "redirect:/groupware/schedule/scheduleList";
	}
	
	
	
	
	

}
