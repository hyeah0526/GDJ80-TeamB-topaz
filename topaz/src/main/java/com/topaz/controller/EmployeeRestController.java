package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.EmployeeService;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class EmployeeRestController {
	
	@Autowired
	EmployeeService employeeService;
	
	/*
	 * 서비스명: selectEmpNo ( 직원번호 중복 확인 )
	 * 시작 날짜: 2024-07-06
	 * 담당자: 김인수
	*/
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
	 * 서비스명: #4 - selectEmpAll ( 직원 전체 조회 )
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empList")
	public Map<String, Object> empList(@RequestParam Map<String, Object> paramMap) {
		
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
		
		
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("empList", empList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
		
		return response;
	}
	
	
	
	//========== 조직도
	
	/*
	 * 서비스명: #4 - selectEmpAllInChart ( 조직도 )
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAllChart")
	public List<Map<String, Object>> empAllChart() {
		
		List<Map<String, Object>> empAllChart = employeeService.selectEmpAllInChart();
		log.debug(Debug.KIS + "controller / empAllChart / empAllChart : " + empAllChart);
		
		return empAllChart;
	
	}

}
