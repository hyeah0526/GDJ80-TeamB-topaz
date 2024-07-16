package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Guest;
import com.topaz.dto.GuestRequest;
import com.topaz.dto.Room;
import com.topaz.service.GuestService;
import com.topaz.service.RoomService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j

public class GuestController {
	@Autowired
	GuestService guestService;
	@Autowired
	RoomService roomService;
	/*
	 * 서비스명: getResidentList
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@GetMapping("/groupware/resident/residentList")
	public String residentList() {

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
	public String modifyResident(GuestRequest gstRq,
								@RequestParam(name = "gstId") String gstId,
								HttpServletRequest httpServletRequest,
								@RequestParam(name="roomAmenity") String roomAmenity,
								@RequestParam(name="oldFileName") String oldFileName) throws Exception {

		// 파일 있으면 false, 없으면 true
		log.debug(Debug.PSJ + "resiUpdate Controller 파일 체크--> " + gstRq.getUploadFile().isEmpty() + Debug.END);
		log.debug(Debug.PSJ + "resiUpdate Controller oldFileName 체크--> " + oldFileName + Debug.END);
		
		//세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empId = (String)session.getAttribute("strId");
		log.debug(Debug.PSJ + "resiUpdate controller empId==> " + empId + Debug.END);
		
		//modId를 세션으로 
		gstRq.setModId(empId);
		
		// amenity 상태 바꾸기
		gstRq.setRoomAmenity(roomAmenity);
	    
		// 수정
		guestService.updateResident(gstRq, oldFileName);
		
		return "redirect:/groupware/resident/residentDetail?gstId="+gstId;
	}
	
	
	/*
	 * 서비스명: insertResident
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	
	@GetMapping("/groupware/resident/residentAdd")
	public String addResident(Model model) throws Exception {
		
		// 객실 조회
		List<Map<String,Object>> room = roomService.selectRoom();
		log.debug(Debug.PSJ + "resiAdd controller==>" + room.toString() + Debug.END);
		model.addAttribute("room",room);
		
		// 고객 조회
		List<Map<String,Object>> gst = guestService.selectResidentByGuest();
		log.debug(Debug.PSJ + "resiAdd controller==>" + gst.toString() + Debug.END);
		model.addAttribute("gstOne",gst);
		
		
		log.debug(Debug.PSJ + "resiAdd controller==>" + model.toString() + Debug.END);

		return "groupware/resident/residentAdd";
	}
	
	/*
	 * 서비스명: setResident
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	@PostMapping("/groupware/resident/residentAdd")
	public String addResident(Model model,
							GuestRequest gstRq, 
							Room room,
							@RequestParam(name="roomAmenity") String roomAmenity,
							HttpServletRequest httpServletRequest) throws Exception{
		
		log.debug(Debug.PSJ + "resiAdd controller guest==> " + gstRq.toString() + Debug.END);
		log.debug(Debug.PSJ + "resiAdd controller roomAmenity==> " + roomAmenity + Debug.END);
		
		
		//세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empId = (String)session.getAttribute("strId");
		//modId를 세션으로 
		gstRq.setModId(empId);
		gstRq.setRegId(empId);
		room.setModId(empId);
		
		
		// 입주자 등록
		guestService.setResident(gstRq);
		log.debug(Debug.PSJ + "resiAdd controller==>" + gstRq + Debug.END);
		
		// 방 등록
		int row1 = roomService.insertResident(room);
		log.debug(Debug.PSJ + "resiAdd controller==>" + row1 + Debug.END);

		return "redirect:/groupware/resident/residentList";
		
	}
	
}
