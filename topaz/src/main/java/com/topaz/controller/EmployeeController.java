package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topaz.dto.EmployeeRequest;
import com.topaz.service.EmployeeService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService; // employeeService 의존성 주입
	
	/*
	 * 서비스명: #4 - 직원등록 뷰 
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAdd")
	public String empAdd() {
		
		return "groupware/emp/empAdd";
	
	}
	
	/*
	 * 서비스명: #4 - 직원번호 중복 확인
	 * 시작 날짜: 2024-07-06
	 * 담당자: 김인수
	*/
	@ResponseBody
	@GetMapping("/groupware/emp/selectEmpNo")
	public String selectEmpNo(@RequestParam("empNo") String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / selectEmpNo / empNo : " + empNo);
		
		String resultEmpNo = employeeService.selectEmpNo(empNo);
	
		//resultEmpNo 디버깅
		log.debug(Debug.KIS + "controller / selectEmpNo / resultEmpNo : " + resultEmpNo);
		
		if(resultEmpNo == null) {			
			return "0";
		}
		
		return "1";
	}
	
	
	
	
	/*
	 * 서비스명: #4 - 직원등록 기능
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empAdd")
	public String empAdd(EmployeeRequest employeeRequest) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empAdd / employeeRequest : " + employeeRequest);
		
		//서비스 레이어로 직원정보 이동
		employeeService.insertEmp(employeeRequest);
		
		return "groupware/emp/empAdd";
	}
}
