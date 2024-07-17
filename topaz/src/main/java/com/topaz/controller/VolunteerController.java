package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Volunteer;
import com.topaz.service.VolunteerService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VolunteerController {

	@Autowired
	VolunteerService volunteerService;
	
	@GetMapping("/groupware/volunteer/volunteerMain")
	public String volunteerMain() {
		
		return "/groupware/volunteer/volunteerMain";
	}
	
	@GetMapping("/groupware/volunteer/volunteerList")
	public String volunteerList() {
		
		return "/groupware/volunteer/volunteerList";
	}
	
	
	/*
	 * 서비스명: getvolunteerDetail
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜
	*/
	@GetMapping("/groupware/volunteer/volunteerDetail")
	public String volunteerDetail(@RequestParam(name="volNo") String volNo, Model model) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller volunteerDetail volunteerNo : " + volNo + Debug.END);
		// 봉사 상세 조회
		Volunteer volunteer = volunteerService.getVolunteerDetail(volNo);
		log.debug(Debug.HEH + "controller volunteerDetail volunteer : " + volunteer + Debug.END);

		model.addAttribute("volunteerOne", volunteer);
		
		return "/groupware/volunteer/volunteerDetail";
	}
	
	/*
	 * 서비스명: modifyVolunteer
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜
	*/
	@PostMapping("/groupware/volunteer/volunteerDetail")
	public String modifyVolunteer(Volunteer volunteer, HttpServletRequest httpServletRequest) {
		
		//세션에서 ID 가져오기 -> 쿼리값 세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		volunteer.setModId(empNo);
		log.debug(Debug.HEH + "controller modifyVolunteer volunteer : " + volunteer + Debug.END);
		// 가져올 상세 정보
		String volNo = volunteer.getVolNo();
		log.debug(Debug.HEH + "controller modifyVolunteer volNo : " + volNo + Debug.END);
		
		volunteerService.modifyVolunteer(volunteer);
		
		return "redirect:/groupware/volunteer/volunteerDetail?volNo="+volNo;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
