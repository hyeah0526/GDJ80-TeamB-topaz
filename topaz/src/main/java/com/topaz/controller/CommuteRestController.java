package com.topaz.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.LoginService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CommuteRestController {
	
	@Autowired 
	LoginService loginService;
	
	/*
	 * 서비스명: selectWorkState ( 출퇴근 상태 확인 )
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/checkWorkState")
	public  Map<String, Object> checkWorkState(HttpServletRequest req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empMain / req : " + req);
				
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / empMain / empNo : " + empNo);
		
		
		//출퇴근 정보 가져오기
		Map<String, Object> checkWork = loginService.selectWorkState(empNo);
		log.debug(Debug.KIS + "controller / empMain / strWork : " + checkWork);
		
		return checkWork;
	}
	
	
	
	/*
	 * 서비스명: insertStrWork ( 출근 등록 )
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/strWork")
	public int insertStrWork(HttpServletRequest req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / insertStrWork / req : " + req);
				
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / insertStrWork / empNo : " + empNo);
		
		
		//출근 정보 저장
		int strWork = loginService.insertStrWork(empNo);
		log.debug(Debug.KIS + "controller / insertStrWork / strWork : " + strWork);
		
		return strWork;
	}
	
	/*
	 * 서비스명: #4 - updateEndWork ( 퇴근 등록 )
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/endWork")
	public int insertEndWork(HttpServletRequest req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / insertEndWork / req : " + req);
				
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / insertEndWork / empNo : " + empNo);
		
		//퇴근 정보 저장
		int endWork = loginService.updateEndWork(empNo);
		log.debug(Debug.KIS + "controller / insertEndWork / endWork : " + endWork);
		
		return endWork;
	}
	
}
