package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Schedule;
import com.topaz.service.ScheduleService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ScheduleController {
	
	@Autowired ScheduleService scheduleService;
	
	/*
	 * 서비스명: getScheduleTodayList
	 * 시작 날짜: 2024-07-06
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/schedule/scheduleList")
	public String ScheduleTodayList(Model model) {
		
		// 오늘의 일정 리스트 출력
		List<Map<String, Object>> list = scheduleService.getScheduleTodayList();
		//log.debug(Debug.PHA + "scheduleTodayList controller--> " + list + Debug.END);
		
		model.addAttribute("todayList", list);

		return "groupware/schedule/scheduleList";
	}
	
	
	/*
	 * 서비스명: setSchedule
	 * 시작 날짜: 2024-07-07
	 * 담당자: 박혜아
	*/
	@PostMapping("/groupware/schedule/scheduleList")
	public String ScheduleAdd(Schedule schedule) {
		// 추후 로그인 구현 완료되면 아이디값 세팅
		schedule.setRegId("testReg");
		schedule.setModId("testMod");
		//log.debug(Debug.PHA + "ScheduleAdd controller--> " + schedule + Debug.END);
		
		// 일정 추가
		scheduleService.setSchedule(schedule);

		return "redirect:/groupware/schedule/scheduleList";
	}
	
	
	/*
	 * 서비스명: getScheduleDetail
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/schedule/scheduleDetail")
	public String scheduleDetail(@RequestParam(name="scheduleNo") String scheduleNo
									, Model model) {
		log.debug(Debug.PHA + "scheduleDetail controller scheduleNo--> " + scheduleNo + Debug.END);
		
		// 일정 상세 조회
		Schedule schedule =  scheduleService.getScheduleDetail(scheduleNo);
		//log.debug(Debug.PHA + "scheduleDetail controller schedule--> " + schedule + Debug.END);
		
		// model담아주기
		model.addAttribute("scheduleOne", schedule);

		return "groupware/schedule/scheduleDetail";
	}
	
	
	/*
	 * 서비스명: 
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@PostMapping("/groupware/schedule/scheduleDetail")
	public String scheduleModify(Schedule schedule) {
		// 추후 로그인 구현 완료되면 수정자 아이디값 세팅
		schedule.setModId("testMod");
		log.debug(Debug.PHA + "scheduleModify controller schedule--> " + schedule + Debug.END);
		
		// redirect용 scheduleNo
		String scheduleNo = schedule.getScheduleNo();
		//log.debug(Debug.PHA + "scheduleModify controller scheduleNo--> " + scheduleNo + Debug.END);
		
		scheduleService.modSchedule(schedule);

		return "redirect:/groupware/schedule/scheduleDetail?scheduleNo="+scheduleNo;
	}
	

}
