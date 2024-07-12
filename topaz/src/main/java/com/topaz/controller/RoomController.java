package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.mapper.RoomMapper;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class RoomController {
	@Autowired
	RoomMapper roomMapper;
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-12
	 * 담당자: 박수지
	*/
	@GetMapping("/groupware/room/roomList")
	public String selectRoomList() {
		
		return "groupware/room/roomList";
	}
	
}
