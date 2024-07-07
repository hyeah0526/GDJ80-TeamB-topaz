package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		
		return "redirect:/groupware/emp/empList";
	}
	

	/*
	 * 서비스명: #4 - 전체 직원조회
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empList")
	public String empList(
			Model model,
			@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empList / paramMap : " + paramMap);
		
		
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectEmpAll(paramMap);
	    List<Map<String, Object>> empList = (List<Map<String, Object>>) resultMap.get("empList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
		//모델 객체에 데이터 추가 
		model.addAttribute("empList", empList);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "groupware/emp/empList";
	}
	
	
	/*
	 * 서비스명: #4 - 직원 상세보기
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empDetail")
	public String empDetail(
			Model model,
			@RequestParam(name = "empNo") String empNo) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empDetail / empNo : " + empNo);
	    
	    //직원 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
	    
		return "groupware/emp/empDetail";
	}
}
