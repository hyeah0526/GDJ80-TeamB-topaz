package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.service.GuestService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class GuestController {
	@Autowired
	GuestService guestService;
	
	/*
	 * 서비스명: getResidentList
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@GetMapping("/groupware/resident/residentList")
	public String residentList(Model model,
							@RequestParam(name="currentPage", defaultValue = "1") int currentPage,
							@RequestParam(name="rowPerPage", defaultValue = "5") int rowPerPage,
							@RequestParam(name="searchWord", defaultValue = "") String searchWord) throws Exception {
		// 입주자 조회
		List<Map<String,Object>> residentList = guestService.getResidentList(currentPage, rowPerPage, searchWord);
		log.debug(Debug.PSJ + "residentList controller==>" + residentList.toString() + Debug.END);
		// 마지막 페이지
		int lastPage = guestService.getLastPage(rowPerPage, searchWord);
		log.debug(Debug.PSJ + "resiLastPage controller==>" + lastPage + Debug.END);
		
		// model에 넣기
		model.addAttribute("residentList", residentList);
		model.addAttribute("lastPage",lastPage);
		model.addAttribute("currentPage",currentPage);
		
		return "groupware/resident/residentList";
		
	}
	
}
