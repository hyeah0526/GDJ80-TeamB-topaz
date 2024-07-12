package com.topaz.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.mapper.GuestMapper;
import com.topaz.mapper.RoomMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@RestController
@Transactional
@Slf4j
public class GuestRestController {
	@Autowired
	GuestMapper guestMapper;
	@Autowired
	RoomMapper roomMapper;
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/filter")
	public Map<String, Object> filterResidentList(@RequestParam(name="dong", required = false) String dong,
	                                              @RequestParam(name="type", required = false) String type,
	                                              @RequestParam(name="ho", required = false) String ho,
	                                              @RequestParam(name="searchWord") String searchWord,
	                                              @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
	                                              @RequestParam(name="rowPerPage", defaultValue = "5") int rowPerPage) throws Exception {
		
		log.debug(Debug.PSJ + "residentList restController requestParam ==>" + dong, type, ho, searchWord + Debug.END);

		int beginRow = (currentPage - 1) * rowPerPage;
		
		List<Map<String, Object>> residents = guestMapper.filterResidentList(dong, type, ho, searchWord, beginRow, rowPerPage);
		int totalRecords = guestMapper.countResidents(dong, type, ho);
		int totalPages = (int) Math.ceil((double) totalRecords / rowPerPage);
			
		log.debug(Debug.PSJ + "residentList restController list ==>" + residents.toString() + Debug.END);

		Map<String, Object> response = new HashMap<>();
		response.put("residents", residents);
		response.put("totalPages", totalPages);
		response.put("searchWord", searchWord);
		
		log.debug(Debug.PSJ + "residentList restController map ==>" + response.toString() + Debug.END);


		return response;
	}
	
	
}
