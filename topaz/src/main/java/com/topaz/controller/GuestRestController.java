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

@RestController
@Transactional
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
	
	@PostMapping("/groupware/resident/residentList/dong")
	public List<String> roomDong(){
		return roomMapper.selectDong();
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/type")
	public List<String> roomType(@RequestParam(name="dong")String dong){
		return roomMapper.selectType(dong);
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/ho")
	public List<String> roomHo(@RequestParam(name="type")String type){
		return roomMapper.selectHo(type);
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/filter")
	public Map<String, Object> filterResidentList(@RequestParam(name="dong", required = false) String dong,
	                                              @RequestParam(name="type", required = false) String type,
	                                              @RequestParam(name="ho", required = false) String ho,
	                                              @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
	                                              @RequestParam(name="rowPerPage", defaultValue = "5") int rowPerPage) {
		int beginRow = (currentPage - 1) * rowPerPage;

		List<Map<String, Object>> residents = guestMapper.filterResidentList(dong, type, ho, beginRow, rowPerPage);
		int totalRecords = guestMapper.countResidents(dong, type, ho);
		int totalPages = (int) Math.ceil((double) totalRecords / rowPerPage);

		Map<String, Object> response = new HashMap<>();
		response.put("residents", residents);
		response.put("totalPages", totalPages);

		return response;
	}
	
	
}
