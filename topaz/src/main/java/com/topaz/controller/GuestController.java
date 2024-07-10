package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Guest;
import com.topaz.service.GuestService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
	
	/*
	 * 서비스명: getResidentOne
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박수지
	*/
	
	@GetMapping("/groupware/resident/residentDetail")
	public String residentDetail(Model model, 
								@RequestParam(name="gstId") String gstId) throws Exception {
		
		// 입주자 상세조회
		Map<String, Object> residentOne = guestService.getResidentOne(gstId);
		log.debug(Debug.PSJ + "residentOne controller==>" + residentOne.toString() + Debug.END);
		
		// model에 넣기
		model.addAttribute("resident",residentOne);
		
		return "groupware/resident/residentDetail";
	}
	
	/*
	 * 서비스명: updateResident
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentDetail")
	public String modifyResident(Guest guest,
								@RequestParam(name = "gstId") String gstId,
								HttpServletRequest httpServletRequest,
								@RequestParam(name="roomAmenity") String roomAmenity) throws Exception {

		//세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empId = (String)session.getAttribute("strId");
		log.debug(Debug.PSJ + "resiUpdate controller empId==> " + empId + Debug.END);
		log.debug(Debug.PSJ + "resiUpdate controller guest==> " + guest + Debug.END);
		
		//modId를 세션으로 
		guest.setModId(empId);
		
		// amenity 상태 바꾸기
		guest.setRoomAmenity(roomAmenity);
	    
		int row = guestService.updateResident(guest);
		log.debug(Debug.PSJ + "resiUpdate controller==>" + row + Debug.END);
		
		return "redirect:/groupware/resident/residentDetail?gstId="+gstId;
	}
}
