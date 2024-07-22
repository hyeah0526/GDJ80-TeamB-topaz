package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	/*
	 * 서비스명: getVolAppList
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜
	 */
	@GetMapping("/volunteer/volunteerList")
	public Map<String, Object> volunteerAppList(@RequestParam(name="currentPage", defaultValue="1") int currentPage,
											@RequestParam(name="rowPerPage", defaultValue="5") int rowPerPage,
											@RequestParam(name="searchDate", defaultValue="") String searchDate,
											@RequestParam(name="searchWord", defaultValue="") String searchWord ){
		// 매개값 디버깅
		log.debug(Debug.HEH + "restController volunteerAppList currentPage : " + currentPage + Debug.END);
		log.debug(Debug.HEH + "restController volunteerAppList rowPerPage : " + rowPerPage + Debug.END);
		log.debug(Debug.HEH + "restController volunteerAppList searchDate : " + searchDate + Debug.END);
		log.debug(Debug.HEH + "restController volunteerAppList searchWord : " + searchWord + Debug.END);
		
		List<Map<String, Object>> list = volunteerService.getVolAppList(currentPage, rowPerPage, searchDate, searchWord);
		log.debug(Debug.HEH + "restController volunteerAppList list : " + list + Debug.END);
		// 마지막 페이지 구하기
		int lastPage = volunteerService.getVolAppListLastPage(rowPerPage, searchDate, searchWord);
		log.debug(Debug.HEH + "restController volunteerAppList lastPage : " + lastPage + Debug.END);

		// 값 추가하기
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("currentPage", currentPage);
		map.put("lastPage", lastPage);
		
		log.debug(Debug.HEH + "restController volunteerAppList map : " + map + Debug.END);

		return map;
	}
	
	
	
}
