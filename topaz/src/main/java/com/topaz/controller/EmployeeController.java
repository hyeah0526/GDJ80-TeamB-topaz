package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
	 * 서비스명: 직원 등록 뷰 
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAdd")
	public String empAdd() {
		
		return "groupware/emp/empAdd";
	
	}
	
	
	/*
	 * 서비스명: 직원 등록 액션
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empAdd")
	public String empAdd(EmployeeRequest employeeRequest) {
		
		//매개변수 디비깅
		log.debug(Debug.KIS + "controller / empAdd / employeeRequest : " + employeeRequest);
		
		//직원정보 삽입
		employeeService.insertEmp(employeeRequest);
		
		return "groupware/emp/empAdd";
	}
}
