package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.topaz.service.ScheduleService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ScheduleController {
	
	@Autowired ScheduleService scheduleService;
	
	/*
	 * 서비스명: getScheduleList
	 * 시작 날짜: 2024-07-05
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/schedule/scheduleList")
	public String scheduleList() {
		

		return "groupware/schedule/scheduleList";
	}

}
