package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Volunteer;
import com.topaz.dto.VolunteerApplication;
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
		
		//세션값 가져오기 -> empNo 세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		// 쿼리에서 필요한 값 세팅
		volunteer.setModId(empNo);
		log.debug(Debug.HEH + "controller modifyVolunteer volunteer : " + volunteer + Debug.END);
		// 가져올 상세 정보
		String volNo = volunteer.getVolNo();
		log.debug(Debug.HEH + "controller modifyVolunteer volNo : " + volNo + Debug.END);
		
		volunteerService.modifyVolunteer(volunteer);
		
		return "redirect:/groupware/volunteer/volunteerDetail?volNo="+volNo;
	}
	
	/*
	 * 서비스명: addVolunteer
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜
	 */
	@PostMapping("/groupware/volunteer/volunteerMain")
	public String addVolunteer(HttpServletRequest httpServletRequest, Volunteer volunteer) {
		
		// 세션값 -> empNo 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.HEH + "controller addVolunteer empNo : " + empNo + Debug.END);
		// 쿼리에서 필요한 값 세팅
		volunteer.setModId(empNo);
		volunteer.setRegId(empNo);
		log.debug(Debug.HEH + "controller addVolunteer volunteer : " + volunteer + Debug.END);
				
		volunteerService.addVolunteer(volunteer);
		
		return "redirect:/groupware/volunteer/volunteerMain";
	}
	
	
	/*
	 * 서비스명: deleteVolunteer
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜
	 */
	@GetMapping("/groupware/volunteer/deleteVolunteer")
	public String deleteVolunteer(HttpServletRequest httpServletRequest, Volunteer volunteer) {
		// 세션값 -> gstId 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.HEH + "controller deleteVolunteer empNo : " + empNo + Debug.END);
		// 쿼리에서 필요한 값 세팅
		volunteer.setModId(empNo);
		log.debug(Debug.HEH + "controller deleteVolunteer empNo : " + volunteer + Debug.END);

		volunteerService.deleteVolunteer(volunteer);
		
		return "redirect:/groupware/volunteer/volunteerMain";
	}
	
	
	/*
	 * 서비스명: getvolunteerDetail
	 * 시작 날짜: 2024-07-18
	 * 담당자: 한은혜
	 */
	@GetMapping("/customer/volunteerRqDetail")
	public String volunteerRqDetail(@RequestParam(name="volNo") String volNo, Model model) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller volunteerRqDetail volunteerNo : " + volNo + Debug.END);
		// 봉사 상세 조회
		Volunteer volunteer = volunteerService.getVolunteerDetail(volNo);
		log.debug(Debug.HEH + "controller volunteerRqDetail volunteer : " + volunteer + Debug.END);

		model.addAttribute("volunteerOne", volunteer);
		
		return "/customer/volunteerRqDetail";
	}
	
	/*
	 * 서비스명: volunteerApp
	 * 시작 날짜: 2024-07-18
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/volunteerRqDetail")
	public String volunteerApp(@RequestParam(name="volNo") String volNo, HttpServletRequest httpServletRequest, VolunteerApplication volunteerApplication) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller volunteerApp volNo : " + volNo + Debug.END);
		// 세션값 -> empNo 가져오기
		HttpSession session = httpServletRequest.getSession();
		String gstId = (String)session.getAttribute("gstId");
		log.debug(Debug.HEH + "controller volunteerApp gstId : " + gstId + Debug.END);
		// 쿼리에서 필요한 값 세팅
		volunteerApplication.setGstId(gstId);
		volunteerApplication.setModId(gstId);
		volunteerApplication.setRegId(gstId);
		log.debug(Debug.HEH + "controller volunteerApp volunteerApplication : " + volunteerApplication + Debug.END);

		volunteerService.addVolApp(volunteerApplication);
		
		return "redirect:/customer/volunteerRqAdd";
	}
		
	
	
	
	
	
}
