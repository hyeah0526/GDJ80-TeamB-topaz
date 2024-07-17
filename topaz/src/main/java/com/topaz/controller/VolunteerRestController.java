package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.VolunteerService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class VolunteerRestController {

	@Autowired 
	VolunteerService volunteerService;
	
	/*
	 * 서비스명: getVolunteerList
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜
	*/
	@GetMapping("/volunteer/volunteerMain")
	public List<Map<String, Object>> volunteerList(){
		// 봉사 일정 리스트 호출
		List<Map<String, Object>> list = volunteerService.getVolunteerList();
		log.debug(Debug.HEH + "restController volunteerList list : " + list + Debug.END);

		return list;
	}
	
	
}
