package com.topaz.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Cleaning;
import com.topaz.service.CleaningService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j

public class CleaningController {
	@Autowired
	CleaningService cleaningService;
	
	
	/*
	 * 서비스명: modifyStatus
	 * 시작 날짜: 2024-07-13
	 * 담당자: 박수지
	*/
	
	@GetMapping("/groupware/room/roomList/state")
	public String updateStatus(Model model,
							Cleaning cleaning,
							@RequestParam(name="roomNo") String roomNo,
							HttpServletRequest httpServletRequest) throws Exception {
		log.debug(Debug.PSJ + "upStatus controller roomNo ==> " + roomNo + Debug.END);
		
		//세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empId = (String)session.getAttribute("strId");
		//modId를 세션으로 
		cleaning.setModId(empId);
		cleaning.setRoomNo(roomNo);
		
		// 상태 수정
		int row = cleaningService.modifyStatus(cleaning);
		log.debug(Debug.PSJ + "upStatus controller row ==> " + row + Debug.END);
		
		return "groupware/room/roomList";
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-13
	 * 담당자: 박수지
	*/
	
	@GetMapping("/groupware/room/roomMakeUpChk")
	public String selectCleaningRate(Model model) {
	    
		return "groupware/room/roomMakeUpChk";
	}
}
